//
//  LoginInfoToll.m
//  Essence
//
//  Created by EssIOS on 15/5/6.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import "LoginInfoToll.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "FMDB.h"

#import "XMLHelper.h"
#import "MD5Tool.h"
#import "NetWorkTools.h"
#import <Security/Security.h>
#import "KeychainItemWrapper.h"
#import "SSKeychain.h"

#import "LayerVC.h"
#import "keepLocationInfo.h"
#define UserDefaults  [NSUserDefaults standardUserDefaults]
@implementation LoginInfoToll


//存储用户账号密码
static int loginCount = 0;

+ (void)preserveUserInfo:(NSDictionary *)loginResult username:(NSString * )userName password:(NSString *)password MMPSWBtn:(UIButton *)MMPSWbtn
              autoLogbtn:(UIButton *)autoLogbtn  sucessBlock:(void (^)(bool isFirstLog))block failedBlock:(void(^)(bool isFirstLog))failBlick
{
//    NSString * userID = [[loginResult objectForKey:@"UserId"] objectForKey:@"text"];
    
    NSString * userID = [[loginResult objectForKey:@"Data"] objectForKey:@"ID"];
//    if ([userID intValue] == 0){
//        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示:" message:@"账号或密码输入有误,请检查后重新输入!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
//        return;
//    }
//        else
//    {

        NSDate * date = [NSDate date];
        
        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString * newDate = [formatter stringFromDate:date];
        
        NSString * identifier   = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        
        KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"com.ESS.ios.ESS_uuid"
                                        
                                                                           accessGroup:nil];
        
        NSString * keychainkey = [wrapper objectForKey:(__bridge id)kSecAttrAccount];
        [UserDefaults setObject:[self getcarrierName] forKey:@"simcard"];
        [UserDefaults setObject:keychainkey forKey:@"identifier"];
        [UserDefaults setObject:userID forKey:@"userID"];
        [UserDefaults setObject:newDate forKey:@"date"];
        [UserDefaults setObject:userName forKey:@"username"];
        [UserDefaults setObject:password forKey:@"password"];
        [UserDefaults setBool:MMPSWbtn.selected forKey:@"mmpswType"];
        [UserDefaults setBool:autoLogbtn.selected forKey:@"autoLogType"];
        
        
        [UserDefaults synchronize];
        
    [LayerVC showLayerVC];
    
    
        if (![[NSUserDefaults standardUserDefaults]valueForKey:@"isAlreadyLogin"] ) {
            NSLog(@"isAlreadyLogin");
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"首次登陆,请求基础数据..." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
                    [alert show];
            /*
            [NetWorkTools getBaseDataWithUserID:userID nowTime:nil withBlock:^(NSString *result, NSError *error) {
                NSLog(@"%@",result);
                [alert dismissWithClickedButtonIndex:0 animated:YES];
            } failedBlock:^(NSString *result, NSError *error) {
                [alert dismissWithClickedButtonIndex:0 animated:YES];
                NSLog(@"%@",result);
            }];
             */
            NSDictionary *newdic=[NSDictionary dictionaryWithObjectsAndKeys:userID,@"userid",nil];
            
            NSString *newurlAddress=[NSString stringWithFormat:@"http://wxapi.egocomm.cn/Perfetti/service/app.ashx?action=loadstore"];
            [NetWorkTools requestWithAddress:newurlAddress andParameters:newdic withSuccessBlock:^(NSDictionary *result, NSError *error) {
                [alert dismissWithClickedButtonIndex:0 animated:YES];
                
                    [keepLocationInfo keepallStoreDataWithDictionary:result];

            } andFailedBlock:^(NSString *result, NSError *error) {
                [alert dismissWithClickedButtonIndex:0 animated:YES];

            }];
            
            
            NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *path=[paths objectAtIndex:0];
            NSString *Json_path=[path stringByAppendingPathComponent:@"JsonFile.json"];
            //==Json数据
            NSData *data=[NSData dataWithContentsOfFile:Json_path];
            NSError *error;
            //==JsonObject
            NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            
            NSLog(@"array %@",array);
            
            if (array.count!=0)
            {
            
                NSLog(@"无需下载");
            }
            else
            {
                NSString * userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
                
                NSDictionary *newdic2=[NSDictionary dictionaryWithObjectsAndKeys:userID,@"userid",nil];
                
                NSString *newurlAddress2=[NSString stringWithFormat:@"http://wxapi.egocomm.cn/Perfetti/service/app.ashx?action=loadconfig"];
                
                [NetWorkTools requestWithAddress:newurlAddress2 andParameters:newdic2 withSuccessBlock:^(NSDictionary *result, NSError *error) {
                    
                    NSArray * basedataArr=[result objectForKey:@"Data"];
                    
                    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                    NSString *path=[paths objectAtIndex:0];
                    NSString *Json_path=[path stringByAppendingPathComponent:@"JsonFile.json"];
                    //==写入文件
                    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:basedataArr];
                    
                    NSLog(@"%@",[data writeToFile:Json_path atomically:YES] ? @"Succeed":@"Failed");
                    
                } andFailedBlock:^(NSString *result, NSError *error) {
                    
                }];

            }
            
            
           [[NSUserDefaults standardUserDefaults]setValue:@"yes" forKey:@"isAlreadyLogin"];
        }
        else
        {
          
        }
        if (loginCount == 0)
        {
            block(YES);
            loginCount ++;
        }else
        {
            block(NO);
        }
