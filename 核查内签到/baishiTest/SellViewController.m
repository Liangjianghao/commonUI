//
//  SellViewController.m
//  Essence
//
//  Created by EssIOS on 15/5/14.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import "SellViewController.h"
#import "MD5Tool.h"
#import "keepLocationInfo.h"
#import "KeepSignInInfo.h"
@interface SellViewController ()
{
    NSString * _sellType;
    NSString * _userID;
    UIAlertView * _alert;
    NSString * _isSuccess;
}
@end

@implementation SellViewController
- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title  =@"卖进反馈";
    _userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    
    _alert = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:nil cancelButtonTitle:@"知道了~" otherButtonTitles:nil, nil];
}
#pragma mark -- 判断填写信息是否正确
// 确定
- (IBAction)certainOK:(UIButton *)sender
{
    NSString * Cretime = [MD5Tool nowTime];
    NSString * identifier = [[NSUserDefaults standardUserDefaults] objectForKey:@"identifier"];
    NSString * storeCode = [keepLocationInfo selectStroeCodeWithTheStoreName:_storeName andProjectName:_projectName];
    
    if (_nameTF.text.length == 0)
    {
        [_alert setTitle:@"请输入姓名!"];
        [_alert show];
        return;
    }
    else if (_phoneTF.text.length != 11)
    {
        [_alert setTitle:@"请输入正确的手机号!"];
        [_alert show];
        return ;
    }else
    {
//        if (_personIdTF.text.length != 18)
//        {
//            [_alert setTitle:@"请输入18位的身份证号!"];
//            [_alert show];
//            return;
//        }else if ( [MD5Tool checkIdentityCardNo:_personIdTF.text] == NO)
//        {
//            [_alert setTitle:@"身份证格式错误!"];
//            [_alert show];
//        }else
            if (_sellOK.selected == NO && _sellFailed.selected == NO)
            {
                [_alert setTitle:@"请选择卖进是否成功!"];
                [_alert show];
            }else
            {
                //成功  存储卖进信息
                NSMutableDictionary *  sellInfo = [NSMutableDictionary dictionary];
                [sellInfo setValue:_userID          forKey:@"userID"];
                [sellInfo setValue:_nameTF.text     forKey:@"Name"];
                [sellInfo setValue:_phoneTF.text    forKey:@"Phone"];
                [sellInfo setValue:_personIdTF.text forKey:@"IdCard"];
                [sellInfo setValue:storeCode        forKey:@"storeCode"];
                [sellInfo setValue:_isSuccess       forKey:@"isSuccess"];
                [sellInfo setValue:identifier       forKey:@"identifier"];
                [sellInfo setValue:Cretime          forKey:@"Cretime"];
                [KeepSignInInfo keepSellInfo:sellInfo withBlock:^(NSString *result) {
                    [_alert setTitle:result];
                    [_alert show];
                    [UIView animateWithDuration:3 animations:^{
                        [_alert dismissWithClickedButtonIndex:0 animated:YES];
                    }];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }];
            }
    }
}
// 取消
- (IBAction)cancel:(UIButton *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
// 卖进成功
- (IBAction)sellOK:(UIButton *)sender
{
    sender.selected = YES;
    _sellFailed.selected = NO;
    _isSuccess =@"卖进成功";
}
// 卖进失败
- (IBAction)sellFailed:(UIButton *)sender
{
    sender.selected = YES;
    _sellOK.selected = NO;
    _isSuccess = @"卖进失败";
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
