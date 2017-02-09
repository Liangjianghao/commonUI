//
//  ProductDetailViewController.h
//  baishiTest
//
//  Created by EssIOS on 15/12/27.
//  Copyright © 2015年 ljh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailViewController : UIViewController<UIScrollViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
@property(nonatomic,retain)NSString *StoreName;

@property (strong,nonatomic) NSString         *storeCode;
@property (strong,nonatomic) NSString         *projectName;
@property (strong,nonatomic)ProductModel *model;
@property (strong,nonatomic)NSArray *smellArr;
@property (strong,nonatomic) NSString         *productName;
@end

