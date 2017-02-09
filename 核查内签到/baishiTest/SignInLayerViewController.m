  //
//  SignInLayerViewController.m
//  Essence
//
//  Created by EssIOS on 15/7/21.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//
#define USER_ID [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]

#import "SignInLayerViewController.h"
#import "SelectShopViewController.h"
#import "SigInLayerCell.h"
#import "keepLocationInfo.h"
#import "KeepSignInInfo.h"
#import "Base64.h"
#import "LoginInfoToll.h"
#import "BMapKit.h"
#import "signInModel.h"
#import "SignInController.h"

#import "ViewController.h"

#import "ProductViewController.h"
#import "ProductModel.h"
#import "StoreDetailViewController.h"
#import "DetailVC.h"
#import "programList.h"
@interface SignInLayerViewController ()<CLLocationManagerDelegate,UIAlertViewDelegate>
{
    NSMutableArray *_signInArray;
    NSMutableDictionary *_loctionDic;
    int   _sigInRow;
    int   _indexRow;
    BOOL isSelect[100];
    NSString *_companyID;
    SelectShopViewController * selectVC;
    UIAlertView * LocationAlert;


}
@end

@implementation SignInLayerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"到点签到";
    _signInArray = [[NSMutableArray alloc]init];
    _sigInRow = -1;
    _loctionDic = [NSMutableDictionary dictionary];
//    _companyID = [NSDictionary  dictionary];
//    _SigInTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.locMgr = [[CLLocationManager alloc]init];
    self.locMgr.delegate = self;
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务当前可能尚未打开，请设置打开！");
        return;
    }
    
    //如果没有授权则请求用户授权
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
        [self.locMgr requestWhenInUseAuthorization];
    }else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse){
        //设置代理
        self.locMgr.delegate=self;
        //设置定位精度
        self.locMgr.desiredAccuracy=kCLLocationAccuracyBest;
        //定位频率,每隔多少米定位一次
        CLLocationDistance distance=10.0;//十米定位一次
        self.locMgr.distanceFilter=distance;
        //启动跟踪定位
        [self.locMgr startUpdatingLocation];
    }
    [self.locMgr startUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status) {
        casekCLAuthorizationStatusNotDetermined:
            if ([self.locMgr respondsToSelector:@selector(requestAlwaysAuthorization)]) {
//                [self.locMgr equestWhenInUseAuthorization];
            }
            break;
            
        default:
            break;
    }
}

-(void)setWithArr:(NSString *)arr
{
    _companyID = arr;
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    [user setValue:_companyID forKey:_companyID];
//    [user synchronize];
    //    NSString *Id = [_companyID objectForKey:@"Id"];
    //    [_loctionDic setValue:Id forKey:@"Id"];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
    [self dataSelect];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [self.locMgr stopUpdatingLocation];
    UIAlertView *alert=(UIAlertView *)[self.view viewWithTag:101];
    [alert dismissWithClickedButtonIndex:0 animated:YES];
    
}

