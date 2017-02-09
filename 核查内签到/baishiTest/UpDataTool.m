//
//  UpDataTool.m
//  Essence
//
//  Created by EssIOS on 15/5/20.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import "UpDataTool.h"
#import "DDXML.h"
#import "KeepSignInInfo.h"
#import "SellModel.h"
#import "signInModel.h"
#import "PatrolModel.h"
#import "PGRecruitModel.h"
#import "LocationMD.h"


#import "PhotoModel.h"

#define USERDF [NSUserDefaults standardUserDefaults]
static NSString *kXML =@"//PGs/PG[last()]" ;
@implementation UpDataTool
// 创建卖进数据XML
+(NSString *)createSellXMLWithArray:(NSMutableArray *)sellArr
{
    //获取document路径,括号中属性为当前应用程序独享
    NSString *documents = [NSHomeDirectory()stringByAppendingPathComponent:@"Documents"];
    NSString *path = [documents stringByAppendingPathComponent:@"Sell.xml"];
    
    
    NSFileManager *manager =[NSFileManager defaultManager];
    //文件不存在时创建
    if (![manager fileExistsAtPath:path])
    {
        NSString *logStr = [NSString stringWithFormat:@"<MJs>"];
        NSData *data = [logStr dataUsingEncoding:NSUTF8StringEncoding];
        [data writeToFile:path atomically:YES];
        
    }
    NSData *dataContent = [[NSData alloc] initWithContentsOfFile:path];
    DDXMLDocument *doc1=[[DDXMLDocument alloc]initWithData:dataContent  options:0 error:nil];
    NSArray *items = [doc1 nodesForXPath:@"MJs/MJ[last()]" error:nil];
    for (int i = 0; i< sellArr.count; i++) {
        
        SellModel * sell = sellArr[i];
        
        if(items){
            for (DDXMLElement *obj in items) {
                
                DDXMLElement *mj = [DDXMLNode elementWithName:@"MJ" stringValue:@""];
                DDXMLNode *uidNode=[DDXMLNode elementWithName:@"uid" stringValue:sell.userID];
                DDXMLNode *nameNode=[DDXMLNode elementWithName:@"name" stringValue:sell.Name];
                DDXMLNode *phoneNode=[DDXMLNode elementWithName:@"phone" stringValue:sell.Phone];
                DDXMLNode *idcardNode=[DDXMLNode elementWithName:@"idcard" stringValue:sell.IdCard];
                DDXMLNode *codeNode=[DDXMLNode elementWithName:@"code" stringValue:sell.storeCode];
                DDXMLNode *IsSuccess=[DDXMLNode elementWithName:@"IsSuccess" stringValue:sell.isSuccess];
                DDXMLNode *IMEINode=[DDXMLNode elementWithName:@"IMEI" stringValue:sell.identifier];
                DDXMLNode *timeNode=[DDXMLNode elementWithName:@"time" stringValue:sell.Cretime];
                
                //给work下添加新的节点
                [obj addChild:mj];//给obj添加一个节点
                [mj addChild:uidNode];
                [mj addChild:nameNode];
                [mj addChild:phoneNode];
                [mj addChild:idcardNode];
                [mj addChild:codeNode];
                [mj addChild:IMEINode];
                [mj addChild:timeNode];
                [mj addChild:IsSuccess];
            }
            //保存到沙盒目录下
            NSString *result=[[NSString alloc]initWithFormat:@"%@",doc1];
            //把 result 写入到path   path 这个是包括文件名的全路径  result 是xml格式的不知道什么东西（XML格式 还是猜的）
            NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:path];
            //找到并定位到outFile的末尾位置(在此后追加文件)
            [outFile seekToEndOfFile];
            
            [outFile writeData:[result dataUsingEncoding:NSUTF8StringEncoding]];
            //关闭读写文件
            [outFile closeFile];
            
        }else{
            //        DDXMLElement *mjs = [DDXMLNode elementWithName:@"MJs" stringValue:@""];//访问MJs的节点
            DDXMLElement *mj = [DDXMLNode elementWithName:@"MJ" stringValue:@""];//访问MJs的节点
            
            DDXMLNode *uidNode=[DDXMLNode elementWithName:@"uid" stringValue:sell.userID];
            DDXMLNode *nameNode=[DDXMLNode elementWithName:@"name" stringValue:sell.Name];
            DDXMLNode *phoneNode=[DDXMLNode elementWithName:@"phone" stringValue:sell.Phone];
            DDXMLNode *idcardNode=[DDXMLNode elementWithName:@"idcard" stringValue:sell.IdCard];
            DDXMLNode *codeNode=[DDXMLNode elementWithName:@"code" stringValue:sell.storeCode];
            DDXMLNode *IsSuccess=[DDXMLNode elementWithName:@"IsSuccess" stringValue:sell.isSuccess];
            DDXMLNode *IMEINode=[DDXMLNode elementWithName:@"IMEI" stringValue:sell.identifier];
            DDXMLNode *timeNode=[DDXMLNode elementWithName:@"time" stringValue:sell.Cretime];
            
            //给work下添加新的节点
            //        [mjs addChild:mj];//给obj添加一个节点
            [mj addChild:uidNode];
            [mj addChild:nameNode];
            [mj addChild:phoneNode];
            [mj addChild:idcardNode];
            [mj addChild:codeNode];
            [mj addChild:IMEINode];
            [mj addChild:timeNode];
            [mj addChild:IsSuccess];
            
            NSString *str=[NSString  stringWithFormat:@"%@",[mj XMLString]];
            NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:path];
            [outFile seekToEndOfFile];
            [outFile writeData:[str dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:path];
    [outFile seekToEndOfFile];
    NSString * aa = @"</MJs>";
    [outFile writeData:[aa dataUsingEncoding:NSUTF8StringEncoding]];
    [outFile closeFile];
    
    return path;
}
+(NSString *)createSignInXMLWithArray:(NSMutableArray *)sellArr
{
    NSString *documents = [NSHomeDirectory()stringByAppendingPathComponent:@"Documents"];
    NSString *path = [documents stringByAppendingPathComponent:@"SignIn.xml"];
    
    NSFileManager *manager =[NSFileManager defaultManager];
    //文件不存在时创建
    if (![manager fileExistsAtPath:path])
    {
        NSString *logStr = [NSString stringWithFormat:@"<works>"];
        NSData *data = [logStr dataUsingEncoding:NSUTF8StringEncoding];
        [data writeToFile:path atomically:YES];
        
    }
    NSData *dataContent = [[NSData alloc] initWithContentsOfFile:path];
    DDXMLDocument *doc1=[[DDXMLDocument alloc]initWithData:dataContent  options:0 error:nil];
    NSArray *items = [doc1 nodesForXPath:@"MJs/MJ[last()]" error:nil];
    for (int i = 0; i< sellArr.count; i++) {
        signInModel * signIn = sellArr[i];
        for (int i = 0; i< 2; i++) {
            if (i == 0) {
                if(items){
                    for (DDXMLElement *obj in items) {
                        
                        DDXMLElement *work = [DDXMLNode elementWithName:@"work" stringValue:@""];//访问MJs的节点
                        DDXMLNode *uid=[DDXMLNode elementWithName:@"uid" stringValue:signIn.userID];//设置一个uid的节点
                        DDXMLNode *code=[DDXMLNode elementWithName:@"code" stringValue:signIn.StoreCode];//招募  姓名
                        DDXMLNode *longitude=[DDXMLNode elementWithName:@"longitude" stringValue:signIn.signLatitude];//手机号
                        DDXMLNode *latitude=[DDXMLNode elementWithName:@"latitude" stringValue:signIn.signLongitude];//身份证
                        DDXMLNode *locationType=[DDXMLNode elementWithName:@"locationType" stringValue:signIn.signLocationType];//门店招募的id
                        DDXMLNode *loctime=[DDXMLNode elementWithName:@"loctime" stringValue:signIn.signLocationTtime];//门店招募的id
                        DDXMLNode *type=[DDXMLNode elementWithName:@"type" stringValue:@"2"];//招募时间
                        DDXMLNode *IMEI=[DDXMLNode elementWithName:@"IMEI" stringValue:signIn.identifier];
                        DDXMLNode *cretime=[DDXMLNode elementWithName:@"cretime" stringValue:signIn.signCreatetime];
                        //给work下添加新的节点
                        [obj addChild:work];//给obj添加一个节点
                        [work addChild:uid];
                        [work addChild:code];
                        [work addChild:latitude];
                        [work addChild:longitude];
                        [work addChild:locationType];
                        [work addChild:loctime];
                        [work addChild:type];
                        [work addChild:IMEI];
                        [work addChild:cretime];
                    }
                    //保存到沙盒目录下
                    NSString *result=[[NSString alloc]initWithFormat:@"%@",doc1];
                    NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:path];
                    //找到并定位到outFile的末尾位置(在此后追加文件)
                    [outFile seekToEndOfFile];
                    
                    [outFile writeData:[result dataUsingEncoding:NSUTF8StringEncoding]];
                    //关闭读写文件
                    [outFile closeFile];
                    
                }else{
                    DDXMLElement *work = [DDXMLNode elementWithName:@"work" stringValue:@""];
                    DDXMLNode *uid=[DDXMLNode elementWithName:@"uid" stringValue:signIn.userID];
                    DDXMLNode *code=[DDXMLNode elementWithName:@"code" stringValue:signIn.StoreCode];
                    DDXMLNode *longitude=[DDXMLNode elementWithName:@"longitude" stringValue:signIn.signLatitude];
                    DDXMLNode *latitude=[DDXMLNode elementWithName:@"latitude" stringValue:signIn.signLongitude];
                    DDXMLNode *locationType=[DDXMLNode elementWithName:@"locationType" stringValue:signIn.signLocationType];
                    DDXMLNode *loctime=[DDXMLNode elementWithName:@"loctime" stringValue:signIn.signLocationTtime];
                    DDXMLNode *type=[DDXMLNode elementWithName:@"type" stringValue:@"2"];
                    DDXMLNode *IMEI=[DDXMLNode elementWithName:@"IMEI" stringValue:signIn.identifier];
                    DDXMLNode *cretime=[DDXMLNode elementWithName:@"cretime" stringValue:signIn.signCreatetime];
                    [work addChild:uid];
                    [work addChild:code];
                    [work addChild:latitude];
                    [work addChild:longitude];
                    [work addChild:locationType];
                    [work addChild:loctime];
                    [work addChild:type];
                    [work addChild:IMEI];
                    [work addChild:cretime];
                    NSString *str=[NSString  stringWithFormat:@"%@",[work XMLString]];
                    NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:path];
                    [outFile seekToEndOfFile];
                    [outFile writeData:[str dataUsingEncoding:NSUTF8StringEncoding]];
                }

            }else
            {
                if(items){
                    for (DDXMLElement *obj in items) {
                        
                        DDXMLElement *work = [DDXMLNode elementWithName:@"work" stringValue:@""];//访问MJs的节点
                        DDXMLNode *uid=[DDXMLNode elementWithName:@"uid" stringValue:signIn.userID];//设置一个uid的节点
                        DDXMLNode *code=[DDXMLNode elementWithName:@"code" stringValue:signIn.StoreCode];//招募  姓名
                        DDXMLNode *longitude=[DDXMLNode elementWithName:@"longitude" stringValue:signIn.signLatitude];
                        DDXMLNode *latitude=[DDXMLNode elementWithName:@"latitude" stringValue:signIn.signLongitude];
                        DDXMLNode *locationType=[DDXMLNode elementWithName:@"locationType" stringValue:signIn.goOutLocationType];//门店招募的id
                        DDXMLNode *loctime=[DDXMLNode elementWithName:@"loctime" stringValue:signIn.goOutLocationTtime];//门店招募的id
                        DDXMLNode *type=[DDXMLNode elementWithName:@"type" stringValue:@"3"];//招募时间
                        DDXMLNode *IMEI=[DDXMLNode elementWithName:@"IMEI" stringValue:signIn.identifier];
                        DDXMLNode *cretime=[DDXMLNode elementWithName:@"cretime" stringValue:signIn.goOutCreatetime];
                        //给work下添加新的节点
                        [obj addChild:work];//给obj添加一个节点
                        [work addChild:uid];
                        [work addChild:code];
                        [work addChild:latitude];
                        [work addChild:longitude];
                        [work addChild:locationType];
                        [work addChild:loctime];
                        [work addChild:type];
                        [work addChild:IMEI];
                        [work addChild:cretime];
                    }
                    //保存到沙盒目录下
                    NSString *result=[[NSString alloc]initWithFormat:@"%@",doc1];
                    //把 result 写入到path   path 这个是包括文件名的全路径  result 是xml格式的不知道什么东西（XML格式 还是猜的）
                    NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:path];
                    //找到并定位到outFile的末尾位置(在此后追加文件)
                    [outFile seekToEndOfFile];
                    
                    [outFile writeData:[result dataUsingEncoding:NSUTF8StringEncoding]];
                    //关闭读写文件
                    [outFile closeFile];
                    
                }else{
                    DDXMLElement *work = [DDXMLNode elementWithName:@"work" stringValue:@""];//访问MJs的节点
                    DDXMLNode *uid=[DDXMLNode elementWithName:@"uid" stringValue:signIn.userID];//设置一个uid的节点
                    DDXMLNode *code=[DDXMLNode elementWithName:@"code" stringValue:signIn.StoreCode];//招募  姓名
                    DDXMLNode *longitude=[DDXMLNode elementWithName:@"longitude" stringValue:signIn.signLatitude];
                    DDXMLNode *latitude=[DDXMLNode elementWithName:@"latitude" stringValue:signIn.signLongitude];
                    DDXMLNode *locationType=[DDXMLNode elementWithName:@"locationType" stringValue:signIn.goOutLocationType];//门店招募的id
                    DDXMLNode *loctime=[DDXMLNode elementWithName:@"loctime" stringValue:signIn.goOutLocationTtime];//门店招募的id
                    DDXMLNode *type=[DDXMLNode elementWithName:@"type" stringValue:@"3"];//招募时间
                    DDXMLNode *IMEI=[DDXMLNode elementWithName:@"IMEI" stringValue:signIn.identifier];
                    DDXMLNode *cretime=[DDXMLNode elementWithName:@"cretime" stringValue:signIn.goOutCreatetime];
                    //给work下添加新的节点
                    [work addChild:uid];
                    [work addChild:code];
                    [work addChild:latitude];
                    [work addChild:longitude];
                    [work addChild:locationType];
                    [work addChild:loctime];
                    [work addChild:type];
                    [work addChild:IMEI];
                    [work addChild:cretime];
                    NSString *str=[NSString  stringWithFormat:@"%@",[work XMLString]];
                    NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:path];
                    [outFile seekToEndOfFile];
                    [outFile writeData:[str dataUsingEncoding:NSUTF8StringEncoding]];
                }

            }
        }
            }
    NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:path];
    [outFile seekToEndOfFile];
    NSString * aa = @"</works>";
    [outFile writeData:[aa dataUsingEncoding:NSUTF8StringEncoding]];
    [outFile closeFile];
    
    return path;
}
+(NSString *)createPatrolPictureXMLWithAPatrol:( PhotoModel*)photo
{
    NSString *imgInfoStr=[NSString stringWithFormat:@"<Imgxmls><imgxml><uid>%@</uid><latitude>%@</latitude><longitude>%@</longitude><LocTime>%@</LocTime><imgpath>%@</imgpath><caremtype>%@</caremtype><IMEI>%@</IMEI><date>%@</date><code>%@</code></imgxml></Imgxmls>",photo.userID,photo.Latitude,photo.Longitude,photo.LocationTtime,photo.imageUrl,photo.selectType,photo.identifier,photo.Createtime,photo.storeCode];
    NSLog(@"imgInfoStr->>\n%@",imgInfoStr);
    return imgInfoStr;
    
    
    NSString *xmlpath = [NSString stringWithFormat:@"%@PatrolPicture.xml",photo.imageUrl];
    NSString *documents = [NSHomeDirectory()stringByAppendingPathComponent:@"Documents"];
    NSString *path      = [documents stringByAppendingPathComponent:xmlpath];
    
    NSFileManager *manager =[NSFileManager defaultManager];
    //文件不存在时创建
    if (![manager fileExistsAtPath:path])
    {
        NSString *logStr = [NSString stringWithFormat:@"<Imgxmls>"];
        NSData *data = [logStr dataUsingEncoding:NSUTF8StringEncoding];
        [data writeToFile:path atomically:YES];
    }
    NSData *dataContent = [[NSData alloc] initWithContentsOfFile:path];
    DDXMLDocument *doc1=[[DDXMLDocument alloc]initWithData:dataContent  options:0 error:nil];
    NSArray *items = [doc1 nodesForXPath:@"Imgxmls/ [last()]" error:nil];
    
    if(items){
        for (DDXMLElement *obj in items) {
            
            DDXMLElement *imgxml    = [DDXMLNode elementWithName:@"imgxml" stringValue:@""];
            DDXMLNode *uid          =[DDXMLNode elementWithName:@"uid" stringValue:photo.userID];
            DDXMLNode *longitude    =[DDXMLNode elementWithName:@"longitude" stringValue:photo.Longitude];
            DDXMLNode *latitude     =[DDXMLNode elementWithName:@"latitude" stringValue:photo.Latitude];
            DDXMLNode *LocTime      =[DDXMLNode elementWithName:@"LocTime" stringValue:photo.LocationTtime];
            DDXMLNode *imgpath      =[DDXMLNode elementWithName:@"imgpath" stringValue:photo.imageUrl];
            DDXMLNode *caremtype    =[DDXMLNode elementWithName:@"caremtype" stringValue:photo.selectType];
            DDXMLNode *IMEI         =[DDXMLNode elementWithName:@"IMEI" stringValue:photo.identifier];
            DDXMLNode *date         =[DDXMLNode elementWithName:@"date" stringValue:photo.Createtime];
            DDXMLNode *code         =[DDXMLNode elementWithName:@"code" stringValue:photo.storeCode];
            
            //给work下添加新的节点
            [obj    addChild:imgxml];
            [imgxml addChild:uid];
            [imgxml addChild:latitude];
            [imgxml addChild:longitude];
            [imgxml addChild:LocTime];
            [imgxml addChild:imgpath];
            [imgxml addChild:caremtype];
            [imgxml addChild:IMEI];
            [imgxml addChild:date];
            [imgxml addChild:code];
        }
        //保存到沙盒目录下
        NSString     *result  =[[NSString alloc]initWithFormat:@"%@",doc1];
        //把 result 写入到path   path 这个是包括文件名的全路径  result 是xml格式的不知道什么东西（XML格式 还是猜的）
        NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:path];
        //找到并定位到outFile的末尾位置(在此后追加文件)
        [outFile seekToEndOfFile];
        
        [outFile writeData:[result dataUsingEncoding:NSUTF8StringEncoding]];
        //关闭读写文件
        [outFile closeFile];
        
    }else{
        DDXMLElement *imgxml    = [DDXMLNode elementWithName:@"imgxml" stringValue:@""];
        DDXMLNode    *uid       = [DDXMLNode elementWithName:@"uid" stringValue:photo.userID];
        DDXMLNode    *longitude = [DDXMLNode elementWithName:@"longitude" stringValue:photo.Longitude];
        DDXMLNode    *latitude  = [DDXMLNode elementWithName:@"latitude" stringValue:photo.Latitude];
        DDXMLNode    *LocTime   = [DDXMLNode elementWithName:@"LocTime" stringValue:photo.LocationTtime];
        DDXMLNode    *imgpath   = [DDXMLNode elementWithName:@"imgpath" stringValue:photo.imageUrl];
        DDXMLNode    *caremtype = [DDXMLNode elementWithName:@"caremtype" stringValue:photo.selectType];
        DDXMLNode    *IMEI      = [DDXMLNode elementWithName:@"IMEI" stringValue:photo.identifier];
        DDXMLNode    *date      = [DDXMLNode elementWithName:@"date" stringValue:photo.Createtime];
        DDXMLNode    *code      = [DDXMLNode elementWithName:@"code" stringValue:photo.storeCode];
        
        [imgxml addChild:uid];
        [imgxml addChild:latitude];
        [imgxml addChild:longitude];
        [imgxml addChild:LocTime];
        [imgxml addChild:imgpath];
        [imgxml addChild:caremtype];
        [imgxml addChild:IMEI];
        [imgxml addChild:date];
        [imgxml addChild:code];
        NSString     *str     =[NSString  stringWithFormat:@"%@",[imgxml XMLString]];
        NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:path];
        [outFile seekToEndOfFile];
        [outFile writeData:[str dataUsingEncoding:NSUTF8StringEncoding]];
    }
    NSFileHandle *outFile2    = [NSFileHandle fileHandleForWritingAtPath:path];
    [outFile2 seekToEndOfFile];
    NSString     * aa         = @"</Imgxmls>";
    [outFile2 writeData:[aa dataUsingEncoding:NSUTF8StringEncoding]];
    [outFile2 closeFile];
    
    return path;
}

