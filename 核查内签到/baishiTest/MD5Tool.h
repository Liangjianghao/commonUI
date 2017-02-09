//
//  MD5Tool.h
//  Essence
//
//  Created by EssIOS on 15/5/8.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>
@interface MD5Tool : NSObject
// MD5加密  登陆密码
+ (NSString *)MD5WithString:(NSString *)string;
// 当前时间  已格式化
+ (NSString *)nowTime;
// 身份证识别
+ (BOOL)checkIdentityCardNo:(NSString*)cardNo;
@end
