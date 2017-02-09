//
//  ShopLocationController.h
//  Essence
//
//  Created by EssIOS on 15/5/15.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface ShopLocationController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate,CLLocationManagerDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) NSArray           *resultArray;
@property (nonatomic, retain) NSMutableArray    *indexArray;
@property (strong, nonatomic) NSMutableArray    *array;
@property (strong, nonatomic) NSMutableArray    *searchArray;
@property (strong, nonatomic) CLLocationManager * locMgr;
@property (strong, nonatomic) NSMutableDictionary * loctionDic;
@property (nonatomic, retain) NSMutableArray    *LetterResultArr;
//设置每个section下的cell内容

- (id)initWithArr:(NSMutableArray *)arr;
@end
