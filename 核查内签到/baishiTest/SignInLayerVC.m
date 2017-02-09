//
//  SignInLayerVC.m
//  Essence
//
//  Created by EssIOS on 15/7/17.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import "SignInLayerVC.h"

#import "SignInController.h"
#define MAIN_WINDOW [UIApplication sharedApplication].windows[0]
@implementation SignInLayerVC
+(void)SignInLayerVC
{
    UITabBarController *tabBarController = [[UITabBarController alloc]init];
    
    //到点
    SignInController *signVc = [[SignInController alloc]init];
    
    UINavigationController *signNav = [[UINavigationController alloc]initWithRootViewController:signVc];
    
    UITabBarItem *signTabBar = [[UITabBarItem alloc]initWithTitle:@"到点" image:nil tag:1];
    
    signVc.tabBarItem = signTabBar;
    
    
    
    NSArray *array = @[signNav];
    tabBarController.viewControllers = array;
    
    [MAIN_WINDOW setRootViewController:tabBarController];
    
    
    
    
}
@end