-(void)being
{
    UIAlertView  *alertView = [[UIAlertView alloc]initWithTitle:@"确定要执行签出操作吗?" message:@"签出后不可更改" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}
#pragma mark -- 点击到点签到
- (void)signInTimeCheck:(UIButton *)button event:(id)event
{
//    [self.locMgr startUpdatingLocation];
//    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"定位中,请稍等" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    [alert show];
//            [self showLocationAlert];
    NSSet *touches =[event allTouches];
    UITouch *touch =[touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:_SigInTableView];
    NSIndexPath *indexPath= [_SigInTableView indexPathForRowAtPoint:currentTouchPosition];
    
    SigInLayerCell * cell = (SigInLayerCell*)[_SigInTableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.row != _signInArray.count-1) {
        if (![cell.signInMD.text isEqualToString:@""]) {

            
            ProductModel *productM=[[ProductModel alloc]init];
            productM.userID=USER_ID;
            
            productM.CreateUserId=USER_ID;
            productM.CreateDate=[self nowTime];

            NSDictionary *dic=[keepLocationInfo selectCodeWithTheStoreName:cell.signInMD.text andProjectName:cell.signInXM.text];
            NSLog(@"dic-->>%@",dic);
            productM.Code=[dic objectForKey:@"code"];
            productM.StoreId=[dic objectForKey:@"storeCode"];
            productM.ProjectId=[dic objectForKey:@"projectCode"];
            NSString *typeStr=[cell.signInMD.text substringToIndex:3];
            NSLog(@"type:%@",typeStr);
            
            programList *proList=[[programList alloc]init];
            [self.navigationController pushViewController:proList animated:YES];
#pragma mark 跳转标记
        }else
        {
#pragma mark test

            SigInLayerCell * cell = (SigInLayerCell*)[_SigInTableView cellForRowAtIndexPath:indexPath];
            _indexRow = (int)indexPath.row;
            selectVC = [[SelectShopViewController alloc]init];
            selectVC.isQDOrPZ = 1;
            selectVC.signBlock = ^(NSString *storeName,NSString *projectName,NSString *Code){
                
                cell.signInMD.text = storeName;
                cell.signInXM.text = projectName;
                cell.signInTime.text = [self nowTime];
                cell.signInMD.textColor = [UIColor blackColor];
                cell.signInTime.textColor = [UIColor blackColor];
                cell.signInXM.textColor = [UIColor blackColor];
                cell.storeCode = Code;
//                cell.imgV.hidden=NO;
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
                NSLog(@"all -->>>\n\n%@",_loctionDic);
                [KeepSignInInfo insertSignInTableWithTheDictionary:_loctionDic ];
                
//                [keepLocationInfo keepLoginInfo:_loctionDic];
                cell.signInBtn.enabled = NO;
                [cell.signInBtn setTitle:@"" forState:UIControlStateNormal];
                cell.signInBtn.backgroundColor = [UIColor clearColor];
                
                [_signInArray insertObject:@"" atIndex:_signInArray.count -1];
                cell.goOutBtn.enabled = YES;
                [cell.goOutBtn setTitle:@"离点签出" forState:UIControlStateNormal];
                cell.goOutBtn.backgroundColor = [UIColor lightGrayColor];
//                [self dataSelect];
            };
            [self.navigationController pushViewController:selectVC animated:YES];
        }
    }else
    {
#pragma mark test
//        [self.locMgr startUpdatingLocation];
//
//            [self showLocationAlert];
        SigInLayerCell * cell = (SigInLayerCell *)[_SigInTableView cellForRowAtIndexPath:indexPath];
        _indexRow = (int)indexPath.row;
        
        selectVC = [[SelectShopViewController alloc]init];
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
            
            [self.locMgr stopUpdatingLocation];
            [KeepSignInInfo insertSignInTableWithTheDictionary:_loctionDic ];
            [keepLocationInfo keepLoginInfo:_loctionDic];
            NSLog(@"judge-->>%@",_loctionDic);
            [_loctionDic setValue:nil forKey:@"Longitude"];
            NSLog(@"judge-->>%@",_loctionDic);
            cell.signInBtn.enabled = NO;
            [cell.signInBtn setTitle:@"" forState:UIControlStateNormal];
            cell.signInBtn.backgroundColor = [UIColor clearColor];
            
            [_signInArray insertObject:@"" atIndex:_signInArray.count -1];
            cell.goOutBtn.enabled = YES;
            [cell.goOutBtn setTitle:@"离点签出" forState:UIControlStateNormal];
            cell.goOutBtn.backgroundColor = [UIColor lightGrayColor];
            
            
            
        };

        [self.navigationController pushViewController:selectVC animated:YES];

            }

}
-(void)showLocationAlert
{
    LocationAlert = [[UIAlertView alloc]initWithTitle:@"定位中,请稍等" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    LocationAlert.tag=101;
    [LocationAlert show];
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:3];
}
-(void)dismiss
{
//    UIAlertView *LocationAlert=(UIAlertView *)[self.view viewWithTag:101];
    [LocationAlert dismissWithClickedButtonIndex:0 animated:YES];
}
-(void)locationF
{
      static int i;
    if ([_loctionDic valueForKey:@"Longitude"])
    {
        
        [self.navigationController pushViewController:selectVC animated:YES];
        
    }
    else
    {
        i++;
        if (i==3) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"很遗憾，获取GPS失败，系统将允许你完成本次签到.\n请在稍后拍摄一张带时间验证的门头照到形象照中。" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag=2001;
            [alert show];
            i=0;
            //                [self.navigationController pushViewController:selectVC animated:YES];
        }else
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"获取GPS坐标失败，请检查GPS开关是否打开，并在室外露天环境进行签到" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        
    }
}

