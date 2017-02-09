//
//  ProductModel.m
//  baishiTest
//
//  Created by EssIOS on 15/12/27.
//  Copyright © 2015年 ljh. All rights reserved.
//
#import <objc/runtime.h>
#import "ProductModel.h"

@implementation ProductModel
+(void)setValue:(NSString *)key
{

    unsigned int propertyCount = 0;
    
    objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
    
    for (unsigned int i = 0; i < propertyCount; ++i) {
        objc_property_t property = properties[i];
        const char * Cname = property_getName(property);//获取属性名字
        //        const char * attributes = property_getAttributes(property);//获取属性类型
        NSString *name = [NSString stringWithCString:Cname encoding:NSUTF8StringEncoding];
        
        if ([key isEqualToString:name]) {
            
        }
        
    }
}
@end
