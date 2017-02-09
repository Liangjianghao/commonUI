//
//  StoreDetailViewController.m
//  baishiTest
//
//  Created by EssIOS on 15/12/25.
//  Copyright © 2015年 ljh. All rights reserved.
//

#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width

#define IS_IPHONE4 (([[UIScreen mainScreen] bounds].size.height == 480) ? YES : NO)
#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height == 568) ? YES : NO)
#define IS_IPhone6 (667 == [[UIScreen mainScreen] bounds].size.height ? YES : NO)
#define IS_IPhone6plus (736 == [[UIScreen mainScreen] bounds].size.height ? YES : NO)

#define USER_ID [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]
#import "StoreDetailViewController.h"
#import "ProductViewController.h"
#import "KeepSignInInfo.h"
#import "ProductModel.h"
#import "keepLocationInfo.h"
#import "KeepSignInInfo.h"
@interface StoreDetailViewController ()
{
    UIPickerView *pickers;
    NSMutableArray *pickerArray;
    NSMutableArray * _projectNames;
    NSMutableArray * _projectSchedules;
    BOOL _isWho;
    NSMutableDictionary *dataDic;
    NSString *Position;
    NSString *POSM;
    NSMutableArray *dataArr;
    UIScrollView *otherScrollVC;
    
        NSString                * _selectType;
        NSMutableDictionary     * _keepInfo;
    UIScrollView *smallScr;
    NSMutableDictionary *MDdic;
}
@end

@implementation StoreDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _StoreName.text=_store;
    _ProjectName.text=_project;
    
    dataArr=[[NSMutableArray alloc]init];
    _selectType=@"imgDoor";
    //    dataArr = [KeepSignInInfo selectPhotoWithType:_selectType];
    NSDictionary *dics=[keepLocationInfo selectCodeWithTheStoreName:_StoreName.text andProjectName:_ProjectName.text];
//    NSLog(@"dic-->>%@",dics);
    NSString *code=[dics objectForKey:@"code"];
    MDdic=[[NSMutableDictionary alloc]init];
    
    dataArr=[KeepSignInInfo selectPhotoWithType:_selectType andId:code];
//    MDdic=[KeepSignInInfo selectMDDetailTable:code];
    ProductModel *mdModel=[KeepSignInInfo selectMDDetailTable:code];
//    NSLog(@"mdModel%@",mdModel);
    [self uiConfig];
    
    pickerArray=[[NSMutableArray alloc]init];
    pickerArray = [[NSMutableArray alloc]initWithObjects:@"入口年货区",@"主通道",@"跨品类区域",@"其他",nil];
    _projectNames =[[NSMutableArray alloc]init];
    _projectSchedules=[[NSMutableArray alloc]init];
    
    _projectNames=[NSMutableArray arrayWithObjects:@"乐事通用主题",@"春节猴脸包主题",@"无乐事画面", nil];
    _projectSchedules=[NSMutableArray arrayWithObjects:@"入口年货区",@"主通道",@"跨品类区域",@"其他", nil];
//    pickers=[[UIPickerView alloc]init];
//    pickers.frame=CGRectMake(0, 420, 320, 100);
        pickers   = [[UIPickerView alloc]initWithFrame:CGRectMake(0, HEIGHT-180,WIDTH, 200)];
    pickers.dataSource=self;
    pickers.delegate=self;
    pickers.showsSelectionIndicator = YES;
    pickers.backgroundColor=[UIColor grayColor];
//    pickers.hidden=YES;
//    [self.view addSubview:pickers];
    _keepInfo =[[NSMutableDictionary alloc]init];
    
    [_areaTF setBorderStyle:UITextBorderStyleRoundedRect];
    _areaTF.delegate=self;
    _areaTF.keyboardType=UIKeyboardTypeDecimalPad;
    _areaTF.placeholder=@"平方米";
    if (mdModel.Area) {
        _areaTF.text=mdModel.Area;
//        _areaTF.placeholder=nil;
    }
