//
//  PatrolPictureViewController.h
//  Essence
//
//  Created by EssIOS on 15/5/8.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface PatrolPictureViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *PMBtn;
@property (weak, nonatomic) IBOutlet UIButton *XXBtn;
@property (weak, nonatomic) IBOutlet UIButton *HDBtn;
@property (weak, nonatomic) IBOutlet UIButton *JPBtn;
@property (strong,nonatomic) CLLocationManager*loMar;
@property (strong,nonatomic) NSString         *storeCode;
@property (strong,nonatomic) NSString         *projectName;
@end
