//
//  PatrolPictureViewController.m
//  Essence
//
//  Created by EssIOS on 15/5/8.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import "PatrolPictureViewController.h"
#import "UICollectionViewWaterfallLayout.h"
#import "CollectionViewCell.h"
#import "keepLocationInfo.h"
#import "KeepSignInInfo.h"
#import "Base64.h"
#import "BMapKit.h"
#import "LoginInfoToll.h"
#define IMAGE_MANAGER [ImageManager shareImageManager]
@interface PatrolPictureViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,CLLocationManagerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateWaterfallLayout,UIAlertViewDelegate>
{
    int                       _row;
    BOOL                      _isFirstLocation;
    NSString                * _selectType;
    UIImageView             * _photoImage;
    NSMutableArray          * _dataArr;
    UICollectionView        * _collection;
    NSMutableDictionary     * _keepInfo;
    UIImagePickerController * _picker;
}
@end

@implementation PatrolPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title      = @"巡店拍照";
    _selectType     = @"imgDoor";
    
    _loMar          = [[CLLocationManager alloc]init];
    _loMar.delegate = self;
    
    _keepInfo       = [NSMutableDictionary dictionary];

    UIBarButtonItem *cameraBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(cameraPc)];
    
    self.navigationItem.rightBarButtonItem = cameraBtn;
    
    _PMBtn.selected = YES;
    [self initView];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    // 隐藏tabbar
    self.tabBarController.tabBar.hidden = YES;
    // 搜索数据库图片信息
    _dataArr = [KeepSignInInfo selectPhotoWithType:_selectType];
    [_collection reloadData];
}

