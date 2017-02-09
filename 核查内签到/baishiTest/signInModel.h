//
//  signInModel.h
//  Essence
//
//  Created by EssIOS on 15/5/12.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface signInModel : NSObject

@property (nonatomic,strong)NSString *userID;
@property (nonatomic,strong)NSString *StoreCode;
@property (nonatomic,strong)NSString *identifier;
@property (nonatomic,strong)NSString *signLongitude;
@property (nonatomic,strong)NSString *signLatitude;
@property (nonatomic,strong)NSString *signLocationType;
@property (nonatomic,strong)NSString *signLocationTtime;
@property (nonatomic,strong)NSString *signInType;
@property (nonatomic,strong)NSString *signCreatetime;
@property (nonatomic,strong)NSString *signIsSelect;
@property (nonatomic,strong)NSString *goOutLongitude;
@property (nonatomic,strong)NSString *goOutLatitude;
@property (nonatomic,strong)NSString *goOutLocationType;
@property (nonatomic,strong)NSString *goOutLocationTtime;
@property (nonatomic,strong)NSString *goOutInType;
@property (nonatomic,strong)NSString *goOutCreatetime;
@property (nonatomic,strong)NSString *storeName;
@property (nonatomic,strong)NSString *projectName;
@property (nonatomic,strong)NSString *btnSelect;

@property (nonatomic,strong)NSString *Address;
@property (nonatomic,strong)NSString *companyLatitude;
@property (nonatomic,strong)NSString *companyLongitude;
@property (nonatomic,strong)NSString *companyName;
@property (nonatomic,strong)NSString *Id;
@property (nonatomic,strong)NSString *ProjectID;

@property (nonatomic,strong)NSString *checkInImei;
@property (nonatomic,strong)NSString *checkInLatitude;
@property (nonatomic,strong)NSString *checkInLocationTime;
@property (nonatomic,strong)NSString *checkInLocationType;
@property (nonatomic,strong)NSString *checkInLongitude;
@property (nonatomic,strong)NSString *checkInTime;

@property (nonatomic,strong)NSString *checkOutImei;
@property (nonatomic,strong)NSString *checkOutLatitude;
@property (nonatomic,strong)NSString *checkOutLocationTime;
@property (nonatomic,strong)NSString *checkOutLocationType;
@property (nonatomic,strong)NSString *checkOutLongitude;
@property (nonatomic,strong)NSString *checkOutTime;

@property (nonatomic,strong)NSString *companyCode;
@property (nonatomic,strong)NSString *isUpload;
@property (nonatomic,strong)NSString *itemCode;


@end
