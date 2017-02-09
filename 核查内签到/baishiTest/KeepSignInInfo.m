//
//  KeepSignInInfo.m
//  Essence
//
//  Created by EssIOS on 15/5/12.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import "KeepSignInInfo.h"
#import "FMDB.h"
#import "signInModel.h"
#import "SellModel.h"
#import "PatrolModel.h"
#import "PGRecruitModel.h"
#import "PhotoModel.h"
#import "LeaveModel.h"
#define USER_ID [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]
@implementation KeepSignInInfo

#pragma mark --创建新的签到数据
//创建新的签到数据
+ (void)createNewSignInTable
{
    FMDatabase *db = [FMDatabase databaseWithPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/NewSignIn.sqlite"]];
    if ([db open]) {
        if (![db tableExists:@"newSignIn"])
        {
            NSString *newCheckTable = [NSString stringWithFormat:@"CREATE TABLE newSignIn (identifier text,checkInLatitude text,checkInLocationTime text,checkInLocationType text,checkInLongitude text,checkInTime text,identifier text,checkOutLatitude text,checkOutLocationTime text,checkOutLocationType text,checkOutLongitude text,checkOutTime text,companyCode text,isUpload text,itemCode text,storeCode text,uid text)"];
            BOOL res = [db executeUpdate:newCheckTable];
            if (!res) {
                NSLog(@"|**=== error when creating db table ===**|");
            } else {
                NSLog(@"|**=== success to creating db table ===**|");
            }
        }
        [db close];
    }
    
}
//+ (void)creatCheckTable
//{
//    FMDatabase *db = [self getDB];
//    if ([db open]) {
//        if (![db tableExists:@"check"]) {
//            NSString *creatString = [NSString stringWithFormat:@"CREATE TABLE check (identifier text,checkInLatitude text,checkInLocationTime text,checkInLocationType text,checkInLongitude text,checkInTime text,identifier text,checkOutLatitude text,checkOutLocationTime text,checkOutLocationType text,checkOutLongitude text,checkOutTime text,Id INTEGER,isUpload text,ProjectID text,storeCode text,userID text)"];
//            BOOL res = [db executeUpdate:creatString];
//            if (!res) {
//                NSLog(@"建表成功");
//            }else
//            {
//                NSLog(@"建表失败");
//            }
//        }
//    }
//    [db close];
//}

//创建公司table
+(void)creatCompanyTable
{
    FMDatabase *db = [self getDB];
    if ([db open]) {
        if (![db tableExists:@"company"]) {
            NSString * creatString = [NSString stringWithFormat:@"CREATE TABLE signIn (Address text,companyLatitude text,companyLongitude text,companyName text,ID text,ProjectID text,ProjectName text)"];
            [db executeUpdate:creatString];
        }
    }
    [db close];
}

// 创建签到table
+ (void)creatSignInTable
{
    FMDatabase * db = [self getDB];
    if ([db open])
    {
        if (![db tableExists:@"signIn"])
        {
            
            //            NSString * creatString = [NSString stringWithFormat:@"CREATE TABLE signIn (userID text,StoreCode text,identifier text,signLongitude text,signLatitude text,signLocationType text,signLocationTtime  text,signInType text,signCreatetime text,goOutLongitude text,goOutLatitude text,goOutLocationType text,goOutLocationTtime  text,goOutInType text,goOutCreatetime text,storeName text,projectName text,btnSelect text,companyName text)"];
            //
            //            [db executeUpdate:creatString];
            NSString *newCheckTable = [NSString stringWithFormat:@"CREATE TABLE signIn (checkInImei text,checkInLatitude text,checkInLocationTime text,checkInLocationType text,checkInLongitude text,checkInTime text,signInType text,checkOutImei text,checkOutLatitude text,checkOutLocationTime text,checkOutLocationType text,checkOutLongitude text,checkOutTime text,goOutInType text,companyCode text,itemCode text,storeCode text,userID text,storeName text,projectName text,btnSelect text,companyName text)"];
            BOOL res = [db executeUpdate:newCheckTable];
            if (!res) {
                NSLog(@"|**=== 1error when creating db table ===**|  %d",res);
            } else {
                NSLog(@"|**=== success to creating db table ===**|  %d",res);
            }
            
        }
    }
    [db close];
}
// 创建相关门店信息
+ (void)creatMDInfo
{
    FMDatabase * db = [self getDB];
    if ([db open])
    {
        if (![db tableExists:@"MDInfo"])
        {
            
            NSString *newCheckTable = [NSString stringWithFormat:@"CREATE TABLE MDInfo (userID text,ProjectId text,StoreId text,Code text,CreateDate text,CreateUserId text,DiDui text,Area text,Position text,POSM text,state text,ProductId text,Price text,ProductSmell text,AreaRatio text,Expand1 text,Expand2 text,Expand3 text,Expand4 text,Expand5 text,Expand6 text,Expand7 text,Expand8 text,Expand9 text,Expand10 text)"];
            BOOL res = [db executeUpdate:newCheckTable];
            if (!res) {
                NSLog(@"|**=== 1error when creating db table ===**|  %d",res);
            } else {
                NSLog(@"|**=== success to creating db table ===**|  %d",res);
            }
            
        }
    }
    [db close];
}
// 创建相关门店信息
+ (void)creatStoreInfo
{
    FMDatabase * db = [self getDB];
    if ([db open])
    {
        if (![db tableExists:@"storeInfo"])
        {
          
            NSString *newCheckTable = [NSString stringWithFormat:@"CREATE TABLE storeInfo (userID text,ProjectId text,StoreId text,Code text,CreateDate text,CreateUserId text,DiDui text,Area text,Position text,POSM text,state text,ProductId text,Price text,ProductSmell text,AreaRatio text,Expand0 text,Expand1 text,Expand2 text,Expand3 text,Expand4 text,Expand5 text,Expand6 text,Expand7 text,Expand8 text,Expand9 text,Expand10 text,Expand11 text,Expand12 text,Expand13 text,Expand14 text,Expand15 text,Expand16 text,Expand17 text,Expand18 text,Expand19 text,Expand20 text,Expand21 text,Expand22 text,Expand23 text,Expand24 text,Expand25 text,Expand26 text,Expand27 text,Expand28 text,Expand29 text,Expand30 text,Expand31 text,Expand32 text,Expand33 text,Expand34 text,Expand35 text,Expand36 text,Expand37 text,Expand38 text,Expand39 text,Expand40 text,Expand41 text,Expand42 text,Expand43 text,Expand44 text,Expand45 text,Expand46 text,Expand47 text,Expand48 text,Expand49 text,Expand50 text,Expand51 text,Expand52 text,Expand53 text,Expand54 text,Expand55 text,Expand56 text,Expand57 text,Expand58 text,Expand59 text,Expand60 text,Expand61 text,Expand62 text,Expand63 text,Expand64 text,Expand65 text,Expand66 text,Expand67 text,Expand68 text,Expand69 text,Expand70 text)"];
            BOOL res = [db executeUpdate:newCheckTable];
            if (!res) {
                NSLog(@"|**=== 1error when creating db table ===**|  %d",res);
            } else {
                NSLog(@"|**=== success to creating db table ===**|  %d",res);
            }
            
        }
    }
    [db close];
}
// 创建巡店拍照table
+ (void)creatPhotoTable
{
    FMDatabase * db = [self getDB];
    if ([db open])
    {
        if (![db tableExists:@"photoInfo"])
        {
            [db executeUpdate:@"CREATE TABLE photoInfo (userID text,StoreCode text,selectType text,imageType text,identifier text,Longitude text,LocationTtime  text,Latitude text,Createtime text,imageUrl text)"];
        }
    }
    [db close];
}
// 创建巡店详情table
+ (void)creatDetailTable
{
    FMDatabase * db = [self getDB];
    if ([db open])
    {
        if (![db tableExists:@"detail"])
        {
            [db executeUpdate:@"CREATE TABLE detail (userID text,StoreCode text,selectType text,imageType text,identifier text,ProductID text,ProductCount  text,ProductTest text,ProductPrice text,ProductAcreage text,text1 text,text2 text,text3 text,text4 text,text5 text,text6 text,text7 text,text8 text,text9 text,text10 text)"];
        }
    }
    [db close];
}
// 创建卖进table
+ (void)creatSellInfoTable
{
    FMDatabase * db = [self getDB];
    if ([db open])
    {
        if (![db tableExists:@"sellInfo"])
        {
            [db executeUpdate:@"CREATE TABLE sellInfo (userID text,StoreCode text,Name text,Phone text,identifier text,IdCard text,isSuccess text,Cretime text)"];
        }
    }
    [db close];
}
// 创建PG招募table
+ (void)creatPGRecruitTable
{
    FMDatabase * db = [self getDB];
    
    [db setShouldCacheStatements:YES];
    
    if ([db open])
    {
        if (![db tableExists:@"pgrecruit"])
        {
            [db executeUpdate:@"CREATE TABLE pgrecruit (userID text,StoreCode text,Name text,Phone text,identifier text,IdCard text,Qq text,Weixin text,Headimgpath text,bodyImgPath text,Createtime text)"];
            
        }
        
    }
    [db close];
}
// 创建门店定位table
+ (void)creatStoreLocationTable
{
    FMDatabase * db = [self getDB];
    if ([db open])
    {
        if (![db tableExists:@"storeLocation"])
        {
            [db executeUpdate:@"CREATE TABLE storeLocation (identifier text,StoreId text,userID text,LocationType text,LocationTtime text,Latitude text,Longitude text)"];
        }
    }
    [db close];
}
// 创建请假table
+ (void)creatLeaveInfoTable
{
    FMDatabase * db = [self getDB];
    if ([db open])
    {
        if (![db tableExists:@"leaveInfo"])
        {
            [db executeUpdate:@"CREATE TABLE leaveInfo (userID text,identifier text,time text,QjType text,TimeType text)"];
        }
    }
    [db close];
}

#pragma mark --新的签到信息存储
//新的签到信息存储
+ (void)insertNewSignInTableWithTheDictionary:(NSDictionary *)newSignInDic
{
    [self createNewSignInTable];
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/NewSignIn.sqlite"]];
    
    [queue inDatabase:^(FMDatabase *db) {
        
        NSString *checkInImei          = [newSignInDic objectForKey:@"identifier"];
        NSString *checkInLatitude      = [newSignInDic objectForKey:@"checkInLatitude"];
        NSString *checkInLocationTime  = [newSignInDic objectForKey:@"checkInLocationTime"];
        NSString *checkInLocationType  = [newSignInDic objectForKey:@"checkInLocationType"];
        NSString *checkInLongitude     = [newSignInDic objectForKey:@"checkInLongitude"];
        NSString *checkInTime          = [newSignInDic objectForKey:@"checkInTime"];
        
        NSString *checkOutImei         = [newSignInDic objectForKey:@"identifier"];
        NSString *checkOutLatitude     = [newSignInDic objectForKey:@"checkOutLatitude"];
        NSString *checkOutLocationTime = [newSignInDic objectForKey:@"checkOutLocationTime"];
        NSString *checkOutLocationType = [newSignInDic objectForKey:@"checkOutLocationType"];
        NSString *checkOutLongitude    = [newSignInDic objectForKey:@"checkOutLongitude"];
        NSString *checkOutTime         = [newSignInDic objectForKey:@"checkOutTime"];
        
        NSString *companyCode          = [newSignInDic objectForKey:@"Id"];
        NSString *isUpload             = [newSignInDic objectForKey:@"isUpload"];
        NSString *itemCode             = [newSignInDic objectForKey:@"itemCode"];
        NSString *storeCode            = [newSignInDic objectForKey:@"storeCode"];
        NSString *uid                  = [newSignInDic objectForKey:@"uid"];
        if ([db open])
        {
            NSString * insertString = [NSString stringWithFormat:@"insert into newSignIn (identifier,checkInLatitude,checkInLocationTime,checkInLocationType,checkInLongitude,identifier,checkOutImei,checkOutLatitude,checkOutLocationTime,checkOutLocationType,checkOutLongitude,checkOutTime,Id,isUpload,itemCode,storeCode,uid) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",checkInImei,checkInLatitude,checkInLocationTime,checkInLocationType,checkInLongitude,checkInTime,checkOutImei,checkOutLatitude,checkOutLocationTime,checkOutLocationType,checkOutLongitude,checkOutTime,companyCode,isUpload,itemCode,storeCode,uid,@"null"];
            [db executeUpdate:insertString];
            NSLog(@"数据  %@",insertString);
        }
        [db close];
    }];
}
//+ (void)insertCheckTableWithTheDictionary:(NSDictionary *)ceShiDic
//{
//    [self creatCheckTable];
//
//    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
//
//    [queue inDatabase:^(FMDatabase *db) {
//        NSString *checkInImei          = [ceShiDic objectForKey:@"identifier"];
//        NSString *checkInLatitude      = [ceShiDic objectForKey:@"checkInLatitude"];
//        NSString *checkInLocationTime  = [ceShiDic objectForKey:@"checkInLocationTime"];
//        NSString *checkInLocationType  = [ceShiDic objectForKey:@"checkInLocationType"];
//        NSString *checkInLongitude     = [ceShiDic objectForKey:@"checkInLongitude"];
//        NSString *checkInTime          = [ceShiDic objectForKey:@"checkInTime"];
//
//        NSString *checkOutImei         = [ceShiDic objectForKey:@"identifier"];
//        NSString *checkOutLatitude     = [ceShiDic objectForKey:@"checkOutLatitude"];
//        NSString *checkOutLocationTime = [ceShiDic objectForKey:@"checkOutLocationTime"];
//        NSString *checkOutLocationType = [ceShiDic objectForKey:@"checkOutLocationType"];
//        NSString *checkOutLongitude    = [ceShiDic objectForKey:@"checkOutLongitude"];
//        NSString *checkOutTime         = [ceShiDic objectForKey:@"checkOutTime"];
//
//        NSString *Id                   = [ceShiDic objectForKey:@"Id"];
//        NSString *isUpload             = [ceShiDic objectForKey:@"isUpload"];
//        NSString *ProjectID            = [ceShiDic objectForKey:@"ProjectID"];
//        NSString *storeCode            = [ceShiDic objectForKey:@"storeCode"];
//        NSString *userID               = [ceShiDic objectForKey:@"userID"];
//
//        if ([db open]) {
//            NSString *insertString = [NSString stringWithFormat:@"insert into check (identifier,checkInLatitude,checkInLocationTime,checkInLocationType,checkInLongitude,checkInTime,identifier,checkOutLatitude,checkOutLocationTime,checkOutLocationType,checkOutLongitude,checkOutTime,Id,isUpload,ProjectID,storeCode,userID) values ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",checkInImei,checkInLatitude,checkInLocationTime,checkInLocationType,checkInLongitude,checkInTime,checkOutImei,checkOutLatitude,checkOutLocationTime,checkOutLocationType,checkOutLongitude,checkOutTime,Id,isUpload,ProjectID,storeCode,userID,@"null"];
//
//            [db executeUpdate:insertString];
//        }
//        [db close];
//    }];
//
//}
#pragma mark --查询签到信息
// 查询签到信息
+ (NSMutableArray *)selectCheckTable
{
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    
    NSMutableArray *array = [NSMutableArray array];
    
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open])
        {
            NSString *selectCeShi = [NSString stringWithFormat:@"select * from NewSignIn where userID like '%@'",USER_ID];
            FMResultSet *set = [db executeQuery:selectCeShi];
            while ([set next]) {
                signInModel *signIn = [[signInModel alloc]init];
                
                signIn.checkInImei = [set stringForColumn:@"identifier"];
                if ([[set stringForColumn:@"checkInLatitude"]isEqualToString:@"(null)"]) {
                    signIn.checkInLatitude = @"0.0";
                }else
                {
                    signIn.checkInLatitude = [set stringForColumn:@"checkInLatitude"];
                }
                if ([[set stringForColumn:@"checkInLocationTime"]isEqualToString:@"(null)"]) {
                    signIn.checkInLocationTime = @"0";
                }else
                {
                    signIn.checkInLocationTime = [set stringForColumn:@"checkInLocationTime"];
                }
                if ([[set stringForColumn:@"checkInLocationType"]isEqualToString:@"(null)"]) {
                    signIn.checkInLocationType = @"0";
                }else
                {
                    signIn.checkInLocationType = [set stringForColumn:@"checkInLocationType"];
                }
                if ([[set stringForColumn:@"checkInLongitude"]isEqualToString:@"(null)"]) {
                    signIn.checkInLongitude = @"0.0";
                }
                else
                {
                    signIn.checkInLongitude = [set stringForColumn:@"checkInLongitude"];
                }
                if ([[set stringForColumn:@"checkInTime"]isEqualToString:@"(null)"]) {
                    signIn.checkInTime = @"0";
                }
                else{
                    signIn.checkInTime = [set stringForColumn:@"checkInTime"];
                }
                
                signIn.checkOutImei = [set stringForColumn:@"identifier"];
                if ([[set stringForColumn:@"checkOutLatitude"]isEqualToString:@"(null)"]) {
                    signIn.checkOutLatitude = @"0.0";
                }else
                {
                    signIn.checkOutLatitude = [set stringForColumn:@"checkOutLatitude"];
                }
                if ([[set stringForColumn:@"checkOutLocationTime"]isEqualToString:@"(null)"]) {
                    signIn.checkOutLocationTime = @"0";
                }else
                {
                    signIn.checkOutLocationTime = [set stringForColumn:@"checkOutLocationTime"];
                }
                if ([[set stringForColumn:@"checkOutLocationType"]isEqualToString:@"(null)"]) {
                    signIn.checkOutLocationType = @"0";
                }else
                {
                    signIn.checkOutLocationType = [set stringForColumn:@"checkOutLocationType"];
                }
                if ([[set stringForColumn:@"checkOutLongitude"]isEqualToString:@"(null)"]) {
                    signIn.checkOutLongitude = @"0.0";
                }else
                {
                    signIn.checkOutLongitude = [set stringForColumn:@"checkOutLongitude"];
                }
                signIn.checkOutTime = [set stringForColumn:@"checkOutTime"];
                
                signIn.Id = [set stringForColumn:@"Id"];
                
                if ([[set stringForColumn:@"isUpload"]isEqualToString:@"(null)"]) {
                    signIn.isUpload = @"0";
                }else
                {
                    signIn.isUpload = [set stringForColumn:@"isUpload"];
                }
                signIn.ProjectID = [set  stringForColumn:@"ProjectID"];
                signIn.StoreCode = [set stringForColumn:@"StoreCode"];
                signIn.userID = [set stringForColumn:@"userID"];
                
                [array addObject:signIn];
            };
        }
    }];
    return array;
}
// 插入签到信息
+ (void)insertSignInTableWithTheDictionary:(NSDictionary *)signInDic
{
    [self creatSignInTable];
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    // 使用
    [queue inDatabase:^(FMDatabase *db) {
        
        
        NSString *userID        =[signInDic objectForKey:@"userID"];
        NSString *StoreCode     =[signInDic objectForKey:@"StoreCode"];
        NSString *Longitude     =[signInDic objectForKey:@"Longitude"];
        NSString *Latitude      =[signInDic objectForKey:@"Latitude"];
        NSString *LocationType  =[signInDic objectForKey:@"LocationType"];
        NSString *LocationTtime =[signInDic objectForKey:@"LocationTtime"];
        NSString *signInType    =[signInDic objectForKey:@"signInType"];
        NSString *identifier    =[signInDic objectForKey:@"identifier"];
        NSString *Createtime    =[signInDic objectForKey:@"Createtime"];
        NSString *storeName     =[signInDic objectForKey:@"storeName"];
        NSString *projectName   =[signInDic objectForKey:@"projectName"];
        NSString *btnSelect     =[signInDic objectForKey:@"btnSelect"];
        NSString *companyName  = [signInDic objectForKey:@"companyName"];
        NSString *Id           = [signInDic objectForKey:@"Id"];
        NSString *ProjectID    = [signInDic objectForKey:@"ProjectID"];
        
        if ([db open])
        {
            
            NSString * insertString = [NSString stringWithFormat:@"insert into signIn (userID,StoreCode,checkInImei,checkInLongitude,checkInLatitude,checkInLocationType,checkInLocationTime,signInType,checkInTime,storeName,projectName,btnSelect,companyName,companyCode,itemCode,checkOutImei,checkOutTime) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",userID,StoreCode,identifier,Longitude,Latitude,LocationType,LocationTtime,signInType,Createtime,storeName,projectName,btnSelect,companyName,Id,ProjectID,identifier,@"null"];
            BOOL res = [db executeUpdate:insertString];
            //            [db executeUpdate:insertString];
            if (!res) {
                NSLog(@"|**=== 2error when creating db table ===**|   %d",res);
            } else {
                NSLog(@"|**=== success to creating db table ===**|   %d",res);
            }
            NSLog(@"数据  %@",insertString);
        }
        
        [db close];
    }];
}

