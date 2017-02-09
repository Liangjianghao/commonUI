//
//  ProjectScheduleMD.h
//  Essence
//
//  Created by EssIOS on 15/5/11.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ProjectScheduleMD : NSObject
@property(nonatomic,strong)NSString *text;
@property(nonatomic,strong)NSString *ProjectScheduleId;
@property(nonatomic,strong)NSString *Name;
@property(nonatomic,strong)NSArray * Stores;
+ (id)ProjectScheduleWithDictionary:(NSDictionary *)dataDic;
- (id)initWithDataDictionary:(NSDictionary *)dataDic;
@end
