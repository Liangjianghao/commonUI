//
//  StoreMD.h
//  Essence
//
//  Created by EssIOS on 15/5/11.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreMD : NSObject
@property(nonatomic,strong)NSString *Longitude;
@property(nonatomic,strong)NSString *Latitude;
@property(nonatomic,strong)NSString *StoreId;
@property(nonatomic,strong)NSString *StoreName;
@property(nonatomic,strong)NSString *Code;
@property(nonatomic,strong)NSString *text;
@property (nonatomic,strong)NSString * ProjectInfoId;
@property (nonatomic,strong)NSString * ProjectName;
@property(nonatomic,strong)NSString *ProjectScheduleId;
@property (nonatomic,strong)NSString*projectSchedule;
@property (nonatomic,strong)NSString*signCreatetime;
@property (nonatomic,strong)NSString*goOutCreatetime;
@property(nonatomic,strong)NSString *Name;
@property(nonatomic,strong)NSString *address;
@property (nonatomic,strong)NSString * timeStamo;
@property (nonatomic,strong)NSMutableArray * dqArr;
@property(nonatomic,strong)NSString *companyName;
@property(nonatomic,strong)NSString *workType;
@property(nonatomic,strong)NSString *Id;
+ (id)StoreMDWithDictionary:(NSDictionary *)dataDic;
- (id)initWithDataDictionary:(NSDictionary *)dataDic;

@property(nonatomic,strong)NSString *Address;
@property(nonatomic,strong)NSString *Area;
@property(nonatomic,strong)NSString *City;
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *Lat;
@property(nonatomic,strong)NSString *Lng;
//@property(nonatomic,strong)NSString *Name;
@property(nonatomic,strong)NSString *ProjectID;
//@property(nonatomic,strong)NSString *ProjectName;
@property(nonatomic,strong)NSString *Province;

@end
