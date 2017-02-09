//
//  ljhSingleChooseBtn.h
//  ljhUI
//
//  Created by mac on 17/1/5.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ljhSingleChooseBtn : UIButton
@property(retain,nonatomic) NSArray *baseArr;
@property(retain,nonatomic) NSString *alertTitle;
@property(retain,nonatomic) NSString *alertMessage;

@property (copy,nonatomic)void(^finishBlock)(NSString *selectArr);

- (instancetype)mybuttonwithArr:(NSArray *)arr andTitle:(NSString *)title andMessage:(NSString *)message;
@end
