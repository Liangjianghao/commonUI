//
//  PGRecruitViewController.m
//  Essence
//
//  Created by EssIOS on 15/5/14.
//  Copyright (c) 2015年 EssIOS. All rights reserved.
//

#import "PGRecruitViewController.h"
#import "MD5Tool.h"
#import "KeepSignInInfo.h"
#import "keepLocationInfo.h"
#define USERID [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]
@interface PGRecruitViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,CLLocationManagerDelegate>
{
    BOOL _isHead;
    NSString * _photoType;
    UIImagePickerController * _picker;
    NSMutableDictionary     * _PGInfo;
    UIAlertView             * _alert;
}
@end

@implementation PGRecruitViewController
- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"PG招募";
    [self initView];
    _PGInfo  =[NSMutableDictionary dictionary];
    _loMar = [[CLLocationManager alloc]init];
    _loMar.delegate = self;
}
- (void)initView
{
    _header.layer.masksToBounds = YES;
    _header.layer.cornerRadius = 8;
    _allPerson.layer.masksToBounds = YES;
    _allPerson.layer.cornerRadius = 8;
    
    _alert = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    
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
// 大头照
- (IBAction)headerTouch:(UIButton *)sender
{
    _isHead = YES;
    _photoType = @"headerPhoto";
    [self presentViewController:_picker animated:YES completion:^{
        
    }];
}
// 全身照
- (IBAction)allPeoson:(UIButton *)sender
{
    _isHead = NO;
    _photoType = @"allPersonPhoto";
    [self presentViewController:_picker animated:YES completion:^{
        
    }];
}
// 判断填写信息是否正确
- (IBAction)certainOK:(UIButton *)sender
{
    
    NSString * storeCode = [keepLocationInfo selectStroeCodeWithTheStoreName:_storeName andProjectName:_projectName];

    NSString * identifier   = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSDate * date = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSString * Createtime = [formatter stringFromDate:date];
    
    if (_nameTF.text.length == 0 || _phoneTF.text.length == 0)
    {
        [_alert setTitle:@"姓名和手机为必填项,请填写完成后提交!"];
        [_alert show];
        return;
    }else if (_phoneTF.text.length != 11)
    {
        [_alert setTitle:@"请输入正确的手机号码!"];
        [_alert show];
        return;
//    }
//    else if (_personIdTF.text.length ==0)
//    {
//        if([MD5Tool checkIdentityCardNo:_personIdTF.text] == NO){
//        [_alert setTitle:@"身份  格式错误!"];
//        [_alert show];
//        return;
//        }
    }else
    {
        [_PGInfo setValue:USERID            forKey:@"userID"];
        [_PGInfo setValue:identifier        forKey:@"identifier"];
        [_PGInfo setValue:Createtime        forKey:@"Createtime"];
        [_PGInfo setValue:_nameTF.text      forKey:@"Name"];
        [_PGInfo setValue:_phoneTF.text     forKey:@"Phone"];
        [_PGInfo setValue:_personIdTF.text  forKey:@"IdCard"];
        [_PGInfo setValue:_qqTF.text        forKey:@"Qq"];
        [_PGInfo setValue:_wxTF.text        forKey:@"Weixin"];

        [_PGInfo setValue:storeCode forKey:@"storeCode"];
//        [KeepSignInInfo keepPGRecruit:_PGInfo withBlock:^(NSString *result) {
//            [_alert setMessage:result];
//            [_alert show];
//            [self.navigationController popToRootViewControllerAnimated:YES];
//        }];
    }
}
// 调用相机
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
         UIImage * image = [editingInfo objectForKey:@"UIImagePickerControllerOriginalImage"];

        
        NSDictionary *  dic = [[editingInfo objectForKey:@"UIImagePickerControllerMediaMetadata"] objectForKey:@"{Exif}"];
        NSString * time = [dic objectForKey:@"DateTimeOriginal"];
        NSString * userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
        NSString * writePath = [NSString stringWithFormat:@"%@/Library/%@%@.jpg",NSHomeDirectory(),time,userID];
        //对图片进行压缩
        CGSize newSize = CGSizeMake(768, 1024);
        UIGraphicsBeginImageContext(newSize);
        [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        if (_isHead == YES)
        {
//            UIImage * image = [dic objectForKey:@"image"];
         
            
            NSString * Headimgpath = [NSString stringWithFormat:@"%@%@.jpg",time,userID];
            NSData * headImageData = UIImageJPEGRepresentation(newImage, 0.3f);
            [headImageData writeToFile:writePath atomically:YES];

//            UIImage * imageC = [UIImage imageWithContentsOfFile:writePath];
            
            [_header setImage:newImage forState:UIControlStateNormal];
            
            [_PGInfo setValue:Headimgpath forKey:@"Headimgpath"];
            
        }else
        {

            NSString * bodyImgPath = [NSString stringWithFormat:@"%@%@.jpg",time,userID];
            NSData * headImageData = UIImageJPEGRepresentation(newImage, 0.3f);
            [headImageData writeToFile:writePath atomically:YES];
            
//            UIImage * image = [UIImage imageWithContentsOfFile:writePath];
            
            [_allPerson setImage:newImage forState:UIControlStateNormal];
            [_PGInfo setValue:bodyImgPath forKey:@"bodyImgPath"];
        }
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
    
 
}
// 键盘消失
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
