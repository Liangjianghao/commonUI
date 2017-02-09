//
//  SelectMDController.m
//  Essence
//
//  Created by EssIOS on 15/5/11.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import "SelectMDController.h"
#import "keepLocationInfo.h"
//#import "SequenceTool.h"
#import "AdrDistance.h"
#import "keepLocationInfo.h"
#import "LoginInfoToll.h"

@interface SelectMDController ()<UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate,CLLocationManagerDelegate>
{
    BOOL  _isSequence ;
    BOOL  _isFirstLocation;
    BOOL         _isBaseTable;
    UIAlertView    * _alert;
    UISearchDisplayController * _dis;
    
    NSMutableArray *planArr2;
    NSMutableArray *MyShopArr2;
    NSMutableArray *dataArray2;
}
@end

@implementation SelectMDController

- (void)viewWillAppear:(BOOL)animated
{
    _planArr=[[NSMutableArray alloc]init];
    _MyShopArr=[[NSMutableArray alloc]init];
    
    [_alert setMessage:@"正在根据当前位置进行搜索"];
    [_alert show];
    self.tabBarController.tabBar.hidden = YES;
    NSDate * nowDate = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString * date = [formatter stringFromDate:nowDate];
    _resultArr =[keepLocationInfo SelectShopPatrolWithDate:date withBlock:^(NSString *result) {
        
    }];
    _planArr =[keepLocationInfo SelectShopPatrolWithDate:date withBlock:^(NSString *result) {
        
    }];
    _MyShopArr=[keepLocationInfo selectMyShopWithDatewithBlock:^(NSString *result) {
        
    }];
    self.automaticallyAdjustsScrollViewInsets = false;
//    NSLog(@"管辖%d",_MyShopArr.count);
//    NSLog(@"计划-->>%d 管辖-->%d  总%d",_planArr.count,_MyShopArr.count,_dataArray.count);
   planArr2=[NSMutableArray arrayWithArray:_planArr];
   MyShopArr2=[NSMutableArray arrayWithArray:_MyShopArr];
   dataArray2=[NSMutableArray arrayWithArray:_dataArray];
//    NSLog(@"%d",planArr2.count);
    for (StoreMD *MyModel in _MyShopArr) {
        for (NSString *AllModel in _dataArray) {
//            NSLog(@"%@  %@",AllModel,MyModel.StoreName);
            if ([AllModel isEqualToString:MyModel.StoreName]) {
                [dataArray2 removeObject:AllModel];
            }
        }
    }
    for (StoreMD *planModel in _planArr) {
        for (NSString *AllModel in _dataArray) {
            if ([AllModel isEqualToString:planModel.StoreName]) {
                [dataArray2 removeObject:AllModel];
            }
        }
    }
    
    for (StoreMD *MyModel in _MyShopArr) {
        for (StoreMD *planModel in _planArr) {
            if ([MyModel.StoreName isEqualToString:planModel.StoreName]) {
                [MyShopArr2 removeObject:MyModel];
            }
        }
    }
    
//    NSLog(@"%@ %@ %@",_dataArray[0]  ,[_planArr[0] StoreName],[_MyShopArr[0] StoreName]);
//    NSLog(@"_plan-->%d,my-->%d,all-->%d",planArr2.count,MyShopArr2.count,dataArray2.count);
    
    
//    NSMutableArray *arrrrr =[NSMutableArray array];
//  
//    if (!arrrrr) {
//        
//    }
//    for (AdrDistance * adr in _resultArr) {
//        
//        [arrrrr addObject:adr.storeName];
//    }
//    NSSet * set = [NSSet setWithArray:arrrrr];
//    [_resultArr removeAllObjects];
//    for (NSString * storeName in set) {
//        [_dataArray insertObject:storeName atIndex:0];
//    }
//    [self.locMgr startUpdatingLocation];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    
    [_alert setMessage:@"搜索OK,赶快去选吧!"];
    [UIView animateWithDuration:3 animations:^{
        
    } completion:^(BOOL finished) {
        [_alert dismissWithClickedButtonIndex:0 animated:YES];
    }];
    [self.locMgr stopUpdatingLocation];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"门店";
    _isSequence = NO;
    _isFirstLocation = YES;
    _isBaseTable     = YES;
    _resultArr = [NSMutableArray array];
    self.searchArray = [NSMutableArray array];
    _alert = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    self.locMgr = [[CLLocationManager  alloc]init];
    self.locMgr.delegate =self;
    
    UISearchBar * search = [[UISearchBar alloc]init];
    search.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 44);
    search.scopeButtonTitles = @[@"",@""];
    [search setPlaceholder:@"输入关键字搜索"];
    [search setBarStyle:UIBarStyleDefault];//搜索框样式 默认是UIBarStyleDefault样式
    [search setTintColor:[UIColor purpleColor]];// 当设置颜色时setBarStyle无效
    search.delegate = self;
    [self.view addSubview:search];
    
    _dis = [[UISearchDisplayController alloc]initWithSearchBar:search contentsController:self];
    _dis.delegate = self;
    _dis.searchResultsDataSource = self;
    _dis.searchResultsDelegate = self;
}
#pragma mark -- CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
//    NSLog(@"mainArr--->%d",_dataArray.count);
    if (_isFirstLocation == YES)
    {
//        NSArray * arr = [SequenceTool selectAddressDistanceWithArr:dataArray2 andNowLoctions:locations successwithBlock:^{
//                _isSequence = YES;
//        }];
//        NSArray *arr= [SequenceTool caculateDistanceWithArr:dataArray2 andNowLoctions:locations successwithBlock:^(NSString *result) {
//             _isSequence = YES;
//        }];
//        for (int i=0; i<20; i++) {
//            NSLog(@"i-->>%@",arr[i] );
//        }
//        NSLog(@"select-->>%d",arr.count);
//        NSDate * nowDate = [NSDate date];
//        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
//        formatter.dateFormat = @"yyyy-MM-dd";
//        NSString * date = [formatter stringFromDate:nowDate];
//        _resultArr =[keepLocationInfo SelectShopPatrolWithDate:date withBlock:^(NSString *result) {
//            
//        }];
//        NSMutableArray *arrrrr =[NSMutableArray array];
//        for (AdrDistance * adr in _resultArr) {
//            
//            [arrrrr addObject:adr.storeName];
//        }
//        NSSet * set = [NSSet setWithArray:arrrrr];
//        [_resultArr removeAllObjects];
//        for (NSString * storeName in set) {
//            AdrDistance * adr = [[AdrDistance alloc]init];
//            adr.storeName = storeName;
//            [_resultArr addObject:adr];
//        }
//        [_resultArr addObjectsFromArray:arr];

        _isFirstLocation = NO;
        _isBaseTable = YES;
//        dataArray2=[NSMutableArray arrayWithArray:arr];
        [_tableView reloadData];
    }else
    {
        _isFirstLocation = NO;
    }
}
#pragma mark -- UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_isBaseTable) {
        return 3;
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"%d  %d  %d",_dataArray.count,_resultArr.count,_searchArray.count);
//    if (_isSequence == YES && _isBaseTable == YES && tableView.tag == 10086) {
//        return _resultArr.count;
//    } else if (_isSequence == NO  && _isBaseTable == YES && tableView.tag == 10086)
//    {
//        return _dataArray.count;
//    }else{
//        return _searchArray.count;
//    }
    if (_isBaseTable) {
        if (section==0) {
            return planArr2.count;
        }
        else if (section==1)
        {
            return MyShopArr2.count;
        }
        else
        {
            return dataArray2.count;
        }
    }
    else
    {
        return _searchArray.count;
    }
  
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
//    if (_isSequence == YES && _isBaseTable == YES && tableView.tag == 10086)
//    {
//        AdrDistance * adr = _resultArr[indexPath.row];
////        NSLog(@"re-->%d",_resultArr.count);
//        cell.textLabel.text = adr.storeName;
//    }else if(_isSequence == NO  && _isBaseTable == YES && tableView.tag == 10086)
//    {
//        cell.textLabel.text = _dataArray[indexPath.row];
//    }else
//    {
//        cell.textLabel.text = _searchArray[indexPath.row];
//    }
    if (_isBaseTable) {
        if (indexPath.section==0) {
            cell.textLabel.text=[planArr2[indexPath.row] StoreName];
        }
        else if (indexPath.section==1)
        {
            cell.textLabel.text=[MyShopArr2[indexPath.row] StoreName];
        }
        else
        {
            if ([dataArray2[0] isKindOfClass:[NSString class]] ) {
                 cell.textLabel.text=dataArray2[indexPath.row]  ;
            }
            else
            {
                 cell.textLabel.text=[dataArray2[indexPath.row]  storeName];
            }
           
        }
    }
    else
    {
    cell.textLabel.text = _searchArray[indexPath.row];
    }
    return cell;
}
#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (_isSequence == YES && _isBaseTable == YES && tableView.tag == 10086)
//    {
//        AdrDistance * adr = _resultArr[indexPath.row];
//        self.selectStoreNameBlock(adr.storeName);
//    }else if (_isSequence == NO &&  _isBaseTable == YES && tableView.tag == 10086)
//    {
//        NSString * storeName = _dataArray[indexPath.row];
//        self.selectStoreNameBlock(storeName);
//    }else
//    {
//        NSString * storeName = _searchArray[indexPath.row];
//        self.selectStoreNameBlock(storeName);
//    }
//    [self.navigationController popViewControllerAnimated:YES];
    if (_isBaseTable) {
        if (indexPath.section==0) {
//            cell.textLabel.text=[planArr2[indexPath.row] StoreName];
            self.selectStoreNameBlock([planArr2[indexPath.row] StoreName]);

        }
        else if (indexPath.section==1)
        {
                       self.selectStoreNameBlock([MyShopArr2[indexPath.row] StoreName]);
        }
        else
        {
            if ([dataArray2[0] isKindOfClass:[NSString class]] ) {
            self.selectStoreNameBlock(dataArray2[indexPath.row]);
            }
            else
            {
            self.selectStoreNameBlock([dataArray2[indexPath.row] storeName]);
            }

        }
    }
    else
    {
            self.selectStoreNameBlock(_searchArray[indexPath.row] );
    }
    [self.navigationController popViewControllerAnimated:YES];
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
    _isBaseTable = YES;
    [_tableView reloadData];
}
//点击键盘 改变搜索框上的内容之后 调用此代理方法
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    _isBaseTable = NO;
    [self reloadTable:searchString search:controller.searchBar.selectedScopeButtonIndex];
    return YES;
}
- (void)searchDisplayController:(UISearchDisplayController *)controller willHideSearchResultsTableView:(UITableView *)tableView
{
    _isBaseTable = YES;
    [_tableView reloadData];
}
-(void)reloadTable:(NSString*)tableSting search:(NSInteger)search
{
    [_searchArray removeAllObjects];
    
    for (NSString * string in _dataArray){
    if ([string rangeOfString:tableSting].location != NSNotFound) {
        
        [_searchArray addObject:string];
        }
    }
    [_tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
