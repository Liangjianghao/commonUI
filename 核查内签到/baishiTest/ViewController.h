//
//  ViewController.h
//  baishiTest
//
//  Created by EssIOS on 15/12/16.
//  Copyright © 2015年 ljh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIScrollViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>

//@property(nonatomic,retain)NSString *ProjectName;
@property(nonatomic,retain)NSString *StoreName;

@property (strong,nonatomic) NSString         *storeCode;
@property (strong,nonatomic) NSString         *projectName;
@end