- (void)initView
{
    UICollectionViewWaterfallLayout *layout = [[UICollectionViewWaterfallLayout alloc] init];
    layout.columnCount = 3;
    layout.itemWidth = 100.0f;
    layout.delegate = self;
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 115, width, height-205) collectionViewLayout:layout];
    [_collection registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
    _collection.delegate = self;
    _collection.dataSource = self;
    _collection.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_collection];
    _photoImage = [[UIImageView alloc]init];
    _photoImage.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    
    _photoImage.bounds = CGRectMake(0, 0, 0, 0);
    _photoImage.layer.masksToBounds = YES;
    _photoImage.layer.cornerRadius = 8;
    _photoImage.layer.borderWidth = 2;
    
    _photoImage.layer.borderColor = [UIColor blackColor].CGColor;
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    button.frame = CGRectMake(270, 0, 30, 30);
    [button addTarget:self action:@selector(closePhoto) forControlEvents:UIControlEventTouchUpInside];
    [_photoImage addSubview:button];
    _photoImage.userInteractionEnabled = YES;
    [self.view addSubview:_photoImage];
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    _picker = [[UIImagePickerController alloc] init];//初始化
    _picker.delegate = self;
    _picker.allowsEditing = YES;//设置可编辑
    _picker.sourceType = sourceType;
}
- (void)closePhoto
{
    [UIView animateWithDuration:0.2 animations:^{
        
        _photoImage.bounds = CGRectMake(0, 0, 0, 0);
    } completion:^(BOOL finished) {
        _photoImage.image = nil;
    }];
}
#pragma mark -- 选择拍照的类型
// 排面照
- (IBAction)PMPhoto:(id)sender
{
    _selectType = @"imgDoor";
    _dataArr = [KeepSignInInfo selectPhotoWithType:_selectType];
    [_collection reloadData];
    _PMBtn.selected = YES;
    _XXBtn.selected = NO;
    _HDBtn.selected = NO;
    _JPBtn.selected = NO;
    [self photoDismiss];
}
// 形象照
- (IBAction)XXPhoto:(id)sender
{
    _selectType = @"imgPGimg";
    _dataArr = [KeepSignInInfo selectPhotoWithType:_selectType];
    [_collection reloadData];
    _PMBtn.selected = NO;
    _XXBtn.selected = YES;
    _HDBtn.selected = NO;
    _JPBtn.selected = NO;
    [self photoDismiss];
}
// 互动照
- (IBAction)HDPhoto:(id)sender
{
    _selectType = @"imgPGint";
    _dataArr = [KeepSignInInfo selectPhotoWithType:_selectType];
    [_collection reloadData];
    _PMBtn.selected = NO;
    _XXBtn.selected = NO;
    _HDBtn.selected = YES;
    _JPBtn.selected = NO;
    [self photoDismiss];
}
// 竞品照
- (IBAction)JPPhoto:(id)sender
{
    _selectType = @"imgJP";
    _dataArr = [KeepSignInInfo selectPhotoWithType:_selectType];
    [_collection reloadData];
    _PMBtn.selected = NO;
    _XXBtn.selected = NO;
    _HDBtn.selected = NO;
    _JPBtn.selected = YES;
    [self photoDismiss];
}
#pragma mark -- 调用相机
// 调用相机
- (void)cameraPc
{
    //开启定位
    [_loMar startUpdatingLocation];
    _isFirstLocation = YES;
    
    [self presentViewController:_picker animated:YES completion:^{
        
    }];//进入照相界面
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [picker dismissViewControllerAnimated:YES completion:^{
        NSString * userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
        UIImage * image = [editingInfo objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        
        NSData *data = UIImageJPEGRepresentation(image, 1);
        NSString *resultStr = [NSString stringWithFormat:@"%ld",(unsigned long)data.length];
        
        NSDictionary *  dic = [[editingInfo objectForKey:@"UIImagePickerControllerMediaMetadata"] objectForKey:@"{Exif}"];
        NSString * time = [dic objectForKey:@"DateTimeOriginal"];
//        time = resultStr;
        NSString * imageUrl  =[NSString stringWithFormat:@"%@%@.jpg",time,userID];
        [_loMar stopUpdatingLocation];
        
        NSDictionary * imageDic = @{@"image":image,@"imageurl":imageUrl};
        
        [NSThread detachNewThreadSelector:@selector(useImage: ) toTarget:self withObject:imageDic];
        
        NSString * storeCode = [keepLocationInfo selectStroeCodeWithTheStoreName:_storeCode andProjectName:_projectName];
        NSString * identifier   = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        NSString * imageType = @"JPG";
        
        NSDate * date = [NSDate date];
        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        
        NSString * Createtime = [formatter stringFromDate:date];
        [_keepInfo setValue:_selectType forKey:@"selectType"];
        [_keepInfo setValue:storeCode   forKey:@"storeCode"];
        [_keepInfo setValue:userID      forKey:@"userID"];
        [_keepInfo setValue:identifier  forKey:@"identifier"];
        [_keepInfo setValue:imageType   forKey:@"imageType"];
        [_keepInfo setValue:Createtime  forKey:@"Createtime"];
        [_keepInfo setValue:imageUrl    forKey:@"imageUrl"];
        
//        if ([[LoginInfoToll  locationType] isEqualToString:@"无网络"])
//        {
//            StoreMD * store = [keepLocationInfo selectLocationLastData];
//            [_keepInfo setValue:store.Latitude forKey:@"Latitude"];
//            [_keepInfo setValue:store.Longitude forKey:@"Longitude"];
//            [_keepInfo setValue:store.timeStamo forKey:@"LocationTtime"];
//        }
        if (![_keepInfo valueForKey:@"Longitude"])
        {
            StoreMD * store = [keepLocationInfo selectLocationLastData];
            [_keepInfo setValue:store.Latitude forKey:@"Latitude"];
            [_keepInfo setValue:store.Longitude forKey:@"Longitude"];
            [_keepInfo setValue:store.timeStamo forKey:@"LocationTtime"];
        }
//        if ([_keepInfo valueForKey:@"Longitude"]) {
        [KeepSignInInfo keepPhotoWithDictionary:_keepInfo];
//        }
//        else
//        {
//            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"定位失败,请重新操作" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//        }
        
        _dataArr = [KeepSignInInfo selectPhotoWithType:_selectType];
    }];
}
- (void)useImage:(NSDictionary *)imageDic
{
    UIImage * image = [imageDic objectForKey:@"image"];
    NSString * imageUrl = [imageDic objectForKey:@"imageurl"];
    NSString * writePath = [NSString stringWithFormat:@"%@/Library/%@",NSHomeDirectory(),imageUrl];
    //对图片进行压缩
    CGSize newSize = CGSizeMake(768, 1024);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //照片写入本地存储
    NSData * photoData = UIImageJPEGRepresentation(newImage,1);
    [photoData writeToFile:writePath atomically:NO];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_collection reloadData];
    });
}
#pragma mark --CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if (_isFirstLocation == YES)
    {
        CLLocation *loc = [locations firstObject];
        // 2.取出经纬度
        CLLocationCoordinate2D coordinate = loc.coordinate;
        CLLocationCoordinate2D test = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude);
        NSDictionary *testdic   = BMKConvertBaiduCoorFrom(test, BMK_COORDTYPE_GPS);
        NSString * latitude     = [NSString stringWithBase64EncodedString:[testdic objectForKey:@"y"]];
        NSString * longitude    = [NSString stringWithBase64EncodedString:[testdic objectForKey:@"x"]];
        
        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *timestamo = [formatter stringFromDate:loc.timestamp];
        [_keepInfo setValue:timestamo forKey:@"LocationTtime"];
        [_keepInfo setValue:latitude forKey:@"Latitude"];
        [_keepInfo setValue:longitude forKey:@"Longitude"];
        NSLog(@"_keepInfo-->>%@",_keepInfo);
        _isFirstLocation = NO;
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSString * imageUrl = _dataArr[indexPath.row];
    NSString * writePath = [NSString stringWithFormat:@"%@/Library/%@",NSHomeDirectory(),imageUrl];
    [cell.deleteBtn setImage:[UIImage imageWithContentsOfFile:writePath] forState:UIControlStateNormal];
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(photoEnlarge:) forControlEvents:UIControlEventTouchUpInside];
    UILongPressGestureRecognizer *longPressGR =
    [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                  action:@selector(deletePhoto:)];
    longPressGR.minimumPressDuration = 0.5;
    [cell.deleteBtn addGestureRecognizer:longPressGR];
    return cell;
}

