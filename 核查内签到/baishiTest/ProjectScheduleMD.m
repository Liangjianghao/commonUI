//
//  ProjectScheduleMD.m
//  Essence
//
//  Created by EssIOS on 15/5/11.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import "ProjectScheduleMD.h"
#import "StoreMD.h"
@implementation ProjectScheduleMD
- (id)initWithDataDictionary:(NSDictionary *)dataDic
{
    self = [super init];
    if (self) {
        
        _text = [dataDic objectForKey:@"text"]  ==nil ? [NSNull null]:[dataDic objectForKey:@"text"];
        
        _ProjectScheduleId = [[dataDic objectForKey:@"ProjectScheduleId"] objectForKey:@"text"] ==nil ? [NSNull null]:[[dataDic objectForKey:@"ProjectScheduleId"] objectForKey:@"text"];
        
        _Name = [[dataDic objectForKey:@"Name"] objectForKey:@"text"] ==nil ? [NSNull null]:[[dataDic objectForKey:@"Name"] objectForKey:@"text"];
        
        _Stores = [dataDic objectForKey:@"Stores"]  ==nil ? [NSNull null]:[dataDic objectForKey:@"Stores"];
        
    }
    return self;
}


+ (id)ProjectScheduleWithDictionary:(NSDictionary *)dataDic;
{
    return [[self alloc]initWithDataDictionary:dataDic];
}
@end
