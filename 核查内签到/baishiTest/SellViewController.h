//
//  SellViewController.h
//  Essence
//
//  Created by EssIOS on 15/5/14.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SellViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *personIdTF;
@property (weak, nonatomic) IBOutlet UIButton *sellOK;
@property (strong,nonatomic)         NSString * storeName;
@property (strong,nonatomic)         NSString * projectName;
@property (weak, nonatomic) IBOutlet UIButton *sellFailed;

@end