- (void)deletePhoto:(UILongPressGestureRecognizer *)PGR
{
    [self photoDismiss];
    UIButton * deleteBtn = (UIButton *)PGR.view;
    if (PGR.state ==
        UIGestureRecognizerStateBegan) {
        _row = (int)deleteBtn.tag;
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"小贴士" message:@"是否删除当前所选照片?" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        [alert show];
    }
}
- (void)photoEnlarge:(UIButton *)button
{
    [UIView animateWithDuration:0.2 animations:^{
        NSString * imageUrl = _dataArr[button.tag];
        NSString * writePath = [NSString stringWithFormat:@"%@/Library/%@",NSHomeDirectory(),imageUrl];
        _photoImage.image = [UIImage imageWithContentsOfFile:writePath];

        _photoImage.bounds = CGRectMake(0, 0, 300, 300*1024/768);
    }];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [KeepSignInInfo deletePhotoWithUrl:_dataArr[_row] successBlock:^(NSString *result) {
            _dataArr = [KeepSignInInfo selectPhotoWithType:_selectType];
            [_collection reloadData];
        }];
    }
}
#pragma mark - UICollectionViewDelegate
#pragma mark - UICollectionViewDelegateWaterfallLayout

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewWaterfallLayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}
// 返回跟页面
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}
- (NSString *)nowTime
{
    NSDate * date = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    return  [formatter stringFromDate:date];
}
// 图片缩小隐藏
- (void)photoDismiss
{
    [UIView animateWithDuration:0.2 animations:^{
        _photoImage.bounds = CGRectMake(0, 0, 0, 0);
    } completion:^(BOOL finished) {
        _photoImage.image = nil;
    }];
}
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo

{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存到相册失败" ;
    }else{
        msg = @"保存到相册成功" ;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil];
    [alert show];
    
    [UIView animateWithDuration:8 animations:^{
        [alert dismissWithClickedButtonIndex:0 animated:YES];
    }];
}
- (void)backRootVC
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
