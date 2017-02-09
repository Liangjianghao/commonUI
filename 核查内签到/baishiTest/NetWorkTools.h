//
//  NetWorkTools.h
//  Essence
//
//  Created by EssIOS on 15/5/7.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NetWorkTools : NSObject
// 发送登陆请求
+ (void)loginWithLoginName:(NSString *)loginName password:(NSString *)password
                 withBlock:(void (^)(NSDictionary *result, NSError *error))block withBlock:(void (^)(NSString *result, NSError *error))failedBlock;
// 发送获取基础数据请求
+ (void)getBaseDataWithUserID:(NSString *)userID nowTime:(NSString *)time
                    withBlock:(void (^)(NSString *result, NSError *error))block failedBlock:(void (^)(NSString *result, NSError *error))failedBlock;
// 发送获取更新数据请求
+ (void)getUpdateBaseDataWithUserID:(NSString *)userID nowTime:(NSString *)time
                          withBlock:(void (^)(NSString *result, NSError *error))block failedBlock:(void (^)(NSString *result, NSError *error))failedBlock;

//发送获取新的加内容数据请求 获取客户公司额
+(void)patrolSignInWithProjectID:(NSString *)ProjectID Name:(NSString *)Name withBlock:(void(^)(id result,NSError *error))block failedBlock:(void(^)(id result,NSError *error))failedBlock;
//用户是否允许指定工作计划
+ (void)getCanEditWorkPlanDataWithUserID:(NSString *)userID nowTime:(NSString *)time
                           withBlock:(void (^)(id result, NSError *error))block failedBlock:(void (^)(id result, NSError *error))failedBlock;
//获取用户管辖门店
+ (void)GetUserStoreWithUserID:(NSString *)userID withBlock:(void (^)(id result, NSError *error))block failedBlock:(void (^)(id result, NSError *error))failedBlock;
//获取工作计划
+ (void)GetWorkPlanWithUserID:(NSString *)userID andStartdate:(NSString *)startdate andEndate:(NSString *)endate andLastdate:(NSString *)lastdate withBlock:(void (^)(id result, NSError *error))block failedBlock:(void (^)(id result, NSError *error))failedBlock;
+(void)test;
//获取产品相关信息
+(void*)GetProductListWithProjectId:(NSString *)ProjectId withBlock:(void (^)(NSString *result, NSError *error))block ;

+(void)requestWithAddress:(NSString *)addrress andParameters:(NSDictionary *)parameter withSuccessBlock:(void (^)(NSDictionary *result, NSError *error))successBlock andFailedBlock:(void (^)(NSString *result, NSError *error))failedBlock;
+(void)requestWithAddresss:(NSString *)addrress andParameters:(id )parameter withSuccessBlock:(void (^)(NSDictionary *result, NSError *error))successBlock andFailedBlock:(void (^)(NSString *result, NSError *error))failedBlock;
@end
