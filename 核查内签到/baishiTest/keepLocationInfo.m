//
//  keepLocationInfo.m
//  Essence
//
//  Created by EssIOS on 15/5/6.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import "keepLocationInfo.h"
#import "FMDB.h"
#import "LoctionModel.h"

#import "LocationMD.h"
#import "AdrDistance.h"
#import "signInModel.h"
#define USER_ID [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]
@implementation keepLocationInfo


+ (void)creatLoctionTable
{
    FMDatabase * db = [self getDB];
    if ([db open])
    {
        if (![db tableExists:@"location"])
        {
            [db executeUpdate:@"CREATE TABLE location (userID text,speed text,timestamo text,strSysVers text,strModel text,verson text,latitude  text,longitude text,phoneModel text,strName text,strSysName text,strLocModel text, identifier text, networkType text, batteryLevel text, carrierName text)"];
        }
    }
    [db close];
}
+ (void)creatBaseDataTable
{
    FMDatabase * db = [self getDataBaseDB];
    if ([db open])
    {
        if (![db tableExists:@"baseData"])
        {
            [db executeUpdate:@"CREATE TABLE baseData (ProjectInfoId text,ProjectName text,projectSchedule text,Longitude text,Latitude text,StoreId text,StoreName  text,Code text,Address text,Area text,City text,ID text,Lat text,Lng text,Name text,ProjectID text,Province text)"];
        }
    }
    [db close];
}
+ (void)creatMyShopTable
{
    FMDatabase * db = [self getMyShopDB];
    if ([db open])
    {
        if (![db tableExists:@"MyShop"])
        {
            [db executeUpdate:@"CREATE TABLE MyShop (Id text,StaffID text,RealName text,ProjectID text,ProjectName text,CityID text,CityName  text,StoreID text,StoreName text,Code text,CreateDate text)"];
        }
    }
    [db close];
}

//巡店公司的存储 2
+ (void)creatPatrolShopTable2
{
    FMDatabase * db = [self getPatrolShopDB2];
    NSLog(@"%@",[self getPatrolShopPath2]);
    if ([db open])
    {
        if (![db tableExists:@"patrolShop2"])
        {
            [db executeUpdate:@"CREATE TABLE patrolShop2 (CreateTime text,StoreCode text,PlanDate text,Result text,Source text,WorkType text,userID  text,StoreName text,ProjectName text,ProjectSchedule text,btnSelect text,companyName text,companyid text,projectid text)"];
        }
    }
    [db close];
}
//建项目的存储项目的信息
+ (void)creatPatrolShopTable3
{
    FMDatabase * db = [self getPatrolShopDB3];
    NSLog(@"%@",[self getPatrolShopPath3]);
    if ([db open])
    {
        if (![db tableExists:@"patrolShop3"])
        {
            [db executeUpdate:@"CREATE TABLE patrolShop3 (CreateTime text,StoreCode text,PlanDate text,Result text,Source text,WorkType text,userID  text,StoreName text,ProjectName text,ProjectSchedule text,btnSelect text,companyName text,companyid text,projectid text)"];
        }
    }
    [db close];
}