//更新门店信息
+ (void)updataMDWithTheDictionary:(ProductModel *)model
{
    [self creatMDInfo];
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    // 使用
    [queue inDatabase:^(FMDatabase *db) {
        
        
        NSString *userID        =model.userID;
        NSString *StoreCode     =model.ProjectId;
        NSString *Longitude     =model.StoreId;
        NSString *Latitude      =model.Code;
        NSString *LocationType  =model.CreateDate;
        NSString *LocationTtime =model.CreateUserId;
        //        NSString *signInType    =model.DiDui;
        //        NSString *identifier    =model.Area;
        //        NSString *Createtime    =model.Position;
        //        NSString *storeName     =model.POSM;
        //        NSString *productId     =model.ProductId;
        //        NSString *price            =model.Price;
        //        NSString *productSmell   =model.ProductSmell;
        //        NSString *areaRatio=   model.AreaRatio;
        //        NSString *state=   model.MDstate;
        NSString *Expand0   =model.Expand0;
        NSString *Expand1   =model.Expand1;
        NSString *Expand2    =model.Expand2;
        NSString *Expand3  = model.Expand3;
        NSString *Expand4           = model.Expand4;
        NSString *Expand5    = model.Expand5;
        NSString *Expand6    = model.Expand6;
        NSString *Expand7   = model.Expand7;
        NSString *Expand8   =model.Expand8;
        NSString *Expand9    =model.Expand9;
        NSString *Expand10  = model.Expand10;
        NSString *Expand11          = model.Expand11;
        NSString *Expand12    = model.Expand12;
        NSString *Expand13   = model.Expand13;
        NSString *Expand14   = model.Expand14;
        NSString *Expand15   =model.Expand15;
        NSString *Expand16    =model.Expand16;
        NSString *Expand17  = model.Expand17;
        NSString *Expand18           = model.Expand18;
        NSString *Expand19    = model.Expand19;
        NSString *Expand20    = model.Expand20;
        NSString *Expand21   = model.Expand21;
        NSString *Expand22   =model.Expand22;
                NSString *Expand23   =model.Expand23;
        NSString *Expand24   =model.Expand24;
        NSString *Expand25   =model.Expand25;
        
        
        NSString *Expand26    = model.Expand26;
        NSString *Expand27    = model.Expand27;
        NSString *Expand28    = model.Expand28;
        NSString *Expand29    = model.Expand29;
        NSString *Expand30    = model.Expand30;
        NSString *Expand31    = model.Expand31;
        NSString *Expand32    = model.Expand32;
        NSString *Expand33    = model.Expand33;
        NSString *Expand34    = model.Expand34;
        NSString *Expand35    = model.Expand35;
        NSString *Expand36    = model.Expand36;
        NSString *Expand37    = model.Expand37;
        NSString *Expand38    = model.Expand38;
        NSString *Expand39    = model.Expand39;
        NSString *Expand40    = model.Expand40;
        NSString *Expand41    = model.Expand41;
        NSString *Expand42    = model.Expand42;
        NSString *Expand43    = model.Expand43;
        NSString *Expand44    = model.Expand44;
        NSString *Expand45    = model.Expand45;
        NSString *Expand46    = model.Expand46;
        NSString *Expand47    = model.Expand47;
        NSString *Expand48    = model.Expand48;
        NSString *Expand49    = model.Expand49;
        NSString *Expand50    = model.Expand50;
        
        NSString *Expand51    = model.Expand51;
        NSString *Expand52    = model.Expand52;
        NSString *Expand53    = model.Expand53;
        NSString *Expand54    = model.Expand54;
        NSString *Expand55    = model.Expand55;
        NSString *Expand56    = model.Expand56;
        NSString *Expand57    = model.Expand57;
        NSString *Expand58    = model.Expand58;
        NSString *Expand59    = model.Expand59;
        NSString *Expand60    = model.Expand60;
        NSString *Expand61    = model.Expand61;
        NSString *Expand62    = model.Expand62;
        NSString *Expand63    = model.Expand63;
        NSString *Expand64    = model.Expand64;
        NSString *Expand65    = model.Expand65;
        NSString *Expand66    = model.Expand66;
        NSString *Expand67    = model.Expand67;
        NSString *Expand68    = model.Expand68;
        NSString *Expand69    = model.Expand69;
        NSString *Expand70    = model.Expand70;


        
        
        if ([db open])
        {

            NSString *  insertString=[NSString stringWithFormat:@"update storeInfo set userID='%@',ProjectId='%@',StoreId='%@',Code='%@',CreateDate='%@',CreateUserId='%@',Expand0='%@',Expand1='%@',Expand2='%@',Expand3='%@',Expand4='%@',Expand5='%@',Expand6='%@',Expand7='%@',Expand8='%@',Expand9='%@',Expand10='%@',Expand11='%@',Expand12='%@',Expand13='%@',Expand14='%@',Expand15='%@',Expand16='%@',Expand17='%@',Expand18='%@',Expand19='%@',Expand20='%@',Expand21='%@',Expand22='%@',Expand23='%@',Expand24='%@',Expand25='%@',Expand26='%@',Expand27='%@',Expand28='%@',Expand29='%@',Expand30='%@',Expand31='%@',Expand32='%@',Expand33='%@',Expand34='%@',Expand35='%@',Expand36='%@',Expand37='%@',Expand38='%@',Expand39='%@',Expand40='%@',Expand41='%@',Expand42='%@',Expand43='%@',Expand44='%@',Expand45='%@',Expand46='%@',Expand47='%@',Expand48='%@',Expand49='%@',Expand50='%@',Expand51='%@',Expand52='%@',Expand53='%@',Expand54='%@',Expand55='%@',Expand56='%@',Expand57='%@',Expand58='%@',Expand59='%@',Expand60='%@',Expand61='%@',Expand62='%@',Expand63='%@',Expand64='%@',Expand65='%@',Expand66='%@',Expand67='%@',Expand68='%@',Expand69='%@',Expand70='%@' where Code like '%@'",userID,StoreCode,Longitude,Latitude,LocationType,LocationTtime,Expand0,Expand1,Expand2,Expand3,Expand4,Expand5,Expand6,Expand7,Expand8,Expand9,Expand10,Expand11,Expand12,Expand13,Expand14,Expand15,Expand16,Expand17,Expand18,Expand19,Expand20,Expand21,Expand22,Expand23,Expand24,Expand25,Expand26,Expand27,Expand28,Expand29,Expand30,Expand31,Expand32,Expand33,Expand34,Expand35,Expand36,Expand37,Expand38,Expand39,Expand40,Expand41,Expand42,Expand43,Expand44,Expand45,Expand46,Expand47,Expand48,Expand49,Expand50,Expand51,Expand52,Expand53,Expand54,Expand55,Expand56,Expand57,Expand58,Expand59,Expand60,Expand61,Expand62,Expand63,Expand64,Expand65,Expand66,Expand67,Expand68,Expand69,Expand70,model.Code];
            BOOL res = [db executeUpdate:insertString];
            //            [db executeUpdate:insertString];
            if (!res) {
                NSLog(@"|**=== 2error when creating db table ===**|   %d",res);
            } else {
                NSLog(@"|**=== success to creating db table ===**|   %d",res);
            }
            NSLog(@"数据  %@",insertString);
        }
        
        [db close];
    }];
    
}
//存储门店信息
+ (void)keepMDWithTheDictionary:(ProductModel *)model
{
    [self creatMDInfo];
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    // 使用
    [queue inDatabase:^(FMDatabase *db) {
        
        
        NSString *userID        =model.userID;
        NSString *StoreCode     =model.ProjectId;
        NSString *Longitude     =model.StoreId;
        NSString *Latitude      =model.Code;
        NSString *LocationType  =model.CreateDate;
        NSString *LocationTtime =model.CreateUserId;
        NSString *signInType    =model.DiDui;
        NSString *identifier    =model.Area;
        NSString *Createtime    =model.Position;
        NSString *storeName     =model.POSM;
        NSString *productId     =model.ProductId;
        NSString *price            =model.Price;
        NSString *productSmell   =model.ProductSmell;
        NSString *areaRatio=   model.AreaRatio;
        NSString *state=   model.MDstate;
        NSString *btnSelect   =model.Expand1;
        NSString *projectName    =model.Expand2;
        NSString *companyName  = model.Expand3;
        NSString *Id           = model.Expand4;
        NSString *ProjectID    = model.Expand5;
        
        if ([db open])
        {
            NSString * insertString = [NSString stringWithFormat:@"insert into MDInfo (userID,ProjectId,StoreId,Code,CreateDate,CreateUserId,DiDui,Area,Position,POSM,state,ProductId,Price,ProductSmell,AreaRatio,Expand1,Expand2,Expand3,Expand4,Expand5,Expand6,Expand7,Expand8,Expand9,Expand10) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",userID,StoreCode,Longitude,Latitude,LocationType,LocationTtime,signInType,identifier,Createtime,storeName,state,productId,price,productSmell,areaRatio,projectName,@"YES",companyName,Id,ProjectID,@"",@"",@"",@"",@""];
            BOOL res = [db executeUpdate:insertString];
            //            [db executeUpdate:insertString];
            if (!res) {
                NSLog(@"|**=== 2error when creating db table ===**|   %d",res);
            } else {
                NSLog(@"|**=== success to creating db table ===**|   %d",res);
            }
            NSLog(@"数据  %@",insertString);
        }
        
        [db close];
    }];
    
}

