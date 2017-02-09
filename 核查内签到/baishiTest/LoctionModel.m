//
//  LoctionModel.m
//  Essence
//
//  Created by EssIOS on 15/5/8.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import "LoctionModel.h"

@implementation LoctionModel
- (id)initWithDataDictionary:(NSDictionary *)dataDic
{
    self = [super init];
    if (self) {
        
        _ProjectInfoId = [[dataDic objectForKey:@"ProjectInfoId"] objectForKey:@"text"]  ==nil ? [NSNull null]:[[dataDic objectForKey:@"ProjectInfoId"] objectForKey:@"text"];
        _ProjectName = [[dataDic objectForKey:@"ProjectName"] objectForKey:@"text"]  ==nil ? [NSNull null]:[[dataDic objectForKey:@"ProjectName"] objectForKey:@"text"];
        _ProjectSchedules = [dataDic objectForKey:@"ProjectSchedules"]   ==nil ? [NSNull null]:[dataDic objectForKey:@"ProjectSchedules"] ;
        
        NSDictionary * schedule =  [_ProjectSchedules objectForKey:@"ProjectSchedule"];
        _projectSchedule = [ProjectScheduleMD ProjectScheduleWithDictionary:schedule];
        
    }
    return self;
}


+ (id)loctionDataWithDictionary:(NSDictionary *)dataDic
{
    return [[self alloc]initWithDataDictionary:dataDic];
}
@end
