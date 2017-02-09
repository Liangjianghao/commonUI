//
//  LocationMD.h
//  Essence
//
//  Created by EssIOS on 15/5/21.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationMD : NSObject
@property (nonatomic,strong)NSString * latitude;
@property (nonatomic,strong)NSString * longitude;
@property (nonatomic,strong)NSString * address;
@property (nonatomic,strong)NSString * mode;
@property (nonatomic,strong)NSString * precision;
@property (nonatomic,strong)NSString * loctime;
@property (nonatomic,strong)NSString * IMEI;
@property (nonatomic,strong)NSString * wdate;

@end