+ (void)keepStoreWithTheDictionary:(ProductModel *)model
{
    [self creatStoreInfo];
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    // 使用
    [queue inDatabase:^(FMDatabase *db) {

        NSString *userID        =model.userID;
        NSString *StoreCode     =model.ProjectId;
        NSString *Longitude     =model.StoreId;
        NSString *Latitude      =model.Code;
        NSString *LocationType  =model.CreateDate;
        NSString *LocationTtime =model.CreateUserId;
        NSString *signInType    =model.DiDui;
        NSString *identifier    =model.Area;
        NSString *Createtime    =model.Position;
        NSString *storeName     =model.POSM;
        NSString *productId     =model.ProductId;
        NSString *price            =model.Price;
        NSString *productSmell   =model.ProductSmell;
        NSString *areaRatio=   model.AreaRatio;
        NSString *state=   model.MDstate;
        
        NSString *Expand0   =model.Expand0;
        NSString *Expand1   =model.Expand1;
        NSString *Expand2    =model.Expand2;
        NSString *Expand3  = model.Expand3;
        NSString *Expand4           = model.Expand4;
        NSString *Expand5    = model.Expand5;
                NSString *Expand6    = model.Expand6;
                NSString *Expand7    = model.Expand7;
                NSString *Expand8    = model.Expand8;
                NSString *Expand9    = model.Expand9;
                NSString *Expand10    = model.Expand10;
        
        NSString *Expand11    = model.Expand11;
        NSString *Expand12    = model.Expand12;
        NSString *Expand13    = model.Expand13;
        NSString *Expand14    = model.Expand14;
        NSString *Expand15    = model.Expand15;
        NSString *Expand16    = model.Expand16;
        NSString *Expand17    = model.Expand17;
        NSString *Expand18    = model.Expand18;
        NSString *Expand19    = model.Expand19;
        NSString *Expand20    = model.Expand20;
        NSString *Expand21    = model.Expand21;
        NSString *Expand22    = model.Expand22;
        NSString *Expand23    = model.Expand23;
        NSString *Expand24    = model.Expand24;
        NSString *Expand25    = model.Expand25;
        NSString *Expand26    = model.Expand26;
        NSString *Expand27    = model.Expand27;
        NSString *Expand28    = model.Expand28;
        NSString *Expand29    = model.Expand29;
        NSString *Expand30    = model.Expand30;
        NSString *Expand31    = model.Expand31;
        NSString *Expand32    = model.Expand32;
        NSString *Expand33    = model.Expand33;
        NSString *Expand34    = model.Expand34;
        NSString *Expand35    = model.Expand35;
        NSString *Expand36    = model.Expand36;
        NSString *Expand37    = model.Expand37;
        NSString *Expand38    = model.Expand38;
        NSString *Expand39    = model.Expand39;
        NSString *Expand40    = model.Expand40;
        NSString *Expand41    = model.Expand41;
        NSString *Expand42    = model.Expand42;
        NSString *Expand43    = model.Expand43;
        NSString *Expand44    = model.Expand44;
        NSString *Expand45    = model.Expand45;
        NSString *Expand46    = model.Expand46;
        NSString *Expand47    = model.Expand47;
        NSString *Expand48    = model.Expand48;
        NSString *Expand49    = model.Expand49;
        NSString *Expand50    = model.Expand50;
        
        NSString *Expand51    = model.Expand51;
        NSString *Expand52    = model.Expand52;
        NSString *Expand53    = model.Expand53;
        NSString *Expand54    = model.Expand54;
        NSString *Expand55    = model.Expand55;
        NSString *Expand56    = model.Expand56;
        NSString *Expand57    = model.Expand57;
        NSString *Expand58    = model.Expand58;
        NSString *Expand59    = model.Expand59;
        NSString *Expand60    = model.Expand60;
        NSString *Expand61    = model.Expand61;
        NSString *Expand62    = model.Expand62;
        NSString *Expand63    = model.Expand63;
        NSString *Expand64    = model.Expand64;
        NSString *Expand65    = model.Expand65;
        NSString *Expand66    = model.Expand66;
        NSString *Expand67    = model.Expand67;
        NSString *Expand68    = model.Expand68;
        NSString *Expand69    = model.Expand69;
        NSString *Expand70    = model.Expand70;

        
        
        if ([db open])
        {
            NSString * insertString = [NSString stringWithFormat:@"insert into storeInfo (userID,ProjectId,StoreId,Code,CreateDate,CreateUserId,DiDui,Area,Position,POSM,state,ProductId,Price,ProductSmell,AreaRatio,Expand0,Expand1,Expand2,Expand3,Expand4,Expand5,Expand6,Expand7,Expand8,Expand9,Expand10,Expand11,Expand12,Expand13,Expand14,Expand15,Expand16,Expand17,Expand18,Expand19,Expand20,Expand21,Expand22,Expand23,Expand24,Expand25,Expand26,Expand27,Expand28,Expand29,Expand30,Expand31,Expand32,Expand33,Expand34,Expand35,Expand36,Expand37,Expand38,Expand39,Expand40,Expand41,Expand42,Expand43,Expand44,Expand45,Expand46,Expand47,Expand48,Expand49,Expand50,Expand51,Expand52,Expand53,Expand54,Expand55,Expand56,Expand57,Expand58,Expand59,Expand60,Expand61,Expand62,Expand63,Expand64,Expand65,Expand66,Expand67,Expand68,Expand69,Expand70) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",userID,StoreCode,Longitude,Latitude,LocationType,LocationTtime,signInType,identifier,Createtime,storeName,state,productId,price,productSmell,areaRatio,Expand0,Expand1,Expand2,Expand3,Expand4,Expand5,Expand6,Expand7,Expand8,Expand9,Expand10,Expand11,Expand12,Expand13,Expand14,Expand15,Expand16,Expand17,Expand18,Expand19,Expand20,Expand21,Expand22,Expand23,Expand24,Expand25,Expand26,Expand27,Expand28,Expand29,Expand30,Expand31,Expand32,Expand33,Expand34,Expand35,Expand36,Expand37,Expand38,Expand39,Expand40,Expand41,Expand42,Expand43,Expand44,Expand45,Expand46,Expand47,Expand48,Expand49,Expand50,Expand51,Expand52,Expand53,Expand54,Expand55,Expand56,Expand57,Expand58,Expand59,Expand60,Expand61,Expand62,Expand63,Expand64,Expand65,Expand66,Expand67,Expand68,Expand69,Expand70];
            BOOL res = [db executeUpdate:insertString];
            //            [db executeUpdate:insertString];
            if (!res) {
                NSLog(@"|**=== 2error when creating db table ===**|   %d",res);
            } else {
                NSLog(@"|**=== success to creating db table ===**|   %d",res);
            }
            NSLog(@"数据  %@",insertString);
        }
        
        [db close];
    }];

}
// 更改签到信息
+ (void)upLoadDataWithTheDictionary:(NSDictionary *)goOutDic
{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    
    [queue inDatabase:^(FMDatabase *db) {
        NSString *Longitude =[goOutDic objectForKey:@"Longitude"];
        NSString *Latitude =[goOutDic objectForKey:@"Latitude"];
        NSString *LocationType =[goOutDic objectForKey:@"LocationType"];
        NSString *LocationTtime =[goOutDic objectForKey:@"LocationTtime"];
        NSString *signInType =[goOutDic objectForKey:@"signInType"];
        NSString *Createtime =[goOutDic objectForKey:@"Createtime"];
        //NSString *identifier    =[goOutDic objectForKey:@"identifier"];
        NSString *StoreCode  =[goOutDic objectForKey:@"StoreCode"];
        //        NSString *Id           = [goOutDic objectForKey:@"Id"];
        //        NSString *ProjectID    = [goOutDic objectForKey:@"ProjectID"];
        //        NSString *storeName =[goOutDic objectForKey:@"storeName"];
        //        NSString *projectName=[goOutDic objectForKey:@"projectName"];
        if ([db open])
        {
            //            NSString * insertString = [NSString stringWithFormat:@"update  signIn set checkOutLongitude='%@',checkOutLatitude='%@',checkOutLocationType='%@',checkOutLocationTime='%@',goOutInType='%@',checkOutTime='%@' where StoreCode like'%@' and companyCode like '%@' and itemCode like '%@' and userID like '%@'",Longitude,Latitude,LocationType,LocationTtime,signInType,Createtime,StoreCode,Id,ProjectID,USER_ID];
            NSString * insertString = [NSString stringWithFormat:@"update  signIn set checkOutLongitude='%@',checkOutLatitude='%@',checkOutLocationType='%@',checkOutLocationTime='%@',goOutInType='%@',checkOutTime='%@' where StoreCode like'%@' and userID like '%@'",Longitude,Latitude,LocationType,LocationTtime,signInType,Createtime,StoreCode,USER_ID];
            // [db executeUpdate:insertString];
            NSLog(@" insertString1---- %@",insertString);
            BOOL res = [db executeUpdate:insertString];
            if (!res) {
                NSLog(@"|**=== error when creating db table ===**|   %d",res);
            } else {
                NSLog(@"|**=== success to creating db table ===**|   %d",res);
            }
            
        }
        [db close];
        
    }];
}
+ (void)upLoadSignInWithTheDictionary:(NSDictionary *)goOutDic
{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    
    [queue inDatabase:^(FMDatabase *db) {
        //        NSString *Longitude =[goOutDic objectForKey:@"Longitude"];
        //        NSString *Latitude =[goOutDic objectForKey:@"Latitude"];
        //        NSString *LocationType =[goOutDic objectForKey:@"LocationType"];
        //        NSString *LocationTtime =[goOutDic objectForKey:@"LocationTtime"];
        //        NSString *signInType =[goOutDic objectForKey:@"signInType"];
        //        NSString *Createtime =[goOutDic objectForKey:@"Createtime"];
        //NSString *identifier    =[goOutDic objectForKey:@"identifier"];
        NSString *StoreCode  =[goOutDic objectForKey:@"storeCode"];
        NSString *companyName  =[goOutDic objectForKey:@"companyName"];
        NSString *storeName  =[goOutDic objectForKey:@"storeName"];
        NSString *str=@"NO";
        if ([db open])
        {
            if (![StoreCode isEqualToString:@""]) {
                //            NSString * insertString = [NSString stringWithFormat:@"update  signIn set checkOutLongitude='%@',checkOutLatitude='%@',checkOutLocationType='%@',checkOutLocationTime='%@',goOutInType='%@',checkOutTime='%@' where StoreCode like'%@' and companyCode like '%@' and itemCode like '%@' and userID like '%@'",Longitude,Latitude,LocationType,LocationTtime,signInType,Createtime,StoreCode,Id,ProjectID,USER_ID];
                NSString * insertString = [NSString stringWithFormat:@"update  signIn set btnSelect='%@' where StoreCode like'%@' and userID like '%@'",str,StoreCode,USER_ID];
                // [db executeUpdate:insertString];
                NSLog(@" insertString1---- %@",insertString);
                BOOL res = [db executeUpdate:insertString];
                if (!res) {
                    NSLog(@"|**=== error when creating db table ===**|   %d",res);
                } else {
                    NSLog(@"|**=== success to creating db table ===**|   %d",res);
                }
            }
            else if (companyName)
            {
                NSString * insertString = [NSString stringWithFormat:@"update  signIn set btnSelect='%@' where companyName like'%@' and userID like '%@'",str,companyName,USER_ID];
                // [db executeUpdate:insertString];
                NSLog(@" insertString1---- %@",insertString);
                BOOL res = [db executeUpdate:insertString];
                if (!res) {
                    NSLog(@"|**=== error when creating db table ===**|   %d",res);
                } else {
                    NSLog(@"|**=== success to creating db table ===**|   %d",res);
                }
                
            }
            else
            {
                NSString * insertString = [NSString stringWithFormat:@"update  signIn set btnSelect='%@' where storeName like'%@' and userID like '%@'",str,storeName,USER_ID];
                // [db executeUpdate:insertString];
                NSLog(@" insertString1---- %@",insertString);
                BOOL res = [db executeUpdate:insertString];
                if (!res) {
                    NSLog(@"|**=== error when creating db table ===**|   %d",res);
                } else {
                    NSLog(@"|**=== success to creating db table ===**|   %d",res);
                }
                
                
            }
            
            
        }
        [db close];
        
    }];
}
// 更改签到信息 2
+ (void)upLoadDataWithTheDictionary2:(NSDictionary *)goOutDic
{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    
    [queue inDatabase:^(FMDatabase *db) {
        NSString *Longitude =[goOutDic objectForKey:@"Longitude"];
        NSString *Latitude =[goOutDic objectForKey:@"Latitude"];
        NSString *LocationType =[goOutDic objectForKey:@"LocationType"];
        NSString *LocationTtime =[goOutDic objectForKey:@"LocationTtime"];
        NSString *signInType =[goOutDic objectForKey:@"signInType"];
        NSString *Createtime =[goOutDic objectForKey:@"Createtime"];
        //NSString *identifier    =[goOutDic objectForKey:@"identifier"];
        NSString *StoreCode  =[goOutDic objectForKey:@"StoreCode"];
        NSString *Id           = [goOutDic objectForKey:@"Id"];
        NSString *ProjectID    = [goOutDic objectForKey:@"ProjectID"];
        NSLog(@"Createtime-->%@",Createtime);
        if ([db open])
        {
            NSString * insertString = [NSString stringWithFormat:@"update  signIn set checkOutLongitude='%@',checkOutLatitude='%@',checkOutLocationType='%@',checkOutLocationTime='%@',goOutInType='%@',checkOutTime='%@',StoreCode='%@' where companyCode like '%@' and userID like '%@'",Longitude,Latitude,LocationType,LocationTtime,signInType,Createtime,StoreCode,Id,USER_ID];
            // [db executeUpdate:insertString];
            NSLog(@"insertString2   %@",insertString);
            BOOL res = [db executeUpdate:insertString];
            if (!res) {
                NSLog(@"|**=== error when creating db table ===**|   %d",res);
            } else {
                NSLog(@"|**=== success to creating db table ===**|   %d",res);
            }
            
        }
        [db close];
        
    }];
}
//控件是否已保存
+ (ProductModel *)selectControlTable:(NSString *)storeCode andProID:(NSString *)proID andControlID:(NSString *)controlID
{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    ProductModel *model=[[ProductModel alloc]init];
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open])
        {
            NSString * selectSignIn = [NSString stringWithFormat:@"select * from myinfo where storeCode like '%@' and ProjectId like '%@' and ControlID like '%@' and userID like '%@'",storeCode,proID,controlID,USER_ID];
            FMResultSet * set = [db executeQuery:selectSignIn];
            
            while ([set next])
            {
                
                model.userID=[set stringForColumn:@"userID"];
                model.ProjectId=[set stringForColumn:@"ProjectId"];
                model.StoreId=[set stringForColumn:@"StoreId"];
                model.Code=[set stringForColumn:@"Code"];
//                model.CreateDate=[set stringForColumn:@"CreateDate"];
//                model.CreateUserId=[set stringForColumn:@"CreateUserId"];
//                model.DiDui=[set stringForColumn:@"DiDui"];
//                model.Area=[set stringForColumn:@"Area"];
//                model.Position=[set stringForColumn:@"Position"];
//                model.POSM=[set stringForColumn:@"POSM"];
//                model.MDstate=[set stringForColumn:@"state"];
//                model.ProductId=[set stringForColumn:@"ProductId"];
//                model.Price=[set stringForColumn:@"Price"];
//                model.ProductSmell=[set stringForColumn:@"ProductSmell"];
//                
//                model.AreaRatio=[set stringForColumn:@"AreaRatio"];
//                model.Expand1=[set stringForColumn:@"Expand1"];
//                model.Expand2=[set stringForColumn:@"Expand2"];
//                model.Expand3=[set stringForColumn:@"Expand3"];
//                model.Expand4=[set stringForColumn:@"Expand4"];
//                model.Expand5=[set stringForColumn:@"Expand5"];
//                model.Expand6=[set stringForColumn:@"Expand6"];
//                model.Expand7=[set stringForColumn:@"Expand7"];
//                model.Expand8=[set stringForColumn:@"Expand8"];
                //                model.Expand9=[set stringForColumn:@"Expand9"];
                //                model.Expand10=[set stringForColumn:@"Expand10"];
                
                
                
                //                [arr addObject:model];
                
            }
        }
    }];
    //    return  arr;
    return model;
    
}
//搜索门店信息
+ (ProductModel *)selectMDDetailTable:(NSString *)code
{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
//    NSMutableArray * arr = [NSMutableArray array];
//    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
      ProductModel *model=[[ProductModel alloc]init];
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open])
        {
            //            NSString * selectSignIn = [NSString stringWithFormat:@"select * from signIn where btnSelect like 'YES' and userID like '%@'",USER_ID];
            //                        NSString * selectSignIn = [NSString stringWithFormat:@"select * from storeInfo where btnSelect like 'NO' and userID like '%@'",USER_ID];
            NSString * selectSignIn = [NSString stringWithFormat:@"select * from storeInfo where Code like '%@' and userID like '%@'",code,USER_ID];
            FMResultSet * set = [db executeQuery:selectSignIn];
            
            while ([set next])
            {

                model.userID=[set stringForColumn:@"userID"];
                model.ProjectId=[set stringForColumn:@"ProjectId"];
                model.StoreId=[set stringForColumn:@"StoreId"];
                model.Code=[set stringForColumn:@"Code"];
                model.CreateDate=[set stringForColumn:@"CreateDate"];
                model.CreateUserId=[set stringForColumn:@"CreateUserId"];
                model.DiDui=[set stringForColumn:@"DiDui"];
                model.Area=[set stringForColumn:@"Area"];
                model.Position=[set stringForColumn:@"Position"];
                model.POSM=[set stringForColumn:@"POSM"];
                model.MDstate=[set stringForColumn:@"state"];
                model.ProductId=[set stringForColumn:@"ProductId"];
                model.Price=[set stringForColumn:@"Price"];
                model.ProductSmell=[set stringForColumn:@"ProductSmell"];
                
                model.AreaRatio=[set stringForColumn:@"AreaRatio"];
                model.Expand1=[set stringForColumn:@"Expand1"];
                model.Expand2=[set stringForColumn:@"Expand2"];
                model.Expand3=[set stringForColumn:@"Expand3"];
                model.Expand4=[set stringForColumn:@"Expand4"];
                model.Expand5=[set stringForColumn:@"Expand5"];
                model.Expand6=[set stringForColumn:@"Expand6"];
                model.Expand7=[set stringForColumn:@"Expand7"];
                model.Expand8=[set stringForColumn:@"Expand8"];
                //                model.Expand9=[set stringForColumn:@"Expand9"];
                //                model.Expand10=[set stringForColumn:@"Expand10"];
                
                
                
//                [arr addObject:model];
                
            }
        }
    }];
