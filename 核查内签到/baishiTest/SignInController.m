//
//  SignInController.m
//  Essence
//
//  Created by EssIOS on 15/5/8.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import "SignInController.h"
#import "TableViewCell.h"
#import "SelectShopViewController.h"
#import "Base64.h"
#import "BMapKit.h"
#import "LoginInfoToll.h"
#import "KeepSignInInfo.h"
#import "signInModel.h"
#import "keepLocationInfo.h"
@interface SignInController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,CLLocationManagerDelegate>
{
    NSMutableArray * _signInArr;
    NSDictionary   * _loctionDic;
    int              _indexRow;
    int              _signInRow;
    BOOL           isSelect[100];
}
@end

@implementation SignInController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title  = @"到点签到";
    _signInArr  = [NSMutableArray array];
    _signInRow  = -1;
    _loctionDic = [NSMutableDictionary dictionary];
    
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [_tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"myCell"];
    
    self.locMgr = [[CLLocationManager alloc]init];
    self.locMgr.delegate = self;
    
    // 调用定位  永久使用定位
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
    {
        [self.locMgr requestAlwaysAuthorization];
    }else
    {
        [self.locMgr startUpdatingLocation];
    }

    [self.locMgr startUpdatingLocation];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
    [self dataSelect];
    
}
- (void)viewDidDisappear:(BOOL)animated
{
    [self.locMgr stopUpdatingLocation];
}
#pragma mark -- 点击到点签到
- (void)signInTimeCheck:(UIButton *)button event:(id)event
{
    [self.locMgr startUpdatingLocation];
    
        NSSet *touches =[event allTouches];
        UITouch *touch =[touches anyObject];
        CGPoint currentTouchPosition = [touch locationInView:_tableView];
        NSIndexPath *indexPath= [_tableView indexPathForRowAtPoint:currentTouchPosition];
        
        TableViewCell * cell = (TableViewCell*)[_tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.row != _signInArr.count-1) {
        if (![cell.signInMD.text isEqualToString:@""]) {
            
            signInModel * sign = _signInArr[indexPath.row];
            
            cell.signInTime.textColor = [UIColor blackColor];
            cell.signInTime.text = [self nowTime];
            
            _indexRow = (int)indexPath.row;
            
            cell.signInTime.text = [self nowTime];
            _signInType = @"签到";
            NSString * identifier = [[NSUserDefaults standardUserDefaults] objectForKey:@"identifier"];
            NSString * userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
            
            [_loctionDic setValue:sign.StoreCode forKey:@"StoreCode"];
            [_loctionDic setValue:[self nowTime] forKey:@"Createtime"];
            [_loctionDic setValue:_signInType forKey:@"signInType"];
            [_loctionDic setValue:identifier forKey:@"identifier"];
            [_loctionDic setValue:userID forKey:@"userID"];
            [_loctionDic setValue:cell.signInMD.text forKey:@"storeName"];
            [_loctionDic setValue:cell.signInXM.text forKey:@"projectName"];
            [_loctionDic setValue:@"YES" forKey:@"btnSelect"];
            [KeepSignInInfo insertSignInTableWithTheDictionary:_loctionDic ];
            
            cell.signInBtn.enabled = NO;
            [cell.signInBtn setTitle:@"" forState:UIControlStateNormal];
            cell.signInBtn.backgroundColor = [UIColor clearColor];
            
            cell.goOueXM.text = @"";
            cell.goOutMD.text = @"";
            cell.goOutTime.text = @"";
            cell.goOutBtn.enabled = YES;
            isSelect[indexPath.row] = NO;
            [keepLocationInfo deletePlanDataStoreCode:sign.StoreCode];
            [self dataSelect];
        }else
        {
            TableViewCell * cell = (TableViewCell*)[_tableView cellForRowAtIndexPath:indexPath];
            
            _indexRow = (int)indexPath.row;
            
            SelectShopViewController * selectVC = [[SelectShopViewController alloc]init];
            selectVC.isQDOrPZ = 1;
            selectVC.signBlock = ^(NSString *storeName,NSString *projectName,NSString *Code){
                
                cell.signInMD.text = storeName;
                cell.signInXM.text = projectName;
                cell.signInTime.text = [self nowTime];
                cell.signInMD.textColor = [UIColor blackColor];
                cell.signInTime.textColor = [UIColor blackColor];
                cell.signInXM.textColor = [UIColor blackColor];
                cell.storeCode = Code;
                _signInType = @"签到";
                NSString * identifier = [[NSUserDefaults standardUserDefaults] objectForKey:@"identifier"];
                NSString * userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
                
                [_loctionDic setValue:Code forKey:@"StoreCode"];
                [_loctionDic setValue:[self nowTime] forKey:@"Createtime"];
                [_loctionDic setValue:_signInType forKey:@"signInType"];
                [_loctionDic setValue:identifier forKey:@"identifier"];
                [_loctionDic setValue:userID forKey:@"userID"];
                [_loctionDic setValue:storeName forKey:@"storeName"];
                [_loctionDic setValue:projectName forKey:@"projectName"];
                [_loctionDic setValue:@"YES" forKey:@"btnSelect"];
                [KeepSignInInfo insertSignInTableWithTheDictionary:_loctionDic ];
                
                cell.signInBtn.enabled = NO;
                [cell.signInBtn setTitle:@"" forState:UIControlStateNormal];
                cell.signInBtn.backgroundColor = [UIColor clearColor];
                
                [_signInArr insertObject:@"" atIndex:_signInArr.count -1];
                cell.goOutBtn.enabled = YES;
                [cell.goOutBtn setTitle:@"离点签出" forState:UIControlStateNormal];
                cell.goOutBtn.backgroundColor = [UIColor lightGrayColor];
                [self dataSelect];
            };
            [self.navigationController pushViewController:selectVC animated:YES];
        }
        }else
        {
            TableViewCell * cell = (TableViewCell*)[_tableView cellForRowAtIndexPath:indexPath];
            _indexRow = (int)indexPath.row;
            
            SelectShopViewController * selectVC = [[SelectShopViewController alloc]init];
            selectVC.isQDOrPZ = 1;
            selectVC.signBlock = ^(NSString *storeName,NSString *projectName,NSString *Code){
                cell.signInMD.text = storeName;
                cell.signInTime.textColor = [UIColor blackColor];
                cell.signInXM.textColor = [UIColor blackColor];
                cell.signInMD.textColor = [UIColor blackColor];
                cell.signInXM.text = projectName;
                cell.signInTime.text = [self nowTime];
                cell.storeCode = Code;
                _signInType = @"签到";
                
                NSString * identifier = [[NSUserDefaults standardUserDefaults] objectForKey:@"identifier"];
                NSString * userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
                
                [_loctionDic setValue:Code forKey:@"StoreCode"];
                [_loctionDic setValue:[self nowTime] forKey:@"Createtime"];
                [_loctionDic setValue:_signInType forKey:@"signInType"];
                [_loctionDic setValue:identifier forKey:@"identifier"];
                [_loctionDic setValue:userID forKey:@"userID"];
                [_loctionDic setValue:storeName forKey:@"storeName"];
                [_loctionDic setValue:projectName forKey:@"projectName"];
                [_loctionDic setValue:@"YES" forKey:@"btnSelect"];
                
                [self.locMgr startUpdatingLocation];
                
                [KeepSignInInfo insertSignInTableWithTheDictionary:_loctionDic ];
                
                cell.signInBtn.enabled = NO;
                [cell.signInBtn setTitle:@"" forState:UIControlStateNormal];
                cell.signInBtn.backgroundColor = [UIColor clearColor];
                
                [_signInArr insertObject:@"" atIndex:_signInArr.count -1];
                cell.goOutBtn.enabled = YES;
                [cell.goOutBtn setTitle:@"离点签出" forState:UIControlStateNormal];
                cell.goOutBtn.backgroundColor = [UIColor lightGrayColor];
                [self dataSelect];
            };
            [self.navigationController pushViewController:selectVC animated:YES];
        }
   // NSArray *arr = [KeepSignInInfo selectSginInTable];
    
}

