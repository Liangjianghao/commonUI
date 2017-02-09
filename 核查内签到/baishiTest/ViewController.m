//
//  ViewController.m
//  baishiTest
//
//  Created by EssIOS on 15/12/16.
//  Copyright © 2015年 ljh. All rights reserved.
//

#import "ViewController.h"
#import "KeepSignInInfo.h"

#import "StoreMD.h"
#import "keepLocationInfo.h"
@interface ViewController ()
{
    NSMutableArray *dataArr;
    
    NSMutableArray *photoArr;
    int                       _row;
    BOOL                      _isFirstLocation;
    NSString                * _selectType;
    UIImageView             * _photoImage;
    NSMutableArray          * _dataArr;
    UICollectionView        * _collection;
    NSMutableDictionary     * _keepInfo;
    UIImagePickerController * _picker;
    UIView *v;
    
    NSMutableArray *pickerArray;
    UIPickerView *pickers;
    
    UIScrollView *scrollVC;
    UIScrollView *bigScro;
    NSMutableArray *typeArr;
    UIScrollView *otherScrollVC;
    NSMutableArray *choiceArr;
    UIButton *cbtn;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _dataArr=[[NSMutableArray alloc]init];
    _dataArr = [KeepSignInInfo selectPhotoWithType:_selectType];
    
    choiceArr=[[NSMutableArray alloc]init];
    
    typeArr=[[NSMutableArray alloc]init];
    typeArr=[NSMutableArray arrayWithObjects:@"排面照",@"堆头照",@"竞品照",@"其他", nil];
   

    pickerArray=[[NSMutableArray alloc]init];
    pickerArray = [[NSMutableArray alloc]initWithObjects:@"全部",@"2015-12-10",@"2015-12-12",@"2015-12-15",@"2015-12-17",nil];
    //    pickerArray = [[NSMutableArray alloc]initWithObjects:@"项目一",@"项目二",@"项目三",@"项目四",nil];
    pickers=[[UIPickerView alloc]init];
    pickers.frame=CGRectMake(0, 420, 320, 100);
    pickers.dataSource=self;
    pickers.delegate=self;
    pickers.showsSelectionIndicator = YES;
    pickers.backgroundColor=[UIColor lightGrayColor];
    
    bigScro=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0 , 320, 568)];
    bigScro.delegate=self;
    bigScro.backgroundColor=[UIColor whiteColor];
    bigScro.delegate=self;
    bigScro.contentSize=CGSizeMake(320*5, 400);
    bigScro.pagingEnabled=YES;
//    [self.view addSubview:bigScro];
//    [self uiConfig];
    self.title=_StoreName;
    
    
}
-(void)uiConfig
{
    scrollVC=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, 320, 568)];
    scrollVC.delegate=self;
    scrollVC.backgroundColor=[UIColor whiteColor];
    scrollVC.contentSize=CGSizeMake(320*4, 0);
    scrollVC.pagingEnabled=YES;

//    scrollVC.alwaysBounceVertical=YES;
//    scrollVC.directionalLockEnabled=YES;
    scrollVC.scrollsToTop=NO;
