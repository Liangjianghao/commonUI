//
//  UpDataTool.h
//  Essence
//
//  Created by EssIOS on 15/5/20.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoModel.h"
@interface UpDataTool : NSObject
// 创建卖进xml
+(NSString *)createSellXMLWithArray:(NSMutableArray *)sellArr;
// 创建签到xml
+(NSString *)createSignInXMLWithArray:(NSMutableArray *)sellArr;
// 创建巡点拍照xml
+(NSString *)createPatrolPictureXMLWithAPatrol:( PhotoModel*)photo;
// 创建PG招募xml
+(NSString *)createPGRecruitXMLWithArray:(NSMutableArray *)sellArr;
// 创建定位轨迹xml
+(NSString *)createLocationXMLWithArray:(NSMutableArray *)LocationArr;
//创建GPSxml
+(NSString *)createGPSXMLWithArray:(NSMutableArray *)GPSArr;
// 创建巡店计划xml
+(NSString *)createPatrolPlanXMLWithArray:(NSMutableArray *)PatrolPlanArr;
+(NSString *)createPatrolPlan2XMLWithArray:(NSMutableArray *)PatrolPlanArr;
+(NSString *)createPatrolPlan3XMLWithArray:(NSMutableArray *)PatrolPlanArr;
// 创建请假xml
+(NSString *)createLeavaInfoXMLWithArray:(NSMutableArray *)LeaveInfoArr;
+(NSString *)createlogInfoXML;


//创建新的签到xml
+(NSString *)createCheckXMLWithArray:(NSMutableArray *)sellArr;

@end