// 存储定位信息
+ (void)keepLoginInfo:(NSMutableDictionary *)userInfoDic
{
    [self creatLoctionTable];
    FMDatabase * db = [self getDB];
//    NSDate * date = [NSDate date];
//    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
//    
//    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    NSString *timestamo=[formatter stringFromDate:date];
    
    NSString * userID       = [userInfoDic objectForKey:@"userID"];
    NSString * speed        = [userInfoDic objectForKey:@"speed"];
    NSString * timestamo    = [userInfoDic objectForKey:@"Createtime"];
    NSString * strSysVers   = [userInfoDic objectForKey:@"strSysVers"];
    NSString * strModel     = [userInfoDic objectForKey:@"strModel"];
    NSString * verson     = [userInfoDic objectForKey:@"verson"];
    NSString * latitude     = [userInfoDic objectForKey:@"Latitude"];
    NSString * longitude    = [userInfoDic objectForKey:@"Longitude"];
    NSString * phoneModel   = [userInfoDic objectForKey:@"phoneModel"];
    NSString * strName      = [userInfoDic objectForKey:@"strName"];
    NSString * strSysName   = [userInfoDic objectForKey:@"strSysName"];
    NSString * strLocModel  = [userInfoDic objectForKey:@"strLocModel"];
    NSString * identifier   = [userInfoDic objectForKey:@"identifier"];
    NSString * networkType  = [userInfoDic objectForKey:@"networkType"];
    NSString * batteryLevel = [userInfoDic objectForKey:@"batteryLevel"];
    NSString * carrierName  = [userInfoDic objectForKey:@"carrierName"];
    
    if ([db open])
    {
        [db executeUpdate:@"insert into location (userID,speed,timestamo,strSysVers,strModel,verson,latitude,longitude,phoneModel,strName,strSysName,strLocModel,identifier,networkType,batteryLevel,carrierName) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",userID,speed,timestamo,strSysVers,strModel,verson,latitude,longitude,phoneModel,strName,strSysName,strLocModel,identifier,networkType,batteryLevel,carrierName];
    }
    [db close];
    
}
//基础所有门店到数据库
+ (void)keepallStoreDataWithDictionary:(NSDictionary *)baseDataDic
{
    FMDatabase * db = [self getDataBaseDB];
    if ([db open]) {
        
        //        NSString * deleteStr = [NSString stringWithFormat:@"delete from GPS where userID like '%@'",USER_ID];
        NSString * deleteStr = [NSString stringWithFormat:@"delete from baseData"];
        [db executeUpdate:deleteStr];
    }
    [db close];
    NSMutableDictionary * mutableDic = [NSMutableDictionary dictionary];

//    NSMutableDictionary * mutableDic = [NSMutableDictionary dictionary];
    NSArray * storeArr = [baseDataDic objectForKey:@"Data"] ;
    for (NSDictionary * dic in storeArr)
    {
        NSLog(@"dic--->>\n%@",dic);
//        StoreMD * store = [StoreMD StoreMDWithDictionary:dic];
//        StoreMD * store = [[StoreMD alloc]init];
//   
//        [mutableDic setObject:[] forKey:@"Address"];
//        [mutableDic setObject:store.Area forKey:@"Area"];
//        [mutableDic setObject:store.City forKey:@"City"];
//        [mutableDic setObject:store.ID forKey:@"ID"];
//        [mutableDic setObject:store.Lat forKey:@"Lat"];
//        [mutableDic setObject:store.Lng forKey:@"Lng"];
//        [mutableDic setObject:store.Name forKey:@"Name"];
//        [mutableDic setObject:store.ProjectID forKey:@"ProjectID"];
//        [mutableDic setObject:store.ProjectName forKey:@"ProjectName"];
//        [mutableDic setObject:store.Province forKey:@"Province"];
        [self keepDataWithDictionary:dic];
    }

    
}
//基础数据保存到数据库
+ (void)keepBaseDataWithDictionary:(NSDictionary *)baseDataDic
{
    FMDatabase * db = [self getDataBaseDB];
    if ([db open]) {
        
        //        NSString * deleteStr = [NSString stringWithFormat:@"delete from GPS where userID like '%@'",USER_ID];
        NSString * deleteStr = [NSString stringWithFormat:@"delete from baseData"];
        [db executeUpdate:deleteStr];
    }
    [db close];
    NSMutableDictionary * mutableDic = [NSMutableDictionary dictionary];
    NSDictionary * PJInfos = [[baseDataDic objectForKey:@"UserProejctList"] objectForKey:@"ProjectInfos"];
    
//    NSArray      * PJInfo = [PJInfos objectForKey:@"ProjectInfo"];
        id  Info = [PJInfos objectForKey:@"ProjectInfo"];
    if ([[Info class]isSubclassOfClass:[NSArray class]]) {
        [self keepInfo1:Info];
    }
    else
    {
    [self keepInfo2:Info];
    }

}
+(void)keepInfo1:(id)info
{
    NSMutableDictionary * mutableDic = [NSMutableDictionary dictionary];
    for (NSDictionary * baseData in info)
    {
        
        LoctionModel * loctionModel = [LoctionModel loctionDataWithDictionary:baseData];
        
        NSDictionary * stores = [[baseData objectForKey:@"ProjectSchedules"] objectForKey:@"ProjectSchedule"];
        
        if ([[[stores objectForKey:@"Stores"] objectForKey:@"Store"] isKindOfClass:[NSArray class]])
        {
            NSArray * store = [[stores objectForKey:@"Stores"] objectForKey:@"Store"];
            for (NSDictionary * dic in store)
            {
                StoreMD * store = [StoreMD StoreMDWithDictionary:dic];
                [mutableDic setObject:loctionModel.ProjectInfoId forKey:@"ProjectInfoId"];
                [mutableDic setObject:loctionModel.ProjectName forKey:@"ProjectName"];
                [mutableDic setObject:loctionModel.projectSchedule.Name forKey:@"projectSchedule"];
                [mutableDic setObject:store.Longitude forKey:@"Longitude"];
                [mutableDic setObject:store.Latitude forKey:@"Latitude"];
                [mutableDic setObject:store.StoreId forKey:@"StoreId"];
                [mutableDic setObject:store.StoreName forKey:@"StoreName"];
                [mutableDic setObject:store.Code forKey:@"Code"];
                [self keepDataWithDictionary:mutableDic];
            }
        }else
        {
            NSDictionary * storeDic = [[stores objectForKey:@"Stores"] objectForKey:@"Store"];
            StoreMD * store = [StoreMD StoreMDWithDictionary:storeDic];
            
            [mutableDic setObject:loctionModel.ProjectInfoId forKey:@"ProjectInfoId"];
            [mutableDic setObject:loctionModel.ProjectName forKey:@"ProjectName"];
            [mutableDic setObject:loctionModel.projectSchedule.Name forKey:@"projectSchedule"];
            [mutableDic setObject:store.Longitude forKey:@"Longitude"];
            [mutableDic setObject:store.Latitude forKey:@"Latitude"];
            [mutableDic setObject:store.StoreId forKey:@"StoreId"];
            [mutableDic setObject:store.StoreName forKey:@"StoreName"];
            [mutableDic setObject:store.Code forKey:@"Code"];
            [self keepDataWithDictionary:mutableDic];
        }
    }

}
+(void)keepInfo2:(id)info
{
    NSMutableDictionary * mutableDic = [NSMutableDictionary dictionary];
    NSDictionary *ProjectInfoId=[info objectForKey:@"ProjectInfoId"];
    NSDictionary *ProjectName=[info objectForKey:@"ProjectName"];
    
    NSDictionary *ProjectSchedules=[info objectForKey:@"ProjectSchedules"];
    NSDictionary *ProjectSchedule=[ProjectSchedules objectForKey:@"ProjectSchedule"];
    //        NSDictionary *ProjectScheduleId=[ProjectSchedules objectForKey:@"ProjectScheduleId"];
    NSDictionary *Name=[ProjectSchedule objectForKey:@"Name"];
    NSDictionary *Stores=[ProjectSchedule objectForKey:@"Stores"];
    NSDictionary *ProjectScheduleId=[ProjectSchedule objectForKey:@"ProjectScheduleId"];
    
    
    NSArray *storeArr=[Stores objectForKey:@"Store"];
    for (int i=0; i<storeArr.count; i++) {
        NSDictionary *Store=storeArr[i];
        
        NSDictionary *Code=[Store objectForKey:@"Code"];
        NSDictionary *Latitude=[Store objectForKey:@"Latitude"];
        NSDictionary *Longitude=[Store objectForKey:@"Longitude"];
        NSDictionary *StoreId=[Store objectForKey:@"StoreId"];
        NSDictionary *StoreName=[Store objectForKey:@"StoreName"];
        
        [mutableDic setObject:[ProjectInfoId objectForKey:@"text"]forKey:@"ProjectInfoId"];
        [mutableDic setObject:[ProjectName objectForKey:@"text"] forKey:@"ProjectName"];
        [mutableDic setObject:[ProjectSchedules objectForKey:@"text"] forKey:@"projectSchedule"];
        [mutableDic setObject:[Longitude objectForKey:@"text"] forKey:@"Longitude"];
        [mutableDic setObject:[Latitude objectForKey:@"text"] forKey:@"Latitude"];
        [mutableDic setObject:[StoreId objectForKey:@"text"] forKey:@"StoreId"];
        [mutableDic setObject:[StoreName objectForKey:@"text"] forKey:@"StoreName"];
        [mutableDic setObject:[Code objectForKey:@"text"] forKey:@"Code"];
        [self keepDataWithDictionary:mutableDic];
    }

}
+ (void)keepBaseDataWithDictionary2:(NSDictionary *)baseDataDic
{
    FMDatabase * db = [self getDataBaseDB];
    if ([db open]) {
        
        //        NSString * deleteStr = [NSString stringWithFormat:@"delete from GPS where userID like '%@'",USER_ID];
        NSString * deleteStr = [NSString stringWithFormat:@"delete from baseData"];
        [db executeUpdate:deleteStr];
    }
    [db close];
    NSMutableDictionary * mutableDic = [NSMutableDictionary dictionary];
    NSDictionary * PJInfos = [[baseDataDic objectForKey:@"UserProejctList"] objectForKey:@"ProjectInfos"];
    NSDictionary      * PJInfo = [PJInfos objectForKey:@"ProjectInfo"];
//    NSDictionary      * PJInfo2 = [PJInfos objectForKey:@"ProjectInfoId"];
        NSDictionary *ProjectInfoId=[PJInfo objectForKey:@"ProjectInfoId"];
        NSDictionary *ProjectName=[PJInfo objectForKey:@"ProjectName"];

        NSDictionary *ProjectSchedules=[PJInfo objectForKey:@"ProjectSchedules"];
        NSDictionary *ProjectSchedule=[ProjectSchedules objectForKey:@"ProjectSchedule"];
//        NSDictionary *ProjectScheduleId=[ProjectSchedules objectForKey:@"ProjectScheduleId"];
        NSDictionary *Name=[ProjectSchedule objectForKey:@"Name"];
        NSDictionary *Stores=[ProjectSchedule objectForKey:@"Stores"];
            NSDictionary *ProjectScheduleId=[ProjectSchedule objectForKey:@"ProjectScheduleId"];
    
    
    NSArray *storeArr=[Stores objectForKey:@"Store"];
    for (int i=0; i<storeArr.count; i++) {
                NSDictionary *Store=storeArr[i];
        
                NSDictionary *Code=[Store objectForKey:@"Code"];
                NSDictionary *Latitude=[Store objectForKey:@"Latitude"];
                NSDictionary *Longitude=[Store objectForKey:@"Longitude"];
                NSDictionary *StoreId=[Store objectForKey:@"StoreId"];
                NSDictionary *StoreName=[Store objectForKey:@"StoreName"];

        [mutableDic setObject:[ProjectInfoId objectForKey:@"text"]forKey:@"ProjectInfoId"];
        [mutableDic setObject:[ProjectName objectForKey:@"text"] forKey:@"ProjectName"];
        [mutableDic setObject:[ProjectSchedules objectForKey:@"text"] forKey:@"projectSchedule"];
        [mutableDic setObject:[Longitude objectForKey:@"text"] forKey:@"Longitude"];
        [mutableDic setObject:[Latitude objectForKey:@"text"] forKey:@"Latitude"];
        [mutableDic setObject:[StoreId objectForKey:@"text"] forKey:@"StoreId"];
        [mutableDic setObject:[StoreName objectForKey:@"text"] forKey:@"StoreName"];
        [mutableDic setObject:[Code objectForKey:@"text"] forKey:@"Code"];
        [self keepDataWithDictionary:mutableDic];
    }

}