#pragma mark -- 点击离点签出
- (void)goOutTimeCheck:(UIButton *)button event:(id)event
{

    
    [self.locMgr startUpdatingLocation];
    [self showLocationAlert];
    NSSet *touches =[event allTouches];
    UITouch *touch =[touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:_SigInTableView];
    NSIndexPath *indexPath= [_SigInTableView indexPathForRowAtPoint:currentTouchPosition];
    
    SigInLayerCell * cell = (SigInLayerCell*)[_SigInTableView cellForRowAtIndexPath:indexPath];
    
    _indexRow = (int)indexPath.row;
    NSMutableArray * arr = [KeepSignInInfo selectSginInTable];
//    _companyID = arr[_indexRow][@"companyCode"];
//    NSArray *array = arr[_indexRow];
    signInModel *signIN = arr[_indexRow];
    
    
    signInModel * signIn = _signInArray[_indexRow];
    cell.goOutTime.text = [self nowTime];
    _signInType = @"签出";
    NSString * identifier = [[NSUserDefaults standardUserDefaults] objectForKey:@"identifier"];
    NSString * userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    NSString * storeCode = signIn.StoreCode ;
    _companyID = signIN.companyCode;
    NSLog(@"ID%@",_companyID);
    NSLog(@"%@",_loctionDic);
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    _companyID = [user objectForKey:_companyID];
    [_loctionDic setValue:storeCode forKey:@"StoreCode"];
    [_loctionDic setValue:[self nowTime] forKey:@"Createtime"];
    [_loctionDic setValue:_signInType forKey:@"signInType"];
    [_loctionDic setValue:identifier forKey:@"identifier"];
    [_loctionDic setValue:userID forKey:@"userID"];
    [_loctionDic setValue:_companyID forKey:@"Id"];
    //    [self.locMgr startUpdatingLocation];
    NSLog(@"_loctionDic-->>%@",_loctionDic);
    [self performSelector:@selector(location) withObject:nil afterDelay:3];
    
}
-(void)location
{
        static int j;
    if ([_loctionDic objectForKey:@"Longitude"])
    {
        UIAlertView * alertVeiw = [[UIAlertView alloc]initWithTitle:@"确定要执行签出操作吗?" message:@"签出后不可更改!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [alertVeiw show];
    }
    else
    {
        
        j++;
        if (j==3) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"很遗憾，获取GPS失败，系统将允许你完成本次签到.\n请在稍后拍摄一张带时间验证的门头照到形象照中." message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag=1001;
            [alert show];
            j=0;
            //                [self.navigationController pushViewController:selectVC animated:YES];
        }else
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"获取GPS坐标失败，请检查GPS开关是否打开，并在室外露天环境进行签到." message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }

}
#pragma mark -- UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1000) {
        NSLog(@"重新定位");
    }
    else if(alertView.tag==2001)
    {
        
    [self.navigationController pushViewController:selectVC animated:YES];
    }
    else if(alertView.tag==1001)
    {
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:_indexRow inSection:0];
        SigInLayerCell * cell = (SigInLayerCell *)[_SigInTableView cellForRowAtIndexPath:indexPath];
        
        if(![cell.signInXM.text isEqualToString:@"(null)"])
        {
            cell.goOueXM.text = cell.signInXM.text;
        }
        else
        {
            cell.goOutMD.text = cell.signInMD.text;
        }
        
        //        if ([_loctionDic objectForKey:@"Longitude"]) {
        cell.goOutTime.text = [self nowTime];
        cell.goOutBtn.backgroundColor = [UIColor clearColor];
        [cell.goOutBtn setTitle:@"" forState:UIControlStateNormal];
        cell.goOutBtn.enabled = NO;
        //[_locMgr stopUpdatingLocation];
        //            [self.locMgr startUpdatingLocation];
        NSLog(@"_loctionDic--->>%@\n\n",_loctionDic);
        if(![[_loctionDic objectForKey:@"StoreCode"] isEqualToString:@""])
        {
            [KeepSignInInfo upLoadDataWithTheDictionary:_loctionDic];
            //
        }else
        {
            [KeepSignInInfo upLoadDataWithTheDictionary2:_loctionDic];
        }
        [_loctionDic setValue:nil forKey:@"Longitude"];
        NSLog(@"_loctionDic--->>%@\n\n",_loctionDic);
        [self.locMgr stopUpdatingLocation];
        [self dataSelect];


    }
    else{
    if (buttonIndex == 1)
    {
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:_indexRow inSection:0];
        SigInLayerCell * cell = (SigInLayerCell *)[_SigInTableView cellForRowAtIndexPath:indexPath];
        
        if(![cell.signInXM.text isEqualToString:@"(null)"])
        {
            cell.goOueXM.text = cell.signInXM.text;
        }
        else
        {
            cell.goOutMD.text = cell.signInMD.text;
        }

//        if ([_loctionDic objectForKey:@"Longitude"]) {
            cell.goOutTime.text = [self nowTime];
            cell.goOutBtn.backgroundColor = [UIColor clearColor];
            [cell.goOutBtn setTitle:@"" forState:UIControlStateNormal];
            cell.goOutBtn.enabled = NO;
            //[_locMgr stopUpdatingLocation];
//            [self.locMgr startUpdatingLocation];
            NSLog(@"_loctionDic--->>%@\n\n",_loctionDic);
            if(![[_loctionDic objectForKey:@"StoreCode"] isEqualToString:@""])
            {
                [KeepSignInInfo upLoadDataWithTheDictionary:_loctionDic];
                //
            }else
            {
                [KeepSignInInfo upLoadDataWithTheDictionary2:_loctionDic];
            }
                    [_loctionDic setValue:nil forKey:@"Longitude"];
                        NSLog(@"_loctionDic--->>%@\n\n",_loctionDic);
                    [self.locMgr stopUpdatingLocation];
            [self dataSelect];
   
    }else
    {
    [self.locMgr stopUpdatingLocation];
        return;
    }
    }
    
}

