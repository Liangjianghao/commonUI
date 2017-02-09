//
//  LoginController.h
//  Essence
//
//  Created by EssIOS on 15/5/6.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface LoginController : UIViewController<CLLocationManagerDelegate>
{
    BOOL _isFirstLogin;
}
@property (weak, nonatomic) IBOutlet UIImageView *bgLogoView;
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton   *MMPSWbtn;
@property (weak, nonatomic) IBOutlet UIButton   *autoLogBtn;
@property (nonatomic,strong)CLLocationManager   * locMgr;
@property (nonatomic,strong)NSMutableDictionary * locationInfo;
@end
