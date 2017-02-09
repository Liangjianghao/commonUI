//
//  NetWorkTools.m
//  Essence
//
//  Created by EssIOS on 15/5/7.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import "NetWorkTools.h"
#import "AFNetworking.h"
#import "XMLHelper.h"
#import "JSONKit.h"
#import "keepLocationInfo.h"
//#define SERVERS_IP  @"http://pm.essenceimc.com"
#define SERVERS_IP  @"http://192.168.60.50/hecha"

//#define SERVER_INTERFACES  @"%@/Service/android/User.asmx"
#define SERVER_INTERFACES  @"%@/service/app.ashx?action=login"

#define SERVER_PEPSI  @"%@/Service/pepsiwebservice.asmx"

#define SERVERS_COMPANY @"%@/Service/appwebservice.asmx"
@implementation NetWorkTools

//+(void)requestWithAddresss:(NSString *)addrress andParameters:(id )parameter withSuccessBlock:(void (^)(NSDictionary *result, NSError *error))successBlock andFailedBlock:(void (^)(NSString *result, NSError *error))failedBlock
//{
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//    
//    NSURL *URL = [NSURL URLWithString:addrress];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//    
//    NSURL *filePath = [NSURL fileURLWithPath:parameter];
//    
//    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:filePath progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
//        if (error) {
//            NSLog(@"Error: %@", error);
//        } else {
//            NSLog(@"Success: %@ %@", response, responseObject);
//        }
//    }];
//    [uploadTask resume];
//}
- (BOOL)validateUrl:(NSString *)candidate {
    NSString *urlRegEx = @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:candidate];
}
+(void)requestWithAddresss:(NSString *)addrress andParameters:( id)parameter withSuccessBlock:(void (^)(NSDictionary *result, NSError *error))successBlock andFailedBlock:(void (^)(NSString *result, NSError *error))failedBlock
{
    NSString *URLString = addrress;
    
    NSDictionary *dic=parameter;
    

    NSString *urlRegEx = @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    if ([urlTest evaluateWithObject:addrress]) {
        NSLog(@"规范");

    }
    else
    {
        NSLog(@"不规范");
    }
    NSString *encoded = [addrress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    if ([urlTest evaluateWithObject:encoded]) {
        NSLog(@"不规范");
    }
    else
    {
        NSLog(@"规范");

    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //    requestSerializer
//    manager.responseSerializer = [[AFCompoundResponseSerializer alloc] init];
//    NSData *data =    [NSJSONSerialization dataWithJSONObject:parameter options:NSJSONWritingPrettyPrinted error:nil];

    
    [manager POST:encoded parameters:parameter success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //        NSString *result = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSLog(@"jsonDict %@",jsonDict);
        
        successBlock(jsonDict,nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"失败:%@",error);  //这里打印错误信息
        failedBlock(@"failed",nil);
    }];
}

+(void)requestWithAddress:(NSString *)addrress andParameters:(NSDictionary *)parameter withSuccessBlock:(void (^)(NSDictionary *result, NSError *error))successBlock andFailedBlock:(void (^)(NSString *result, NSError *error))failedBlock
{
    NSString *URLString = addrress;
    
    NSDictionary *dic=parameter;
    NSString *encoded = [addrress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    //    requestSerializer
    manager.responseSerializer = [[AFCompoundResponseSerializer alloc] init];

    [manager POST:addrress parameters:parameter success:^(NSURLSessionDataTask *task, id responseObject) {
        
                //        NSString *result = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
                NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
                NSLog(@"jsonDict %@",jsonDict);
        
                successBlock(jsonDict,nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"失败:%@",error);  //这里打印错误信息
                failedBlock(@"failed",nil);
    }];
}
//登陆请求
+ (void)loginWithLoginName:(NSString *)loginName password:(NSString *)password
                 withBlock:(void (^)(NSDictionary *result, NSError *error))block withBlock:(void (^)(NSString *result, NSError *error))failedBlock
{
    
    NSString *soapBody = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                          "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                          "<soap:Body>\n"
                          "<Login xmlns=\"http://tempuri.org/\">\n"
                          "<username>%@</username>\n"
                          "<password>%@</password>\n"
                          "</Login>\n"
                          "</soap:Body>\n"
                          "</soap:Envelope>\n", loginName  ,password
                          ];
    NSString *baseApiURL = [NSString stringWithFormat:SERVER_INTERFACES,SERVERS_IP];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseApiURL]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapBody dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"http://tempuri.org/Login" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSLog(@"soap\n%@",soapBody);
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request] ;
    
    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id XML) {
        
        // xml转换json
        
        NSDictionary * loginResult = [XMLHelper loginXmlChangeJsonStr:operation.responseString];
        NSLog(@"Result-->>\n%@",loginResult);
        block(loginResult,operation.error);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"登录失败");
        failedBlock(@"登录失败",error);
        
    }];
    [operation start];
    [operation waitUntilFinished];
}

