;//
//  UpDataServer.m
//  Essence
//
//  Created by EssIOS on 15/5/21.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import "UpDataServer.h"
#import "Base64.h"
#define SERVERS_IP  @"http://pm.essenceimc.com"
#define SERVER_INTERFACES  @"%@/Service/android/User.asmx"
#import "PhotoModel.h"
#import "PGRecruitModel.h"

@implementation UpDataServer
+ (void)UpSignInXML:(NSString *)xmlPath  andUpDataType:(NSString *)DataType successBlock:(void (^)(NSString *result))successblock failedBlock:(void (^)(NSString *result))failedBlock
{
    NSData *data=[[NSData alloc]init];
    data=[NSData dataWithContentsOfFile:xmlPath];
    NSString *content=[[NSString alloc ]initWithData:data  encoding:NSUTF8StringEncoding ];
    NSLog(@"%@",content);
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                             "<soap:Body>"
                             "<%@ xmlns=\"http://tempuri.org/\">"
                             "<xml><![CDATA[%@]]></xml>"
                             "</%@>"
                             "</soap:Body>"
                             "</soap:Envelope>",DataType,content,DataType];
    NSString *baseApiURL = @"http://pm.essenceimc.com/Service/android/User.asmx";
    NSLog(@"卖进soap-->>  %@",soapMessage);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseApiURL]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString * UpDataType = [NSString stringWithFormat:@"http://tempuri.org/%@",DataType];
    [request setValue:UpDataType forHTTPHeaderField:@"SOAPAction"];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request] ;
    
    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id XML) {
        NSString *result = operation.responseString;
        successblock(result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
        failedBlock(error.localizedDescription);
    }];
    [operation start];
}
+ (void)updataLocXML:(NSString *)uid andLogType:(NSString *)logType andLogDate:(NSString *)logDate andLogContent:(NSString *)logContent successBlock:(void (^)(NSString *result))successblock failedBlock:(void (^)(NSString *result))failedBlock
{
    NSData *data=[[NSData alloc]init];
    data=[NSData dataWithContentsOfFile:logContent];
    NSString *content=[[NSString alloc ]initWithData:data  encoding:NSUTF8StringEncoding ];
    NSLog(@"content-->>%@",content);
    NSString *soapMsg = [NSString stringWithFormat:
                                         @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                                         "<soap:Envelope "
                                         "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                                         "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
                                         "xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                         "<soap:Body>"
                                         "<UploadLog xmlns=\"http://tempuri.org/\">"
                                         "<userId><![CDATA[%@]]></userId>"
                                         "<logType><![CDATA[%@]]></logType>"
                                         "<logDate><![CDATA[%@]]></logDate>"
                                         "<logTxt><![CDATA[%@]]></logTxt>"
                                         "</UploadLog>"
                                         "</soap:Body>"
                                         "</soap:Envelope>", uid, logType,logDate,content];
    NSLog(@"上传定位日志-->>%@",soapMsg);
    NSString *baseApiURL = @"http://pm.essenceimc.com/Service/android/User.asmx";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseApiURL]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:@"http://tempuri.org/UploadLog" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request] ;
    
    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        successblock(operation.responseString);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failedBlock(error.localizedDescription);
    }];
    
    [operation start];
}
+ (void)updateZhaoMuXML:(NSString *)xmlPath andDataArr:(NSArray *)arr successBlock:(void (^)(NSString *result))successblock failedBlock:(void (^)(NSString *result))failedBlock
{
    
    NSData *data=[[NSData alloc]init];
    data=[NSData dataWithContentsOfFile:xmlPath];
    NSString *content=[[NSString alloc ]initWithData:data  encoding:NSUTF8StringEncoding ];
    
    NSMutableData * headerData = [NSMutableData data];
    NSMutableData * bodyData  = [NSMutableData data];
    
    for ( PGRecruitModel* pg in arr) {
        NSString * headerPath = [NSString stringWithFormat:@"%@/Library/%@",NSHomeDirectory(),pg.Headimgpath];
        
        UIImage * headerImg = [UIImage imageWithContentsOfFile:headerPath];
        NSData  *headerDa = UIImageJPEGRepresentation(headerImg, 0.7f);
        
        [headerData appendData:headerDa];
        
        NSString * bodyPath = [NSString stringWithFormat:@"%@/Library/%@",NSHomeDirectory(),pg.bodyImgPath];
        
        UIImage * bodyImg = [UIImage imageWithContentsOfFile:bodyPath];
        NSData  *bodyDa = UIImageJPEGRepresentation(bodyImg, 0.7f);
        
        [bodyData appendData:bodyDa];
        
    }
    
    NSString * _encodedImageStr=[headerData base64EncodedStringWithOptions:0];
    
    NSString *_encodedImageStrTwo=[bodyData base64EncodedStringWithOptions:0];
    
    if(_encodedImageStr==nil){
        _encodedImageStr=@"";
    }
    if(_encodedImageStrTwo==nil){
        _encodedImageStrTwo=@"";
    }
    
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                             "<soap:Body>"
                             "<ZhaoMu xmlns=\"http://tempuri.org/\">"
                             "<xml><![CDATA[%@]]></xml>"
                             "<imgHeadStr><![CDATA[%@]]></imgHeadStr>"
                             "<imgBodyStr><![CDATA[%@]]></imgBodyStr>"
                             "</ZhaoMu>"
                             "</soap:Body>"
                             "</soap:Envelope>\n",content,_encodedImageStr,_encodedImageStrTwo
                             ];
    NSLog(@"zhaoMuSoap-->> %@",soapMessage);
    NSString *baseApiURL = [NSString stringWithFormat:SERVER_INTERFACES,SERVERS_IP];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseApiURL]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue:@"http://tempuri.org/ZhaoMu" forHTTPHeaderField:@"SOAPAction"];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request] ;
    
    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id XML) {
        NSString *result = operation.responseString;
        NSLog(@"%@",result);
        successblock(result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
        failedBlock(error.localizedDescription);
    }];
    [operation start];
    
    
}