//    return  arr;
    return model;
    
}
//搜索所有门店信息
+ (NSMutableArray *)selectAllMDDetailTable
{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    NSMutableArray * arr = [NSMutableArray array];
    
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open])
        {
            //            NSString * selectSignIn = [NSString stringWithFormat:@"select * from signIn where btnSelect like 'YES' and userID like '%@'",USER_ID];
            //                        NSString * selectSignIn = [NSString stringWithFormat:@"select * from storeInfo where btnSelect like 'NO' and userID like '%@'",USER_ID];
            NSString * selectSignIn = [NSString stringWithFormat:@"select * from MDInfo where userID like '%@'",USER_ID];
            FMResultSet * set = [db executeQuery:selectSignIn];
            while ([set next])
            {
                ProductModel *model=[[ProductModel alloc]init];
                model.userID=[set stringForColumn:@"userID"];
                model.ProjectId=[set stringForColumn:@"ProjectId"];
                model.StoreId=[set stringForColumn:@"StoreId"];
                model.Code=[set stringForColumn:@"Code"];
                model.CreateDate=[set stringForColumn:@"CreateDate"];
                model.CreateUserId=[set stringForColumn:@"CreateUserId"];
                model.DiDui=[set stringForColumn:@"DiDui"];
                model.Area=[set stringForColumn:@"Area"];
                model.Position=[set stringForColumn:@"Position"];
                model.POSM=[set stringForColumn:@"POSM"];
                model.MDstate=[set stringForColumn:@"state"];
                model.ProductId=[set stringForColumn:@"ProductId"];
                model.Price=[set stringForColumn:@"Price"];
                model.ProductSmell=[set stringForColumn:@"ProductSmell"];
                
                model.AreaRatio=[set stringForColumn:@"AreaRatio"];
                model.Expand1=[set stringForColumn:@"Expand1"];
                model.Expand2=[set stringForColumn:@"Expand2"];
                model.Expand3=[set stringForColumn:@"Expand3"];
                model.Expand4=[set stringForColumn:@"Expand4"];
                model.Expand5=[set stringForColumn:@"Expand5"];
                model.Expand6=[set stringForColumn:@"Expand6"];
                model.Expand7=[set stringForColumn:@"Expand7"];
                model.Expand8=[set stringForColumn:@"Expand8"];
                //                model.Expand9=[set stringForColumn:@"Expand9"];
                //                model.Expand10=[set stringForColumn:@"Expand10"];
                
                
                
                [arr addObject:model];
                
            }
        }
    }];
    return  arr;
    
}
//搜索单一产品信息
+ (ProductModel *)selectOneProductDetailTable:(NSString *)code andProCode:(NSString *)productCode;
{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
//    NSMutableArray * arr = [NSMutableArray array];
    ProductModel *model=[[ProductModel alloc]init];
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open])
        {
            //            NSString * selectSignIn = [NSString stringWithFormat:@"select * from signIn where btnSelect like 'YES' and userID like '%@'",USER_ID];
            //                        NSString * selectSignIn = [NSString stringWithFormat:@"select * from storeInfo where btnSelect like 'NO' and userID like '%@'",USER_ID];
            NSString * selectSignIn = [NSString stringWithFormat:@"select * from storeInfo where Code like '%@' and ProductId like '%@' and userID like '%@'",code,productCode,USER_ID];
            FMResultSet * set = [db executeQuery:selectSignIn];
            while ([set next])
            {
//                ProductModel *model=[[ProductModel alloc]init];
                model.userID=[set stringForColumn:@"userID"];
                model.ProjectId=[set stringForColumn:@"ProjectId"];
                model.StoreId=[set stringForColumn:@"StoreId"];
                model.Code=[set stringForColumn:@"Code"];
                model.CreateDate=[set stringForColumn:@"CreateDate"];
                model.CreateUserId=[set stringForColumn:@"CreateUserId"];
                model.DiDui=[set stringForColumn:@"DiDui"];
                model.Area=[set stringForColumn:@"Area"];
                model.Position=[set stringForColumn:@"Position"];
                model.POSM=[set stringForColumn:@"POSM"];
                model.MDstate=[set stringForColumn:@"state"];
                model.ProductId=[set stringForColumn:@"ProductId"];
                model.Price=[set stringForColumn:@"Price"];
                model.ProductSmell=[set stringForColumn:@"ProductSmell"];
                
                model.AreaRatio=[set stringForColumn:@"AreaRatio"];
                
                model.Expand0=[set stringForColumn:@"Expand0"];
                model.Expand1=[set stringForColumn:@"Expand1"];
                model.Expand2=[set stringForColumn:@"Expand2"];
                model.Expand3=[set stringForColumn:@"Expand3"];
                model.Expand4=[set stringForColumn:@"Expand4"];
                model.Expand5=[set stringForColumn:@"Expand5"];
                model.Expand6=[set stringForColumn:@"Expand6"];
                model.Expand7=[set stringForColumn:@"Expand7"];
                model.Expand8=[set stringForColumn:@"Expand8"];
                model.Expand9=[set stringForColumn:@"Expand9"];
                model.Expand10=[set stringForColumn:@"Expand10"];
                
                model.Expand11=[set stringForColumn:@"Expand11"];
                model.Expand12=[set stringForColumn:@"Expand12"];
                model.Expand13=[set stringForColumn:@"Expand13"];
                model.Expand14=[set stringForColumn:@"Expand14"];
                model.Expand15=[set stringForColumn:@"Expand15"];
                model.Expand16=[set stringForColumn:@"Expand16"];
                model.Expand17=[set stringForColumn:@"Expand17"];
                model.Expand18=[set stringForColumn:@"Expand18"];
                model.Expand19=[set stringForColumn:@"Expand19"];
                model.Expand20=[set stringForColumn:@"Expand20"];
                
                model.Expand21=[set stringForColumn:@"Expand21"];
                model.Expand22=[set stringForColumn:@"Expand22"];
                model.Expand23=[set stringForColumn:@"Expand23"];
                model.Expand24=[set stringForColumn:@"Expand24"];
                model.Expand25=[set stringForColumn:@"Expand25"];
                model.Expand26=[set stringForColumn:@"Expand26"];
                model.Expand27=[set stringForColumn:@"Expand27"];
                model.Expand28=[set stringForColumn:@"Expand28"];
                model.Expand29=[set stringForColumn:@"Expand29"];
                model.Expand30=[set stringForColumn:@"Expand30"];
                
                model.Expand31=[set stringForColumn:@"Expand31"];
                model.Expand32=[set stringForColumn:@"Expand32"];
                model.Expand33=[set stringForColumn:@"Expand33"];
                model.Expand34=[set stringForColumn:@"Expand34"];
                model.Expand35=[set stringForColumn:@"Expand35"];
                model.Expand36=[set stringForColumn:@"Expand36"];
                model.Expand37=[set stringForColumn:@"Expand37"];
                model.Expand38=[set stringForColumn:@"Expand38"];
                model.Expand39=[set stringForColumn:@"Expand39"];
                model.Expand40=[set stringForColumn:@"Expand40"];
            
                model.Expand41=[set stringForColumn:@"Expand41"];
                model.Expand42=[set stringForColumn:@"Expand42"];
                model.Expand43=[set stringForColumn:@"Expand43"];
                model.Expand44=[set stringForColumn:@"Expand44"];
                model.Expand45=[set stringForColumn:@"Expand45"];
                model.Expand46=[set stringForColumn:@"Expand46"];
                model.Expand47=[set stringForColumn:@"Expand47"];
                model.Expand48=[set stringForColumn:@"Expand48"];
                model.Expand49=[set stringForColumn:@"Expand49"];
                model.Expand50=[set stringForColumn:@"Expand50"];
                model.Expand51=[set stringForColumn:@"Expand51"];
                model.Expand52=[set stringForColumn:@"Expand52"];
                model.Expand53=[set stringForColumn:@"Expand53"];
                model.Expand54=[set stringForColumn:@"Expand54"];
                model.Expand55=[set stringForColumn:@"Expand55"];
                model.Expand56=[set stringForColumn:@"Expand56"];
                model.Expand57=[set stringForColumn:@"Expand57"];
                model.Expand58=[set stringForColumn:@"Expand58"];
                model.Expand59=[set stringForColumn:@"Expand59"];
                model.Expand60=[set stringForColumn:@"Expand60"];
            
                model.Expand61=[set stringForColumn:@"Expand61"];
                model.Expand62=[set stringForColumn:@"Expand62"];
                model.Expand63=[set stringForColumn:@"Expand63"];
                model.Expand64=[set stringForColumn:@"Expand64"];
                model.Expand65=[set stringForColumn:@"Expand65"];
                model.Expand66=[set stringForColumn:@"Expand66"];
                model.Expand67=[set stringForColumn:@"Expand67"];
                model.Expand68=[set stringForColumn:@"Expand68"];
                model.Expand69=[set stringForColumn:@"Expand69"];
                model.Expand70=[set stringForColumn:@"Expand70"];
                
//                [arr addObject:model];
                
            }
        }
    }];
