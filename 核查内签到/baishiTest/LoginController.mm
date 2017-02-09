//
//  LoginController.m
//  Essence
//
//  Created by EssIOS on 15/5/6.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//
#import <Security/Security.h>
#import "KeychainItemWrapper.h"
#import "SSKeychain.h"

#import "LoginController.h"
#import "LoginInfoToll.h"
#import "BMapKit.h"
#import "Base64.h"
#import "MD5Tool.h"
#import "keepLocationInfo.h"
#import "KeepSignInInfo.h"
#import "NetWorkTools.h"

#import "ViewController.h"
#import "WorkViewController.h"
#define UserDefaults  [NSUserDefaults standardUserDefaults]
@interface LoginController ()
{
    UIAlertView * _alert;
      NSString    *_timeout;
}
@end

@implementation LoginController

//- (CLLocationManager *)locMgr
//{
//    if(![CLLocationManager locationServicesEnabled]) return nil;
//    if (!_locMgr) {
//        // 创建定位管理者
//        self.locMgr = [[CLLocationManager alloc] init];
//        // 设置代理
//        self.locMgr.delegate = self;
//    }
//    return _locMgr;
//}
- (void)viewWillAppear:(BOOL)animated
{
    // 取出记住密码及自动登录状态
    _MMPSWbtn.selected   = (BOOL) [UserDefaults boolForKey:@"mmpswType"];
    _autoLogBtn.selected = (BOOL) [UserDefaults boolForKey:@"autoLogType"];
    // 判断是否记住密码
    if (_MMPSWbtn.selected == YES)
    {
        _userNameTF.text = [UserDefaults objectForKey:@"username"];
        _passwordTF.text = [UserDefaults objectForKey:@"password"];
        //是否自动登录
        if (_autoLogBtn.selected == YES)
        {
            [self login];
        }
    }else {
        _userNameTF.text = @"";
        _passwordTF.text = @"";
    }
    NSLog(@"address-->>%@",NSHomeDirectory());
  _alert = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
}

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view from its nib.
//    self.locationInfo = [NSMutableDictionary dictionary];
//    // 调用定位  永久使用定位
//    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
//    {
//        [self.locMgr requestAlwaysAuthorization];
//    }else
//    {
//        [self.locMgr startUpdatingLocation];
//    }
//
//    _alert=[[UIAlertView alloc]initWithTitle:@"稍等,加载中~" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
//    
//    [self.locMgr startUpdatingLocation];
//    
//    
//}

- (IBAction)loginToSystem:(UIButton *)sender
{
    [self login];
}

- (IBAction)memorizePSW:(UIButton *)sender
{
    sender.selected = !sender.selected;
}

- (IBAction)autoLogin:(UIButton *)sender
{
    sender.selected = !sender.selected;
}


- (void)login
{
    // 检查网络
    if ([[LoginInfoToll networktype] isEqualToString:@"NO"]) {
        
        [_alert setTitle:@"当前网络不可用,请检查你的网络!"];
        [_alert show];
        [UIView animateWithDuration:8 animations:^{
            [_alert dismissWithClickedButtonIndex:0 animated:YES];
        }];
        return;
    }
    // 判断账号密码
    if (_userNameTF.text.length == 0 || _passwordTF.text.length == 0) {
        
        [_alert setTitle:@"账号或密码不能为空!"];
        [_alert show];
        [UIView animateWithDuration:8 animations:^{
            [_alert dismissWithClickedButtonIndex:0 animated:YES];
        }];
        return;
    }else{
        [_alert setTitle:@"稍等,加载中~"];
        [_alert show];
    }
    
    NSString * password = nil;
    // MD5 32位加密  判断是否是新密码
    if (_passwordTF.text.length != 32)
    {   // 新密码进行MD5 加密
        password = [MD5Tool MD5WithString:_passwordTF.text];
    }
    else
    {
        password = _passwordTF.text;
    }
    // 登录请求
    
        NSDictionary *newdic=[NSDictionary dictionaryWithObjectsAndKeys:_userNameTF.text,@"username",password,@"password",nil];
        NSString *newurlAddress=[NSString stringWithFormat:@"http://wxapi.egocomm.cn/Perfetti/service/app.ashx?action=login"];
    [NetWorkTools requestWithAddress:newurlAddress andParameters:newdic withSuccessBlock:^(NSDictionary *result, NSError *error) {
        NSLog(@"%@",result);
        
        NSString * errorcode = [result objectForKey:@"ErrorCode"] ;
        if ([errorcode intValue] != 0){
            [_alert setTitle:@"账号密码错误!"];
            [_alert show];
            [UIView animateWithDuration:4 animations:^{
                [_alert dismissWithClickedButtonIndex:0 animated:YES];
            }];
            return;
        }else
        {
            NSString * userID = [[result objectForKey:@"Data"] objectForKey:@"ID"];
//            NSString * name = [[result objectForKey:@"Data"] objectForKey:@"Name"];
            [_alert dismissWithClickedButtonIndex:0 animated:YES];
            
            [_locationInfo setObject:userID forKey:@"userID"];
            //            [_alert setTitle:@"奋力加载中,请稍后~"];
            [LoginInfoToll keepFirstLogin:_locationInfo];
            [LoginInfoToll preserveUserInfo:result username:_userNameTF.text password:_passwordTF.text MMPSWBtn:_MMPSWbtn autoLogbtn:_autoLogBtn sucessBlock:^(bool isFirstLog) {
                
            } failedBlock:^(bool isFirstLog) {
                
            }];
        }

    } andFailedBlock:^(NSString *result, NSError *error) {
        NSLog(@"%@",result);
        [_alert setMessage:@"登陆失败,请检查您的网络"];
        [_alert show];
        [UIView animateWithDuration:4 animations:^{
            
            [_alert dismissWithClickedButtonIndex:0 animated:YES];
        }];
        return ;
    }];
    
    /*
    [NetWorkTools loginWithLoginName:_userNameTF.text password:password withBlock:^(NSDictionary *result, NSError *error) {
        
        
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
            [LoginInfoToll preserveUserInfo:result username:_userNameTF.text password:_passwordTF.text MMPSWBtn:_MMPSWbtn autoLogbtn:_autoLogBtn sucessBlock:^(bool isFirstLog) {
                
            } failedBlock:^(bool isFirstLog) {
                
            }];
        }

    } withBlock:^(NSString *result, NSError *error) {
        [_alert setMessage:@"登陆失败,请检查您的网络"];
        [_alert show];
        [UIView animateWithDuration:4 animations:^{
            
            [_alert dismissWithClickedButtonIndex:0 animated:YES];
        }];
        return ;
    }];
    */
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