#pragma mark -- 点击离点签出
- (void)goOutTimeCheck:(UIButton *)button event:(id)event
{
    
    [self.locMgr startUpdatingLocation];
    
    NSSet *touches =[event allTouches];
    UITouch *touch =[touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:_tableView];
    NSIndexPath *indexPath= [_tableView indexPathForRowAtPoint:currentTouchPosition];
    
    TableViewCell * cell = (TableViewCell*)[_tableView cellForRowAtIndexPath:indexPath];

    _indexRow = (int)indexPath.row;
    signInModel * signIn = _signInArr[_indexRow];
    cell.goOutTime.text = [self nowTime];
    _signInType = @"签出";
    NSString * identifier = [[NSUserDefaults standardUserDefaults] objectForKey:@"identifier"];
    NSString * userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    NSString * storeCode = signIn.StoreCode ;
    
    [_loctionDic setValue:storeCode forKey:@"StoreCode"];
    [_loctionDic setValue:[self nowTime] forKey:@"Createtime"];
    [_loctionDic setValue:_signInType forKey:@"signInType"];
    [_loctionDic setValue:identifier forKey:@"identifier"];
    [_loctionDic setValue:userID forKey:@"userID"];
    
//    [self.locMgr startUpdatingLocation];
    
    UIAlertView * alertVeiw = [[UIAlertView alloc]initWithTitle:@"确定要执行签出操作吗?" message:@"签出后不可更改!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alertVeiw show];
}
#pragma mark --UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:_indexRow inSection:0];
        TableViewCell * cell = (TableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
        cell.goOueXM.text = cell.signInXM.text;
        cell.goOutMD.text = cell.signInMD.text;
        cell.goOutTime.text = [self nowTime];
        cell.goOutBtn.backgroundColor = [UIColor clearColor];
        [cell.goOutBtn setTitle:@"" forState:UIControlStateNormal];
        cell.goOutBtn.enabled = NO;
        //[_locMgr stopUpdatingLocation];
        [self.locMgr startUpdatingLocation];
        [KeepSignInInfo upLoadDataWithTheDictionary:_loctionDic];
        
        [self dataSelect];
    }else
    {	
        //[_locMgr stopUpdatingLocation];
        [self.locMgr stopUpdatingLocation];
        return;
    }
}
- (NSString *)nowTime
{
    NSDate * date = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    return  [formatter stringFromDate:date];
}
#pragma mark --CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //CLLocation *loc = [locations firstObject];
    CLLocation *loc = [locations lastObject];
    //NSLog(@"%@",loc);
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSString * timestamo = [formatter stringFromDate:loc.timestamp];
    // 2.取出经纬度
    CLLocationCoordinate2D coordinate = loc.coordinate;
    CLLocationCoordinate2D test = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude);

    NSDictionary *testdic   = BMKConvertBaiduCoorFrom(test, BMK_COORDTYPE_GPS);
    NSString * latitude     = [NSString stringWithBase64EncodedString:[testdic objectForKey:@"y"]];
    NSString * longitude    = [NSString stringWithBase64EncodedString:[testdic objectForKey:@"x"]];
    NSString * LocationType =[LoginInfoToll locationType];
    [_loctionDic setValue:LocationType  forKey:@"LocationType"];
    [_loctionDic setValue:timestamo     forKey:@"LocationTtime"];
    [_loctionDic setValue:latitude      forKey:@"Latitude"];
    [_loctionDic setValue:longitude     forKey:@"Longitude"];
}
#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _signInArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.signInBtn.layer.masksToBounds = YES;
    cell.signInBtn.layer.cornerRadius = 5;
    cell.goOutBtn.layer.masksToBounds = YES;
    cell.goOutBtn.layer.cornerRadius = 5;
    [cell.signInBtn addTarget:self action:@selector(signInTimeCheck:event:) forControlEvents:UIControlEventTouchUpInside];
    [cell.goOutBtn addTarget:self action:@selector(goOutTimeCheck:event:) forControlEvents:UIControlEventTouchUpInside];
    signInModel * signIn = _signInArr[indexPath.row];
    
    if (_signInArr.count > 1) {
        
        if (indexPath.row == _signInArr.count-1) {
            cell.signInBtn.enabled = YES;
            [cell.signInBtn setTitle:@"到点签到" forState:UIControlStateNormal];
            cell.signInBtn.backgroundColor = [UIColor lightGrayColor];
            cell.signInMD.text = @"";
            cell.signInTime.text = @"";
            cell.signInXM.text = @"";
            
            cell.goOutBtn.enabled = NO;
            [cell.goOutBtn setTitle:@"离点签出" forState:UIControlStateNormal];
            cell.goOutBtn.backgroundColor = [UIColor lightGrayColor];
            cell.goOueXM.text = @"";
            cell.goOutMD.text = @"";
            cell.goOutTime.text = @"";
        } else
        {
            if (isSelect[indexPath.row] == YES) {
                cell.signInBtn.backgroundColor = [UIColor clearColor];
                [cell.signInBtn setTitle:@"" forState:UIControlStateNormal];
                cell.signInBtn.enabled = YES;
                cell.signInMD.text = signIn.storeName;
                cell.signInXM.text = signIn.projectName;
                cell.signInTime.text = @"点击签到";
                cell.signInTime.textColor = [UIColor redColor];
                
                cell.goOutBtn.enabled = NO;
                [cell.goOutBtn setTitle:@"离点签出" forState:UIControlStateNormal];
                cell.goOutBtn.backgroundColor = [UIColor lightGrayColor];
                cell.goOueXM.text = @"   ";
                cell.goOutMD.text = @"   ";
                cell.goOutTime.text = @"   ";
                
            }else if(isSelect[indexPath.row] == NO && [signIn.goOutCreatetime isEqualToString:@"null"])
            {
                cell.signInBtn.backgroundColor = [UIColor clearColor];
                [cell.signInBtn setTitle:@"" forState:UIControlStateNormal];
                cell.signInBtn.enabled = NO;
                cell.signInMD.text = signIn.storeName;
                cell.signInXM.text = signIn.projectName;
                cell.signInTime.text = signIn.signCreatetime;
                cell.signInMD.textColor = [UIColor blackColor];
                cell.signInXM.textColor = [UIColor blackColor];
                cell.signInTime.textColor = [UIColor blackColor];
                cell.goOutBtn.enabled = YES;
                [cell.goOutBtn setTitle:@"离点签出" forState:UIControlStateNormal];
                cell.goOutBtn.backgroundColor = [UIColor lightGrayColor];
                cell.goOueXM.text = @"";
                cell.goOutMD.text = @"";
                cell.goOutTime.text = @"";
                
            }else
            {
                cell.signInBtn.backgroundColor = [UIColor clearColor];
                [cell.signInBtn setTitle:@"" forState:UIControlStateNormal];
                cell.signInBtn.enabled = NO;
                cell.signInMD.text = signIn.storeName;
                cell.signInXM.text = signIn.projectName;
                cell.signInTime.text = signIn.signCreatetime;
                
                cell.goOutBtn.enabled = NO;
                [cell.goOutBtn setTitle:@"" forState:UIControlStateNormal];
                cell.goOutBtn.backgroundColor = [UIColor clearColor];
                cell.goOueXM.text = signIn.projectName;
                cell.goOutMD.text = signIn.storeName;
                cell.goOutTime.text = signIn.goOutCreatetime;
            }
        }
    }else
    {
        cell.signInBtn.enabled = YES;
        [cell.signInBtn setTitle:@"到点签到" forState:UIControlStateNormal];
        cell.signInBtn.backgroundColor = [UIColor lightGrayColor];
        cell.signInMD.text = @"";
        cell.signInTime.text = @"";
        cell.signInXM.text = @"";
        
        cell.goOutBtn.enabled = NO;
        [cell.goOutBtn setTitle:@"离点签出" forState:UIControlStateNormal];
        cell.goOutBtn.backgroundColor = [UIColor lightGrayColor];
        cell.goOueXM.text = @"";
        cell.goOutMD.text = @"";
        cell.goOutTime.text = @"";
    }
    return cell;
}
#pragma mark --UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
#pragma mark -- 搜索数据库,获取基础元素
- (void)dataSelect
{
    for (int i = 0;i < 100;i++) {
        isSelect[i] = NO;
    }
    NSDate * now = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
//    NSString * nowDate = [formatter stringFromDate:now];
//    NSString * userID =[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    
//    NSMutableArray * PatrolArr = [keepLocationInfo selectPlanWithDate:nowDate andUserID:userID];
    NSMutableArray * PatrolArr = [KeepSignInInfo selectSginInTable];
    for (int i =0; i < PatrolArr.count; i ++) {
        isSelect[i] = YES;
    }
    
    if (PatrolArr.count != 0) {
        _signInArr = PatrolArr;
        NSMutableArray * arr = [KeepSignInInfo selectCheckTable];
        if (arr != nil)
        {
            [_signInArr addObjectsFromArray:arr];
            [_signInArr insertObject:@"" atIndex:_signInArr.count];
            [_tableView reloadData];
        }else
        {
            [_signInArr addObject:@""];
        }
    }else
    {
        NSMutableArray * arr = [KeepSignInInfo selectCheckTable];
        if (arr != nil)
        {
            _signInArr = arr;
            [_signInArr insertObject:@"" atIndex:_signInArr.count];
            [_tableView reloadData];
        }else
        {
            [_signInArr addObject:@""];
        }
    }
    [_tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