//    return  arr;
    return model;
    
}
//搜索所有产品信息
+ (NSMutableArray *)selectProductDetailTable
{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    NSMutableArray * arr = [NSMutableArray array];
    
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open])
        {
//            NSString * selectSignIn = [NSString stringWithFormat:@"select * from signIn where btnSelect like 'YES' and userID like '%@'",USER_ID];
//                        NSString * selectSignIn = [NSString stringWithFormat:@"select * from storeInfo where btnSelect like 'NO' and userID like '%@'",USER_ID];
                                    NSString * selectSignIn = [NSString stringWithFormat:@"select * from storeInfo where userID like '%@'",USER_ID];
            FMResultSet * set = [db executeQuery:selectSignIn];
            while ([set next])
            {
                ProductModel *model=[[ProductModel alloc]init];
                model.userID=[set stringForColumn:@"userID"];
                model.ProjectId=[set stringForColumn:@"ProjectId"];
                model.StoreId=[set stringForColumn:@"StoreId"];
                model.Code=[set stringForColumn:@"Code"];
                model.CreateDate=[set stringForColumn:@"CreateDate"];
                model.CreateUserId=[set stringForColumn:@"CreateUserId"];
                model.DiDui=[set stringForColumn:@"DiDui"];
                model.Area=[set stringForColumn:@"Area"];
                model.Position=[set stringForColumn:@"Position"];
                model.POSM=[set stringForColumn:@"POSM"];
                model.MDstate=[set stringForColumn:@"state"];
                model.ProductId=[set stringForColumn:@"ProductId"];
                model.Price=[set stringForColumn:@"Price"];
                model.ProductSmell=[set stringForColumn:@"ProductSmell"];
                
                model.AreaRatio=[set stringForColumn:@"AreaRatio"];
                
                model.Expand0=[set stringForColumn:@"Expand0"];
                model.Expand1=[set stringForColumn:@"Expand1"];
                model.Expand2=[set stringForColumn:@"Expand2"];
                model.Expand3=[set stringForColumn:@"Expand3"];
                model.Expand4=[set stringForColumn:@"Expand4"];
                model.Expand5=[set stringForColumn:@"Expand5"];
                model.Expand6=[set stringForColumn:@"Expand6"];
                model.Expand7=[set stringForColumn:@"Expand7"];
                model.Expand8=[set stringForColumn:@"Expand8"];
                model.Expand9=[set stringForColumn:@"Expand9"];
                model.Expand10=[set stringForColumn:@"Expand10"];
                
                model.Expand11=[set stringForColumn:@"Expand11"];
                model.Expand12=[set stringForColumn:@"Expand12"];
                model.Expand13=[set stringForColumn:@"Expand13"];
                model.Expand14=[set stringForColumn:@"Expand14"];
                model.Expand15=[set stringForColumn:@"Expand15"];
                model.Expand16=[set stringForColumn:@"Expand16"];
                model.Expand17=[set stringForColumn:@"Expand17"];
                model.Expand18=[set stringForColumn:@"Expand18"];
                model.Expand19=[set stringForColumn:@"Expand19"];
                model.Expand20=[set stringForColumn:@"Expand20"];
                
                model.Expand21=[set stringForColumn:@"Expand21"];
                model.Expand22=[set stringForColumn:@"Expand22"];
                model.Expand23=[set stringForColumn:@"Expand23"];
                model.Expand24=[set stringForColumn:@"Expand24"];
                model.Expand25=[set stringForColumn:@"Expand25"];
                model.Expand26=[set stringForColumn:@"Expand26"];
                model.Expand27=[set stringForColumn:@"Expand27"];
                model.Expand28=[set stringForColumn:@"Expand28"];
                model.Expand29=[set stringForColumn:@"Expand29"];
                model.Expand30=[set stringForColumn:@"Expand30"];
                
                model.Expand31=[set stringForColumn:@"Expand31"];
                model.Expand32=[set stringForColumn:@"Expand32"];
                model.Expand33=[set stringForColumn:@"Expand33"];
                model.Expand34=[set stringForColumn:@"Expand34"];
                model.Expand35=[set stringForColumn:@"Expand35"];
                model.Expand36=[set stringForColumn:@"Expand36"];
                model.Expand37=[set stringForColumn:@"Expand37"];
                model.Expand38=[set stringForColumn:@"Expand38"];
                model.Expand39=[set stringForColumn:@"Expand39"];
                model.Expand40=[set stringForColumn:@"Expand40"];
                model.Expand41=[set stringForColumn:@"Expand41"];
                model.Expand42=[set stringForColumn:@"Expand42"];
                model.Expand43=[set stringForColumn:@"Expand43"];
                model.Expand44=[set stringForColumn:@"Expand44"];
                model.Expand45=[set stringForColumn:@"Expand45"];
                model.Expand46=[set stringForColumn:@"Expand46"];
                model.Expand47=[set stringForColumn:@"Expand47"];
                model.Expand48=[set stringForColumn:@"Expand48"];
                model.Expand49=[set stringForColumn:@"Expand49"];
                model.Expand50=[set stringForColumn:@"Expand50"];
                model.Expand51=[set stringForColumn:@"Expand51"];
                model.Expand52=[set stringForColumn:@"Expand52"];
                model.Expand53=[set stringForColumn:@"Expand53"];
                model.Expand54=[set stringForColumn:@"Expand54"];
                model.Expand55=[set stringForColumn:@"Expand55"];
                model.Expand56=[set stringForColumn:@"Expand56"];
                model.Expand57=[set stringForColumn:@"Expand57"];
                model.Expand58=[set stringForColumn:@"Expand58"];
                model.Expand59=[set stringForColumn:@"Expand59"];
                model.Expand60=[set stringForColumn:@"Expand60"];

                model.Expand61=[set stringForColumn:@"Expand61"];
                model.Expand62=[set stringForColumn:@"Expand62"];
                model.Expand63=[set stringForColumn:@"Expand63"];
                model.Expand64=[set stringForColumn:@"Expand64"];
                model.Expand65=[set stringForColumn:@"Expand65"];
                model.Expand66=[set stringForColumn:@"Expand66"];
                model.Expand67=[set stringForColumn:@"Expand67"];
                model.Expand68=[set stringForColumn:@"Expand68"];
                model.Expand69=[set stringForColumn:@"Expand69"];
                model.Expand70=[set stringForColumn:@"Expand70"];
                
                
                [arr addObject:model];
  
            }
        }
    }];
    return  arr;

}
// 搜索签到信息
+ (NSMutableArray *)selectSginInTable
{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    NSMutableArray * arr = [NSMutableArray array];
    
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open])
        {
            NSString * selectSignIn = [NSString stringWithFormat:@"select * from signIn where btnSelect like 'YES' and userID like '%@'",USER_ID];
            FMResultSet * set = [db executeQuery:selectSignIn];
            while ([set next])
            {
                signInModel * signIn        = [[signInModel alloc]init];
                //                signIn.userID               = [set stringForColumn:@"userID"];
                //                signIn.StoreCode            = [set stringForColumn:@"StoreCode"];
                //                signIn.identifier           = [set stringForColumn:@"identifier"];
                //                if ([[set stringForColumn:@"signLongitude"] isEqualToString:@"(null)"]) {
                //                    signIn.signLongitude = @"0.0";
                //                }else
                //                {
                //                    signIn.signLongitude = [set stringForColumn:@"signLongitude"];
                //                }
                //                signIn.signLatitude         = [set stringForColumn:@"signLatitude"];
                //                if ([[set stringForColumn:@"signLatitude"] isEqualToString:@"(null)"]) {
                //                    signIn.signLatitude = @"0.0";
                //                }else
                //                {
                //                    signIn.signLatitude = [set stringForColumn:@"signLatitude"];
                //                }
                //                if ([[set stringForColumn:@"signLocationType"] isEqualToString:@"(null)"]) {
                //                    signIn.signLocationType = @"0";
                //                }else
                //                {
                //                    signIn.signLocationType = [set stringForColumn:@"signLocationType"];
                //                }
                //
                //                if ([[set stringForColumn:@"signLocationTtime"] isEqualToString:@"(null)"]) {
                //                    signIn.signLocationTtime = @"0";
                //                }else
                //                {
                //                    signIn.signLocationTtime = [set stringForColumn:@"signLocationTtime"];
                //                }
                //                signIn.signInType           = [set stringForColumn:@"signInType"];
                //                signIn.signCreatetime       = [set stringForColumn:@"signCreatetime"];
                //
                //                if ([[set stringForColumn:@"signLongitude"] isEqualToString:@"(null)"]) {
                //                    signIn.signLongitude = @"0.0";
                //                }else
                //                {
                //                    signIn.signLongitude = [set stringForColumn:@"signLongitude"];
                //                }
                //                if ([[set stringForColumn:@"goOutLongitude"] isEqualToString:@"(null)"]) {
                //                    signIn.goOutLongitude = @"0.0";
                //                }else
                //                {
                //                    signIn.goOutLongitude = [set stringForColumn:@"goOutLongitude"];
                //                }
                //                if ([[set stringForColumn:@"goOutLatitude"] isEqualToString:@"(null)"]) {
                //                    signIn.goOutLatitude = @"0.0";
                //                }else
                //                {
                //                    signIn.goOutLatitude = [set stringForColumn:@"goOutLatitude"];
                //                }
                //
                //                if ([[set stringForColumn:@"goOutLocationType"] isEqualToString:@"(null)"]) {
                //                    signIn.goOutLocationType = @"0";
                //                }else
                //                {
                //                    signIn.goOutLocationType = [set stringForColumn:@"goOutLocationType"];
                //                }
                //                signIn.goOutLocationTtime   = [set stringForColumn:@"goOutLocationTtime"];
                //                signIn.goOutInType          = [set stringForColumn:@"goOutInType"];
                //                signIn.goOutCreatetime      = [set stringForColumn:@"goOutCreatetime"];
                //                signIn.storeName            = [set stringForColumn:@"storeName"];
                //                signIn.projectName          = [set stringForColumn:@"projectName"];
                //                signIn.btnSelect            = [set stringForColumn:@"btnSelect"];
                //                signIn.companyName          = [set stringForColumn:@"companyName"];
                //                [arr addObject:signIn];
                signIn.checkInImei = [set stringForColumn:@"checkInImei"];
                if ([[set stringForColumn:@"checkInLatitude"]isEqualToString:@"(null)"]) {
                    signIn.checkInLatitude = @"0.0";
                }else
                {
                    signIn.checkInLatitude = [set stringForColumn:@"checkInLatitude"];
                }
                if ([[set stringForColumn:@"checkInLocationTime"]isEqualToString:@"(null)"]) {
                    signIn.checkInLocationTime = @"0";
                }else
                {
                    signIn.checkInLocationTime = [set stringForColumn:@"checkInLocationTime"];
                }
                if ([[set stringForColumn:@"checkInLocationType"]isEqualToString:@"(null)"]) {
                    signIn.checkInLocationType = @"0";
                }else
                {
                    signIn.checkInLocationType = [set stringForColumn:@"checkInLocationType"];
                }
                if ([[set stringForColumn:@"checkInLongitude"]isEqualToString:@"(null)"]) {
                    signIn.checkInLongitude = @"0.0";
                }else
                {
                    signIn.checkInLongitude = [set stringForColumn:@"checkInLongitude"];
                }
                if ([[set stringForColumn:@"checkInTime"]isEqualToString:@"(null)"])
                {
                    signIn.checkInTime = @"0";
                }else
                {
                    signIn.checkInTime = [set stringForColumn:@"checkInTime"];
                }
                signIn.signInType = [set stringForColumn:@"signInType"];
                signIn.checkOutImei = [set stringForColumn:@"checkOutImei"];
                if ([[set stringForColumn:@"checkOutLatitude"]isEqualToString:@"(null)"]) {
                    signIn.checkOutLatitude = @"0.0";
                }else
                {
                    signIn.checkOutLatitude = [set stringForColumn:@"checkOutLatitude"];
                }
                if ([[set stringForColumn:@"checkOutLocationTime"]isEqualToString:@"(null)"]) {
                    signIn.checkOutLocationTime = @"0";
                }else
                {
                    signIn.checkOutLocationTime = [set stringForColumn:@"checkOutLocationTime"];
                }
                if ([[set stringForColumn:@"checkOutLocationType"]isEqualToString:@"(null)"]) {
                    signIn.checkOutLocationType = @"0";
                }else
                {
                    signIn.checkOutLocationType = [set stringForColumn:@"checkOutLocationType"];
                }
                if ([[set stringForColumn:@"checkOutLongitude"]isEqualToString:@"(null)"]) {
                    signIn.checkOutLongitude = @"0.0";
                }else
                {
                    signIn.checkOutLongitude = [set stringForColumn:@"checkOutLongitude"];
                }
                if ([[set stringForColumn:@"checkOutTime"]isEqualToString:@"(null)"]) {
                    signIn.checkOutTime = @"0";
                }else
                {
                    signIn.checkOutTime = [set stringForColumn:@"checkOutTime"];
                }
                signIn.goOutInType = [set stringForColumn:@"goOutInType"];
                if ([[set stringForColumn:@"companyCode"]isEqualToString:@"(null)"]) {
                    signIn.companyCode = @"";
                }else
                {
                    signIn.companyCode = [set stringForColumn:@"companyCode"];
                }
                if ([[set stringForColumn:@"itemCode"]isEqualToString:@"(null)"]) {
                    signIn.itemCode = @"";
                }else
                {
                    signIn.itemCode = [set stringForColumn:@"itemCode"];
                }
                if ([[set stringForColumn:@"storeCode"]isEqualToString:@"(null)"]) {
                    signIn.StoreCode = @"";
                }else
                {
                    signIn.StoreCode = [set stringForColumn:@"storeCode"];
                }
                signIn.userID = [set stringForColumn:@"userID"];
                signIn.storeName = [set stringForColumn:@"storeName"];
                signIn.projectName = [set stringForColumn:@"projectName"];
                signIn.btnSelect = [set stringForColumn:@"btnSelect"];
                signIn.companyName = [set stringForColumn:@"companyName"];
                [arr addObject:signIn];
                
            }
        }
    }];
    return arr;
}
// 存储照片信息
+ (void)keepPhotoWithDictionary:(NSDictionary *)photoInfo
{
    [self creatPhotoTable];
    NSString *userID = [photoInfo objectForKey:@"userID"];
    NSString *storeCode = [photoInfo objectForKey:@"storeCode"];
    NSString *selectType = [photoInfo objectForKey:@"selectType"];
    NSString *imageType = [photoInfo objectForKey:@"imageType"];
    NSString *identifier = [photoInfo objectForKey:@"identifier"];
    NSString *Longitude = [photoInfo objectForKey:@"Longitude"];
    NSString *Latitude = [photoInfo objectForKey:@"Latitude"];
    NSString *LocationTtime = [photoInfo objectForKey:@"LocationTtime"];
    NSString *Createtime = [photoInfo objectForKey:@"Createtime"];
    NSString *imageUrl = [photoInfo objectForKey:@"imageUrl"];
    
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    [queue inDatabase:^(FMDatabase *db) {
        
        if ([db open]) {
            
            NSString * insertPhotoStr = [NSString stringWithFormat:@"insert into photoInfo(userID,storeCode,identifier,selectType,imageType,Longitude,Latitude,LocationTtime,Createtime,imageUrl) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",userID,storeCode,identifier,selectType,imageType,Longitude,Latitude,LocationTtime,Createtime,imageUrl];
//            if ([db executeUpdate:insertPhotoStr]) {
//                NSLog(@"success");
//            }
//            else
//            {
//                NSLog(@"faiel");
//            }
            [db executeUpdate:insertPhotoStr];
        }
    }];
}
//存储详情
+ (void)keepDetailWithDictionary:(NSDictionary *)photoInfo
{
    [self creatDetailTable];
    NSString *userID = [photoInfo objectForKey:@"userID"];
    NSString *storeCode = [photoInfo objectForKey:@"storeCode"];
    NSString *selectType = [photoInfo objectForKey:@"selectType"];
    NSString *imageType = [photoInfo objectForKey:@"imageType"];
    NSString *identifier = [photoInfo objectForKey:@"identifier"];
    NSString *Longitude = [photoInfo objectForKey:@"Longitude"];
    NSString *Latitude = [photoInfo objectForKey:@"Latitude"];
    NSString *LocationTtime = [photoInfo objectForKey:@"LocationTtime"];
    NSString *Createtime = [photoInfo objectForKey:@"Createtime"];
    NSString *imageUrl = [photoInfo objectForKey:@"imageUrl"];
    
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    [queue inDatabase:^(FMDatabase *db) {
        
        if ([db open]) {
            
            NSString * insertPhotoStr = [NSString stringWithFormat:@"insert into detail(userID,storeCode,identifier,selectType,imageType) values('%@','%@','%@','%@','%@')",userID,storeCode,identifier,selectType,imageType];
            [db executeUpdate:insertPhotoStr];
            if ([db executeUpdate:insertPhotoStr]) {
                NSLog(@"success");
            }
            else
            {
                NSLog(@"fail");
            }
            
        }
    }];
}
// 根据选的照片类型查询门店照片
+ (NSMutableArray *)selectPhotoWithType:(NSString *)selectType
{
    NSMutableArray * arr = [NSMutableArray array];
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open])
        {
//            NSString * selectStr = [NSString stringWithFormat:@"select * from photoInfo where selectType = '%@' and userID like '%@'",selectType,USER_ID];
                        NSString * selectStr = [NSString stringWithFormat:@"select * from photoInfo where selectType = '%@' and userID like '%@'",selectType,USER_ID];
            FMResultSet * set = [db executeQuery:selectStr];
            while ([set next])
            {
                NSString * imageUrl = [set stringForColumn:@"imageurl"];
                [arr addObject:imageUrl];
            }
        }
        [db close];
    }];
    return arr;
}
// 根据选的照片类型查询产品照片
+ (NSMutableArray *)selectPhotoWithType:(NSString *)selectType andId:(NSString *)storecode
{
    NSMutableArray * arr = [NSMutableArray array];
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open])
        {
            //            NSString * selectStr = [NSString stringWithFormat:@"select * from photoInfo where selectType = '%@' and userID like '%@'",selectType,USER_ID];
            NSString * selectStr = [NSString stringWithFormat:@"select * from photoInfo where selectType = '%@' and storecode = '%@' and userID like '%@'",selectType,storecode,USER_ID];
            FMResultSet * set = [db executeQuery:selectStr];
            while ([set next])
            {
                NSString * imageUrl = [set stringForColumn:@"imageurl"];
                [arr addObject:imageUrl];
            }
        }
        [db close];
    }];
    return arr;
}
//查询详情
+ (NSMutableArray *)selectDetailWithType:(NSString *)selectType
{
    NSMutableArray * arr = [NSMutableArray array];
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open])
        {
            //            NSString * selectStr = [NSString stringWithFormat:@"select * from photoInfo where selectType = '%@' and userID like '%@'",selectType,USER_ID];
            NSString * selectStr = [NSString stringWithFormat:@"select * from detail"];
            FMResultSet * set = [db executeQuery:selectStr];
            while ([set next])
            {
                NSString * imageUrl = [set stringForColumn:@"selectType"];
                [arr addObject:imageUrl];
            }
        }
        [db close];
    }];
    return arr;
}
// 保存卖进信息
+ (void)keepSellInfo:(NSMutableDictionary *)sellInfo withBlock:(void (^)(NSString *result))block;
{
    [self creatSellInfoTable];
    
    NSString *userID     = [sellInfo objectForKey:@"userID"];
    NSString *Name       = [sellInfo objectForKey:@"Name"];
    NSString *Phone      = [sellInfo objectForKey:@"Phone"];
    NSString *IdCard     = [sellInfo objectForKey:@"IdCard"];
    NSString *storeCode  = [sellInfo objectForKey:@"storeCode"];
    NSString *isSuccess  = [sellInfo objectForKey:@"isSuccess"];
    NSString *identifier = [sellInfo objectForKey:@"identifier"];
    NSString *Cretime    = [sellInfo objectForKey:@"Cretime"];
    FMDatabaseQueue * queue = [[FMDatabaseQueue alloc]initWithPath:[self getPath]];
    
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open]){
            NSString * insertPhotoStr = [NSString stringWithFormat:@"insert into sellInfo(userID,Name,Phone,IdCard,StoreCode,isSuccess,identifier,Cretime) values('%@','%@','%@','%@','%@','%@','%@','%@')",userID,Name,Phone,IdCard,storeCode,isSuccess,identifier,Cretime];
            if ([db executeUpdate:insertPhotoStr] == YES) {
                block(@"保存数据成功");
            }
        }
    }];
}
// 保存请假信息
+ (void)keepLeaveInfo:(NSMutableDictionary *)leaveInfo
{
    [self creatLeaveInfoTable];
    NSString * userID = [leaveInfo objectForKey:@"userID"];
    NSString * identifier = [leaveInfo objectForKey:@"identifier"];
    NSString * time     = [leaveInfo objectForKey:@"time"];
    NSString * QjType   = [leaveInfo objectForKey:@"QjType"];
    NSString * TimeType = [leaveInfo objectForKey:@"TimeType"];
    
    
    FMDatabase * db = [self getDB];
    if ([db open]) {
        NSString * insertStr = [NSString stringWithFormat:@"insert into leaveInfo(userID,identifier,time,QjType,TimeType) values('%@','%@','%@','%@','%@')",userID,identifier,time,QjType,TimeType];
        [db executeUpdate:insertStr];
    }
    [db close];
}
// 搜索请假信息
+ (NSMutableArray *)selectLeaveInfo
{
    NSMutableArray * arr = [NSMutableArray array];
    FMDatabase * db = [self getDB];
    if ([db open]) {
        
        NSString * selectStr = [NSString stringWithFormat:@"select * from leaveInfo where userID like '%@'",USER_ID];
        FMResultSet * set = [db executeQuery:selectStr];
        while ([set next]) {
            LeaveModel * leave = [[LeaveModel alloc]init];
            leave.date = [set stringForColumn:@"time"];
            leave.time = [set stringForColumn:@"TimeType"];
            leave.reason = [set stringForColumn:@"QjType"];
            leave.identifier = [set stringForColumn:@"identifier"];
            leave.userID     = [set stringForColumn:@"userID"];
            [arr addObject:leave];
        }
    }
    [db close];
    
    return arr;
}
// 搜索卖进信息
+ (NSMutableArray *)selectSellTable
{
    NSMutableArray * arr = [NSMutableArray array];
    FMDatabaseQueue * queue = [[FMDatabaseQueue alloc]initWithPath:[self getPath]];
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open]) {
            NSString * selectSell = [NSString stringWithFormat:@"select * from sellInfo where userID like '%@'",USER_ID];
            FMResultSet * resultSet = [db executeQuery:selectSell];
            while ([resultSet next]) {
                SellModel * sell = [[SellModel alloc]init];
                sell.userID = [resultSet stringForColumn:@"userID"];
                sell.Name = [resultSet stringForColumn:@"Name"];
                sell.Phone = [resultSet stringForColumn:@"Phone"];
                sell.IdCard = [resultSet stringForColumn:@"IdCard"];
                sell.isSuccess = [resultSet stringForColumn:@"isSuccess"];
                sell.identifier = [resultSet stringForColumn:@"identifier"];
                sell.Cretime = [resultSet stringForColumn:@"Cretime"];
                sell.storeCode = [resultSet stringForColumn:@"StoreCode"];
                [arr addObject:sell];
            }
        }
        [db close];
    }];
    return arr;
}
// 删除卖进信息
+ (void)deleteSellTable
{
    FMDatabase * db = [self getDB];
    if ([db open]) {
        NSString * deleteStr = [NSString stringWithFormat:@"delete from sellInfo where userID like '%@'",USER_ID];
        [db executeUpdate:deleteStr];
    }
    [db close];
}
// 保存PG招募信息
+ (void)keepPGRecruit:(NSMutableDictionary *)PGInfo withBlock:(void (^)(NSString *result))block;
{
    [self creatPGRecruitTable];
    
    NSString *Headimgpath   = [PGInfo objectForKey:@"Headimgpath"];
    NSString *bodyImgPath   = [PGInfo objectForKey:@"bodyImgPath"];
    NSString *userID        = [PGInfo objectForKey:@"userID"];
    NSString *Name          = [PGInfo objectForKey:@"Name"];
    NSString *Phone         = [PGInfo objectForKey:@"Phone"];
    NSString *IdCard        = [PGInfo objectForKey:@"IdCard"];
    NSString *storeCode  = [PGInfo objectForKey:@"storeCode"];
    NSString *Weixin        = [PGInfo objectForKey:@"Weixin"];
    NSString *Qq            = [PGInfo objectForKey:@"Qq"];
    NSString *identifier    = [PGInfo objectForKey:@"identifier"];
    NSString *Createtime    = [PGInfo objectForKey:@"Createtime"];
    FMDatabaseQueue * queue = [[FMDatabaseQueue alloc]initWithPath:[self getPath]];
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open]){
            NSString * insertPhotoStr = [NSString stringWithFormat:@"insert into pgrecruit(userID,Name,Phone,IdCard,StoreCode,Weixin,Qq,identifier,Createtime,Headimgpath,bodyImgPath) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",userID,Name,Phone,IdCard,storeCode,Weixin,Qq,identifier,Createtime,Headimgpath,bodyImgPath];
            if ([db executeUpdate:insertPhotoStr] == YES) {
                block(@"已保存,请稍后尽量在WiFi状态下进行上传操作~");
            }
        }
    }];
}
// 搜索招募信息
+ (NSMutableArray *)selectPGRecruit
{
    NSMutableArray * arr = [NSMutableArray array];
    FMDatabaseQueue * queue = [[FMDatabaseQueue alloc]initWithPath:[self getPath]];
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open]) {
            NSString * selectStr = [NSString stringWithFormat:@"select * from pgrecruit where userID like '%@'",USER_ID];
            FMResultSet * resultSet = [db executeQuery:selectStr];
            while ([resultSet next]) {
                PGRecruitModel * PGRecruit = [[PGRecruitModel alloc]init];
                PGRecruit.Headimgpath = [resultSet stringForColumn:@"Headimgpath"];
                PGRecruit.bodyImgPath = [resultSet stringForColumn:@"bodyImgPath"];
                PGRecruit.userID = [resultSet stringForColumn:@"userID"];
                PGRecruit.Name = [resultSet stringForColumn:@"Name"];
                PGRecruit.Phone = [resultSet stringForColumn:@"Phone"];
                PGRecruit.IdCard = [resultSet stringForColumn:@"IdCard"];
                PGRecruit.Weixin = [resultSet stringForColumn:@"Weixin"];
                PGRecruit.Qq = [resultSet stringForColumn:@"Qq"];
                PGRecruit.identifier = [resultSet stringForColumn:@"identifier"];
                PGRecruit.Createtime = [resultSet stringForColumn:@"Createtime"];
                PGRecruit.storeCode=[resultSet stringForColumn:@"StoreCode"];
                PGRecruit.Latitude = @"0.0";
                PGRecruit.Longitude = @"0.0";
                PGRecruit.locationType = @"0";
                [arr addObject:PGRecruit];
            }
            [resultSet close];
        }
        [db close];
    }];
    return arr;
}
// 删除PG招募表
+ (void)deletePGRecruit
{
    FMDatabase * db = [self getDB];
    if ([db open]) {
        
        NSString * delete = [NSString stringWithFormat:@"delete from pgrecruit where userID like '%@'",USER_ID];
        [db executeUpdate:delete];
    }
    [db close];
}
// 删除产品信息
+ (void) deleteMDWithImageUrl:(NSString *)url
{
    FMDatabase * db = [self getDB];
    if ([db open]) {
        
        NSString * delete = [NSString stringWithFormat:@"delete from MDInfo where userID like '%@'",USER_ID];
        [db executeUpdate:delete];
    }
    [db close];
}
// 删除产品信息
+ (void) deleteProductWithImageUrl:(NSString *)url
{
    FMDatabase * db = [self getDB];
    if ([db open]) {
        
        NSString * delete = [NSString stringWithFormat:@"delete from storeInfo where userID like '%@'",USER_ID];
        [db executeUpdate:delete];
    }
    [db close];
}
// 删除巡店拍照信息
+ (void) deletePatrolPictureWithImageUrl:(NSString *)url
{
    FMDatabase * db = [self getDB];
    if ([db open]) {
        
        NSString * delete = [NSString stringWithFormat:@"delete from photoInfo where userID like '%@' and imageUrl like '%@'",USER_ID,url];
        [db executeUpdate:delete];
    }
    [db close];
}
+ (void)deletePhotoWithUrl:(NSString *)url successBlock:(void (^)(NSString * result))successBlock
{
    FMDatabase * db = [self getDB];
    if ([db open]) {
        
        NSString * delete = [NSString stringWithFormat:@"delete from photoInfo where imageUrl like '%@' and userID like'%@'",url,USER_ID];
        if ([db executeUpdate:delete] == YES ) {
            successBlock(@"OK");
        }
    }
    [db close];
}
// 查询巡店拍照信息
+ (NSMutableArray *)selectPatrolPicture
{
    NSMutableArray * arr = [NSMutableArray array];
    FMDatabase * db = [self getDB];
    if ([db open]) {
        NSString * selectStr = [NSString stringWithFormat:@"select * from photoInfo where userID like '%@'",USER_ID];
        FMResultSet * resultSrt = [db executeQuery:selectStr];
        while ([resultSrt next]) {
            PhotoModel  * photo = [[PhotoModel alloc]init];
            photo.userID        = [resultSrt stringForColumn:@"userID"];
            if ([[resultSrt stringForColumn:@"Longitude"] isEqualToString:@"(null)"]) {
                photo.Longitude          = @"0.0";
            }else
            {
                photo.Longitude          = [resultSrt stringForColumn:@"Longitude"];
            }
            if ([[resultSrt stringForColumn:@"Latitude"] isEqualToString:@"(null)"]) {
                photo.Latitude          = @"0.0";
            }else
            {
                photo.Latitude          = [resultSrt stringForColumn:@"Latitude"];
            }
            if ([[resultSrt stringForColumn:@"LocationTtime"] isEqualToString:@"(null)"]) {
                NSDate * date = [NSDate date];
                NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
                formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                NSString *timestamo = [formatter stringFromDate:date];
                photo.LocationTtime          = timestamo;
            }
            else
            {
                photo.LocationTtime          =[resultSrt stringForColumn:@"LocationTtime"];
            }
            photo.imageUrl              = [resultSrt stringForColumn:@"imageUrl"];
            photo.selectType            = [resultSrt stringForColumn:@"selectType"];
            photo.storeCode             = [resultSrt stringForColumn:@"storeCode"];
            photo.identifier            = [resultSrt stringForColumn:@"identifier"];
            photo.Createtime            = [resultSrt stringForColumn:@"Createtime"];
            [arr addObject:photo];
        }
    }
    [db close];
    return arr;
}
// 保存门店定位信息
+ (void)keepStoreLocationInfo:(NSMutableDictionary *)dic
{
    [self creatStoreLocationTable];
    
    NSString *identifier            = [dic objectForKey:@"identifier"];
    NSString *StoreId               = [dic objectForKey:@"StoreId"];
    NSString *userID                = [dic objectForKey:@"userID"];
    NSString *LocationType          = [dic objectForKey:@"LocationType"];
    NSString *LocationTtime         = [dic objectForKey:@"LocationTtime"];
    NSString *Latitude              = [dic objectForKey:@"Latitude"];
    NSString *Longitude             = [dic objectForKey:@"Longitude"];
    FMDatabase * db = [self getDB];
    if ([db open]) {
        NSString * insertStoreLocationStr = [NSString stringWithFormat:@"insert into storeLocation(identifier,StoreId,userID,LocationType,LocationTtime,Latitude,Longitude) values('%@','%@','%@','%@','%@','%@','%@')",identifier,StoreId,userID,LocationType,LocationTtime,Latitude,Longitude];
        [db executeUpdate:insertStoreLocationStr];
    }
    [db close];
}
// 删除签到信息
+ (void)deleteSignInTable
{
    FMDatabase * db = [self getDB];
    if ([db open]) {
        NSString * deleteStr = [NSString stringWithFormat:@"delete from signIn where userID like '%@'",USER_ID];
        [db executeUpdate:deleteStr];
    }
    [db close];
}
// 删除请假信息
+ (void)deleteLeaveWithTime:(NSString *)time timeType:(NSString *)timeType QjType:(NSString *)QjType
{
    FMDatabase * db = [self getDB];
    if ([db open]) {
        NSString * deleteStr = [NSString stringWithFormat:@"delete from leaveInfo where userID like '%@' and time like '%@' and timeType like '%@' and QjType like '%@'",USER_ID,time,timeType,QjType];
        [db executeUpdate:deleteStr];
    }
    [db close];
}
// 上传成功后删除请假表
+ (void)deleteLeaveTable
{
    FMDatabase * db = [self getDB];
    if ([db open]) {
        NSString * deleteStr = [NSString stringWithFormat:@"delete from leaveInfo where userID like '%@'",USER_ID];
        [db executeUpdate:deleteStr];
    }
    [db close];
    
}