+ (NSMutableArray *)selectPlanWithDate:(NSString *)date andUserID:(NSString*)userID
{
    NSMutableArray * arr = [NSMutableArray array];
    FMDatabase * db = [self getPatrolShopDB];
    if ([db open]) {
        NSString * selectString = [NSString stringWithFormat:@"select * from signIn where PlanDate like '%@' and userID like '%@'",date,USER_ID];
        NSLog(@"-->>%@",selectString);
        FMResultSet * set = [db executeQuery:selectString];
        while ([set next]) {
            
            //            if ([[set stringForColumn:@"btnSelect"] isEqualToString:@"NO"]) {
            signInModel * signIn = [[signInModel alloc]init];
            signIn.storeName = [set stringForColumn:@"StoreName"];
            signIn.projectName = [set stringForColumn:@"ProjectName"];
            signIn.btnSelect = @"NO";
            signIn.goOutCreatetime = @"null";
            signIn.signCreatetime = [set stringForColumn:@"btnSelect"];
            signIn.StoreCode = [set stringForColumn:@"StoreCode"];
            [arr addObject:signIn];
            //            }
        }
        [set close];
    }
    [db close];
    return arr;
}
+ (void)keepDataWithDictionary:(NSMutableDictionary *)dic
{
    [self creatBaseDataTable];
    FMDatabase * db = [self getDataBaseDB];
    if ([db open])
    {
        [db executeUpdate:@"insert into baseData (ProjectInfoId,ProjectName,projectSchedule,Longitude,Latitude,StoreName,Code,StoreId,Address,Area,City,ID,Lat,Lng,Name,ProjectID,ProjectName,Province) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",[dic objectForKey:@"ProjectInfoId"],[dic objectForKey:@"ProjectName"],[dic objectForKey:@"projectSchedule"],[dic objectForKey:@"Longitude"],[dic objectForKey:@"Latitude"],[dic objectForKey:@"StoreName"],[dic objectForKey:@"Code"],[dic objectForKey:@"StoreId"],[dic objectForKey:@"Address"],[dic objectForKey:@"Area"],[dic objectForKey:@"City"],[dic objectForKey:@"ID"],[dic objectForKey:@"Lat"],[dic objectForKey:@"Lng"],[dic objectForKey:@"Name"],[dic objectForKey:@"ProjectID"],[dic objectForKey:@"ProjectName"],[dic objectForKey:@"Province"]];
    }
    [db close];
}
+ (NSMutableArray *)selectAllStoreName
{
    NSMutableArray * dataArray = [NSMutableArray array];
    
    FMDatabase *db = [self getDataBaseDB];
    if ([db open])
    {
        FMResultSet *set = [db executeQuery:@"select * from baseData"];
        while ([set next])
        {
            int a = 0;
            a ++;
            StoreMD * store = [[StoreMD alloc]init];
//            store.StoreName = [set stringForColumn:@"StoreName"];
            store.StoreName = [set stringForColumn:@"Name"];
            if (store.StoreName != nil)
            {
                [dataArray addObject:store.StoreName];
            }
//            [dataArray addObject:store];

        }
        [set close];
    }
    [db close];

    return dataArray;
}
+ (NSMutableArray *)selectAllProjectName
{
    NSMutableArray * dataArray = [NSMutableArray array];
    
    FMDatabase *db = [self getDataBaseDB];
    if ([db open])
    {
        FMResultSet *set = [db executeQuery:@"select * from baseData"];
        while ([set next])
        {
            int a = 0;
            a ++;
            StoreMD * store = [[StoreMD alloc]init];
            store.StoreName = [set stringForColumn:@"ProjectName"];
            if (store.StoreName != nil)
            {
                [dataArray addObject:store.StoreName];
            }
            //            [dataArray addObject:store];
        }
        [set close];
    }
    [db close];
    
    return dataArray;
}
+ (NSMutableArray *)selectXM:(NSString *)storeName
{
    NSMutableArray * dataArray = [NSMutableArray array];

        // 创建，最好放在一个单例的类中
        FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[self getDataBasePath]];
        // 使用
        [queue inDatabase:^(FMDatabase *db) {
           
            if ([db open]) {
                
                
                NSString * selectStr = [NSString  stringWithFormat:@"select * from baseData where ProjectName like '%@'",storeName];
                FMResultSet *set = [db executeQuery:selectStr];
                while ([set next])
                {
                    int a = 0;
                    a ++;
                    StoreMD * store = [[StoreMD alloc]init];
                    store.StoreName = [set stringForColumn:@"StoreName"];
                    store.ProjectInfoId = [set stringForColumn:@"ProjectInfoId"];
                    store.ProjectName = [set stringForColumn:@"ProjectName"];
                    store.Name = [set stringForColumn:@"ProjectSchedule"];
                    store.Latitude = [set stringForColumn:@"Latitude"];
                    store.Longitude = [set stringForColumn:@"Longitude"];
                    store.StoreId = [set stringForColumn:@"StoreId"];
                    store.Code = [set stringForColumn:@"Code"];
                    [dataArray addObject:store.StoreName];
                }
                [set close];
            }
        [db close];
    }];
    return dataArray;
}
+ (NSMutableArray *)selectXMAndDQ:(NSString *)storeName
{
    NSMutableArray * dataArray = [NSMutableArray array];
    
    // 创建，最好放在一个单例的类中
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[self getDataBasePath]];
    // 使用
    [queue inDatabase:^(FMDatabase *db) {
        
        if ([db open]) {
            
            
            NSString * selectStr = [NSString  stringWithFormat:@"select * from baseData where Name like '%@'",storeName];
            FMResultSet *set = [db executeQuery:selectStr];
            while ([set next])
            {
                int a = 0;
                a ++;
                StoreMD * store = [[StoreMD alloc]init];
                store.StoreName = [set stringForColumn:@"StoreName"];
                store.ProjectInfoId = [set stringForColumn:@"ProjectInfoId"];
                store.ProjectName = [set stringForColumn:@"ProjectName"];
                
//                store.Name = [set stringForColumn:@"ProjectSchedule"];
                
                store.Latitude = [set stringForColumn:@"Latitude"];
                store.Longitude = [set stringForColumn:@"Longitude"];
                store.StoreId = [set stringForColumn:@"StoreId"];
                store.Code = [set stringForColumn:@"Code"];
                [dataArray addObject:store];
            }
            [set close];
        }
        [db close];
    }];
    return dataArray;
}
//+ (NSMutableArray *)selectMD:(NSString *)ProjectName
//{
//    NSMutableArray * dataArray = [NSMutableArray array];
//    
//    // 创建，最好放在一个单例的类中
//    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[self getDataBasePath]];
//    // 使用
//    [queue inDatabase:^(FMDatabase *db) {
//        
//        if ([db open]) {
//            
//            
//            NSString * selectStr = [NSString  stringWithFormat:@"select * from baseData where StoreName like '%@'",ProjectName];
//            FMResultSet *set = [db executeQuery:selectStr];
//            while ([set next])
//            {
//                int a = 0;
//                a ++;
//                StoreMD * store = [[StoreMD alloc]init];
//                store.StoreName = [set stringForColumn:@"StoreName"];
//                store.ProjectInfoId = [set stringForColumn:@"ProjectInfoId"];
//                store.ProjectName = [set stringForColumn:@"ProjectName"];
//                store.Name = [set stringForColumn:@"ProjectSchedule"];
//                store.Latitude = [set stringForColumn:@"Latitude"];
//                store.Longitude = [set stringForColumn:@"Longitude"];
//                store.StoreId = [set stringForColumn:@"StoreId"];
//                store.Code = [set stringForColumn:@"Code"];
//                [dataArray addObject:store];
//            }
//            [set close];
//        }
//        [db close];
//    }];
//    return dataArray;
//}
+ (NSMutableArray *)selectDQWithTheStoreName:(NSString *)storeName  andProjectName:(NSString *)projectName
{
    NSMutableArray * dataArray = [NSMutableArray array];
    
        // 创建，最好放在一个单例的类中
        FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[self getDataBasePath]];
        // 使用
        [queue inDatabase:^(FMDatabase *db) {
            if ([db open])
            {
                
                NSString * selectStr = [NSString  stringWithFormat:@"select * from baseData where StoreName like '%@' and ProjectName like '%@'",storeName,projectName];
                FMResultSet *set = [db executeQuery:selectStr];
                while ([set next])
                {
                    int a = 0;
                    a ++;
                    StoreMD * store = [[StoreMD alloc]init];
                    store.StoreName = [set stringForColumn:@"StoreName"];
                    store.ProjectInfoId = [set stringForColumn:@"ProjectInfoId"];
                    store.ProjectName = [set stringForColumn:@"ProjectName"];
                    store.Name = [set stringForColumn:@"ProjectSchedule"];
                    store.Latitude = [set stringForColumn:@"Latitude"];
                    store.Longitude = [set stringForColumn:@"Longitude"];
                    store.StoreId = [set stringForColumn:@"StoreId"];
                    store.Code = [set stringForColumn:@"Code"];
                    [dataArray addObject:store];
                }
                [set close];
            }
            [db close];
    }];
    return dataArray;
}
//查询店铺唯一码
+ (NSString *)selectStroeCodeWithTheStoreName:(NSString *)storeName andProjectName:(NSString *)projectName
{
    FMDatabase * db = [self getDataBaseDB];
    if ([db open])
    {
        NSString * selectStr = [NSString  stringWithFormat:@"select * from baseData where StoreName like '%@' and ProjectName like '%@'",storeName,projectName];
        FMResultSet *set = [db executeQuery:selectStr];
        if ([set next])
        {
            return [set stringForColumn:@"Code"];
        }
        [set close];
    }
    [db close];
    return @"";
    
}
//查询门店项目id
+ (NSDictionary *)selectCodeWithTheStoreName:(NSString *)storeName andProjectName:(NSString *)projectName
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    FMDatabase * db = [self getDataBaseDB];
    if ([db open])
    {
        NSString * selectStr = [NSString  stringWithFormat:@"select * from baseData where StoreName like '%@' and ProjectName like '%@'",storeName,projectName];
        FMResultSet *set = [db executeQuery:selectStr];
        if ([set next])
        {
            NSLog(@"%@",[set stringForColumn:@"ProjectInfoId"]);
//            return [set stringForColumn:@"Code"];
            dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:[set stringForColumn:@"StoreId"],@"storeCode",[set stringForColumn:@"ProjectInfoId"],@"projectCode",[set stringForColumn:@"Code"],@"code", nil];
//            NSLog(@"%@",dic);
        }
        [set close];
    }
    [db close];
