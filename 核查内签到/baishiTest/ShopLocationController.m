//
//  ShopLocationController.m
//  Essence
//
//  Created by EssIOS on 15/5/15.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import "ShopLocationController.h"
#import "Base64.h"
#import "BMapKit.h"
#import "LoginInfoToll.h"
#import "keepLocationInfo.h"
#import "KeepSignInInfo.h"
#import "ChineseString.h"
#import "LoginInfoToll.h"
@interface ShopLocationController ()
{
    UITableView * _table;
    NSString    * _storeName;
    UISearchDisplayController * _dis;
    BOOL         _isFirstLocation;
    BOOL         _isBaseTable;
}
@end

@implementation ShopLocationController
- (id)initWithArr:(NSMutableArray *)arr
{
    self = [super init];
    if (self) {
        _array = arr;
        _loctionDic = [NSMutableDictionary dictionary];
    }
    return self;
}
// 隐藏tabbar
- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"门店定位";
    self.searchArray = [NSMutableArray array];
    self.indexArray = [ChineseString IndexArray:_array];
    self.LetterResultArr = [ChineseString LetterSortArray:_array];
    
    self.locMgr = [[CLLocationManager alloc]init];
    self.locMgr.delegate = self;
    
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-44)];
    _table.tag = 10086;
//    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.delegate =self;
    _table.dataSource =self;
    [self.view addSubview:_table];
    
    //搜索的显示条
    UISearchBar * search = [[UISearchBar alloc]init];
    search.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 44);
    search.scopeButtonTitles = @[@"按首字体搜索",@""];
    [search setPlaceholder:@"输入关键字搜索"];
    [search setBarStyle:UIBarStyleDefault];//搜索框样式 默认是UIBarStyleDefault样式
    [search setTintColor:[UIColor purpleColor]];// 当设置颜色时setBarStyle无效
    search.delegate = self;
    [self.view addSubview:search];
    
    _dis = [[UISearchDisplayController alloc]initWithSearchBar:search contentsController:self];
    _dis.delegate = self;
    _dis.searchResultsDataSource = self;
    _dis.searchResultsDelegate = self;
    _isBaseTable = YES;
}
// 搜索框编辑开始
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [self.searchDisplayController setActive:YES animated:YES];
    return YES;
}
// 点击cancle
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [self.searchDisplayController setActive:NO animated:YES];
    _isBaseTable = NO;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isBaseTable == YES)
    {
        NSString * string = [[self.LetterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
        _storeName = string;
    }
    else
    {
        NSString * string = _searchArray[indexPath.row];
        _storeName = string;
    }
    _isFirstLocation = YES;
    UIAlertView * alertView= [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"确定要定位到当前店铺?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [_locMgr startUpdatingLocation];
    [alertView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [_locMgr stopUpdatingLocation];
        NSString * identifier = [[NSUserDefaults standardUserDefaults] objectForKey:@"identifier"];
        NSString * StoreId    =  [keepLocationInfo selectStroeIDWithTheStoreName:_storeName];
        NSString * userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
        [_loctionDic setObject:identifier forKey:@"identifier"];
        [_loctionDic setObject:StoreId forKey:@"StoreId"];
        [_loctionDic setObject:userID forKey:@"userID"];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"保存中~" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alert show];
        // 判断当前定位类型是0否为GPS
        if ([[LoginInfoToll locationType] isEqualToString:@"GPS定位"]) {
            
            [keepLocationInfo upDataLocationInfo:_loctionDic];
            
            [KeepSignInInfo keepStoreLocationInfo:_loctionDic];
            [alert setMessage:@"保存完成!"];
            
        }else
        {
            [alert setMessage:@"请开启GPS定位进行操作!"];
        }
        [UIView animateWithDuration:5 animations:^{
            [alert dismissWithClickedButtonIndex:0 animated:YES];
        }];
//         更新基础数据的地理坐标,这块sqlite3 数据库锁上了  暂时没搞定!!!记得写
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -Section的Header的值
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (_isBaseTable == YES) {
        return [_indexArray objectAtIndex:section];
    }
    else
    {
        return nil;
    }
}
#pragma mark - Section header view
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
    lab.backgroundColor = [UIColor grayColor];
    lab.text = [_indexArray objectAtIndex:section];
    lab.textColor = [UIColor whiteColor];
    return lab;
}
#pragma mark -设置右方表格的索引数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (_isBaseTable == YES) {
        return  _indexArray;
    }else
    {
        return nil;
    }
}
#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (_isBaseTable == YES) {
        return index;
    }else{
    return 0;
    }
}
#pragma mark -允许数据源告知必须加载到Table View中的表的Section数。
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_isBaseTable == YES) {
      return  [_indexArray count];
    }else
    {
        return 1;
    }
}
#pragma mark -设置表格的行数为数组的元素个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isBaseTable == YES)
    {
        return [[self.LetterResultArr objectAtIndex:section] count];
        
    }else
    {
        return _searchArray.count;
    }
    
}
#pragma mark -每一行的内容为数组相应索引的值
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (_isBaseTable == YES)
    {
        cell.textLabel.text = [[self.LetterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    }else
    {
        cell.textLabel.text = _searchArray[indexPath.row];
    }
    
    return cell;
}

//点击键盘 改变搜索框上的内容之后 调用此代理方法
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    _isBaseTable = NO;
    [self reloadTable:searchString search:controller.searchBar.selectedScopeButtonIndex];
    return YES;
}
// 选择所搜索的范围之后  调用此代理方法
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    _isBaseTable = NO;
    [self reloadTable:controller.searchBar.text search:searchOption];
    return YES;
}
- (void)searchDisplayController:(UISearchDisplayController *)controller willHideSearchResultsTableView:(UITableView *)tableView
{
    _isBaseTable = YES;
}
-(void)reloadTable:(NSString*)tableSting search:(NSInteger)search
{
    [_searchArray removeAllObjects];
    
    for (NSString * string in _array){
        if ([string rangeOfString:tableSting].location != NSNotFound) {
            
            [_searchArray addObject:string];
        }
    }
}
#pragma mark --CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if (_isFirstLocation == YES) {
        CLLocation *loc = [locations firstObject];
        
       // CLLocation *loc = [locations lastObject];
        
        NSString * timestamo = [NSString stringWithFormat:@"%@",loc.timestamp];
        // 2.取出经纬度
        CLLocationCoordinate2D coordinate = loc.coordinate;
        CLLocationCoordinate2D test = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude);
        NSDictionary *testdic   = BMKConvertBaiduCoorFrom(test, BMK_COORDTYPE_GPS);
        NSString * latitude     = [NSString stringWithBase64EncodedString:[testdic objectForKey:@"y"]];
        NSString * longitude    = [NSString stringWithBase64EncodedString:[testdic objectForKey:@"x"]];
        NSString * LocationType =[LoginInfoToll locationType];
        [_loctionDic setValue:LocationType forKey:@"LocationType"];
        [_loctionDic setValue:timestamo forKey:@"LocationTtime"];
        [_loctionDic setValue:latitude forKey:@"Latitude"];
        [_loctionDic setValue:longitude forKey:@"Longitude"];
        _isFirstLocation = NO;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