//    _areaTF.secureTextEntry=YES;
    [self.view addSubview:_areaTF];
    if (mdModel.Position) {
           [_posisionBtn setTitle:[NSString stringWithFormat:@"%@",mdModel.Position] forState:UIControlStateNormal];
            Position=[NSString stringWithFormat:@"%@",mdModel.Position];
    }
    else{
    [_posisionBtn setTitle:[NSString stringWithFormat:@"%@",_projectSchedules[0]] forState:UIControlStateNormal];
            Position=[NSString stringWithFormat:@"%@",_projectSchedules[0]];
    }
    if (mdModel.Position) {
        [_POSMBtn setTitle:[NSString stringWithFormat:@"%@",mdModel.POSM] forState:UIControlStateNormal];
            POSM=[NSString stringWithFormat:@"%@",mdModel.POSM];
    }
    else{
        [_POSMBtn setTitle:[NSString stringWithFormat:@"%@",_projectNames[0]] forState:UIControlStateNormal];
            POSM=[NSString stringWithFormat:@"%@",_projectNames[0]];
    }
//    [_POSMBtn setTitle:[NSString stringWithFormat:@"%@",_projectNames[0]] forState:UIControlStateNormal];


    dataDic =[[NSMutableDictionary alloc]init];
    
    
//    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"有",@"无",nil];
//    //初始化UISegmentedControl
//    _seg= [[UISegmentedControl alloc]initWithItems:segmentedArray];
    [_seg setTitle:@"有" forSegmentAtIndex:0];
    [_seg setTitle:@"无" forSegmentAtIndex:1];
        _seg.selectedSegmentIndex=0;
    
    if ([mdModel.DiDui isEqualToString:@"0"]) {
        
        _seg.selectedSegmentIndex=1;
    }
  
    
    [_seg addTarget:self action:@selector(didClicksegmentedControlAction:) forControlEvents:UIControlEventValueChanged];
    
    [_seg2 setTitle:@"正常" forSegmentAtIndex:0];
    [_seg2 setTitle:@"关店" forSegmentAtIndex:1];
        _seg2.selectedSegmentIndex=0;
    if ([mdModel.MDstate isEqualToString:@"关店"]) {
        _seg2.selectedSegmentIndex=1;
    }
   
    [_seg2 addTarget:self action:@selector(didClicksegmentedControlAction:) forControlEvents:UIControlEventValueChanged];