//    return @"";
//                NSLog(@"%@",dic);
    return dic;
}
+ (NSString *)selectStroeIDWithTheStoreName:(NSString *)storeName
{
    FMDatabase * db = [self getDataBaseDB];
    if ([db open])
    {
        NSString * selectStr = [NSString  stringWithFormat:@"select * from baseData where StoreName like '%@'",storeName];
        FMResultSet *set = [db executeQuery:selectStr];
        if ([set next])
        {
            return [set stringForColumn:@"StoreId"];
        }
        [set close];
    }
    [db close];
    return @"";
}
// 查询最后一条数据
+ (StoreMD *)selectLocationLastData
{
    FMDatabase * db = [self getDB];
    StoreMD * store = [[StoreMD alloc]init];
    if ([db open])
    {
        NSString * seleMax = [NSString stringWithFormat:@"select  max(rowid) from location where userID like '%@'",USER_ID];
        FMResultSet * MaxSet = [db executeQuery:seleMax];
        NSString * MAXID = [MaxSet stringForColumn:@"rowid"];
        
        NSString *resules=[db stringForQuery:@"select count(*) from location"];
        NSLog(@"resules=%@",resules);
        
//        NSString * lastSetStr = [NSString stringWithFormat:@"select * from location where rowid = '%@' and userID LIKE '%@'",resules,USER_ID];
                NSString * lastSetStr = [NSString stringWithFormat:@"select * from location where rowid = '%@'",resules];
        FMResultSet * lastSet = [db executeQuery:lastSetStr];
        if ([lastSet next]) {
            store.StoreName = [lastSet stringForColumn:@"StoreName"];
            store.ProjectInfoId = [lastSet stringForColumn:@"ProjectInfoId"];
            store.ProjectName = [lastSet stringForColumn:@"ProjectName"];
            store.Name = [lastSet stringForColumn:@"ProjectSchedule"];
            store.Latitude = [lastSet stringForColumn:@"Latitude"];
            store.Longitude = [lastSet stringForColumn:@"Longitude"];
            store.StoreId = [lastSet stringForColumn:@"StoreId"];
            store.Code = [lastSet stringForColumn:@"Code"];
            store.timeStamo = [lastSet stringForColumn:@"timestamo"];
        }
        
     
        
        [lastSet close];
    }
    [db close];
    
    return store;
    
    
}
+ (void)upDataLocationInfo:(NSDictionary *)dic
{
    FMDatabase * db = [self getDataBaseDB];
    if ([db open]) {
        [db executeUpdate:@"UNLOCK  baseData"];
        
        NSString * upDataString = [NSString stringWithFormat:@"update  baseData set Latitude='%@',Longitude='%@' where StoreId like'%@'",[dic objectForKey:@"Latitude"],[dic objectForKey:@"Longitude"],[dic objectForKey:@"StoreId"]];
         [db executeUpdate:upDataString];
    }
    [db close];
}
+ (NSMutableArray *)selectStoreAndProjectNameWithStoreName:(NSString *)storeName
{
    NSMutableArray * projectName = [NSMutableArray array];
    FMDatabaseQueue * queue = [[FMDatabaseQueue alloc]initWithPath:[self getDataBasePath]];
    [queue inDatabase:^(FMDatabase *db) {
        if ([db open])
        {
            NSString * selectString = [NSString stringWithFormat:@"select * from baseData where StoreName = '%@'",storeName];
            FMResultSet * set = [db executeQuery:selectString];
            while ([set next]) {
                StoreMD * store = [[StoreMD alloc]init];
                store.ProjectName = [set stringForColumn:@"ProjectName"];
                store.dqArr = [NSMutableArray array];
                [store.dqArr addObject:[set stringForColumn:@"projectSchedule"]];
                [projectName addObject:store];
            }
            [set close];
        }
        [db close];
    }];
    
    return projectName;
}
//存储我的相关门店
+ (void)keepMyShopWithDictionary:(NSMutableDictionary *)dictionary  withBlock:(void (^)(NSString *result))block withBlock:(void (^)(NSString *result))failedBlock
{
    [self creatMyShopTable];
    NSString * Id       = [dictionary objectForKey:@"Id"];
    NSString * StaffID   = [dictionary objectForKey:@"StaffID"];
    NSString * RealName       = [dictionary objectForKey:@"RealName"];
    NSString * ProjectID    = [dictionary objectForKey:@"ProjectID"];
    NSString * ProjectName     = [dictionary objectForKey:@"ProjectName"];
    NSString * CityID       = [dictionary objectForKey:@"CityID"];
    NSString * CityName     = [dictionary objectForKey:@"CityName"];
    NSString * StoreID       = [dictionary objectForKey:@"StoreID"];
    NSString *StoreName = [dictionary objectForKey:@"StoreName"];
    NSString *Code = [dictionary objectForKey:@"Code"];
        NSString *CreateDate = [dictionary objectForKey:@"CreateDate"];

  
    FMDatabase * db = [self getMyShopDB];

        
        if ([db open]) {
            
            NSString * insertStr = [NSString stringWithFormat:@"insert into MyShop (Id,StaffID,RealName,ProjectID,ProjectName,CityID,CityName,StoreID,StoreName,Code,CreateDate) values ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",Id,StaffID,RealName,ProjectID,ProjectName,CityID,CityName,StoreID,StoreName,Code,CreateDate];
            if ([db executeUpdate:insertStr] == YES) {
                
                [[NSUserDefaults standardUserDefaults]setValue:@"YES" forKey:@"myShop"];
            }else
            {
                failedBlock(@"存储失败,请重新操作!");
            }
        }
        [db close];
    
    block(@"存储成功!");
}
//搜索我的门店
+ (NSMutableArray *)selectMyShopWithDatewithBlock:(void (^)(NSString *result))block
{
    NSMutableArray * arr = [NSMutableArray array];
    FMDatabase * db = [self getMyShopDB];
    if ([db open]) {
        NSString * selectString = [NSString stringWithFormat:@"select * from Myshop where  staffID like '%@'",USER_ID];
        FMResultSet * set = [db executeQuery:selectString];
        while ([set next]) {
            StoreMD * store = [[StoreMD alloc]init];
            store.StoreName = [set stringForColumn:@"StoreName"];
//            store.ProjectName = [set stringForColumn:@"ProjectName"];
//            store.projectSchedule = [set stringForColumn:@"projectSchedule"];
//            store.workType = [set stringForColumn:@"workType"];
//            store.companyName = [set stringForColumn:@"companyName"];
//            store.ProjectInfoId =[set stringForColumn:@"ProjectInfoId"];
//            store.Id = [set stringForColumn:@"Id"];
            [arr addObject:store];
        }
        [set close];
    }
    [db close];
    block(@"OK");
    return arr;
}
//根据时间搜索门店数据 2
+ (NSMutableArray *)selectPatrolShopWithDate:(NSString *)date withBlock:(void (^)(NSString *result))block
{
    NSMutableArray * arr = [NSMutableArray array];
    FMDatabase * db = [self getPatrolShopDB];
    if ([db open]) {
//        NSString * selectString = [NSString stringWithFormat:@"select * from patrolShop where PlanDate like '%@' and userID like '%@'",date,USER_ID];
                NSString * selectString = [NSString stringWithFormat:@"select DISTINCT group_concat(WorkType) as work,WorkType,StoreName,Projectname,projectSchedule from patrolShop where PlanDate like '%@' and userID like '%@' GROUP by StoreName,Projectname",date,USER_ID];
        NSLog(@"%@",selectString);
//        select DISTINCT group_concat(WorkType)from patrolShop where 1=1 GROUP by storename,Projectname
        FMResultSet * set = [db executeQuery:selectString];
        while ([set next]) {
            StoreMD * store = [[StoreMD alloc]init];
            store.Name = [set stringForColumn:@"StoreName"];
            store.ProjectName = [set stringForColumn:@"ProjectName"];
            store.projectSchedule = [set stringForColumn:@"projectSchedule"];
            store.workType = [set stringForColumn:@"work"];
            store.companyName = [set stringForColumn:@"companyName"];
            store.ProjectInfoId =[set stringForColumn:@"ProjectInfoId"];
            store.Id = [set stringForColumn:@"Id"];

            [arr addObject:store];
        }
        [set close];
    }
    [db close];
    block(@"OK");
    if (!arr) {
        return nil;
    }
    return arr;
}
//根据时间搜索公司数据 2
+ (NSMutableArray *)selectPatrolShopWithDate2:(NSString *)date withBlock:(void (^)(NSString *result))block
{
    NSMutableArray * arr = [NSMutableArray array];
    FMDatabase * db = [self getPatrolShopDB2];
    if ([db open]) {
        NSString * selectString = [NSString stringWithFormat:@"select * from patrolShop2 where PlanDate like '%@' and userID like '%@'",date,USER_ID];
        FMResultSet * set = [db executeQuery:selectString];
        while ([set next]) {
            StoreMD * store = [[StoreMD alloc]init];
            store.Name = [set stringForColumn:@"StoreName"];
            store.ProjectName = [set stringForColumn:@"ProjectName"];
            store.projectSchedule = [set stringForColumn:@"projectSchedule"];
            store.workType = [set stringForColumn:@"workType"];
            store.companyName = [set stringForColumn:@"companyName"];
            store.ProjectInfoId =[set stringForColumn:@"ProjectInfoId"];
            store.Id = [set stringForColumn:@"Id"];
            [arr addObject:store];
        }
        [set close];
    }
    [db close];
    block(@"OK");
    return arr;
}
//巡店项目的数据存储 3
+ (NSMutableArray *)selectPatrolShopWithDate3:(NSString *)date withBlock:(void (^)(NSString *result))block
{
    NSMutableArray * arr = [NSMutableArray array];
    FMDatabase * db = [self getPatrolShopDB3];
    if ([db open]) {
        NSString * selectString = [NSString stringWithFormat:@"select * from patrolShop3 where PlanDate like '%@' and userID like '%@'",date,USER_ID];
        FMResultSet * set = [db executeQuery:selectString];
        while ([set next]) {
            StoreMD * store = [[StoreMD alloc]init];
            store.Name = [set stringForColumn:@"StoreName"];
            store.ProjectName = [set stringForColumn:@"ProjectName"];
            store.projectSchedule = [set stringForColumn:@"projectSchedule"];
            store.workType = [set stringForColumn:@"workType"];
            store.companyName = [set stringForColumn:@"companyName"];
            store.ProjectInfoId =[set stringForColumn:@"ProjectInfoId"];
            store.Id = [set stringForColumn:@"Id"];
            [arr addObject:store];
        }
        [set close];
    }
    [db close];
    block(@"OK");
    return arr;
}
//搜索计划门店
+ (NSMutableArray *)SelectShopPatrolWithDate:(NSString *)date withBlock:(void (^)(NSString *result))block
{
    NSMutableArray * arr = [NSMutableArray array];
    FMDatabase * db = [self getPatrolShopDB];
    if ([db open]) {
        NSString * selectString = [NSString stringWithFormat:@"select * from patrolShop where PlanDate like '%%' and userID like'%@' group by storename",USER_ID];
        FMResultSet * set = [db executeQuery:selectString];
        while ([set next]) {
//            AdrDistance* adr = [[AdrDistance alloc]init];
//            adr.storeName = [set stringForColumn:@"StoreName"];
//            NSLog(@"%@",adr.storeName);
//            [arr addObject:adr];
            StoreMD * store = [[StoreMD alloc]init];
            store.StoreName = [set stringForColumn:@"StoreName"];
            [arr addObject:store];
        }
        [set close];
    }
    [db close];
    block(@"OK");
    return arr;
}

