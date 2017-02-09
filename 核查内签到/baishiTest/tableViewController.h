//
//  tableViewController.h
//  ljhUI
//
//  Created by mac on 17/1/9.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"
@interface tableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)NSArray *baseDataArr;

@property (strong,nonatomic)ProductModel *model;

@property(nonatomic,retain)NSString  *projectID;
@property(nonatomic,retain)NSString  *storeID;

@end
