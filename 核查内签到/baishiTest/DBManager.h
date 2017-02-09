//
//  DBManager.h
//  pickersTest
//
//  Created by EssIOS on 16/1/14.
//  Copyright © 2016年 ljh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMModel.h"
@interface DBManager : NSObject
+ (void)keeInfo:(FMModel *)model;
+(NSMutableDictionary *)selectInfo:(NSString *)str;
+(NSMutableArray *)selectStoreInfo:(NSString *)projectID;

@end