+(NSString *)createPGRecruitXMLWithArray:(NSMutableArray *)PGArr
{
    NSString *documents = [NSHomeDirectory()stringByAppendingPathComponent:@"Documents"];
    NSString *path      = [documents stringByAppendingPathComponent:@"PGRecruit.xml"];
    
    NSFileManager *manager =[NSFileManager defaultManager];
    //文件不存在时创建
    if (![manager fileExistsAtPath:path])
    {
        NSString *logStr   = [NSString stringWithFormat:@"<PGs>"];
        NSData *data = [logStr dataUsingEncoding:NSUTF8StringEncoding];
        [data writeToFile:path atomically:YES];
    }
    NSData *dataContent    = [[NSData alloc] initWithContentsOfFile:path];
    DDXMLDocument *doc1    = [[DDXMLDocument alloc]initWithData:dataContent  options:0 error:nil];
    NSArray *items = [doc1 nodesForXPath:@"MJs/MJ[last()]" error:nil];
    for (int i = 0; i< PGArr.count; i++) {
        
        PGRecruitModel * PGRecruit = PGArr[i];
        
        if(items){
            for (DDXMLElement *obj in items) {
                
                DDXMLElement *PG = [DDXMLNode elementWithName:@"PG" stringValue:@""];
                DDXMLNode    *uid=[DDXMLNode elementWithName:@"uid" stringValue:PGRecruit.userID];
                DDXMLNode    *name=[DDXMLNode elementWithName:@"name" stringValue:PGRecruit.Name];
                DDXMLNode    *phone=[DDXMLNode elementWithName:@"phone" stringValue:PGRecruit.Phone];
                DDXMLNode    *idcard=[DDXMLNode elementWithName:@"idcard" stringValue:PGRecruit.IdCard];
                DDXMLNode *code = [DDXMLNode elementWithName:@"StoreCode" stringValue:PGRecruit.storeCode];
                DDXMLNode    *qq=[DDXMLNode elementWithName:@"qq" stringValue:PGRecruit.Qq];
                DDXMLNode    *weixin=[DDXMLNode elementWithName:@"weixin" stringValue:PGRecruit.Weixin];
                DDXMLNode    *imgheadpath=[DDXMLNode elementWithName:@"imgheadpath" stringValue:PGRecruit.Headimgpath];
                DDXMLNode    *imgbodypath=[DDXMLNode elementWithName:@"imgbodypath" stringValue:PGRecruit.bodyImgPath];
                DDXMLNode    *IMEI=[DDXMLNode elementWithName:@"IMEI" stringValue:PGRecruit.identifier];
                DDXMLNode    *time=[DDXMLNode elementWithName:@"time" stringValue:PGRecruit.Createtime];
                DDXMLNode    *latitude =[DDXMLNode elementWithName:@"latitude" stringValue:PGRecruit.Latitude];
                DDXMLNode    *longitude =[DDXMLNode elementWithName:@"longitude" stringValue:PGRecruit.Longitude];
                DDXMLNode    *locationType =[DDXMLNode elementWithName:@"locationType" stringValue:PGRecruit.locationType];
                
                //给work下添加新的节点 locationType
                [obj addChild:PG];//给obj添加一个节点
                [PG  addChild:uid];
                [PG  addChild:name];
                [PG  addChild:phone];
                [PG  addChild:idcard];
                [PG addChild:code];
                [PG  addChild:qq];
                [PG  addChild:weixin];
                [PG  addChild:imgheadpath];
                [PG  addChild:imgbodypath];
                [PG  addChild:IMEI];
                [PG  addChild:time];
                [PG  addChild:latitude];
                [PG  addChild:longitude];
                [PG  addChild:locationType];
            }
            //保存到沙盒目录下
            NSString     *result  =[[NSString alloc]initWithFormat:@"%@",doc1];
            //把 result 写入到path   path 这个是包括文件名的全路径  result 是xml格式的不知道什么东西（XML格式 还是猜的）
            NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:path];
            //找到并定位到outFile的末尾位置(在此后追加文件)
            [outFile seekToEndOfFile];
            
            [outFile writeData:[result dataUsingEncoding:NSUTF8StringEncoding]];
            //关闭读写文件
            [outFile closeFile];
            
        }else{
            DDXMLElement *PG         = [DDXMLNode elementWithName:@"PG" stringValue:@""];
            DDXMLNode    *uid        =[DDXMLNode elementWithName:@"uid" stringValue:PGRecruit.userID];
            DDXMLNode    *name       =[DDXMLNode elementWithName:@"name" stringValue:PGRecruit.Name];
            DDXMLNode    *phone      =[DDXMLNode elementWithName:@"phone" stringValue:PGRecruit.Phone];
            DDXMLNode    *idcard     =[DDXMLNode elementWithName:@"idcard" stringValue:PGRecruit.IdCard];
            DDXMLNode *code=[DDXMLNode elementWithName:@"StoreCode" stringValue:PGRecruit.storeCode];
            DDXMLNode    *qq         =[DDXMLNode elementWithName:@"qq" stringValue:PGRecruit.Qq];
            DDXMLNode    *weixin     =[DDXMLNode elementWithName:@"weixin" stringValue:PGRecruit.Weixin];
            DDXMLNode    *imgheadpath=[DDXMLNode elementWithName:@"imgheadpath" stringValue:PGRecruit.Headimgpath];
            DDXMLNode    *imgbodypath=[DDXMLNode elementWithName:@"imgbodypath" stringValue:PGRecruit.bodyImgPath];
            DDXMLNode    *IMEI       =[DDXMLNode elementWithName:@"IMEI" stringValue:PGRecruit.identifier];
            DDXMLNode    *time       =[DDXMLNode elementWithName:@"time" stringValue:PGRecruit.Createtime];
            DDXMLNode    *latitude   =[DDXMLNode elementWithName:@"latitude" stringValue:PGRecruit.Latitude];
            DDXMLNode    *longitude  =[DDXMLNode elementWithName:@"longitude" stringValue:PGRecruit.Longitude];
            DDXMLNode    *locationType =[DDXMLNode elementWithName:@"locationType" stringValue:PGRecruit.locationType];
            //给work下添加新的节点
            [PG addChild:uid];
            [PG addChild:name];
            [PG addChild:phone];
            [PG addChild:idcard];
            [PG addChild:code];
            [PG addChild:qq];
            [PG addChild:weixin];
            [PG addChild:imgheadpath];
            [PG addChild:imgbodypath];
            [PG addChild:IMEI];
            [PG addChild:time];
            [PG addChild:latitude];
            [PG addChild:longitude];
            [PG addChild:locationType];
            NSString *str=[NSString  stringWithFormat:@"%@",[PG XMLString]];
            NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:path];
            [outFile seekToEndOfFile];
            [outFile writeData:[str dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:path];
    [outFile seekToEndOfFile];
    NSString * aa = @"</PGs>";
    [outFile writeData:[aa dataUsingEncoding:NSUTF8StringEncoding]];
    [outFile closeFile];
    return path;
}
+(NSString *)createLocationXMLWithArray:(NSMutableArray *)LocationArr
{
    NSString *documents = [NSHomeDirectory()stringByAppendingPathComponent:@"Documents"];
    NSString *path = [documents stringByAppendingPathComponent:@"Location.xml"];
    
    NSFileManager *manager =[NSFileManager defaultManager];
    //文件不存在时创建
    if (![manager fileExistsAtPath:path])
    {
        NSString *logStr = [NSString stringWithFormat:@"<locations>"];
        NSData *data = [logStr dataUsingEncoding:NSUTF8StringEncoding];
        [data writeToFile:path atomically:YES];
        
    }
//    NSData *dataContent = [[NSData alloc] initWithContentsOfFile:path];
//    DDXMLDocument *doc1=[[DDXMLDocument alloc]initWithData:dataContent  options:0 error:nil];
//    NSArray *items = [doc1 nodesForXPath:@"locations/location[last()]" error:nil];
    for (int i = 0; i< LocationArr.count; i++) {
        
        LocationMD * locatiMD = LocationArr[i];
//        
//        if(items){
//            for (DDXMLElement *obj in items) {
//                
//                DDXMLElement *location  = [DDXMLNode elementWithName:@"location" stringValue:@""];
//                DDXMLNode    *longitude =[DDXMLNode elementWithName:@"longitude" stringValue:locatiMD.longitude];
//                DDXMLNode    *latitude  =[DDXMLNode elementWithName:@"latitude" stringValue:locatiMD.latitude];
//                DDXMLNode    *address   =[DDXMLNode elementWithName:@"address" stringValue:locatiMD.address];
//                DDXMLNode    *mode      =[DDXMLNode elementWithName:@"mode" stringValue:locatiMD.mode];
//                DDXMLNode    *precision =[DDXMLNode elementWithName:@"precision" stringValue:locatiMD.precision];
//                DDXMLNode    *loctime   =[DDXMLNode elementWithName:@"loctime" stringValue:locatiMD.loctime];
//                DDXMLNode    *IMEI      =[DDXMLNode elementWithName:@"IMEI" stringValue:locatiMD.IMEI];
//                DDXMLNode    *wdate     =[DDXMLNode elementWithName:@"wdate" stringValue:locatiMD.wdate];
//                
//                
//                //给work下添加新的节点
//                [obj      addChild:location];//给obj添加一个节点
//                [location addChild:latitude];
//                [location addChild:longitude];
//                [location addChild:address];
//                [location addChild:mode];
//                [location addChild:precision];
//                [location addChild:loctime];
//                [location addChild:IMEI];
//                [location addChild:wdate];
//                
//            }
//            //保存到沙盒目录下
//            NSString     *result    =[[NSString alloc]initWithFormat:@"%@",doc1];
//            //把 result 写入到path   path 这个是包括文件名的全路径  result 是xml格式的不知道什么东西（XML格式 还是猜的）
//            NSFileHandle *outFile   = [NSFileHandle fileHandleForWritingAtPath:path];
//            //找到并定位到outFile的末尾位置(在此后追加文件)
//            [outFile seekToEndOfFile];
//            
//            [outFile writeData:[result dataUsingEncoding:NSUTF8StringEncoding]];
//            //关闭读写文件
//            [outFile closeFile];
//            
//        }else{
            DDXMLElement *location  = [DDXMLNode elementWithName:@"location" stringValue:@""];
            DDXMLNode    *longitude =[DDXMLNode elementWithName:@"longitude" stringValue:locatiMD.longitude];
            DDXMLNode    *latitude  =[DDXMLNode elementWithName:@"latitude" stringValue:locatiMD.latitude];
            DDXMLNode    *address   =[DDXMLNode elementWithName:@"address" stringValue:locatiMD.address];
            DDXMLNode    *mode      =[DDXMLNode elementWithName:@"mode" stringValue:locatiMD.mode];
            DDXMLNode    *precision =[DDXMLNode elementWithName:@"precision" stringValue:locatiMD.precision];
            DDXMLNode    *loctime   =[DDXMLNode elementWithName:@"loctime" stringValue:locatiMD.loctime];
            DDXMLNode    *IMEI      =[DDXMLNode elementWithName:@"IMEI" stringValue:locatiMD.IMEI];
            DDXMLNode    *wdate     =[DDXMLNode elementWithName:@"wdate" stringValue:locatiMD.wdate];
            
            //给work下添加新的节点
            [location addChild:latitude];
            [location addChild:longitude];
            [location addChild:address];
            [location addChild:mode];
            [location addChild:precision];
            [location addChild:loctime];
            [location addChild:IMEI];
            [location addChild:wdate];
            
            NSString     *str     = [NSString  stringWithFormat:@"%@",[location XMLString]];
            NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:path];
            [outFile seekToEndOfFile];
            [outFile writeData:[str dataUsingEncoding:NSUTF8StringEncoding]];
//        }
    }
    NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:path];
    [outFile seekToEndOfFile];
    NSString     * aa     = @"</locations>";
    [outFile writeData:[aa dataUsingEncoding:NSUTF8StringEncoding]];
    [outFile closeFile];
    return path;
}
+(NSString *)createlogInfoXML;
{
    NSString *documents = [NSHomeDirectory()stringByAppendingPathComponent:@"Documents"];
    NSString *path = [documents stringByAppendingPathComponent:@"userlogin.xml"];
    NSFileManager *manager =[NSFileManager defaultManager];
    
    //文件不存在时创建
    if (![manager fileExistsAtPath:path])
    {
        NSString    * creatStr  = @"<userlogin>";
        NSData      *data       = [creatStr dataUsingEncoding:NSUTF8StringEncoding];
        [data writeToFile:path atomically:YES];
    }
    
    NSString *useridS = [USERDF objectForKey:@"userID"];
    NSString *modelS = [USERDF objectForKey:@"phoneModel"];
    NSString *osversionS = [USERDF objectForKey:@"strSysVersion"];
    NSString *simcardS = [USERDF objectForKey:@"carrierName"];
    NSString *IMEIS = [USERDF objectForKey:@"identifier"];
    NSString *latitudeS = [USERDF objectForKey:@"latitude"];
    NSString *longitudeS = [USERDF objectForKey:@"longitude"];
    NSString *LocTypeS = [USERDF objectForKey:@"networkType"];
    NSString *AppVerS = [USERDF objectForKey:@"verson"];
    NSString *loginDateS = [USERDF objectForKey:@"date"];
    
    
    NSData *dataContent = [[NSData alloc] initWithContentsOfFile:path];
    DDXMLDocument *doc1 =[[DDXMLDocument alloc]initWithData:dataContent  options:0 error:nil];
    NSArray *items      = [doc1 nodesForXPath:@"userlogin/login[last()]" error:nil];
    
        if(items){
            for (DDXMLElement *obj in items) {
                DDXMLElement *login      =[DDXMLNode elementWithName:@"login" stringValue:@""];
                DDXMLNode    *userid     =[DDXMLNode elementWithName:@"userid" stringValue:useridS];
                DDXMLNode    *model    =[DDXMLNode elementWithName:@"model" stringValue:modelS];
                DDXMLNode    *osversion    =[DDXMLNode elementWithName:@"osversion" stringValue:osversionS];
                DDXMLNode    *simcard  =[DDXMLNode elementWithName:@"simcard" stringValue:simcardS];
                DDXMLNode    *IMEI=[DDXMLNode elementWithName:@"IMEI" stringValue:IMEIS];
                DDXMLNode    *latitude=[DDXMLNode elementWithName:@"latitude" stringValue:latitudeS];
                DDXMLNode    *longitude=[DDXMLNode elementWithName:@"longitude" stringValue:longitudeS];
                DDXMLNode    *LocType=[DDXMLNode elementWithName:@"LocType" stringValue:LocTypeS];
                DDXMLNode    *AppVer=[DDXMLNode elementWithName:@"AppVer" stringValue:AppVerS];
                DDXMLNode    *loginDate=[DDXMLNode elementWithName:@"loginDate" stringValue:loginDateS];
                
                //给work下添加新的节点
                [obj addChild:login];
                [login  addChild:userid];
                [login  addChild:model];
                [login  addChild:osversion];
                [login  addChild:simcard];
                [login  addChild:IMEI];
                [login  addChild:latitude];
                [login  addChild:longitude];
                [login  addChild:LocType];
                [login  addChild:AppVer];
                [login  addChild:loginDate];
            }
            //保存到沙盒目录下
            NSString     *result  =[[NSString alloc]initWithFormat:@"%@",doc1];
            NSLog(@"result--->>%@",result);
            //把 result 写入到path   path 这个是包括文件名的全路径  result 是xml格式的不知道什么东西（XML格式 还是猜的）
            NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:path];
            //找到并定位到outFile的末尾位置(在此后追加文件)
            [outFile seekToEndOfFile];
            
            [outFile writeData:[result dataUsingEncoding:NSUTF8StringEncoding]];
            //关闭读写文件
            [outFile closeFile];
            
        }else{
            DDXMLElement *login      =[DDXMLNode elementWithName:@"login" stringValue:@""];
            DDXMLNode    *userid     =[DDXMLNode elementWithName:@"userid" stringValue:useridS];
            DDXMLNode    *model    =[DDXMLNode elementWithName:@"model" stringValue:modelS];
            DDXMLNode    *osversion    =[DDXMLNode elementWithName:@"osversion" stringValue:osversionS];
            DDXMLNode    *simcard  =[DDXMLNode elementWithName:@"simcard" stringValue:simcardS];
            DDXMLNode    *IMEI=[DDXMLNode elementWithName:@"IMEI" stringValue:IMEIS];
            DDXMLNode    *latitude=[DDXMLNode elementWithName:@"latitude" stringValue:latitudeS];
            DDXMLNode    *longitude=[DDXMLNode elementWithName:@"longitude" stringValue:longitudeS];
            DDXMLNode    *LocType=[DDXMLNode elementWithName:@"LocType" stringValue:LocTypeS];
            DDXMLNode    *AppVer=[DDXMLNode elementWithName:@"AppVer" stringValue:AppVerS];
            DDXMLNode    *loginDate=[DDXMLNode elementWithName:@"loginDate" stringValue:loginDateS];
            
            //给work下添加新的节点
            [login  addChild:userid];
            [login  addChild:model];
            [login  addChild:osversion];
            [login  addChild:simcard];
            [login  addChild:IMEI];
            [login  addChild:latitude];
            [login  addChild:longitude];
            [login  addChild:LocType];
            [login  addChild:AppVer];
            [login  addChild:loginDate];
            //给work下添加新的节点
            
            NSString     *str     =[NSString  stringWithFormat:@"%@",[login XMLString]];
            NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:path];
            [outFile seekToEndOfFile];
            [outFile writeData:[str dataUsingEncoding:NSUTF8StringEncoding]];
        }
    NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:path];
    [outFile seekToEndOfFile];
    NSString     * aa     = @"</userlogin>";
    [outFile writeData:[aa dataUsingEncoding:NSUTF8StringEncoding]];
    [outFile closeFile];
    return path;
}

