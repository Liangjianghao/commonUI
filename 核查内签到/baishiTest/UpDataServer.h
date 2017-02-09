//
//  UpDataServer.h
//  Essence
//
//  Created by EssIOS on 15/5/21.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "PhotoModel.h"
@interface UpDataServer : NSObject
// 上传签到xml  卖进xml  门店定位xml 请假xml
+ (void)UpSignInXML:(NSString *)xmlPath  andUpDataType:(NSString *)DataType successBlock:(void (^)(NSString *result))successblock failedBlock:(void (^)(NSString *result))failedBlock;
// 上传登陆定位xml
+ (void)updataLocXML:(NSString *)uid andLogType:(NSString *)logType andLogDate:(NSString *)logDate andLogContent:(NSString *)logContent successBlock:(void (^)(NSString *result))successblock failedBlock:(void (^)(NSString *result))failedBlock;
// 上传PG招募xml
+ (void)updateZhaoMuXML:(NSString *)xmlPath andDataArr:(NSArray *)arr successBlock:(void (^)(NSString *result))successblock failedBlock:(void (^)(NSString *result))failedBlock;
// 上传巡店拍照xml
+ (void)updateStoreImgXML:(NSString *)xmlPath andPatrol:(PhotoModel *)photo
             successBlock:(void (^)(NSString *result))successblock failedBlock:(void (^)(NSString *result))failedBlock;


//上传新的签到xml
+ (void)UpSignInXML:(NSString *)xmlPath andUpDataType:(NSString *)DataType successBlock:(void (^)(NSString *result))successblock failedBlocks:(void (^)(NSString *result))failedBlocks;

//上传新的巡店计划XML
+ (void)UpPatrolXML:(NSString *)xmlPath  andUpDataType:(NSString *)DataType successBlock:(void (^)(NSString *result))successblock failedBlock:(void (^)(NSString *result))failedBlock;
@end
