//
//  XMLHelper.m
//  Essence
//
//  Created by EssIOS on 15/5/8.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import "XMLHelper.h"
#import "JSONKit.h"
@implementation XMLHelper
+ (NSDictionary * )loginXmlChangeJsonStr:(NSString *)xmlString
{
    NSError * error = nil;
    
    NSDictionary * dic = [XMLReader dictionaryForXMLString:xmlString error:&error];
    
    NSDictionary * soapEnvelope = [dic objectForKey:@"soap:Envelope"];
    
    NSDictionary * soapBody = [soapEnvelope objectForKey:@"soap:Body"];
    
    NSDictionary * LoginResponse = [soapBody objectForKey:@"LoginResponse"];
    
    NSDictionary * LoginResult = [LoginResponse objectForKey:@"LoginResult"];
    
    NSString * textData = [LoginResult objectForKey:@"text"];
    
    NSDictionary * textDic = [XMLReader dictionaryForXMLString:textData error:&error];
    
    NSDictionary * resultLog = [textDic objectForKey:@"LoginResult"];
    
    return resultLog;
}
+ (BOOL)isFirstUse{
    NSDictionary * bundle = [[NSBundle mainBundle] infoDictionary];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"currnVerson"] == nil)
    {
        NSString * currnVerson = [bundle objectForKey:@"CFBundleShortVersionString"];
        [[NSUserDefaults standardUserDefaults] setObject:currnVerson forKey:@"currnVerson"];
        return YES;
    }
    else
    {
        return NO;
    }
}

//+ (NSString *)XMLBaseDataWithTheXML:(NSString *)baseDataXML
//{
//    
//    NSError * error = nil;
//    
//    NSDictionary * dic = [XMLReader dictionaryForXMLString:baseDataXML error:&error];
//    
//    NSDictionary * soapEnvelope = [dic objectForKey:@"soap:Envelope"];
//    
//    NSDictionary * soapBody = [soapEnvelope objectForKey:@"soap:Body"];
//    
//    NSDictionary * LoadProjectDataResponse = [soapBody objectForKey:@"LoadProjectData3Response"];
//    
//    NSDictionary * LoadProjectDataResult = [LoadProjectDataResponse objectForKey:@"LoadProjectData3Result"];
//    
//    NSString * textData = [LoadProjectDataResult objectForKey:@"text"];
//    
//    NSDictionary * textDic = [XMLReader dictionaryForXMLString:textData error:&error];
//    NSData * data = [NSJSONSerialization dataWithJSONObject:textDic options:NSJSONWritingPrettyPrinted error:&error];
//    
//    NSString * json = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//   
//
//    return json;
//}
+ (NSString *)XMLBaseDataWithTheXML:(NSString *)baseDataXML
{
    
    NSError * error = nil;
    
    NSDictionary * dic = [XMLReader dictionaryForXMLString:baseDataXML error:&error];
    
    NSDictionary * soapEnvelope = [dic objectForKey:@"soap:Envelope"];
    
    NSDictionary * soapBody = [soapEnvelope objectForKey:@"soap:Body"];
    
    NSDictionary * LoadProjectDataResponse = [soapBody objectForKey:@"LoadProjectData4Response"];
    
    NSDictionary * LoadProjectDataResult = [LoadProjectDataResponse objectForKey:@"LoadProjectData4Result"];
    
    NSString * textData = [LoadProjectDataResult objectForKey:@"text"];
    
    if ([textData isEqualToString:@"0"]) {
        return @"0";
    }
    else
    {
        NSDictionary * textDic = [XMLReader dictionaryForXMLString:textData error:&error];
        NSData * data = [NSJSONSerialization dataWithJSONObject:textDic options:NSJSONWritingPrettyPrinted error:&error];
        
        NSString * json = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        
        
        return json;
    }
}
+ (NSString *)XMLUpDataWithTheXML:(NSString *)upDataXML
{
    NSError * error = nil;
    NSDictionary * dic = [XMLReader dictionaryForXMLString:upDataXML error:&error];
    
    NSDictionary * soapEnvelope = [dic objectForKey:@"soap:Envelope"];
    
    NSDictionary * soapBody = [soapEnvelope objectForKey:@"soap:Body"];
    
    NSDictionary * LoadProjectDataResponse = [soapBody objectForKey:@"LoadProjectData4Response"];
    
    NSDictionary * LoadProjectDataResult = [LoadProjectDataResponse objectForKey:@"LoadProjectData4Result"];
    
    NSString * textData = [LoadProjectDataResult objectForKey:@"text"];
    if (![textData isEqualToString:@"0"])
    {
        NSDictionary * textDic = [XMLReader dictionaryForXMLString:textData error:&error];
        NSData * data = [NSJSONSerialization dataWithJSONObject:textDic options:NSJSONWritingPrettyPrinted error:&error];
        
        NSString * json = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        return json;
    }
    else
    {
        return textData;
    }
}