+ (void)deletePlanDataStoreCode:(NSString *)storeCode
{
    FMDatabase * db  =[self getPatrolShopDB];
    if ([db open]) {
        
        NSString * deleteStr = [NSString stringWithFormat:@"UPDATE patrolShop set btnSelect='YES' where StoreCode like '%@' and userID like '%@'",storeCode,USER_ID];
        [db executeUpdate:deleteStr];
        
    }
}


// 查询定位信息
+ (NSMutableArray *)selectLocationsTable
{
    NSMutableArray * arr = [NSMutableArray array];
    
    FMDatabase * db = [self getDB];
    if ([db open]) {
        
        NSString * selectLocation = [NSString stringWithFormat:@"select * from location where userID like '%@'",USER_ID];
        FMResultSet * set = [db executeQuery:selectLocation];
        while ([set next]) {
            
            LocationMD * loction = [[LocationMD alloc]init];
            loction.latitude = [set stringForColumn:@"latitude"];
            loction.longitude = [set stringForColumn:@"longitude"];
            loction.address = @"0";
            loction.mode = [set stringForColumn:@"netWorkType"];
            loction.precision = @"50";
            loction.loctime = [set stringForColumn:@"timestamo"];
            loction.IMEI = [set stringForColumn:@"identifier"];
            loction.wdate = [set stringForColumn:@"timestamo"];
            [arr addObject:loction];
        }
        [set close];
    }
    [db close];
    return arr;
    
}


