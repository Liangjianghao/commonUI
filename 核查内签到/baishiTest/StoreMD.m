//
//  StoreMD.m
//  Essence
//
//  Created by EssIOS on 15/5/11.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import "StoreMD.h"

@implementation StoreMD
- (id)initWithDataDictionary:(NSDictionary *)dataDic
{
    self = [super init];
    if (self) {
        
        _Longitude = [[dataDic objectForKey:@"Longitude"] objectForKey:@"text"]==nil ? [NSNull null]:[[dataDic objectForKey:@"Longitude"] objectForKey:@"text"];
        
        _Latitude = [[dataDic objectForKey:@"Latitude"] objectForKey:@"text"]  ==nil ? [NSNull null]:[[dataDic objectForKey:@"Latitude"] objectForKey:@"text"];
        
        _StoreId = [[dataDic objectForKey:@"StoreId"] objectForKey:@"text"]    ==nil ? [NSNull null]:[[dataDic objectForKey:@"StoreId"] objectForKey:@"text"];
        
        _StoreName = [[dataDic objectForKey:@"StoreName"] objectForKey:@"text"]==nil ? [NSNull null]:[[dataDic objectForKey:@"StoreName"] objectForKey:@"text"];
        
        _Code = [[dataDic objectForKey:@"Code"] objectForKey:@"text"]          ==nil ? [NSNull null]:[[dataDic objectForKey:@"Code"] objectForKey:@"text"];
        
        _text = [dataDic objectForKey:@"text"]          ==nil ? [NSNull null]:[dataDic objectForKey:@"text"];
        
    }
    return self;
}


+ (id)StoreMDWithDictionary:(NSDictionary *)dataDic;
{
    return [[self alloc]initWithDataDictionary:dataDic];
}
@end
