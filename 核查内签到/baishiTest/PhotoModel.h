//
//  PhotoModel.h
//  Essence
//
//  Created by EssIOS on 15/5/14.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoModel : NSObject
/*
 userID"];
 Longitude"];
 Latitude"];
 LocationTtime"];
 imageUrl"];
 selectType"];
 storeCode"];
 identifier"];
 Createtime"];
 bodyImgPath"];
 */

@property (nonatomic,strong)NSString * userID;
@property (nonatomic,strong)NSString * Longitude;
@property (nonatomic,strong)NSString * Latitude;
@property (nonatomic,strong)NSString * LocationTtime;
@property (nonatomic,strong)NSString * imageUrl;
@property (nonatomic,strong)NSString * selectType;
@property (nonatomic,strong)NSString * storeCode;
@property (nonatomic,strong)NSString * identifier;
@property (nonatomic,strong)NSString * Createtime;
@end
