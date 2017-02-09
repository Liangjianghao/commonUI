//
//  SigInLayerCell.h
//  Essence
//
//  Created by EssIOS on 15/7/28.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SigInLayerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *goOutMD;
@property (weak, nonatomic) IBOutlet UILabel *goOueXM;
@property (weak, nonatomic) IBOutlet UILabel *goOutTime;
@property (weak, nonatomic) IBOutlet UIButton *goOutBtn;
@property (weak, nonatomic) IBOutlet UILabel *signInMD;
@property (weak, nonatomic) IBOutlet UILabel *signInXM;
@property (weak, nonatomic) IBOutlet UILabel *signInTime;
@property (weak, nonatomic) IBOutlet UIButton *signInBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;

@property (strong, nonatomic)        NSString *storeCode;

@end
