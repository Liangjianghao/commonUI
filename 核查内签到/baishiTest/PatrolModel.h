//
//  PatrolModel.h
//  Essence
//
//  Created by EssIOS on 15/5/21.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PatrolModel : NSObject
@property(nonatomic,strong)NSString * userID;
@property(nonatomic,strong)NSString * storeCode;
@property(nonatomic,strong)NSString * selectType;
@property(nonatomic,strong)NSString * imageType;
@property(nonatomic,strong)NSString * identifier;
@property(nonatomic,strong)NSString * Longitude;
@property(nonatomic,strong)NSString * Latitude;
@property(nonatomic,strong)NSString * LocationTtime;
@property(nonatomic,strong)NSString * Createtime;
@property(nonatomic,strong)NSString * imageUrl;

@end