#pragma mark -- 搜索数据库,获取基础元素
- (void)dataSelect
{
//    NSLog(@"%@",self.ProjectName);
    
    for (int i =0; i<100; i++) {
        isSelect[i]= NO;
    }
    NSDate *now = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *nowDate = [formatter stringFromDate:now];
    NSString *userID = [[NSUserDefaults standardUserDefaults]objectForKey:@"userID"];
    
    NSMutableArray * PatrolArr = [keepLocationInfo selectPlanWithDate:nowDate andUserID:userID];
    for (int i =0; i < PatrolArr.count; i ++) {
        isSelect[i] = YES;    
    }
    
    if (PatrolArr.count != 0) {
        _signInArray = PatrolArr;
        NSMutableArray * arr = [KeepSignInInfo selectSginInTable];
//        NSMutableArray * arr = [KeepSignInInfo selectCheckTable];
        if (arr != nil)
        {
            [_signInArray addObjectsFromArray:arr];
            [_signInArray insertObject:@"" atIndex:_signInArray.count];
            [_SigInTableView reloadData];
        }else
        {
            [_signInArray addObject:@""];
        }
    }else
    {
        NSMutableArray * arr = [KeepSignInInfo selectSginInTable];
//        NSMutableArray *arr = [KeepSignInInfo selectCheckTable];
        if (arr != nil)
        {
            _signInArray = arr;
            [_signInArray insertObject:@"" atIndex:_signInArray.count];
            [_SigInTableView reloadData];
        }else
        {
            [_signInArray addObject:@""];
        }
        
    }
    NSLog(@"%@",_signInArray[0]);
    [_SigInTableView reloadData];
//    signInModel *sinMOdel = [[signInModel alloc] init];
//    sinMOdel.projectName = self.ProjectName;
}

