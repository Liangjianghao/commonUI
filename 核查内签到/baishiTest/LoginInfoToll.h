//
//  LoginInfoToll.h
//  Essence
//
//  Created by EssIOS on 15/5/6.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface LoginInfoToll : NSObject
//  登陆
+ (void)preserveUserInfo:(NSDictionary *)loginResult username:(NSString * )userName password:(NSString *)password MMPSWBtn:(UIButton *)MMPSWbtn
              autoLogbtn:(UIButton *)autoLogbtn  sucessBlock:(void (^)(bool isFirstLog))block failedBlock:(void(^)(bool isFirstLog))failBlick;
// 获取运营商
+ (NSString *)getcarrierName;
// 获取定位类型
+ (NSString *)locationType;
// 网络状态
+ (NSString *)networktype;
// 存储第一次登陆的信息
+ (void)keepFirstLogin:(NSMutableDictionary *)firstInfo;
@end
