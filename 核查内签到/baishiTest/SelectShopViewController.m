//
//  SelectShopViewController.m
//  Essence
//
//  Created by EssIOS on 15/5/8.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//
#define USER_ID [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]

#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width

#import "SelectShopViewController.h"
#import "keepLocationInfo.h"
#import "StoreMD.h"
#import "SelectMDController.h"
#import "SignInController.h"
#import "PatrolPictureViewController.h"
#import "SellViewController.h"
#import "ShopLocationController.h"

#import "PGRecruitViewController.h"

#import "ViewController.h"

#import "ProductViewController.h"

#import "StoreDetailViewController.h"

#import "programList.h"

@interface SelectShopViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSMutableArray * _storeName ;
    NSMutableArray * _projectName;
    NSMutableArray * _projectSchedule;
    UIPickerView   * _pickerView;
    
    BOOL             _isWho;
}
@end
@implementation SelectShopViewController
- (void)viewWillAppear:(BOOL)animated
{
    _hideDQ.hidden=YES;
    _hideDqLab.hidden=YES;
    _locationDq.hidden=YES;
    _selectDQ.hidden=YES;
    self.tabBarController.tabBar.hidden = YES;
    NSMutableArray * dataArray =  [keepLocationInfo selectAllStoreName];
    NSSet * set = [NSSet setWithArray:dataArray];
//    NSLog(@"set-->%d",set.count);
    [_storeName removeAllObjects];
    
//    NSLog(@"total-->%d",dataArray.count);
    for (NSString * storeName in set)
    {
        [_storeName addObject:storeName];
    }
//    for (StoreMD * model in dataArray)
//    {
//        [_storeName addObject:model];
//    }
//    NSLog(@"%d",_storeName.count);
    _pickerView.frame =CGRectMake(0, HEIGHT,WIDTH, 180) ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _storeName                          = [NSMutableArray array];
    _projectName                        = [NSMutableArray array];
    _projectSchedule                    = [NSMutableArray array];
    _pickerView                         = [[UIPickerView alloc]initWithFrame:CGRectMake(0,HEIGHT ,WIDTH, 200)];
    _pickerView.delegate                = self;
    _pickerView.dataSource              = self;
    _pickerView.backgroundColor         = [UIColor whiteColor];
    _pickerView.showsSelectionIndicator = YES;
    
    self.title        = @"选择门店";
    _selectDQ.enabled = NO;
    _selectXM.enabled = NO;
    
    [self.view addSubview:_pickerView];
}
// 选择门店 先选择门店才能选择项目 档期
- (IBAction)selectMD:(UIButton *)sender {
    
    SelectMDController * selectMD = [[SelectMDController alloc]init];
    selectMD.dataArray            = _storeName;
    [_projectName removeAllObjects];
    selectMD.selectStoreNameBlock = ^(NSString * storeName)
    {
        _StoreNameLB.text       = storeName;
        
        NSMutableArray * arr    = [keepLocationInfo selectXMAndDQ:storeName];
        
        StoreMD * storeMD       =arr[0];
        _ProjectNameLB.text     = storeMD.ProjectName;
        _ProjectScheduleLB.text = storeMD.Name;
        
        for (StoreMD * store in arr)
        {
            [_projectName addObject:store.ProjectName];
        }
        [_pickerView reloadComponent:0];
        _selectXM.enabled = YES;
    };
    [self.navigationController pushViewController:selectMD animated:YES];
}
// 选择项目
- (IBAction)selectXM:(UIButton *)sender {
    _isWho = YES;
    [_pickerView reloadAllComponents];
    _selectDQ.enabled = YES;
    [UIView animateWithDuration:0.5 animations:^{
        _pickerView.frame = CGRectMake(0, HEIGHT-180, WIDTH, 180) ;
    }];
}
// 选择档期
- (IBAction)selectDQ:(UIButton *)sender {
    _isWho = NO;
    [UIView animateWithDuration:0.5 animations:^{
        _pickerView.frame = CGRectMake(0, HEIGHT-180,WIDTH, 180) ;
    }];
    
    [_pickerView reloadAllComponents];
}
// 跳转门店定位页面
- (IBAction)loctionMD:(UIButton *)sender {
    ShopLocationController * shopLoction = [[ShopLocationController alloc]initWithArr:_storeName];
    [self.navigationController pushViewController:shopLoction animated:YES];
    
}
// 判断选择信息是否正确
- (IBAction)selectOK:(UIButton *)sender {
     
    if ([_StoreNameLB.text isEqualToString:@"点击选择门店"]||[_ProjectNameLB.text isEqualToString:@"点击选择项目"]||[_ProjectScheduleLB.text isEqualToString:@"点击选择档期"]) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"友情提示" message:@"亲,还没选择完成哦~" delegate:nil cancelButtonTitle:@"知道了!" otherButtonTitles:nil, nil];
        
        [alert show];
        return;
    }
    if (_isQDOrPZ == 1)
    {
        NSString * storeCode = [keepLocationInfo selectStroeCodeWithTheStoreName:_StoreNameLB.text andProjectName:_ProjectNameLB.text];
        
        self.signBlock(_StoreNameLB.text,_ProjectNameLB.text,storeCode);


        ProductModel *productM=[[ProductModel alloc]init];
        productM.userID=USER_ID;
        
        productM.CreateUserId=USER_ID;
        productM.CreateDate=[self nowTime];

        
        NSDictionary *dic=[keepLocationInfo selectCodeWithTheStoreName:_StoreNameLB.text andProjectName:_ProjectNameLB.text];
        NSLog(@"dic-->>%@",dic);
        productM.Code=[dic objectForKey:@"code"];
        productM.StoreId=[dic objectForKey:@"storeCode"];
        productM.ProjectId=[dic objectForKey:@"projectCode"];
        //            productM.ProductId=IDArr[indexPath.row];
        NSString *typeStr=[_StoreNameLB.text substringToIndex:3];
        NSLog(@"type:%@",typeStr);
#pragma mark 跳转
    
        programList *proList=[[programList alloc]init];
        [self.navigationController pushViewController:proList animated:YES];

    }
    if (_isQDOrPZ == 2)
    {
        PatrolPictureViewController * patrolvc= [[PatrolPictureViewController alloc]init];
        patrolvc.storeCode = _StoreNameLB.text;
        patrolvc.projectName = _ProjectNameLB.text;
        [self.navigationItem.backBarButtonItem setTitle:@"返回"];
        [self.navigationController pushViewController:patrolvc animated:YES];
    }if (_isQDOrPZ == 3)
    {
        SellViewController * sellVC = [[SellViewController alloc]init];
        sellVC.storeName = _StoreNameLB.text;
        sellVC.projectName = _ProjectNameLB.text;
        [self.navigationController pushViewController:sellVC animated:YES];
    }
    if (_isQDOrPZ == 4)
    {
        PGRecruitViewController *PGRVC = [[PGRecruitViewController alloc]init];
        PGRVC.storeName =_StoreNameLB.text;
        PGRVC.projectName = _ProjectNameLB.text;
        
        [self.navigationController pushViewController:PGRVC animated:YES];
    }
}
#pragma mark -- UIPickerViewDataSource ,UIPickerViewDelegate
// picker选择结束
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (_isWho == YES)
    {
        return _projectName[row];
    }else
    {
        return _projectSchedule[row];
    }
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (_isWho == YES)
    {
        return _projectName.count;
    }else
    {
        return _projectSchedule.count;
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (_isWho == YES)
    {
        _ProjectNameLB.text  = _projectName[row];
        
        NSMutableArray * arr = [keepLocationInfo selectDQWithTheStoreName:_StoreNameLB.text andProjectName:_projectName[row]];
        [_projectSchedule removeAllObjects];
        for (StoreMD * store in arr)
        {
            [_projectSchedule addObject:store.Name];
            _ProjectScheduleLB.text = store.Name;
        }
    }else
    {
        _ProjectScheduleLB.text     = _projectSchedule[row];
    }
}
- (NSString *)nowTime
{
    NSDate * date = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    return  [formatter stringFromDate:date];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.5 animations:^{
        
        _pickerView.frame = CGRectMake(0, HEIGHT, WIDTH, 180) ;
    }];
}
@end
