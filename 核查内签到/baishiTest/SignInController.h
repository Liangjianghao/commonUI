//
//  SignInController.h
//  Essence
//
//  Created by EssIOS on 15/5/8.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface SignInController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)CLLocationManager   * locMgr;
@property (nonatomic,strong)NSString            * signInType;
@end