+(FMDatabase * )getDB
{
    FMDatabase *  db = [[FMDatabase alloc]initWithPath:[self getPath]];
    return db ;
}

+(NSString *)getPath
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/SignIn.sqlite"];
}



//存储公司信息
+ (void)insertCompanyTableWithTheDictionary:(NSDictionary *)CompanyDic
{
    [self creatCompanyTable];
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    
    //使用
    [queue inDatabase:^(FMDatabase *db){
        
        NSString *Address = [CompanyDic objectForKey:@"Address"];
        NSString *Latitude = [CompanyDic objectForKey:@"Latitude"];
        NSString *Longitude = [CompanyDic objectForKey:@"Longitude"];
        NSString *companyName = [CompanyDic objectForKey:@"companyName"];
        NSString *ID = [CompanyDic objectForKey:@"ID"];
        NSString *ProjectID = [CompanyDic objectForKey:@"ProjectID"];
        NSString *ProjectName = [CompanyDic objectForKey:@"ProjectName"];
        
        if ([db open]) {
            NSString * insertString = [NSString stringWithFormat:@"insert into Company (Address,companyLatitude,companyLongitude,companyName,ID,ProjectID,ProjectName)valuse('%@','%@','%@','%@','%@','%@','%@')",Address,Latitude,Longitude,companyName,ID,ProjectID,ProjectName];
            [db executeUpdate:insertString];
        }
        [db close];
    }];
}