////获取基础数据
//+ (void)getBaseDataWithUserID:(NSString *)userID nowTime:(NSString *)time
//                    withBlock:(void (^)(NSString *result, NSError *error))block failedBlock:(void (^)(NSString *result, NSError *error))failedBlock
//{
//    //    BOOL isFirstUsed = NO;
//    //    if ([XMLHelper isFirstUse] == YES)
//    //    {
//    //        time = @"";
//    //        isFirstUsed = YES;
//    //    }else
//    //    {
//    //        NSDate * nowDate = [NSDate date];
//    //        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
//    //        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    //        time = [formatter stringFromDate:nowDate];
//    //    }
//    
//    if (![[NSUserDefaults standardUserDefaults]valueForKey:@"lastUpdate"] )
//    {
//        time = @"";
//        ////        isFirstUsed = YES;
//    }else
//    {
//        //        NSDate * nowDate = [NSDate date];
//        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
//        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//        time = [formatter stringFromDate:[[NSUserDefaults standardUserDefaults] valueForKey:@"lastUpdate"]];
//        
//    }
//    NSString *soapBody = [NSString stringWithFormat:
//                          @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
//                          "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
//                          "<soap:Body>\n"
//                          "<LoadProjectData3 xmlns=\"http://tempuri.org/\">"
//                          "<userId>%@</userId>"
//                          "<lastUpdateTime>%@</lastUpdateTime>"
//                          "</LoadProjectData3>"
//                          "</soap:Body>"
//                          
//                          "</soap:Envelope>\n",userID,time
//                          ];
//    NSLog(@"soapBody-->>%@",soapBody);
//    NSString *baseApiURL = [NSString stringWithFormat:SERVER_INTERFACES,SERVERS_IP];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseApiURL]];
//    
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:[soapBody dataUsingEncoding:NSUTF8StringEncoding]];
//    [request addValue:@"http://tempuri.org/LoadProjectData3" forHTTPHeaderField:@"SOAPAction"];
//    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    request.timeoutInterval = 30.0f;
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        // 判断是否为第一次登录
//        //        if (isFirstUsed == NO)
//        if ([[NSUserDefaults standardUserDefaults]valueForKey:@"lastUpdate"])
//        {
//            NSString * resultStr = [XMLHelper XMLUpDataWithTheXML:operation.responseString];
//            
//            block(resultStr,nil);
//            [[NSUserDefaults standardUserDefaults]setValue:[NSDate date] forKey:@"lastUpdate"];
//        
//            NSLog(@"resultStr1111-->>%@",resultStr);
//            if (![resultStr isEqualToString:@"0"])
//            {
//                NSString * dataJson = [XMLHelper XMLBaseDataWithTheXML:operation.responseString];
//                JSONDecoder * decoder = [[JSONDecoder alloc]init];
//                NSDictionary * baseDataDic = [decoder objectWithUTF8String:(unsigned char *)[dataJson UTF8String] length:operation.responseData.length];
//                //存储更新的数据
//                [keepLocationInfo keepBaseDataWithDictionary:baseDataDic];
////                NSLog(@"baseDataDic-->>%@,baseDataDicCount-->>%d",baseDataDic,baseDataDic.count);
//                NSLog(@"更新数据");
//            }
//            else
//            {
//                return ;
//            }
//        }else
//        {
//            //第一次使用登陆成功后获取基本数据
//            NSString * baseDataJson = [XMLHelper XMLBaseDataWithTheXML:operation.responseString];
//            NSDictionary * baseDataDic = [baseDataJson objectFromJSONString];
//            //存储基本数据
//            NSLog(@"base-->>\n%@",baseDataDic);
//            //           NSLog(@"baseDataDic-->>%@\n",baseDataDic);
//            [keepLocationInfo keepBaseDataWithDictionary:baseDataDic];
//            NSLog(@"完整数据");
//            //            [[NSUserDefaults standardUserDefaults]setValue:@"NO" forKey:@"isFirstLogin"];
//            [[NSUserDefaults standardUserDefaults]setValue:[NSDate date] forKey:@"lastUpdate"];
//            //            NSLog(@"is-->%@,date-->>%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"isFirstLogin"],[[NSUserDefaults standardUserDefaults]valueForKey:@"lastUpdate"]);
//            block(@"存储完成",nil);
//            
//            
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
//        //        if (isFirstUsed == YES)
//        //        {
//        //            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"currnVerson"] !=nil) {
//        //                [[NSUserDefaults standardUserDefaults] delete:@"currnVerson"];
//        //            }
//        //        }
//    }];
//    [operation start];
//    [operation waitUntilFinished];
//    
//}
//获取基础数据
+ (void)getBaseDataWithUserID:(NSString *)userID nowTime:(NSString *)time
                    withBlock:(void (^)(NSString *result, NSError *error))block failedBlock:(void (^)(NSString *result, NSError *error))failedBlock
{
    //    BOOL isFirstUsed = NO;
    //    if ([XMLHelper isFirstUse] == YES)
    //    {
    //        time = @"";
    //        isFirstUsed = YES;
    //    }else
    //    {
    //        NSDate * nowDate = [NSDate date];
    //        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    //        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //        time = [formatter stringFromDate:nowDate];
    //    }
    
    if (![[NSUserDefaults standardUserDefaults]valueForKey:@"lastUpdate"] )
    {
        time = @"";
        ////        isFirstUsed = YES;
    }else
    {
        //        NSDate * nowDate = [NSDate date];
        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        time = [formatter stringFromDate:[[NSUserDefaults standardUserDefaults] valueForKey:@"lastUpdate"]];
        
    }
    NSString *soapBody = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                          "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                          "<soap:Body>\n"
                          "<LoadProjectData4 xmlns=\"http://tempuri.org/\">"
                          "<userId>%@</userId>"
                          "<projectid>%@</projectid>"
                          "</LoadProjectData4>"
                          "</soap:Body>"
                          
//                          "</soap:Envelope>\n",userID,@"BFD-DEMO1604"
                          "</soap:Envelope>\n",userID,@"perfettiLH17Q1"
                          ];
    NSLog(@"soapBody-->>%@",soapBody);
    NSString *baseApiURL = [NSString stringWithFormat:SERVER_INTERFACES,SERVERS_IP];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseApiURL]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapBody dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"http://tempuri.org/LoadProjectData4" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    request.timeoutInterval = 30.0f;
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 判断是否为第一次登录
        //        if (isFirstUsed == NO)
        if ([[NSUserDefaults standardUserDefaults]valueForKey:@"lastUpdate"])
        {
            
#pragma mark 督导未分配门店处理 返回数据为空
            
            //            if (operation.responseString) {
            //                return ;
            //            }else
            //            {
            NSString * resultStr = [XMLHelper XMLUpDataWithTheXML:operation.responseString];
            
            block(resultStr,nil);
            [[NSUserDefaults standardUserDefaults]setValue:[NSDate date] forKey:@"lastUpdate"];
            
            //            }
            
            //            NSLog(@"resultStr1111-->>%@",resultStr);
            //            if (![resultStr isEqualToString:@"0"])
            //            {
            //                NSString * dataJson = [XMLHelper XMLBaseDataWithTheXML:operation.responseString];
            //                JSONDecoder * decoder = [[JSONDecoder alloc]init];
            //                NSDictionary * baseDataDic = [decoder objectWithUTF8String:(unsigned char *)[dataJson UTF8String] length:operation.responseData.length];
            //                //存储更新的数据
            //                [keepLocationInfo keepBaseDataWithDictionary:baseDataDic];
            ////                NSLog(@"baseDataDic-->>%@,baseDataDicCount-->>%d",baseDataDic,baseDataDic.count);
            //                NSLog(@"更新数据");
            //            }
            //            else
            //            {
            //                return ;
            //            }
        }else
        {
            //第一次使用登陆成功后获取基本数据
            NSString * baseDataJson = [XMLHelper XMLBaseDataWithTheXML:operation.responseString];
            if ([baseDataJson isEqualToString:@"0"]) {
                block(@"门店未分配",nil);
                return ;
            }
            NSDictionary * baseDataDic = [baseDataJson objectFromJSONString];
            //存储基本数据
            NSLog(@"base-->>\n%@",baseDataDic);
            //           NSLog(@"baseDataDic-->>%@\n",baseDataDic);
            [keepLocationInfo keepBaseDataWithDictionary:baseDataDic];
            NSLog(@"完整数据");
            //            [[NSUserDefaults standardUserDefaults]setValue:@"NO" forKey:@"isFirstLogin"];
            [[NSUserDefaults standardUserDefaults]setValue:[NSDate date] forKey:@"lastUpdate"];
            //            NSLog(@"is-->%@,date-->>%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"isFirstLogin"],[[NSUserDefaults standardUserDefaults]valueForKey:@"lastUpdate"]);
            block(@"存储完成",nil);
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        //        if (isFirstUsed == YES)
        //        {
        //            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"currnVerson"] !=nil) {
        //                [[NSUserDefaults standardUserDefaults] delete:@"currnVerson"];
        //            }
        //        }
    }];
    [operation start];
    [operation waitUntilFinished];
    
}
+(void *)GetProductListWithProjectId:(NSString *)ProjectId withBlock:(void (^)(NSString *result, NSError *error))block
{

    NSDictionary *dataDic;
    NSString *soapBody = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                          "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                          "<soap:Body>\n"
                          "<GetProductList xmlns=\"http://tempuri.org/\">"
                          "<projectid>%@</projectid>"
                          "</GetProductList>"
                          "</soap:Body>"
                          
                          "</soap:Envelope>\n",ProjectId
                          ];
    NSLog(@"soapBody-->>%@",soapBody);
    NSString *baseApiURL = [NSString stringWithFormat:SERVER_PEPSI,SERVERS_IP];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseApiURL]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapBody dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"http://tempuri.org/GetProductList" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    request.timeoutInterval = 30.0f;
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError * error = nil;
        
        NSDictionary * dic = [XMLReader dictionaryForXMLString:operation.responseString error:&error];
        
        NSDictionary * soapEnvelope = [dic objectForKey:@"soap:Envelope"];
        
        NSDictionary * soapBody = [soapEnvelope objectForKey:@"soap:Body"];
        
        NSDictionary * LoadProjectDataResponse = [soapBody objectForKey:@"GetProductListResponse"];
        
        NSDictionary * LoadProjectDataResult = [LoadProjectDataResponse objectForKey:@"GetProductListResult"];
        
        NSString * textData = [LoadProjectDataResult objectForKey:@"text"];
        
        block(textData,nil);
        NSData *data= [textData dataUsingEncoding:NSUTF8StringEncoding];
        id dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
