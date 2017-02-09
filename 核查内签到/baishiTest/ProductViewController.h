//
//  ProductViewController.h
//  baishiTest
//
//  Created by EssIOS on 15/12/25.
//  Copyright © 2015年 ljh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"
@interface ProductViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate>
@property(nonatomic,retain)NSString *StoreName;

@property (strong,nonatomic) NSString         *storeCode;
@property (strong,nonatomic) NSString         *projectName;
@property (strong,nonatomic)ProductModel *model;
@end
