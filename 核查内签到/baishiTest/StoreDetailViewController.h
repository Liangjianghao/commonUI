//
//  StoreDetailViewController.h
//  baishiTest
//
//  Created by EssIOS on 15/12/25.
//  Copyright © 2015年 ljh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreDetailViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *StoreName;
@property (weak, nonatomic) IBOutlet UILabel *ProjectName;
@property (weak, nonatomic) IBOutlet UIButton *areaBtn;

@property (weak, nonatomic) IBOutlet UIButton *posisionBtn;

@property (weak, nonatomic) IBOutlet UIButton *POSMBtn;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (retain, nonatomic) IBOutlet UISegmentedControl *seg;
@property (weak, nonatomic) IBOutlet UITextField *areaTF;

@property(nonatomic,nonatomic)NSString *store;

@property (strong,nonatomic) NSString  *storeCode;
@property (strong,nonatomic) NSString  *project;
@property (weak, nonatomic) IBOutlet UISegmentedControl *seg2;

@end
