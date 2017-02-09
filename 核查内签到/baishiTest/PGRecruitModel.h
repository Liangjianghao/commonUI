//
//  PGRecruitModel.h
//  Essence
//
//  Created by EssIOS on 15/5/21.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PGRecruitModel : NSObject
@property (nonatomic,strong)NSString * userID;
@property (nonatomic,strong)NSString * Name;
@property (nonatomic,strong)NSString * Phone;
@property (nonatomic,strong)NSString * IdCard;
@property (nonatomic,strong)NSString * Weixin;
@property (nonatomic,strong)NSString * Qq;
@property (nonatomic,strong)NSString * identifier;
@property (nonatomic,strong)NSString * Createtime;
@property (nonatomic,strong)NSString * Headimgpath;
@property (nonatomic,strong)NSString * bodyImgPath;
@property (nonatomic,strong)NSString * Latitude;
@property (nonatomic,strong)NSString * Longitude;
@property (nonatomic,strong)NSString * locationType;

@property (strong,nonatomic)NSString *storeCode;
@end
