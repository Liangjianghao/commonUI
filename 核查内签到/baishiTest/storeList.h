//
//  programList.h
//  ljhUI
//
//  Created by mac on 17/1/18.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"
@interface storeList : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)NSArray *baseDataArr;

@property(nonatomic,retain)NSString  *projectID;

@property (strong,nonatomic)ProductModel *model;

@end
