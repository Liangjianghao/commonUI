//
//  LoctionModel.h
//  Essence
//
//  Created by EssIOS on 15/5/8.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProjectScheduleMD.h"
@interface LoctionModel : NSObject
@property (nonatomic,strong)NSString * ProjectInfoId;
@property (nonatomic,strong)NSString * ProjectName;
@property (nonatomic,strong)NSDictionary * ProjectSchedules;
@property (nonatomic,strong)ProjectScheduleMD * projectSchedule;
+ (id)loctionDataWithDictionary:(NSDictionary *)dataDic;
- (id)initWithDataDictionary:(NSDictionary *)dataDic;
@end
