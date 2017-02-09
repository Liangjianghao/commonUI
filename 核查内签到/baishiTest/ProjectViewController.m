//
//  ProjectViewController.m
//  baishiTest
//
//  Created by EssIOS on 15/12/18.
//  Copyright © 2015年 ljh. All rights reserved.
//

#import "ProjectViewController.h"
#import "NetWorkTools.h"
#import "LoginInfoToll.h"
#import "MD5Tool.h"
#import "keepLocationInfo.h"
#import "StoreViewController.h"
@interface ProjectViewController ()
{
    NSMutableArray *dataArr;
    UIAlertView * _alert;
    UITableView *tableView;
}
@end

@implementation ProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"项目";
    [self loadData];
    [self uiConfig];
    
}
-(void)loadData
{
    dataArr=[[NSMutableArray alloc]init];
    NSString *password=@"111111";
       // 新密码进行MD5 加密
        password = [MD5Tool MD5WithString:password];
 
    [NetWorkTools loginWithLoginName:@"pgapp" password:password withBlock:^(NSDictionary *result, NSError *error) {
        
        
        NSString * userID = [[result objectForKey:@"UserId"] objectForKey:@"text"];
        if ([userID intValue] == 0){
            [_alert setTitle:@"账号密码错误!"];
            [_alert show];
            [UIView animateWithDuration:4 animations:^{
                [_alert dismissWithClickedButtonIndex:0 animated:YES];
            }];
            return;
        }else
        {
            [_alert dismissWithClickedButtonIndex:0 animated:YES];
            
            [_locationInfo setObject:userID forKey:@"userID"];
            //            [_alert setTitle:@"奋力加载中,请稍后~"];
            [LoginInfoToll keepFirstLogin:_locationInfo];
            [LoginInfoToll preserveUserInfo:result username:@"pgapp" password:password MMPSWBtn:nil autoLogbtn:nil sucessBlock:^(bool isFirstLog) {
                
            } failedBlock:^(bool isFirstLog) {
                
            }];
        }
        NSMutableArray * Projects =  [keepLocationInfo selectAllProjectName];
        NSSet * set = [NSSet setWithArray:Projects];

        [dataArr removeAllObjects];
        

        for (NSString * storeName in set)
        {
            [dataArr addObject:storeName];
        }
//        dataArr=[keepLocationInfo selectAllProjectName];
        [tableView reloadData];
        NSLog(@"dataArr-->\n%@",dataArr);
        NSDate * date = [NSDate date];
        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";

//                [NetWorkTools getBaseDataWithUserID:userID nowTime:[formatter stringFromDate:date] withBlock:^(NSString *result, NSError *error) {
//                    NSLog(@"%@",result);
//                    [_alert setTitle:@"加载完成!"];
//                    [UIView animateWithDuration:4 animations:^{
//        
//                        [_alert dismissWithClickedButtonIndex:0 animated:YES];
//        
//                    }];
//        
//                } failedBlock:^(NSString *result, NSError *error) {
//        
//                    [_alert setTitle:@"数据更新失败!"];
//                    [UIView animateWithDuration:4 animations:^{
//        
//                        [_alert dismissWithClickedButtonIndex:0 animated:YES];
//        
//                    }];
//                     NSLog(@"%@",result);
//                }];
    } withBlock:^(NSString *result, NSError *error) {
        [_alert setMessage:@"登陆失败,请检查您的网络"];
        [_alert show];
        [UIView animateWithDuration:4 animations:^{
            
            [_alert dismissWithClickedButtonIndex:0 animated:YES];
        }];
        return ;
    }];
}
-(void)uiConfig
{
    tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    [self.view addSubview:tableView];
}
#pragma mark--tableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  dataArr.count;
//    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cellID";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        //        cell=[[[NSBundle mainBundle]loadNibNamed:@"BottleCell" owner:self options:nil]firstObject];
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    //    [cell setModel:dataArr[indexPath.row]];
    cell.textLabel.text=dataArr[indexPath.row];
//    cell.textLabel.text=[NSString stringWithFormat:@"%d",indexPath.row];
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoreViewController *storeVC=[[StoreViewController alloc]init];
    storeVC.ProjectName=dataArr[indexPath.row];
    [self.navigationController pushViewController:storeVC animated:YES];
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
