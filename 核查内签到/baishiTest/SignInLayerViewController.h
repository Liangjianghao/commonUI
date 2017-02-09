//
//  SignInLayerViewController.h
//  Essence
//
//  Created by EssIOS on 15/7/21.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface SignInLayerViewController : UIViewController<UIAlertViewDelegate>
- (IBAction)patrol:(UIButton *)sender;
- (IBAction)company:(UIButton *)sender;
- (IBAction)project:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITableView *SigInTableView;
@property (nonatomic,strong)NSString            * signInType;
@property (nonatomic,strong)CLLocationManager   * locMgr;
@property (nonatomic,copy)NSString *Name;
@property (nonatomic,copy)NSString *ProjectName;
-(void)setWithArr:(NSString *)arr;

@end
