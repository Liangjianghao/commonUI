//
//  SelectShopViewController.h
//  Essence
//
//  Created by EssIOS on 15/5/8.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//
typedef void(^signInBlock)(id,id,id);
#import <UIKit/UIKit.h>

@interface SelectShopViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *StoreNameLB;
@property (weak, nonatomic) IBOutlet UILabel *ProjectNameLB;
@property (weak, nonatomic) IBOutlet UILabel *ProjectScheduleLB;
@property (weak, nonatomic) IBOutlet UIButton *selectXM;
@property (weak, nonatomic) IBOutlet UIButton *selectDQ;
@property (copy, nonatomic) signInBlock signBlock;
@property (weak, nonatomic) IBOutlet UILabel *hideDQ;
@property (weak, nonatomic) IBOutlet UIButton *hideDqLab;
@property (weak, nonatomic) IBOutlet UIButton *locationDq;
@property (assign,nonatomic) int isQDOrPZ;
@end
