//
//  ProjectViewController.h
//  baishiTest
//
//  Created by EssIOS on 15/12/18.
//  Copyright © 2015年 ljh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableDictionary * locationInfo;
@end
