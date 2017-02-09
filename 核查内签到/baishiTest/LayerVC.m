//
//  LayerVC.m
//  Essence
//
//  Created by EssIOS on 15/5/7.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import "LayerVC.h"
//#import "WorkController.h"
//#import "UpLoadController.h"
//#import "PersonalController.h"
#import "WorkViewController.h"
#define MAIN_WINDOW [UIApplication sharedApplication].windows[0]
@implementation LayerVC

+ (void)showLayerVC
{
    
//    UITabBarController * tabBarcontroller = [[UITabBarController alloc] init];
//    
//    //工作
//    WorkController * workVC = [[WorkController alloc] init];
//    
//    UINavigationController * workNav = [[UINavigationController alloc] initWithRootViewController:workVC];
//    
//    UITabBarItem * workTabBar = [[UITabBarItem alloc] initWithTitle:@"工作" image:[UIImage imageNamed:@"bg_iphone6_mynote@2x"] tag:1];
//    
//    workVC.tabBarItem = workTabBar;
//    
//    
//    //上传
//    UpLoadController * upLoadVC = [[UpLoadController alloc] init];
//    UINavigationController * upLoadNav = [[UINavigationController alloc] initWithRootViewController:upLoadVC];
//    
//    UITabBarItem * upLoadTabBar = [[UITabBarItem alloc] initWithTitle:@"上传" image:[UIImage imageNamed:@"bg_iphone6_off-line@2x"] tag:2];
//    upLoadVC.tabBarItem = upLoadTabBar;
//    
//    
//    //个人
//    
//    PersonalController * personalVC = [[PersonalController alloc] init];
//    UINavigationController * personalNav = [[UINavigationController alloc] initWithRootViewController:personalVC];
//    
//    UITabBarItem * personalTabBar = [[UITabBarItem alloc] initWithTitle:@"个人" image:[UIImage imageNamed:@"bg_iphone6_mymooc@2x"] tag:3];
//    personalVC.tabBarItem = personalTabBar;
//    
//    
//    NSArray * array = @[workNav,upLoadNav,personalNav];
//    tabBarcontroller.viewControllers = array;
    WorkViewController *workVC=[[WorkViewController alloc]init];
    UINavigationController * workNav = [[UINavigationController alloc] initWithRootViewController:workVC];

    
    [MAIN_WINDOW setRootViewController:workNav];
    
}


@end