//上传成功后删除公司信息
+ (void)deleteCompanyTable
{
    FMDatabase *db = [self getDB];
    if ([db open]) {
        NSString *deleteStr = [NSString stringWithFormat:@"dete from company where userId like '%@'",USER_ID];
        [db executeUpdate:deleteStr];
    }
    [db close];
}
//删除控件信息
+ (void)deleteControlTable
{
    FMDatabase *db = [self getDB];
    if ([db open]) {
        NSString *deleteStr = [NSString stringWithFormat:@"delete from myinfo where  userId like '%@'",USER_ID];
        [db executeUpdate:deleteStr];
    }
    [db close];
}
//查询控件信息
+ (NSMutableArray *)selectControlWithInfo:(NSDictionary *)infoDic
{
    NSString * userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];

    NSMutableArray * arr = [NSMutableArray array];
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open])
        {
            //            NSString * selectStr = [NSString stringWithFormat:@"select * from photoInfo where selectType = '%@' and userID like '%@'",selectType,USER_ID];
            NSString *imgControl=@"imgControl";
            NSString * selectStr = [NSString stringWithFormat:@"select * from myinfo where ControlValue!='%@' and userID = '%@'",imgControl,userID];
            FMResultSet * set = [db executeQuery:selectStr];
            while ([set next])
            {
                //                NSString * ControlID = [set stringForColumn:@"ControlID"];
                
                NSMutableDictionary *controlDic=[[NSMutableDictionary alloc]init];
                
                [controlDic setValue:[set stringForColumn:@"ControlID"] forKey:@"ControlID"];
                //                [controlDic setValue:[set stringForColumn:@"StoreID"] forKey:@"StoreID"];
                [controlDic setValue:[set stringForColumn:@"storeCode"] forKey:@"StoreID"];
                [controlDic setValue:[set stringForColumn:@"ControlValue"] forKey:@"ControlValue"];
                //                [controlDic setValue:[set stringForColumn:@"CreateDate"] forKey:@"CreateDate"];
                [controlDic setValue:[NSString stringWithFormat:@"%@",[NSDate date]] forKey:@"CreateDate"];
                //                NSError *error;
                //                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:controlDic options:NSJSONWritingPrettyPrinted error:&error];//此处data参数是我上面提到的key为"data"的数组
                //                NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                
                //                NSDictionary *newDic=[NSDictionary dictionaryWithObjectsAndKeys:[set stringForColumn:@"ControlID"],@"ControlID",@"2257",@"StoreID",[set stringForColumn:@"ControlValue"],@"ControlValue",[NSString stringWithFormat:@"%@",[NSDate date]],@"CreateDate", nil];
                
                [arr addObject:controlDic];
            }
        }
        [db close];
    }];
    return arr;
}

