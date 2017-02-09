//
//  TableViewCell.h
//  Essence
//
//  Created by EssIOS on 15/5/12.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *signInMD;
@property (weak, nonatomic) IBOutlet UILabel *signInXM;
@property (weak, nonatomic) IBOutlet UILabel *signInTime;
@property (weak, nonatomic) IBOutlet UILabel *goOutMD;
@property (weak, nonatomic) IBOutlet UILabel *goOueXM;
@property (weak, nonatomic) IBOutlet UILabel *goOutTime;
@property (weak, nonatomic) IBOutlet UIButton *signInBtn;
@property (weak, nonatomic) IBOutlet UIButton *goOutBtn;
@property (strong, nonatomic)        NSString *storeCode;

@end