//创建新的签到xml
+(NSString *)createCheckXMLWithArray:(NSMutableArray *)sellArr
{
    NSString *documents = [NSHomeDirectory()stringByAppendingPathComponent:@"Documents"];
    NSString *path = [documents stringByAppendingPathComponent:@"SignIn.xml"];
    NSFileManager *manager =[NSFileManager defaultManager];
    //文件不存在时创建
    if (![manager fileExistsAtPath:path])
    {
        NSString *logStr = [NSString stringWithFormat:@"<works>"];
        NSData *data = [logStr dataUsingEncoding:NSUTF8StringEncoding];
        [data writeToFile:path atomically:YES];
        
    }
    NSData *dataContent = [[NSData alloc] initWithContentsOfFile:path];
    DDXMLDocument *doc1=[[DDXMLDocument alloc]initWithData:dataContent  options:0 error:nil];
    NSArray *items = [doc1 nodesForXPath:@"MJs/MJ[last()]" error:nil];
    for (int i = 0; i< sellArr.count; i++) {
        signInModel * signIn = sellArr[i];
        if(items){
            for (DDXMLElement *obj in items) {
                DDXMLElement  *work = [DDXMLNode elementWithName:@"work" stringValue:@""];
                DDXMLNode *checkInImei = [DDXMLNode elementWithName:@"checkInImei" stringValue:signIn.checkInImei];
                DDXMLNode *checkInLatitude = [DDXMLNode elementWithName:@"checkInLatitude" stringValue:signIn.checkInLatitude];
                DDXMLNode *checkInLocationTime = [DDXMLNode elementWithName:@"checkInLocationTime" stringValue:signIn.checkInLocationTime];
                DDXMLNode *checkInLocationType = [DDXMLNode elementWithName:@"checkInLocationType" stringValue:signIn.signLocationType];
                DDXMLNode *checkInLongitude = [DDXMLNode elementWithName:@"checkInLongitude" stringValue:signIn.checkInLongitude];
                DDXMLNode *checkInTime = [DDXMLNode elementWithName:@"checkInTime" stringValue:signIn.checkInTime];
                
                DDXMLNode *checkOutImei = [DDXMLNode elementWithName:@"checkOutImei" stringValue:signIn.checkOutImei];
                DDXMLNode *checkOutLatitude = [DDXMLNode elementWithName:@"checkOutLatitude" stringValue:signIn.checkOutLatitude];
                DDXMLNode *checkOutLocationTime = [DDXMLNode elementWithName:@"checkOutLocationTime" stringValue:signIn.checkOutLocationTime];
                DDXMLNode *checkOutLocationType = [DDXMLNode elementWithName:@"checkOutLocationType" stringValue:signIn.checkOutLocationType];
                DDXMLNode *checkOutLongitude = [DDXMLNode elementWithName:@"checkOutLongitude" stringValue:signIn.checkOutLongitude];
                DDXMLNode *checkOutTime = [DDXMLNode elementWithName:@"checkOutTime" stringValue:signIn.checkOutTime];
                
                DDXMLNode *companyCode = [DDXMLNode elementWithName:@"companyCode" stringValue:signIn.companyCode];
                //DDXMLNode *isUpload = [DDXMLNode elementWithName:@"isUpload" stringValue:signIn.isUpload];
                DDXMLNode *itemCode = [DDXMLNode elementWithName:@"itemCode" stringValue:signIn.itemCode];
                DDXMLNode *StoreCode =[DDXMLNode elementWithName:@"StoreCode" stringValue:signIn.StoreCode];
                DDXMLNode *uid=[DDXMLNode elementWithName:@"uid" stringValue:signIn.userID];
                //给work下添加新的节点
                [obj addChild:work];//给obj添加一个节点
                [work addChild:checkInImei];
                [work addChild:checkInLatitude];
                [work addChild:checkInLocationTime];
                [work addChild:checkInLocationType];
                [work addChild:checkInLongitude];
                [work addChild:checkInTime];
                
                [work addChild:checkOutImei];
                [work addChild:checkOutLatitude];
                [work addChild:checkOutLocationTime];
                [work addChild:checkOutLocationType];
                [work addChild:checkOutLongitude];
                [work addChild:checkOutTime];
                
                [work addChild:companyCode];
                //[work addChild:isUpload];
                [work addChild:itemCode];
                [work addChild:StoreCode];
                [work addChild:uid];
            }
            //保存到沙盒目录下
            NSString     *result  =[[NSString alloc]initWithFormat:@"%@",doc1];
            //把 result 写入到path   path 这个是包括文件名的全路径  result 是xml格式的不知道什么东西（XML格式 还是猜的）
            NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:path];
            //找到并定位到outFile的末尾位置(在此后追加文件)
            [outFile seekToEndOfFile];
            
            [outFile writeData:[result dataUsingEncoding:NSUTF8StringEncoding]];
            //关闭读写文件
            [outFile closeFile];
        }else
        {
            DDXMLElement  *work = [DDXMLNode elementWithName:@"work" stringValue:@""];
            DDXMLNode *checkInImei = [DDXMLNode elementWithName:@"checkInImei" stringValue:signIn.checkInImei];
            DDXMLNode *checkInLatitude = [DDXMLNode elementWithName:@"checkInLatitude" stringValue:signIn.checkInLatitude];
            DDXMLNode *checkInLocationTime = [DDXMLNode elementWithName:@"checkInLocationTime" stringValue:signIn.checkInLocationTime];
            DDXMLNode *checkInLocationType = [DDXMLNode elementWithName:@"checkInLocationType" stringValue:signIn.checkInLocationType];
            DDXMLNode *checkInLongitude = [DDXMLNode elementWithName:@"checkInLongitude" stringValue:signIn.checkInLongitude];
            DDXMLNode *checkInTime = [DDXMLNode elementWithName:@"checkInTime" stringValue:signIn.checkInTime];
            
            DDXMLNode *checkOutImei = [DDXMLNode elementWithName:@"checkOutImei" stringValue:signIn.checkOutImei];
            DDXMLNode *checkOutLatitude = [DDXMLNode elementWithName:@"checkOutLatitude" stringValue:signIn.checkOutLatitude];
            DDXMLNode *checkOutLocationTime = [DDXMLNode elementWithName:@"checkOutLocationTime" stringValue:signIn.checkOutLocationTime];
            DDXMLNode *checkOutLocationType = [DDXMLNode elementWithName:@"checkOutLocationType" stringValue:signIn.checkOutLocationType];
            DDXMLNode *checkOutLongitude = [DDXMLNode elementWithName:@"checkOutLongitude" stringValue:signIn.checkOutLongitude];
            DDXMLNode *checkOutTime = [DDXMLNode elementWithName:@"checkOutTime" stringValue:signIn.checkOutTime];
            
            DDXMLNode *companyCode = [DDXMLNode elementWithName:@"companyCode" stringValue:signIn.companyCode];
            //DDXMLNode *isUpload = [DDXMLNode elementWithName:@"isUpload" stringValue:signIn.isUpload];
            DDXMLNode *itemCode = [DDXMLNode elementWithName:@"itemCode" stringValue:signIn.itemCode];
            DDXMLNode *StoreCode =[DDXMLNode elementWithName:@"StoreCode" stringValue:signIn.StoreCode];
            DDXMLNode *uid=[DDXMLNode elementWithName:@"uid" stringValue:signIn.userID];
            
            [work addChild:checkInImei];
            [work addChild:checkInLatitude];
            [work addChild:checkInLocationTime];
            [work addChild:checkInLocationType];
            [work addChild:checkInLongitude];
            [work addChild:checkInTime];
            
            [work addChild:checkOutImei];
            [work addChild:checkOutLatitude];
            [work addChild:checkOutLocationTime];
            [work addChild:checkOutLocationType];
            [work addChild:checkOutLongitude];
            [work addChild:checkOutTime];
            
            [work addChild:companyCode];
            //[work addChild:isUpload];
            [work addChild:itemCode];
            [work addChild:StoreCode];
            [work addChild:uid];
            
            NSString *str=[NSString  stringWithFormat:@"%@",[work XMLString]];
            NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:path];
            [outFile seekToEndOfFile];
            [outFile writeData:[str dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:path];
    [outFile seekToEndOfFile];
    NSString * aa = @"</works>";
    [outFile writeData:[aa dataUsingEncoding:NSUTF8StringEncoding]];
    [outFile closeFile];
    
    return path;
}

@end