+ (void)creatMyInfo
{
    FMDatabase * db = [self getDB];
    if ([db open])
    {
        if (![db tableExists:@"myinfo"])
        {
            
            NSString *newCheckTable = [NSString stringWithFormat:@"CREATE TABLE myinfo (userID text,storeCode text,identifier text,ProjectId text,ControlID text,ControlValue text,ControlType text,CreateDate text)"];
            BOOL res = [db executeUpdate:newCheckTable];
            if (!res) {
                NSLog(@"|**=== 1error when creating db table ===**|  %d",res);
            } else {
                NSLog(@"|**=== success to creating db table ===**|  %d",res);
            }
            
        }
    }
    [db close];
}
+ (void)keepStoreWithdata:(NSArray *)arr andModel:(ProductModel *)model withBlock:(void (^)(NSString *result))block
{
    [self creatMyInfo];
    
//    NSString *userID        =model.Code;
    NSString * userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];

    NSString *ProjectId     =model.ProjectId;
    NSString *StoreId     =model.StoreId;
    NSString *identifier    =model.Area;
    
    
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    [queue inDatabase:^(FMDatabase *db) {
        
        if ([db open]) {
            
            
            for (int i=0; i<arr.count; i++) {
                
                NSString * selectSignIn = [NSString stringWithFormat:@"select * from myinfo where storeCode like '%@' and ProjectId like '%@' and ControlID like '%@' and userID like '%@'",model.StoreId,model.ProjectId,arr[i][1],USER_ID];
                FMResultSet * set = [db executeQuery:selectSignIn];
                
                if ([set next])
                {
                    NSLog(@"存在 更新");
                    
                    NSString * updateStr = [NSString stringWithFormat:@"update  myinfo set ControlValue='%@',ControlType='%@',CreateDate='%@' where storeCode like '%@' and ProjectId like '%@' and ControlID like '%@' and userID like '%@'",arr[i][0],arr[i][2],[NSString stringWithFormat:@"%@",[NSDate date]],StoreId,ProjectId,arr[i][1],userID];
                    
                    //                [db executeUpdate:insertPhotoStr];
                    
                    BOOL res = [db executeUpdate:updateStr];
                    //            [db executeUpdate:insertString];
                    if (!res) {
                        NSLog(@"|**===数据更新失败 ===**|   %d",res);
                        block(@"failed");
                    } else {
                        NSLog(@"|**=== 更新成功 ===**|   %d",res);
                        block(@"success");
                    }
                }
                else
                {
                    NSLog(@"不存在 插入");
                    NSString * insertPhotoStr = [NSString stringWithFormat:@"insert into myinfo(userID,storeCode,identifier,ProjectId,ControlID,ControlValue,ControlType,CreateDate) values('%@','%@','%@','%@','%@','%@','%@','%@')",userID,StoreId,identifier,ProjectId,arr[i][1],arr[i][0],arr[i][2],[NSString stringWithFormat:@"%@",[NSDate date]]];
                    
                    //                [db executeUpdate:insertPhotoStr];
                    
                    BOOL res = [db executeUpdate:insertPhotoStr];
                    //            [db executeUpdate:insertString];
                    if (!res) {
                        NSLog(@"|**=== error when creating db table ===**|   %d",res);
                        block(@"failed");
                    } else {
                        NSLog(@"|**=== success to creating db table ===**|   %d",res);
                        block(@"success");
                    }
                }
                    
                    
   
            }
            
        }
    }];
}


+ (NSArray *)select:(NSString *)code andProCode:(NSString *)productCode
{
    NSMutableArray *myArr=[[NSMutableArray alloc]init];
    
    ProductModel *model=[[ProductModel alloc]init];
    NSString * userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];

    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[self getPath]];
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open])
        {
            NSString * selectSignIn = [NSString stringWithFormat:@"select * from myinfo where storeCode like '%@' and ProjectId like '%@' and userID like '%@' ",code,productCode,userID];
            FMResultSet * set = [db executeQuery:selectSignIn];
            while ([set next])
            {
                //                ProductModel *model=[[ProductModel alloc]init];
                NSMutableArray *singleArr=[[NSMutableArray alloc]init];
                

                
                
                [singleArr addObject:[set stringForColumn:@"ControlValue"]];
                [singleArr addObject:[set stringForColumn:@"ControlID"]];
                [singleArr addObject:[set stringForColumn:@"ControlType"]];
                
                [singleArr addObject:[set stringForColumn:@"CreateDate"]];
                
                
                [myArr addObject:singleArr];
                
            }
        }
    }];
    return myArr;
    
}

@end