//        NSLog(@"%@",[dictionary objectForKey:@"List"]);


//            NSDictionary *dictionary = (NSDictionary *)data;
//        NSLog(@"dictionary-->%@",dictionary);

//        NSDictionary * textDic = [XMLReader dictionaryForXMLString:textData error:&error];
//        NSData * data = [NSJSONSerialization dataWithJSONObject:textData options:NSJSONWritingPrettyPrinted error:&error];
        
//        NSString * json = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//        NSString * baseDataJson = [XMLHelper XMLBaseDataWithTheXML:operation.responseString];
//        NSDictionary * baseDataDic = [json objectFromJSONString];
//        NSLog(@"%@",json);
//        return dictionary;
//        return responseObject;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        return ;
    }];
    [operation start];
    [operation waitUntilFinished];
    return 0;
}
//获取更新基础数据
+ (void)getUpdateBaseDataWithUserID:(NSString *)userID nowTime:(NSString *)time
                          withBlock:(void (^)(NSString *result, NSError *error))block failedBlock:(void (^)(NSString *result, NSError *error))failedBlock
{
    
    
    
    time = @"";
    
    NSString *soapBody = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                          "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                          "<soap:Body>\n"
                          "<LoadProjectData4 xmlns=\"http://tempuri.org/\">"
                          "<userId>%@</userId>"
                          "<projectid>%@</projectid>"
                          "</LoadProjectData4>"
                          "</soap:Body>"
                          
//                          "</soap:Envelope>\n",userID,@"BFD-DEMO1604"
                          "</soap:Envelope>\n",userID,@"perfettiLH17Q1"
                          
                          ];
    NSLog(@"soapBody-->>%@",soapBody);
    NSString *baseApiURL = [NSString stringWithFormat:SERVER_INTERFACES,SERVERS_IP];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseApiURL]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapBody dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"http://tempuri.org/LoadProjectData4" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    request.timeoutInterval = 30.0f;
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString * baseDataJson = [XMLHelper XMLBaseDataWithTheXML:operation.responseString];
        if ([baseDataJson isEqualToString:@"0"]) {
            block(@"门店未分配",nil);
            return ;
        }
        NSDictionary * baseDataDic = [baseDataJson objectFromJSONString];
        //存储基本数据
        //           NSLog(@"baseDataDic-->>%@\n",baseDataDic);
        [keepLocationInfo keepBaseDataWithDictionary:baseDataDic];
        NSLog(@"完整数据");
        //            [[NSUserDefaults standardUserDefaults]setValue:@"NO" forKey:@"isFirstLogin"];
        [[NSUserDefaults standardUserDefaults]setValue:[NSDate date] forKey:@"lastUpdate"];
        //            NSLog(@"is-->%@,date-->>%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"isFirstLogin"],[[NSUserDefaults standardUserDefaults]valueForKey:@"lastUpdate"]);
        block(@"存储完成",nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        
    }];
    [operation start];
    [operation waitUntilFinished];
    
}
//发送获取新的加内容数据请求 获取客户公司额
+(void)patrolSignInWithProjectID:(NSString *)ProjectID Name:(NSString *)Name withBlock:(void(^)(id result,NSError *error))block failedBlock:(void(^)(id result,NSError *error))failedBlock
{
    
     BOOL isFirstUsed = NO;
    
    NSString *soapBody = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                          "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                          "<soap:Body>\n"
                          "<GetCompanys xmlns=\"http://tempuri.org/\" />\n"
                          "</soap:Body>"
                          "</soap:Envelope>\n"];
    NSString *baseApiURL = [NSString stringWithFormat:SERVERS_COMPANY,SERVERS_IP];
    NSLog(@"%@",baseApiURL);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseApiURL]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapBody dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"http://tempuri.org/GetCompanys" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request] ;
    
    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id XML) {
            NSDictionary * loginResult = [XMLHelper XMLUpCompanyWithTheXML:operation.responseString];
            block(loginResult , nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (isFirstUsed == YES) {
            
            if ([[NSUserDefaults standardUserDefaults]objectForKey:@"currnVerson"] != nil) {
                [[NSUserDefaults standardUserDefaults]objectForKey:@"currnVerson"];
            }
        }
    }];
    [operation start];
    [operation waitUntilFinished];
}
//用户是否允许制定计划
+ (void)getCanEditWorkPlanDataWithUserID:(NSString *)userID nowTime:(NSString *)time
                               withBlock:(void (^)(id result, NSError *error))block failedBlock:(void (^)(id result, NSError *error))failedBlock
{
    
    NSString *soapBody = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                          "<soap:Body>"
                          "<CanEditWorkPlan xmlns=\"http://tempuri.org/\">"
                          "<userid>%@</userid>"
                          "<startdate>%@</startdate>"
                          "</CanEditWorkPlan>"
                          " </soap:Body> "
                          "</soap:Envelope>",userID,time
                          ];
    NSLog(@"isCan-->>>%@",soapBody);
    NSString *baseApiURL = [NSString stringWithFormat:SERVERS_COMPANY,SERVERS_IP];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseApiURL]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapBody dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"http://tempuri.org/CanEditWorkPlan" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    request.timeoutInterval = 30.0f;
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {

            NSString * resultStr = [XMLHelper CanEditWorkPlanWithXML:operation.responseString];
            
            block(resultStr,nil);
//            NSLog(@"resultStr%@",resultStr);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){

    }];
    [operation start];
    [operation waitUntilFinished];
}
//获取用户管辖门店
+ (void)GetUserStoreWithUserID:(NSString *)userID withBlock:(void (^)(id result, NSError *error))block failedBlock:(void (^)(id result, NSError *error))failedBlock
{
    
    NSString *soapBody = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                          "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                          "<soap:Body>"
                          "<GetUserStore xmlns=\"http://tempuri.org/\">"
                          "<userid>%@</userid>"
                          "</GetUserStore>"
                          "</soap:Body>"
                          "</soap:Envelope>",userID
                          ];
    NSLog(@"%@",soapBody);
    NSString *baseApiURL = [NSString stringWithFormat:SERVERS_COMPANY,SERVERS_IP];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseApiURL]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapBody dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"http://tempuri.org/GetUserStore" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    request.timeoutInterval = 30.0f;
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString * resultStr = [XMLHelper GetUserStore:operation.responseString];
//         NSLog(@"resultStr-->>%@",resultStr);
        block(resultStr,nil);
       
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        
    }];
    [operation start];
    [operation waitUntilFinished];
}
//获取工作计划
+ (void)GetWorkPlanWithUserID:(NSString *)userID andStartdate:(NSString *)startdate andEndate:(NSString *)endate andLastdate:(NSString *)lastdate withBlock:(void (^)(id result, NSError *error))block failedBlock:(void (^)(id result, NSError *error))failedBlock
{
    
    NSString *soapBody = [NSString stringWithFormat:
                         @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                          "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                          "<soap:Body>"
                          "<GetWorkPlan xmlns=\"http://tempuri.org/\">"
                          "<userId>%@</userId>"
                          "<startdate>%@</startdate>"
                          "<endate>%@</endate>"
                          "<lastdate>%@</lastdate>"
                          "</GetWorkPlan>"
                          "</soap:Body>"
                          "</soap:Envelope>",userID,startdate,endate,lastdate
                          ];
    NSLog(@"planUrl--->>%@",soapBody);
    NSString *baseApiURL = [NSString stringWithFormat:SERVERS_COMPANY,SERVERS_IP];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseApiURL]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapBody dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"http://tempuri.org/GetWorkPlan" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    request.timeoutInterval = 30.0f;
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString * resultStr = [XMLHelper GetWorkPlan:operation.responseString];
        
        block(resultStr,nil);
        NSLog(@"%@",resultStr);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        
    }];
    [operation start];
    [operation waitUntilFinished];
}
+(void)test
{

    
    NSString *soapBody = [NSString stringWithFormat:@"ess,12333"];
    NSLog(@"soapBody-->>%@",soapBody);
    NSString *baseApiURL = [NSString stringWithFormat:@"http://api.essenceimc.com/12114/12114.aspx"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseApiURL]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapBody dataUsingEncoding:NSUTF8StringEncoding]];