//    }
}

+ (void)keepFirstLogin:(NSMutableDictionary *)firstInfo
{
    [UserDefaults setObject:[firstInfo objectForKey:@"userID"] forKey:@"userID"];
    [UserDefaults setObject:[firstInfo objectForKey:@"speed"] forKey:@"speed"];
    [UserDefaults setObject:[firstInfo objectForKey:@"timestamo"] forKey:@"timestamo"];
    [UserDefaults setObject:[firstInfo objectForKey:@"strSysVers"] forKey:@"strSysVers"];
    [UserDefaults setObject:[firstInfo objectForKey:@"strSysVersion"] forKey:@"strSysVersion"];
    [UserDefaults setObject:[firstInfo objectForKey:@"strModel"] forKey:@"strModel"];
    [UserDefaults setObject:[firstInfo objectForKey:@"verson"] forKey:@"verson"];
    [UserDefaults setObject:[firstInfo objectForKey:@"latitude"] forKey:@"latitude"];
    [UserDefaults setObject:[firstInfo objectForKey:@"longitude"] forKey:@"longitude"];
    [UserDefaults setObject:[firstInfo objectForKey:@"phoneModel"] forKey:@"phoneModel"];
    [UserDefaults setObject:[firstInfo objectForKey:@"strName"] forKey:@"strName"];
    [UserDefaults setObject:[firstInfo objectForKey:@"strSysName"] forKey:@"strSysName"];
    [UserDefaults setObject:[firstInfo objectForKey:@"strLocModel"] forKey:@"strLocModel"];
    [UserDefaults setObject:[firstInfo objectForKey:@"identifier"] forKey:@"identifier"];
    [UserDefaults setObject:[firstInfo objectForKey:@"networkType"] forKey:@"networkType"];
    
    //今天刚打开
    if ([firstInfo objectForKey:@"carrierName"] == [NSNull null])
    {
        [UserDefaults setObject:[firstInfo objectForKey:@"null"] forKey:@"carrierName"];
    }else
    {
        [UserDefaults setObject:[firstInfo objectForKey:@"carrierName"] forKey:@"carrierName"];
    }
    [UserDefaults setObject:[firstInfo objectForKey:@"batteryLevel"] forKey:@"batteryLevel"];
    
}

// 获取网络状态
+ (NSString *)networktype{
    NSArray *subviews = [[[[UIApplication sharedApplication] valueForKey:@"statusBar"] valueForKey:@"foregroundView"]subviews];
    NSNumber *dataNetworkItemView = nil;
    
    for (id subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataNetworkItemView = subview;
            break;
        }
    }
    switch ([[dataNetworkItemView valueForKey:@"dataNetworkType"]integerValue]) {
        case 0:
            return @"No";
            break;
            
        case 1:
            return @"2G";
            break;
            
        case 2:
            return @"3G";
            break;
            
        case 3:
            return @"4G";
            break;
            
        case 4:
            return @"LTE";
            break;
            
        case 5:
            return @"Wifi";
            break;
        default:
            break;
    }
    return nil;
}
+(NSString *)getcarrierName{
    
    CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
    
    NSString *currentCountry=[carrier carrierName];
    return currentCountry;
}
+ (NSString *)locationType
{
    if (([CLLocationManager locationServicesEnabled]) && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)) {

    return @"GPS定位";
    } else {
        if ([[self networktype]isEqualToString:@"No"])
        {
            return @"无网络";
        }
        if ([[self networktype]isEqualToString:@"2G"])
        {
            return @"2G";
        }
        if ([[self networktype]isEqualToString:@"3G"])
        {
            return @"3G";
        }
        if ([[self networktype]isEqualToString:@"4G"])
        {
            return @"4G";
        }
        if ([[self networktype]isEqualToString:@"LTE"])
        {
            return @"LTE";
        }
        if ([[self networktype]isEqualToString:@"Wifi"])
        {
            return @"Wifi定位";
        }
    }
    return nil;
}

@end