//    dataArr=[[NSMutableArray alloc]init];
//    dataArr = [KeepSignInInfo selectPhotoWithType:@"store"];
//    [self uiConfig];
 
 
    
}
-(void)uiConfig
{
    [smallScr removeFromSuperview];
    smallScr=[[UIScrollView alloc]init];
    if (IS_IPHONE4) {
    smallScr.frame=CGRectMake(15, 335, 305, 90);
    }
    else if (IS_IPHONE5)
    {
        smallScr.frame=CGRectMake(15, 400, 305, 90);
    }
    else
    {
    smallScr.frame=CGRectMake(15, 400, 305, 90);
    }
    
    
    //                smallScr.backgroundColor=[UIColor grayColor];
    smallScr.contentSize=CGSizeMake(90 *dataArr.count+80, 90);
    [self.view addSubview:smallScr];
    UIButton *Photobtn=[UIButton buttonWithType:UIButtonTypeCustom];
    Photobtn.frame=CGRectMake(0, 0, 80, 80);
    //        [Photobtn setTitle:@"拍照" forState:UIControlStateNormal];
    //        [Photobtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [Photobtn setBackgroundImage:[UIImage imageNamed:@"photo"] forState:UIControlStateNormal];
    //        [Photobtn setBackgroundColor:[UIColor redColor]];
    [Photobtn addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [smallScr addSubview:Photobtn];
    for (int j=0; j<dataArr.count; j++) {
        
        
        
        UIImageView *imgV=[[UIImageView alloc]init];
        imgV.frame=CGRectMake(80+90*j, 0, 80, 80);
        
        [imgV setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/Library/%@.jpg",NSHomeDirectory(),dataArr[j]]]];
//        imgV.backgroundColor=[UIColor redColor];
        //            imgV.backgroundColor=[UIColor grayColor];
        UITapGestureRecognizer *longPress=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toDetail:)];
        [imgV addGestureRecognizer:longPress];
        imgV.userInteractionEnabled=YES;
        [smallScr addSubview:imgV];
        
    }
    

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
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
 
//    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:@"1",@"userID", @"2",@"storeCode", @"3",@"selectType", @"4",@"imageType", @"5",@"identifier",@"123",@"ProductCount",  @"23",@"ProductTest" @"11",@"ProductPrice", @"344",@"ProductAcreage",@"text1" ,@"text",@"text2" ,@"text",@"text3", @"text",@"text4",@"text",@"text5",@"text",@"text6", @"text",@"text7", @"text",@"text8", @"text",@"text9" ,@"text",@"text10" , nil];
//    [KeepSignInInfo keepDetailWithDictionary:dic];
    [picker dismissViewControllerAnimated:YES completion:^{
        NSString * userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
        UIImage * image = [editingInfo objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        
        NSData *data = UIImageJPEGRepresentation(image, 1);
//        NSString *resultStr = [NSString stringWithFormat:@"%ld",(unsigned long)data.length];
        
        NSDictionary *  dic = [[editingInfo objectForKey:@"UIImagePickerControllerMediaMetadata"] objectForKey:@"{Exif}"];
        NSString * time = [dic objectForKey:@"DateTimeOriginal"];
        //        time = resultStr;
        NSString * imageUrl  =[NSString stringWithFormat:@"%@%@.jpg",time,userID];
        //        [_loMar stopUpdatingLocation];
        
        NSDictionary * imageDic = @{@"image":image,@"imageurl":imageUrl};
        
//        [NSThread detachNewThreadSelector:@selector(useImage:) toTarget:self withObject:imageDic];
        [self useImage:imageDic];
        
        NSString * storeCode = [keepLocationInfo selectStroeCodeWithTheStoreName:_storeCode andProjectName:_project];
        NSString * identifier   = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        NSString * imageType = @"JPG";
        
        NSDate * date = [NSDate date];
        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        
        NSDictionary *dics=[keepLocationInfo selectCodeWithTheStoreName:_StoreName.text andProjectName:_ProjectName.text];
//        NSLog(@"dic-->>%@",dics);
        NSString *code=[dics objectForKey:@"code"];
        
        NSString * Createtime = [formatter stringFromDate:date];
        _keepInfo=[[NSMutableDictionary alloc]init];
        [_keepInfo setValue:@"imgDoor" forKey:@"selectType"];
//        [_keepInfo setValue:storeCode   forKey:@"storeCode"];
                [_keepInfo setValue:code   forKey:@"storeCode"];
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
        
        //        _dataArr = [KeepSignInInfo selectPhotoWithType:_selectType];
        dataArr=[KeepSignInInfo selectPhotoWithType:_selectType andId:code];
        [self uiConfig];
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
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_areaTF resignFirstResponder];
    [pickers removeFromSuperview];
//    [UIView animateWithDuration:0.5 animations:^{
//        
//        pickers.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 200) ;
//    }];
}
-(void)viewWillAppear:(BOOL)animated
{
//    dataArr=[[NSMutableArray alloc]init];
//    _selectType=@"imgDoor";
////    dataArr = [KeepSignInInfo selectPhotoWithType:_selectType];
//    NSDictionary *dics=[keepLocationInfo selectCodeWithTheStoreName:_StoreName.text andProjectName:_ProjectName.text];
//    NSLog(@"dic-->>%@",dics);
//    NSString *code=[dics objectForKey:@"code"];
//
//        dataArr=[KeepSignInInfo selectPhotoWithType:_selectType andId:code];
//        [self uiConfig];
    
}
-(void)toDetail:(UITapGestureRecognizer *)tap
{
    self.tabBarController.tabBar.hidden = YES;
    otherScrollVC=[[UIScrollView alloc]init];
    otherScrollVC.frame=CGRectMake(0, 104, 320, 464);
    otherScrollVC.contentSize=CGSizeMake(320*dataArr.count, 400);
    NSLog(@"count-->>%lu",(unsigned long)dataArr.count);
    otherScrollVC.pagingEnabled=YES;
    for (int i=0; i<dataArr.count; i++) {
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
        //        [imgV addSubview:typeLab];
        imgV.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/Library/%@.jpg",NSHomeDirectory(),dataArr[i]]];
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
-(void)didClicksegmentedControlAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    NSLog(@"Index %i", Index);
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)area:(id)sender {
    
}
- (IBAction)position:(id)sender {
    _isWho=NO;
    [pickers reloadAllComponents];
//    [UIView animateWithDuration:0.5 animations:^{
//        pickers.frame = CGRectMake(0, self.view.frame.size.height-180, self.view.frame.size.width, 180) ;
//    }];
        [self.view addSubview:pickers];
//    pickers.hidden=NO;
}
- (IBAction)POSM:(id)sender {
    _isWho=YES;
    [pickers reloadAllComponents];
//    [UIView animateWithDuration:0.5 animations:^{
//        pickers.frame = CGRectMake(0, self.view.frame.size.height-180, self.view.frame.size.width, 180) ;
//    }];
        [self.view addSubview:pickers];
//    pickers.hidden=NO;
}

- (IBAction)confirm:(id)sender {
    ProductViewController *productVC=[[ProductViewController alloc]init];
    
    productVC.StoreName=_StoreName.text;
    productVC.projectName=_ProjectName.text;
    NSLog(@"USER_ID-->>%@",USER_ID);
    NSString *didui;
    NSString *state;
    if (!_seg.selectedSegmentIndex) {
        didui=@"1";
        if ([_areaTF.text isEqualToString:@""]) {
            UIAlertView * alertView= [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请添加地推面积" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            
            [alertView show];
            return;
            //                _areaTF.text=@"0";
        }else
        {
            
        }
    }
    else
    {
    didui=@"0";
    }
    
    if (!_seg2.selectedSegmentIndex) {
        state=@"正常";
    }
    else
    {
        state=@"关店";
    }
 
    ProductModel *productM=[[ProductModel alloc]init];
    productM.userID=USER_ID;
    productM.DiDui=didui;
    productM.Area=_areaTF.text;
    productM.Position=Position;
    productM.POSM=POSM;
    productM.CreateUserId=USER_ID;
    productM.CreateDate=[self nowTime];
    
    dataDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:USER_ID,@"userID",didui,@"DiDui",_areaTF.text,@"Area",Position,@"Position",POSM,@"POSM", nil];
//    NSLog(@"%@",dataDic);
//     NSString * storeCode = [keepLocationInfo selectStroeCodeWithTheStoreName:_StoreName.text andProjectName:_ProjectName.text];
//    [KeepSignInInfo keepStoreWithTheDictionary:dataDic];
    NSDictionary *dic=[keepLocationInfo selectCodeWithTheStoreName:_StoreName.text andProjectName:_ProjectName.text];
    NSLog(@"dic-->>%@",dic);
    productM.Code=[dic objectForKey:@"code"];
    productM.StoreId=[dic objectForKey:@"storeCode"];
    productM.ProjectId=[dic objectForKey:@"projectCode"];
    productM.MDstate=state;
    productVC.model=productM;
    ProductModel *model=  [KeepSignInInfo selectMDDetailTable:[dic objectForKey:@"code"]];
    if (model.Code) {
        NSLog(@"存在,更新");
        [KeepSignInInfo updataMDWithTheDictionary:productM];
    }
    else
    {
        NSLog(@"不存在,创建");
        [KeepSignInInfo keepMDWithTheDictionary:productM];
    }
    
    [self.navigationController pushViewController:productVC animated:YES];
}
- (NSString *)nowTime
{
    NSDate * date = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    return  [formatter stringFromDate:date];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   
        [UIView animateWithDuration:5 animations:^{
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        }];
}
#pragma mark -- UIPickerViewDataSource ,UIPickerViewDelegate
// picker选择结束
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (_isWho == YES)
    {
        return _projectNames[row];
    }else
    {
        return _projectSchedules[row];
    }
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (_isWho == YES)
    {
        return _projectNames.count;
    }else
    {
        return _projectSchedules.count;
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (_isWho == NO)
    {
//        _ProjectNameLB.text  = _projectName[row];
        [_posisionBtn setTitle:_projectSchedules[row] forState:UIControlStateNormal];
        
//        NSMutableArray * arr = [keepLocationInfo selectDQWithTheStoreName:_StoreNameLB.text andProjectName:_projectName[row]];
//        [_projectSchedule removeAllObjects];
//        for (StoreMD * store in arr)
//        {
//            [_projectSchedule addObject:store.Name];
//            _ProjectScheduleLB.text = store.Name;
//        }
        Position=_projectSchedules[row];
    }else
    {
//        _ProjectScheduleLB.text     = _projectSchedule[row];
          [_POSMBtn setTitle:_projectNames[row] forState:UIControlStateNormal];
        POSM=_projectNames[row];
    }
}
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [UIView animateWithDuration:0.5 animations:^{
//        
//        pickers.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 180) ;
//    }];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