//    [request addValue:@"http://tempuri.org/LoadProjectData" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    request.timeoutInterval = 30.0f;
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        NSString * baseDataJson = [XMLHelper XMLBaseDataWithTheXML:operation.responseString];
//        NSLog(@"baseDataJson%@",baseDataJson);
        
//        NSDictionary * baseDataDic = [baseDataJson objectFromJSONString];
//        //存储基本数据
//        NSLog(@"baseDataDic-->>%@\n",baseDataDic);
//        NSLog(@"%@",responseObject);
        NSString *aString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"aStr-->>\n%@",aString);
        
        
//        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//        NSString *textFile  = [NSString stringWithContentsOfFile:filePath encoding:enc error:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        
    }];
    [operation start];
    [operation waitUntilFinished];
    
    NSURL *urls = [NSURL URLWithString:@"http://api.hudong.com/iphonexml.do?type=focus-c"];
    
    
    
    //第二步，通过URL创建网络请求
    
    NSURLRequest *requestS = [[NSURLRequest alloc]initWithURL:urls cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    //NSURLRequest初始化方法第一个参数：请求访问路径，第二个参数：缓存协议，第三个参数：网络请求超时时间（秒）
    

    
    //第三步，连接服务器
    
    NSData *received = [NSURLConnection sendSynchronousRequest:requestS returningResponse:nil error:nil];
    
    
    
    NSString *str = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    
    
    
//    NSLog(@"%@",str);
    
    
    
    
    
    NSURL *url = [NSURL URLWithString:@"http://api.essenceimc.com/12114/12114.aspx"];
    
    //第二步，创建请求
    
    NSMutableURLRequest *requestT = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    [requestT setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    
    NSString *strs = @"type=focus-c";//设置参数
    
    NSData *data = [strs dataUsingEncoding:NSUTF8StringEncoding];
    
    [requestT setHTTPBody:data];
    NSData *receiveds = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *retStr = [[NSString alloc] initWithData:receiveds encoding:enc];
    
    NSString *str1 = [[NSString alloc]initWithData:receiveds encoding:NSUTF8StringEncoding];
    
    NSLog(@"1-->>%@  \n2--->>%@\n3-->%@",receiveds,str1,retStr);

}
@end
