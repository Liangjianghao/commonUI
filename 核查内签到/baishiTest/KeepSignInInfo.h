//
//  KeepSignInInfo.h
//  Essence
//
//  Created by EssIOS on 15/5/12.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductModel.h"
@interface KeepSignInInfo : NSObject
// 存储签到信息
+ (void)insertSignInTableWithTheDictionary:(NSDictionary *)signInDic;
//存储相关门店信息
+ (void)keepStoreWithTheDictionary:(ProductModel *)model;
// 更改签到定位信息
+ (void)upLoadDataWithTheDictionary:(NSDictionary *)goOutDic;
// 更改签到信息 2
+ (void)upLoadDataWithTheDictionary2:(NSDictionary *)goOutDic;
// 查询签到信息
+ (NSMutableArray *)selectSginInTable;
// 存储巡店拍照信息
+ (void)keepPhotoWithDictionary:(NSDictionary *)photoInfo;
//存储详情
+ (void)keepDetailWithDictionary:(NSDictionary *)photoInfo;
// 查询巡店拍照信息
+ (NSMutableArray *)selectPhotoWithType:(NSString *)selectType;
// 存储门店定位信息
+ (void)keepStoreLocationInfo:(NSMutableDictionary *)dic;
// 存储卖进信息
+ (void)keepSellInfo:(NSMutableDictionary *)sellInfo withBlock:(void (^)(NSString *result))block;
// 存储PG招募信息
+ (void)keepPGRecruit:(NSMutableDictionary *)PGInfo withBlock:(void (^)(NSString *result))block;
// 存储请假信息
+ (void)keepLeaveInfo:(NSMutableDictionary *)leaveInfo;
// 查询请假信息
+ (NSMutableArray *)selectLeaveInfo;
// 查询卖进信息
+ (NSMutableArray *)selectSellTable;
// 查询巡店计划信息
+ (NSMutableArray *)selectPatrolPicture;
// 查询PG招募信息
+ (NSMutableArray *)selectPGRecruit;
// 删除用户操作的照片
+ (void)deletePhotoWithUrl:(NSString *)url successBlock:(void (^)(NSString * result))successBlock;
// 上传成功后删除PG招募信息
+ (void)deletePGRecruit;
// 上传成功后删除卖进信息
+ (void)deleteSellTable;
// 上传成功后删除签到信息
+ (void)deleteSignInTable;
// 上传成功后删除巡店拍照信息
+ (void) deletePatrolPictureWithImageUrl:(NSString *)url;
// 上传成功后删除请假信息
+ (void)deleteLeaveTable;
// 用户删除请假信息,删除对应表中元素
+ (void)deleteLeaveWithTime:(NSString *)time timeType:(NSString *)timeType QjType:(NSString *)QjType;


//存储公司信息
+ (void)insertCompanyTableWithTheDictionary:(NSDictionary *)CompanyDic;

//上传成功后删除公司信息
+ (void)deleteCompanyTable;
+(void)creatSignInTable;

//新的签到信息存储
//+ (void)insertCheckTableWithTheDictionary:(NSDictionary *)ceShiDic;
+ (void)insertNewSignInTableWithTheDictionary:(NSDictionary *)newSignInDic;
// 查询签到信息
+ (NSMutableArray *)selectCheckTable;
+ (void)upLoadSignInWithTheDictionary:(NSDictionary *)goOutDic;
//查询产品信息
+ (NSMutableArray *)selectProductDetailTable;

+ (NSMutableArray *)selectPhotoWithType:(NSString *)selectType andId:(NSString *)storecode;
//删除产品信息
+ (void) deleteProductWithImageUrl:(NSString *)url;
//存储门店信息
+ (void)keepMDWithTheDictionary:(ProductModel *)model;
+ (void)creatMDInfo;
+ (void) deleteMDWithImageUrl:(NSString *)url;
+ (ProductModel *)selectMDDetailTable:(NSString *)code;
+ (NSMutableArray *)selectAllMDDetailTable;
//+ (ProductModel *)selectOneProductDetailTable:(NSString *)productCode;
//搜索单一产品信息
+ (ProductModel *)selectOneProductDetailTable:(NSString *)code andProCode:(NSString *)productCode;


+ (void)updataMDWithTheDictionary:(ProductModel *)model;


+ (NSMutableArray *)selectPhotoWithType:(NSString *)selectType andId:(NSString *)storecode;
+ (void)keepPhotoWithDictionary:(NSDictionary *)photoInfo;
+ (void)keepStoreWithTheDictionary:(ProductModel *)model;
+ (ProductModel *)selectOneProductDetailTable:(NSString *)code andProCode:(NSString *)productCode;

+ (void)keepStoreWithdata:(NSArray *)arr andModel:(ProductModel *)model;
+ (void)keepStoreWithdata:(NSArray *)arr andModel:(ProductModel *)model withBlock:(void (^)(NSString *result))block;

+ (NSArray *)select:(NSString *)code andProCode:(NSString *)productCode;
+ (NSMutableArray *)selectControlWithInfo:(NSDictionary *)infoDic;

+ (ProductModel *)selectControlTable:(NSString *)storeCode andProID:(NSString *)proID andControlID:(NSString *)controlID;

+ (void)deleteControlTable;

@end