- (NSString *)nowTime
{
    NSDate * date = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    return  [formatter stringFromDate:date];
}

#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _signInArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SigInLayerCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];

    if(cell == nil)
    {
        cell = [[[NSBundle  mainBundle] loadNibNamed:@"SigInLayerCell" owner:self options:nil] lastObject];
    }
//    SigInLayerCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SigInLayerCell" forIndexPath:nil];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.signInBtn.layer.masksToBounds = YES;
    cell.signInBtn.layer.cornerRadius = 5;
    cell.goOutBtn.layer.masksToBounds = YES;
    cell.goOutBtn.layer.cornerRadius = 5;
    [cell.signInBtn addTarget:self action:@selector(signInTimeCheck:event:) forControlEvents:UIControlEventTouchUpInside];
    [cell.goOutBtn addTarget:self action:@selector(goOutTimeCheck:event:) forControlEvents:UIControlEventTouchUpInside];
    signInModel * signIn = _signInArray[indexPath.row];
    
    
//                    cell.imgV.hidden=YES;
    
    if (_signInArray.count > 1) {
        
        if (indexPath.row == _signInArray.count-1) {
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
            cell.imgV.hidden=YES;
        } else
        {
            if (isSelect[indexPath.row] == YES) {

                
            }else if(isSelect[indexPath.row] == NO && [signIn.checkOutTime isEqualToString:@"null"])
            {
                int j=0;
                NSLog(@"j%d",j++);
                NSLog(@"%@",[_signInArray[0] checkOutTime]);
                cell.signInBtn.backgroundColor = [UIColor clearColor];
                [cell.signInBtn setTitle:@"" forState:UIControlStateNormal];
                
//                cell.signInBtn.enabled = NO;
                
                if(![signIn.storeName isEqualToString:@"(null)"])
                {
                    cell.signInMD.text = signIn.storeName;
                    NSLog(@"%@",signIn.storeName);
                }
                else
                {
                    cell.signInMD.text = signIn.companyName;
                }
                cell.signInXM.text = signIn.projectName;
                cell.signInTime.text = signIn.checkInTime;
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
                int i=0;
                NSLog(@"i%d",i++);
                cell.signInBtn.backgroundColor = [UIColor clearColor];
                [cell.signInBtn setTitle:@"" forState:UIControlStateNormal];
                cell.signInBtn.enabled = NO;
                if(![signIn.storeName isEqualToString:@"(null)"])
                {
                    cell.signInMD.text = signIn.storeName;
                    NSLog(@"%@",signIn.storeName);
                }
                else
                {
                    cell.signInMD.text = signIn.companyName;
                }
                cell.signInXM.text = signIn.projectName;
                cell.signInTime.text = signIn.checkInTime;
                
                cell.goOutBtn.enabled = NO;
                [cell.goOutBtn setTitle:@"" forState:UIControlStateNormal];
                cell.goOutBtn.backgroundColor = [UIColor clearColor];
                cell.goOueXM.text = signIn.projectName;
                cell.imgV.hidden=YES;
                /**
                 *    cell.goOutBtn.enabled = NO;
                 [cell.goOutBtn setTitle:@"离点签出" forState:UIControlStateNormal];
                 cell.goOutBtn.backgroundColor = [UIColor lightGrayColor];
                 cell.goOueXM.text = @"";
                 cell.goOutMD.text = @"";
                 cell.goOutTime.text = @"";
                 */
                if(![signIn.storeName isEqualToString:@"(null)"])
                {
                    cell.goOutMD.text = signIn.storeName;
                }
                else
                {
                   cell.goOutMD.text = signIn.companyName;
                }
                cell.goOutTime.text = signIn.checkOutTime;
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
//    NSLog(@"DDDD-->>%@",_loctionDic);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)patrol:(UIButton *)sender {

}

- (IBAction)company:(UIButton *)sender {

    
}

- (IBAction)project:(UIButton *)sender {
    

}
-(void)viewDidAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}
@end