//+ (NSString *)XMLBasecompanyWithTheXML:(NSString *)companyXML
//{
//    NSError * error = nil;
//    
//    NSDictionary *dic = [XMLReader dictionaryForXMLString:companyXML error:&error];
//    
//    NSDictionary *soapEnvelope = [dic  objectForKey:@"soap:Envelope"];
//    
//    NSDictionary *soapBody = [soapEnvelope objectForKey:@"soap:Body"];
//    
//    NSDictionary *getCompanysResponse = [soapBody objectForKey:@"GetCompanysResponse"];
//    
//    NSDictionary *getCompanysResult = [getCompanysResponse objectForKey:@"GetCompanysResult"];
//    
//    NSString *textData = [getCompanysResult objectForKey:@"text"];
//    
//    NSDictionary *textDic = [XMLReader dictionaryForXMLString:textData error:&error];
//    
//    NSLog(@"%@",textDic);
//    
//    
//    NSData *data = [NSJSONSerialization dataWithJSONObject:textDic options:NSJSONWritingPrettyPrinted error:&error];
//    
//    NSString *json = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    
//    return json;
//
//}
+ (NSString *)XMLBasecompanyWithTheXML:(NSString *)companyXML
{
    NSError * error = nil;
    
    NSDictionary *dic = [XMLReader dictionaryForXMLString:companyXML error:&error];
    
    NSDictionary *soapEnvelope = [dic  objectForKey:@"soap:Envelope"];
    
    NSDictionary *soapBody = [soapEnvelope objectForKey:@"soap:Body"];
    
    NSDictionary *getCompanysResponse = [soapBody objectForKey:@"GetCompanysResponse"];
    
    NSDictionary *getCompanysResult = [getCompanysResponse objectForKey:@"GetCompanysResult"];
    
    NSString *textData = [getCompanysResult objectForKey:@"text"];
    
    NSDictionary *textDic = [XMLReader dictionaryForXMLString:textData error:&error];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:textDic options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *json = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    return json;
    
}
+(NSDictionary *)XMLUpCompanyWithTheXML:(NSString *)UpcompanyXML
{
    NSError *error = nil;
    
    NSDictionary * dic = [XMLReader dictionaryForXMLString:UpcompanyXML error:&error];
    
    NSDictionary * soapEnveloope = [dic objectForKey:@"soap:Envelope"];
    
    NSDictionary * soapBody = [soapEnveloope objectForKey:@"soap:Body"];
    
    NSDictionary * getCompanyResponse = [soapBody objectForKey:@"GetCompanysResponse"];
    
    NSDictionary * getCompanyResult = [getCompanyResponse objectForKey:@"GetCompanysResult"];
    
    NSString * textData = [getCompanyResult objectForKey:@"text"];
    NSLog(@"%@",textData);
    NSLog(@"%@",[textData class]);

    NSError *err;
    NSData *jsonData = [textData dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];

        return dic1;

}
//处理用户是否制定计划 xml转json
+(NSString *)CanEditWorkPlanWithXML:(NSString *)UpcompanyXML
{
    NSError *error = nil;
    
    NSDictionary * dic = [XMLReader dictionaryForXMLString:UpcompanyXML error:&error];
    
    NSDictionary * soapEnveloope = [dic objectForKey:@"soap:Envelope"];
    
    NSDictionary * soapBody = [soapEnveloope objectForKey:@"soap:Body"];
    
    NSDictionary * getCompanyResponse = [soapBody objectForKey:@"CanEditWorkPlanResponse"];
    
    NSDictionary * getCompanyResult = [getCompanyResponse objectForKey:@"CanEditWorkPlanResult"];
    
    NSString * textData = [getCompanyResult objectForKey:@"text"];
    NSLog(@"%@",textData);
    NSLog(@"%@",[textData class]);
    
    return  textData;

    
}
//获取用户管辖的门店
+(NSString *)GetUserStore:(NSString *)UpcompanyXML
{
    NSError *error = nil;
    
    NSDictionary * dic = [XMLReader dictionaryForXMLString:UpcompanyXML error:&error];
    
    NSDictionary * soapEnveloope = [dic objectForKey:@"soap:Envelope"];
    
    NSDictionary * soapBody = [soapEnveloope objectForKey:@"soap:Body"];
    
    NSDictionary * getCompanyResponse = [soapBody objectForKey:@"GetUserStoreResponse"];
    
    NSDictionary * getCompanyResult = [getCompanyResponse objectForKey:@"GetUserStoreResult"];
    
    NSString * textData = [getCompanyResult objectForKey:@"text"];
//    NSLog(@"textData-->%@",textData);
    NSLog(@"%@",[textData class]);
    
    return  textData;
    
    
}
//获取工作计划
+(NSString *)GetWorkPlan:(NSString *)UpcompanyXML
{
    NSError *error = nil;
    
    NSDictionary * dic = [XMLReader dictionaryForXMLString:UpcompanyXML error:&error];
    
    NSDictionary * soapEnveloope = [dic objectForKey:@"soap:Envelope"];
    
    NSDictionary * soapBody = [soapEnveloope objectForKey:@"soap:Body"];
    
    NSDictionary * getCompanyResponse = [soapBody objectForKey:@"GetWorkPlanResponse"];
    
    NSDictionary * getCompanyResult = [getCompanyResponse objectForKey:@"GetWorkPlanResult"];
    
    NSString * textData = [getCompanyResult objectForKey:@"text"];
    NSLog(@"%@",textData);
    NSLog(@"%@",[textData class]);
    
    return  textData;
    
    
}

@end