//    scrollVC.scrollEnabled=NO;
    [self.view addSubview:scrollVC];
    
    for (int i=0; i<4; i++) {
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(100+320*i, 0, 120, 40);
        //        [btn setTitle:@"竞品照" forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@"%@",typeArr[i]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(changeType:) forControlEvents:UIControlEventTouchUpInside];
        [scrollVC addSubview:btn];
        
        UIScrollView *smallScr=[[UIScrollView alloc]init];
        smallScr.frame=CGRectMake(15+320*i, 60, 305, 90);
//                smallScr.backgroundColor=[UIColor grayColor];
        smallScr.contentSize=CGSizeMake(90 *_dataArr.count+80, 90);
        [scrollVC addSubview:smallScr];
        
        UILabel *nameLabel=[[UILabel alloc]init];
        nameLabel.frame=CGRectMake(10+320*i, 160, 80, 40);
        nameLabel.text=[NSString stringWithFormat:@"姓名:"];
        //    nameLabel.textAlignment=NSTextAlignmentCenter;
        [scrollVC addSubview:nameLabel];
        
        UITextField *nameTextField=[[UITextField alloc]init];
        nameTextField.frame=CGRectMake(90+320*i, 160, 220, 40);
        [nameTextField setBorderStyle:UITextBorderStyleRoundedRect];
        nameTextField.delegate=self;
        nameTextField.tag=1001;
        [scrollVC addSubview:nameTextField];
        
        UILabel *phoneLabel=[[UILabel alloc]init];
        phoneLabel.frame=CGRectMake(10+320*i, 210, 80, 40);
        phoneLabel.text=[NSString stringWithFormat:@"多选一"];
        //    phoneLabel.textAlignment=NSTextAlignmentCenter;
        [scrollVC addSubview:phoneLabel];
        
//        UITextField *phoneTextField=[[UITextField alloc]init];
//        phoneTextField.frame=CGRectMake(90+320*i, 210, 220, 40);
//        phoneTextField.delegate=self;
//        phoneTextField.tag=1002;
//        [phoneTextField setBorderStyle:UITextBorderStyleRoundedRect];
//        [scrollVC addSubview:phoneTextField];
        
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",nil];
        
        UISegmentedControl *segmentCtr=[[UISegmentedControl alloc]initWithItems:segmentedArray];
        segmentCtr.frame=CGRectMake(100+320*i, 210, 200, 40);
        [scrollVC addSubview:segmentCtr];
        
        UILabel *IDLabel=[[UILabel alloc]init];
        IDLabel.frame=CGRectMake(10+320*i, 260,80,40);
        IDLabel.text=[NSString stringWithFormat:@"多选:"];
        //    label.textAlignment=NSTextAlignmentCenter;
        [scrollVC addSubview:IDLabel];
        
//        UITextField *IDTextField=[[UITextField alloc]init];
//        IDTextField.frame=CGRectMake(90+320*i,260, 220, 40);
//        IDTextField.delegate=self;
//        IDTextField.tag=1003;
//        [IDTextField setBorderStyle:UITextBorderStyleRoundedRect];
//        [scrollVC addSubview:IDTextField];
        
        cbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        cbtn.frame=CGRectMake(100+320*i, 260, 80, 40);
        [cbtn setTitle:@"choose" forState:UIControlStateNormal];
        [cbtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [cbtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [scrollVC addSubview:cbtn];
        
    
        UILabel *sexLabel=[[UILabel alloc]init];
        sexLabel.frame=CGRectMake(10+320*i, 310, 80, 40);
        sexLabel.text=[NSString stringWithFormat:@"性别:"];
        //    sexLabel.textAlignment=NSTextAlignmentCenter;
        [scrollVC addSubview:sexLabel];
        
//        UITextField *sexTextField=[[UITextField alloc]init];
//        sexTextField.frame=CGRectMake(90+320*i, 310, 70, 40);
//        sexTextField.delegate=self;
//        sexTextField.tag=1004;
//        sexTextField.placeholder=[NSString stringWithFormat:@"女"];
//        [sexTextField setBorderStyle:UITextBorderStyleRoundedRect];
//        [scrollVC addSubview:sexTextField];
        
        NSArray *sexSegmentedArray = [[NSArray alloc]initWithObjects:@"男",@"女",nil];
        
        UISegmentedControl *sexSegmentCtr=[[UISegmentedControl alloc]initWithItems:sexSegmentedArray];
        sexSegmentCtr.frame=CGRectMake(90+320*i, 310, 70, 40);
        [scrollVC addSubview:sexSegmentCtr];
        
        
        UITextView *textV=[[UITextView alloc]init];
        textV.frame=CGRectMake(10+320*i, 360, 300, 100);
        textV.text=@"情况介绍:\n1:...\n2:..\n3:..\n4:..";
        [scrollVC addSubview:textV];
        
        UIButton *Photobtn=[UIButton buttonWithType:UIButtonTypeCustom];
        Photobtn.frame=CGRectMake(0, 0, 80, 80);
//        [Photobtn setTitle:@"拍照" forState:UIControlStateNormal];
//        [Photobtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [Photobtn setBackgroundImage:[UIImage imageNamed:@"a"] forState:UIControlStateNormal];
//        [Photobtn setBackgroundColor:[UIColor redColor]];
        [Photobtn addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
        [smallScr addSubview:Photobtn];
            for (int j=0; j<_dataArr.count; j++) {
             
                
                
                UIImageView *imgV=[[UIImageView alloc]init];
                imgV.frame=CGRectMake(80+90*j, 0, 80, 80);
                [imgV setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/Library/%@.jpg",NSHomeDirectory(),_dataArr[j]]]];
                //            imgV.backgroundColor=[UIColor grayColor];
                UITapGestureRecognizer *longPress=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toDetail:)];
                [imgV addGestureRecognizer:longPress];
                imgV.userInteractionEnabled=YES;
                [smallScr addSubview:imgV];
                
            }
  
        
        
     
        
        
    }

}
-(void)btnClick:(UIButton *)btn
{


}
-(void)Update
{
    
    [cbtn setTitle:@"choice" forState:UIControlStateNormal];
    UILabel *label=[[UILabel alloc]init];
    label.frame=CGRectMake(180, 260, 140, 40);
    label.text=[NSString stringWithFormat:@"%@",choiceArr];
    label.text=@"shenme ";
    //    label.textAlignment=NSTextAlignmentCenter;
    label.backgroundColor=[UIColor grayColor];
    [scrollVC addSubview:label];
}
-(void)viewWillAppear:(BOOL)animated
{
    _dataArr=[[NSMutableArray alloc]init];
    _dataArr = [KeepSignInInfo selectPhotoWithType:_selectType];
    [self uiConfig];
}
-(void)toDetail:(UITapGestureRecognizer *)tap
{
//    self.tabBarController.tabBar.hidden = YES;
    otherScrollVC=[[UIScrollView alloc]init];
    otherScrollVC.frame=CGRectMake(0, 104, 320, 464);
    otherScrollVC.contentSize=CGSizeMake(320*_dataArr.count, 400);
    NSLog(@"count-->>%lu",(unsigned long)_dataArr.count);
    otherScrollVC.pagingEnabled=YES;
    for (int i=0; i<_dataArr.count; i++) {
        UIImageView *imgV=[[UIImageView alloc]init];
        imgV.frame=CGRectMake(10+320*i, 0, 300, 400);
        [otherScrollVC addSubview:imgV];
        UILabel *label=[[UILabel alloc]init];
        label.frame=CGRectMake( 0, 300, 300, 30);
        label.text=[NSString stringWithFormat:@"大润发昆山店"];
        //    label.textAlignment=NSTextAlignmentCenter;
//        [imgV addSubview:label];
        
        UILabel *Prolabel=[[UILabel alloc]init];
        Prolabel.frame=CGRectMake(0, 330, 300, 30);
        Prolabel.text=[NSString stringWithFormat:@"大波浪店促"];
        //    label.textAlignment=NSTextAlignmentCenter;
//        [imgV addSubview:Prolabel];
        
        UILabel *typeLab=[[UILabel alloc]init];
        typeLab.frame=CGRectMake(0, 360, 300, 30);
        typeLab.text=[NSString stringWithFormat:@"排面照"];
        //    label.textAlignment=NSTextAlignmentCenter;
        [imgV addSubview:typeLab];
        imgV.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/Library/%@.jpg",NSHomeDirectory(),_dataArr[i]]];
        imgV.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss:)];
        [imgV addGestureRecognizer:tap];
        //
        //        UILongPressGestureRecognizer *longTap=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longTap:)];
        //        [imgV addGestureRecognizer:longTap];
        //        _photoImage.bounds = CGRectMake(0, 0, 300, 300*1024/768);
        
    }
    
    
    [UIView animateWithDuration:0.2 animations:^{
        //        [scrollV removeFromSuperview];
        [self.view addSubview:otherScrollVC];
        
    }];
}
-(void)dismiss:(UITapGestureRecognizer *)tap
{
    [otherScrollVC removeFromSuperview];

//    self.tabBarController.tabBar.hidden = NO;
}
-(void)dismissTap:(UITapGestureRecognizer *)tap
{

    [scrollVC removeFromSuperview];
    self.tabBarController.tabBar.hidden = NO;
}
-(void)takePhoto:(UIButton *)btn
{
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
    
//    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate=self;
    imagePicker.allowsEditing=YES;

        [self presentViewController:imagePicker animated:YES completion:^{
            
        }];


}
-(void)changeType:(UIButton *)btn
{

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"切换照片类型" message:nil preferredStyle: UIAlertControllerStyleActionSheet];
    
    //    UIAlertAction *pailAction = [UIAlertAction actionWithTitle:@"排面照" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *pailAction = [UIAlertAction actionWithTitle:@"排面照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [scrollVC setContentOffset:CGPointMake(320*0, 0) animated:YES];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"堆头照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
             [scrollVC setContentOffset:CGPointMake(320*1, 0) animated:YES];
    }];
    
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"竞品照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               [scrollVC setContentOffset:CGPointMake(320*2, 0) animated:YES];
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"其他" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [scrollVC setContentOffset:CGPointMake(320*3, 0) animated:YES];
    }];

    [alertController addAction:pailAction];
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [alertController addAction:archiveAction];
    [alertController addAction:otherAction];
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
//    
//    NSDate *date = [NSDate date];
//    
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    
//    NSInteger interval = [zone secondsFromGMTForDate: date];
//    
//    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
//    
//    NSLog(@"%@", localeDate);
//    
//
//    UIImage *imageNew = [info objectForKey:UIImagePickerControllerOriginalImage];
//    UIImageWriteToSavedPhotosAlbum(imageNew, nil, nil, nil);
//    int  a;
//    a=arc4random()%10+20;
//    NSString *aStr=[NSString stringWithFormat:@"%d",a];
//    _keepInfo=[[NSMutableDictionary alloc]init];
//    [_keepInfo setValue:aStr forKey:@"selectType"];
//    [KeepSignInInfo keepPhotoWithDictionary:_keepInfo];
//    NSString * imageUrl  =[NSString stringWithFormat:@"%@.jpg",aStr];
//    NSDictionary * imageDic = @{@"image":imageNew,@"imageurl":imageUrl};
//    
//    [NSThread detachNewThreadSelector:@selector(useImage: ) toTarget:self withObject:imageDic];
//    _dataArr = [KeepSignInInfo selectPhotoWithType:_selectType];
//    [picker dismissViewControllerAnimated:YES completion:^{
//        
//    }];
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"1",@"userID", @"2",@"storeCode", @"3",@"selectType", @"4",@"imageType", @"5",@"identifier",@"123",@"ProductCount",  @"23",@"ProductTest" @"11",@"ProductPrice", @"344",@"ProductAcreage",@"text1" ,@"text",@"text2" ,@"text",@"text3", @"text",@"text4",@"text",@"text5",@"text",@"text6", @"text",@"text7", @"text",@"text8", @"text",@"text9" ,@"text",@"text10" , nil];
//    [KeepSignInInfo keepDetailWithDictionary:dic];
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
//        [_loMar stopUpdatingLocation];
        
        NSDictionary * imageDic = @{@"image":image,@"imageurl":imageUrl};
        
        [NSThread detachNewThreadSelector:@selector(useImage: ) toTarget:self withObject:imageDic];
        
        NSString * storeCode = [keepLocationInfo selectStroeCodeWithTheStoreName:_storeCode andProjectName:_projectName];
        NSString * identifier   = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        NSString * imageType = @"JPG";
        
        NSDate * date = [NSDate date];
        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        
        NSString * Createtime = [formatter stringFromDate:date];
        _keepInfo=[[NSMutableDictionary alloc]init];
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
//        if (![_keepInfo valueForKey:@"Longitude"])
//        {
            StoreMD * store = [keepLocationInfo selectLocationLastData];
            [_keepInfo setValue:store.Latitude forKey:@"Latitude"];
            [_keepInfo setValue:store.Longitude forKey:@"Longitude"];
            [_keepInfo setValue:store.timeStamo forKey:@"LocationTtime"];
//        }
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