// 上传巡店拍照
+ (void)updateStoreImgXML:(NSString *)xmlPath andPatrol:(PhotoModel *)photo
                successBlock:(void (^)(NSString *result))successblock failedBlock:(void (^)(NSString *result))failedBlock
{
        NSString * writePath = [NSString stringWithFormat:@"%@/Library/%@",NSHomeDirectory(),photo.imageUrl];
    
        NSData *data=[[NSData alloc]init];
        data=[NSData dataWithContentsOfFile:xmlPath];
        NSString *content=[[NSString alloc ]initWithData:data  encoding:NSUTF8StringEncoding ];
    
        UIImage * image = [UIImage imageWithContentsOfFile:writePath];
        NSLog(@"%@",writePath);
    
        NSData * Imagedata = UIImageJPEGRepresentation(image, 0.5f);
        
        NSString * _encodedImageStr=[Imagedata base64EncodedStringWithOptions:0];

    
        NSString *soapMessage = [NSString stringWithFormat:
                                 @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                                 "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                 "<soap:Body>"
                                 "<UploadStoreImgBase64 xmlns=\"http://tempuri.org/\">"
                                 "<xml><![CDATA[%@]]></xml>"
                                 "<base64Str><![CDATA[%@]]></base64Str>"
                                 "</UploadStoreImgBase64>"
                                 "</soap:Body>"
                                 "</soap:Envelope>",xmlPath,_encodedImageStr
                                 ];
    NSLog(@"photoSoap--->>>%@",soapMessage);
        NSString *baseApiURL = [NSString stringWithFormat:SERVER_INTERFACES,SERVERS_IP];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseApiURL]];
        
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
        [request addValue:@"http://tempuri.org/UploadStoreImgBase64" forHTTPHeaderField:@"SOAPAction"];
        [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request] ;
        
        operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id XML) {
            NSString *result = operation.responseString;
            NSLog(@"上传成功=========%@",result);
            successblock(result);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"上传失败=========%@",error.localizedDescription);
            failedBlock(error.localizedDescription);
        }];
    [operation start];
    [operation waitUntilFinished];
}
//<?xml version="1.0" encoding="utf-8"?>
//<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
//<soap:Body>
//<UploadAttendance xmlns="http://tempuri.org/">
//<jsonStr>string</jsonStr>
//</UploadAttendance>
//</soap:Body>
//</soap:Envelope>
+ (void)UpSignInXML:(NSString *)xmlPath andUpDataType:(NSString *)DataType successBlock:(void (^)(NSString *result))successblock failedBlocks:(void (^)(NSString *result))failedBlocks;
{
    NSData *data = [[NSData alloc]init];
    data = [NSData dataWithContentsOfFile:xmlPath];
    NSString *content = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",content);
    /*
     @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
     "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
     "<soap:Body>"
     "<%@ xmlns=\"http://tempuri.org/\">"
     "<xml><![CDATA[%@]]></xml>"
     "</%@>"
     "</soap:Body>"
     "</soap:Envelope>"
     */
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                             "<soap:Body>"
                             "<%@ xmlns=\"http://tempuri.org/\">"
                             "<jsonStr><![CDATA[%@]]></jsonStr>"
                             "</%@>"
                             "</soap:Body>"
                             "</soap:Envelope>",DataType,content,DataType];
    NSString *url = @"http://pm.essenceimc.com/Service/appwebservice.asmx";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *UpDataType = [NSString stringWithFormat:@"http://tempuri.org/%@",DataType];
    [request setValue:UpDataType forHTTPHeaderField:@"SOAPAction"];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id XML) {
        NSString *result = operation.responseString;
        successblock(result);
        NSLog(@"上传成功=========%@",result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"上传失败=========%@",error.localizedDescription);
        failedBlocks(error.localizedDescription);
    }];
    [operation start];
}

/*
 <?xml version="1.0" encoding="utf-8"?>
 <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
 <soap:Body>
 <UploadXunDianPlan xmlns="http://tempuri.org/">
 <xml>string</xml>
 </UploadXunDianPlan>
 </soap:Body>
 </soap:Envelope>
 */
+ (void)UpPatrolXML:(NSString *)xmlPath  andUpDataType:(NSString *)DataType successBlock:(void (^)(NSString *result))successblock failedBlock:(void (^)(NSString *result))failedBlock
{
    NSData *data = [[NSData alloc]init];
    data = [NSData dataWithContentsOfFile:xmlPath];
    NSString *content = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",content);
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                             "<soap:Body>"
                             "<%@ xmlns=\"http://tempuri.org/\">"
                             "<xml><![CDATA[%@]]></xml>"
                             "</%@>"
                             "</soap:Body>"
                             "</soap:Envelope>",DataType,content,DataType];
    NSLog(@"soapMessage-->%@",soapMessage);
    NSString *url = @"http://pm.essenceimc.com/Service/appwebservice.asmx";
//        NSString *url = @"http://pm.essenceimc.com/service/android/user.asmx";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *UpDataType = [NSString stringWithFormat:@"http://tempuri.org/%@",DataType];
    [request setValue:UpDataType forHTTPHeaderField:@"SOAPAction"];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id XML) {
        NSString *result = operation.responseString;
        successblock(result);
        NSLog(@"上传成功=========%@",result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"上传失败=========%@",error.localizedDescription);
        failedBlock(error.localizedDescription);
    }];
    [operation start];
}
@end