+ (void)deleteLocationble
{
    FMDatabase * db = [self getDB];
    if ([db open]) {
        
//        NSString * deleteStr = [NSString stringWithFormat:@"delete from location where userID like '%@'",USER_ID];
                NSString * deleteStr = [NSString stringWithFormat:@"delete from location"];
        [db executeUpdate:deleteStr];
    }
    [db close];
}

+(FMDatabase * )getDataBaseDB
{
    FMDatabase *  db = [[FMDatabase alloc]initWithPath:[self getDataBasePath]];
    return db ;
}
+(NSString *)getGPSPath
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/gps.sqlite"];
}
+(NSString *)getDataBasePath
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/database.sqlite"];
}
+(FMDatabase * )getMyShopDB
{
    FMDatabase *  db = [[FMDatabase alloc]initWithPath:[self getMyShopPath]];
    return db ;
}
+(FMDatabase * )getSignInDB
{
    FMDatabase *  db = [[FMDatabase alloc]initWithPath:[self getSignInPath]];
    return db ;
}
+(FMDatabase * )getPatrolShopDB
{
    FMDatabase *  db = [[FMDatabase alloc]initWithPath:[self getPatrolShopPath]];
    return db ;
}
+(NSString *)getMyShopPath
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/MyShop.sqlite"];
}
+(NSString *)getSignInPath
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/signIn.sqlite"];
}
+(NSString *)getPatrolShopPath
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/patrolShop.sqlite"];
}
//new
+(FMDatabase * )getPatrolShopDB2
{
    FMDatabase *  db = [[FMDatabase alloc]initWithPath:[self getPatrolShopPath2]];
    return db ;
}
//new
+(NSString *)getPatrolShopPath2
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/patrolShop2.sqlite"];
}
//new项目的路径
+(FMDatabase * )getPatrolShopDB3
{
    FMDatabase *  db = [[FMDatabase alloc]initWithPath:[self getPatrolShopPath3]];
    return db ;
}
+(NSString *)getPatrolShopPath3
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/patrolShop3.sqlite"];
}

+(FMDatabase * )getDB
{
    FMDatabase *  db = [[FMDatabase alloc]initWithPath:[self getPath]];
    return db ;
}
+ (NSString *)getPath
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/location.sqlite"];
}

@end
