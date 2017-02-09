//
//  keepLocationInfo.h
//  Essence
//
//  Created by EssIOS on 15/5/6.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoreMD.h"
@interface keepLocationInfo : NSObject
// 存储登陆信息
+ (void)keepLoginInfo:(NSMutableDictionary *)userInfoDic;
//存储GPS信息
+ (void)keepGPSInfo:(NSMutableDictionary *)userInfoDic;
// 存储基础信息
+ (void)keepBaseDataWithDictionary:(NSDictionary *)baseDataDic;

// 存储巡店拍照信息
+ (void)keepPatrolShopWithDictionary:(NSMutableDictionary *)dictionary  withBlock:(void (^)(NSString *result))block withBlock:(void (^)(NSString *result))failedBlock;
//存储公司的信息
+ (void)keepPatrolShopWithDictionary2:(NSMutableDictionary *)dictionary  withBlock:(void (^)(NSString *result))block withBlock:(void (^)(NSString *result))failedBlock;
//存储项目的信息
+ (void)keepPatrolShopWithDictionary3:(NSMutableDictionary *)dictionary  withBlock:(void (^)(NSString *result))block withBlock:(void (^)(NSString *result))failedBlock;
//获取我的门店
+ (void)keepMyShopWithDictionary:(NSMutableDictionary *)dictionary  withBlock:(void (^)(NSString *result))block withBlock:(void (^)(NSString *result))failedBlock;
//添加门店信息
+ (void)addPatrolShopWithDictionary:(NSMutableDictionary *)dictionary  withBlock:(void (^)(NSString *result))block withBlock:(void (^)(NSString *result))failedBlock;
// 根据当前时间搜索巡店计划信息
+ (NSMutableArray *)selectPatrolShopWithDate:(NSString *)date withBlock:(void (^)(NSString *result))block;
//根据当前时间搜索公司的信息
+ (NSMutableArray *)selectPatrolShopWithDate2:(NSString *)date withBlock:(void (^)(NSString *result))block;
//根据当前时间搜索项目的信息
+ (NSMutableArray *)selectPatrolShopWithDate3:(NSString *)date withBlock:(void (^)(NSString *result))block;

+ (NSMutableArray *)SelectShopPatrolWithDate:(NSString *)date withBlock:(void (^)(NSString *result))block;
// 搜索整个巡店计划信息
+ (NSMutableArray *)selectPatrolShop;
+ (NSMutableArray *)selectPatrolShop2;
+ (NSMutableArray *)selectPatrolShop3;
// 根据所选时间搜索巡店计划信息
+ (NSMutableArray *)selectPlanWithDate:(NSString *)date andUserID:(NSString*)userID;
// 搜索门店名称
+ (NSMutableArray *)selectAllStoreName;
//搜索所有项目名
+ (NSMutableArray *)selectAllProjectName;
// 根据项目名称搜索门店
+ (NSMutableArray *)selectXM:(NSString *)storeName;
// 根据门店名称搜索项目和当期
+ (NSMutableArray *)selectXMAndDQ:(NSString *)storeName;
// 根据门店名称,项目名称搜索档期
+ (NSMutableArray *)selectDQWithTheStoreName:(NSString *)storeName  andProjectName:(NSString *)projectName;
// 根据门店名称,项目名称搜索门店code
+ (NSString *)selectStroeCodeWithTheStoreName:(NSString *)storeName andProjectName:(NSString *)projectName;
// 搜索定位信息的最后一次定位
+ (StoreMD *)selectLocationLastData;
// 根据门店名称搜索门店id
+ (NSString *)selectStroeIDWithTheStoreName:(NSString *)storeName;
// 更新定位门店后的baseData的数据  未完成,表被锁
+ (void)upDataLocationInfo:(NSDictionary *)dic;
// 根据门店名称搜索档期和项目
+ (NSMutableArray *)selectStoreAndProjectNameWithStoreName:(NSString *)storeName;
// 搜索整个巡店轨迹定位
+ (NSMutableArray *)selectLocationsTable;
//查询GPS信息
+ (NSMutableArray *)selectGPSTable;
+ (NSMutableArray *)selectMyShopWithDatewithBlock:(void (^)(NSString *result))block;
// 上传成功后删除定位信息表
+ (void)deleteLocationble;
//上传成功后删除GPS信息
+ (void)deleteGPStable;
// 根据门店code,更改门店是否被签到
+ (void)deletePlanDataStoreCode:(NSString *)storeCode;

+ (NSDictionary *)selectCodeWithTheStoreName:(NSString *)storeName andProjectName:(NSString *)projectName;
//存储多个
+ (void)keepBaseDataWithDictionary2:(NSDictionary *)baseDataDic;

+ (void)keepallStoreDataWithDictionary:(NSDictionary *)baseDataDic;
@end
