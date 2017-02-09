//
//  SelectMDController.h
//  Essence
//
//  Created by EssIOS on 15/5/11.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//
typedef void(^selectStoreName)(id);
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SelectMDController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray* dataArray;
@property (nonatomic,strong)NSMutableArray * resultArr;
@property (nonatomic,strong)NSMutableArray * planArr;
@property (nonatomic,strong)NSMutableArray * MyShopArr;
@property (nonatomic,copy) selectStoreName selectStoreNameBlock;
@property (strong,nonatomic)         NSDictionary * loctionDic;
@property (nonatomic,strong)CLLocationManager   * locMgr;
@property (strong, nonatomic) NSMutableArray    *searchArray;
@end
