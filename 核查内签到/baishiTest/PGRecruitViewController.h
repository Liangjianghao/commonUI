//
//  PGRecruitViewController.h
//  Essence
//
//  Created by EssIOS on 15/5/14.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface PGRecruitViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *personIdTF;
@property (weak, nonatomic) IBOutlet UITextField *qqTF;
@property (weak, nonatomic) IBOutlet UITextField *wxTF;
@property (weak, nonatomic) IBOutlet UIButton *header;
@property (weak, nonatomic) IBOutlet UIButton *allPerson;
@property (strong,nonatomic) CLLocationManager*loMar;

@property (strong,nonatomic)         NSString * storeName;
@property (strong,nonatomic)         NSString * projectName;
@end
