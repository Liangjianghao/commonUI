//
//  ProductDetailViewController.m
//  baishiTest
//
//  Created by EssIOS on 15/12/27.
//  Copyright © 2015年 ljh. All rights reserved.
//

#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width

#import "KeepSignInInfo.h"
#import "StoreMD.h"
#import "keepLocationInfo.h"
#import "ProductDetailViewController.h"
#import "KeepSignInInfo.h"
@interface ProductDetailViewController ()
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
    
    NSMutableArray *selectedArr;
    NSString *smellStr;
    
    UITextField *priceTextField;
    UITextField *areaTextField;
    UITextField *nameTextField;
    UIScrollView *smallScr;
    BOOL issaved;
}
@end

@implementation ProductDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    _dataArr=[[NSMutableArray alloc]init];
//    _dataArr = [KeepSignInInfo selectPhotoWithType:_selectType];
    
    choiceArr=[[NSMutableArray alloc]init];
    
    typeArr=[[NSMutableArray alloc]init];
    typeArr=[NSMutableArray arrayWithObjects:@"排面照",@"堆头照",@"竞品照",@"其他", nil];
    
    selectedArr=[[NSMutableArray alloc]init];
    
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
    _selectType=_productName;
    dataArr=[[NSMutableArray alloc]init];
//    _dataArr=[KeepSignInInfo selectPhotoWithType:_selectType andId:_model.Code];
    dataArr=[KeepSignInInfo selectPhotoWithType:_selectType andId:_model.Code];

    [self uiConfig];
    UILabel *nameLabel=[[UILabel alloc]init];
    nameLabel.frame=CGRectMake(10, 60, 120, 40);
    nameLabel.text=[NSString stringWithFormat:@"产品名:"];
    //    nameLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:nameLabel];
    
    nameTextField=[[UITextField alloc]init];
    nameTextField.frame=CGRectMake(120, 60, WIDTH-120, 40);
    [nameTextField setBorderStyle:UITextBorderStyleRoundedRect];
    nameTextField.delegate=self;
    nameTextField.tag=1001;
    nameTextField.userInteractionEnabled=NO;
    //        [self.view addSubview:nameTextField];
    
    UILabel *nameLabel2=[[UILabel alloc]init];
    nameLabel2.frame=CGRectMake(120, 60, WIDTH-120, 40);
    nameLabel2.text=[NSString stringWithFormat:@"%@",_productName];
    //    nameLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:nameLabel2];
    
    UILabel *phoneLabel=[[UILabel alloc]init];
    phoneLabel.frame=CGRectMake(10, 110, 80, 40);
    phoneLabel.text=[NSString stringWithFormat:@""];
    //    phoneLabel.textAlignment=NSTextAlignmentCenter;
    //        [self.view addSubview:phoneLabel];
    
    //        UITextField *phoneTextField=[[UITextField alloc]init];
    //        phoneTextField.frame=CGRectMake(90+320*i, 210, 220, 40);
    //        phoneTextField.delegate=self;
    //        phoneTextField.tag=1002;
    //        [phoneTextField setBorderStyle:UITextBorderStyleRoundedRect];
    //        [scrollVC addSubview:phoneTextField];
    
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",nil];
    
    UISegmentedControl *segmentCtr=[[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentCtr.frame=CGRectMake(100, 110, 200, 40);
    //        [self.view addSubview:segmentCtr];
    
    UILabel *IDLabel=[[UILabel alloc]init];
    IDLabel.frame=CGRectMake(10, 110,160,40);
    IDLabel.text=[NSString stringWithFormat:@"产品口味:"];
    //    label.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:IDLabel];
    
    //        UITextField *IDTextField=[[UITextField alloc]init];
    //        IDTextField.frame=CGRectMake(90+320*i,260, 220, 40);
    //        IDTextField.delegate=self;
    //        IDTextField.tag=1003;
    //        [IDTextField setBorderStyle:UITextBorderStyleRoundedRect];
    //        [scrollVC addSubview:IDTextField];
    
//    ProductModel *oneModel=[KeepSignInInfo selectOneProductDetailTable:_model.ProductId];
    ProductModel *oneModel=[KeepSignInInfo selectOneProductDetailTable:_model.Code andProCode:_model.ProductId];
    
    cbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    cbtn.frame=CGRectMake(120, 110, 200, 40);
    [cbtn setTitle:@"选择口味" forState:UIControlStateNormal];
//    cbtn.backgroundColor=[UIColor grayColor];
//    if (oneModel.ProductSmell&&oneModel.ProductSmell.length!=0) {
//        NSLog(@"length1-->%@",[oneModel.ProductSmell class]);
//        NSLog(@"length2-->%hhd",[[oneModel.ProductSmell class] isSubclassOfClass:[NSNull null]]);
//        if ([[oneModel.ProductSmell class] isSubclassOfClass:[NSNull null]]) {
//            NSLog(@"123");
//        }
//        [cbtn setTitle:oneModel.ProductSmell forState:UIControlStateNormal];
//    }
    if (oneModel.ProductSmell) {
        issaved=YES;
        [cbtn setTitle:oneModel.ProductSmell forState:UIControlStateNormal];
        smellStr=oneModel.ProductSmell;
    }
    [cbtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [cbtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cbtn];
    
    UILabel *priceLabel=[[UILabel alloc]init];
    priceLabel.frame=CGRectMake(10, 160, 150, 40);
    priceLabel.text=[NSString stringWithFormat:@"零售价格(元):"];
    //    nameLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:priceLabel];
    
    priceTextField=[[UITextField alloc]init];
    priceTextField.frame=CGRectMake(160, 160, WIDTH-160, 40);
    [priceTextField setBorderStyle:UITextBorderStyleRoundedRect];
    priceTextField.delegate=self;
    priceTextField.tag=1002;
    if (oneModel.Price) {
        priceTextField.text=oneModel.Price;
    }
    priceTextField.keyboardType=UIKeyboardTypeDecimalPad;
    [self.view addSubview:priceTextField];
    
    UILabel *areaLabel=[[UILabel alloc]init];
    areaLabel.frame=CGRectMake(10, 210, 150, 40);
    areaLabel.text=[NSString stringWithFormat:@"占地堆面积比(%%):"];
    //    nameLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:areaLabel];
    
    areaTextField=[[UITextField alloc]init];
    areaTextField.frame=CGRectMake(160, 210, WIDTH-160, 40);
    [areaTextField setBorderStyle:UITextBorderStyleRoundedRect];
    areaTextField.delegate=self;
    areaTextField.tag=1003;
    if (oneModel.AreaRatio) {
        areaTextField.text=oneModel.AreaRatio;
    }
    areaTextField.keyboardType=UIKeyboardTypeNumberPad;
    [self.view addSubview:areaTextField];
    
    
    UILabel *sexLabel=[[UILabel alloc]init];
    sexLabel.frame=CGRectMake(10, 310, 80, 40);
    sexLabel.text=[NSString stringWithFormat:@"性别:"];
    //    sexLabel.textAlignment=NSTextAlignmentCenter;
    //        [scrollVC addSubview:sexLabel];
    
    //        UITextField *sexTextField=[[UITextField alloc]init];
    //        sexTextField.frame=CGRectMake(90+320*i, 310, 70, 40);
    //        sexTextField.delegate=self;
    //        sexTextField.tag=1004;
    //        sexTextField.placeholder=[NSString stringWithFormat:@"女"];
    //        [sexTextField setBorderStyle:UITextBorderStyleRoundedRect];
    //        [scrollVC addSubview:sexTextField];
    
    NSArray *sexSegmentedArray = [[NSArray alloc]initWithObjects:@"男",@"女",nil];
    
    UISegmentedControl *sexSegmentCtr=[[UISegmentedControl alloc]initWithItems:sexSegmentedArray];
    sexSegmentCtr.frame=CGRectMake(90, 310, 70, 40);
    //        [self.view addSubview:sexSegmentCtr];
    
    
    UITextView *textV=[[UITextView alloc]init];
    textV.frame=CGRectMake(10, 360, 300, 100);
    textV.text=@"情况介绍:\n1:...\n2:..\n3:..\n4:..";
    //        [self.view addSubview:textV];
    
//    UIButton *Photobtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    Photobtn.frame=CGRectMake(0, 0, 80, 80);
//    //        [Photobtn setTitle:@"拍照" forState:UIControlStateNormal];
//    //                [Photobtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [Photobtn setBackgroundImage:[UIImage imageNamed:@"a"] forState:UIControlStateNormal];
//    //        [Photobtn setBackgroundColor:[UIColor redColor]];
//    [Photobtn addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
//    [smallScr addSubview:Photobtn];
//    for (int j=0; j<_dataArr.count; j++) {
//        
//        
//        
//        UIImageView *imgV=[[UIImageView alloc]init];
//        imgV.frame=CGRectMake(80+90*j, 0, 80, 80);
//        [imgV setImage:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/Library/%@.jpg",NSHomeDirectory(),_dataArr[j]]]];
//        //            imgV.backgroundColor=[UIColor grayColor];
//        UITapGestureRecognizer *longPress=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toDetail:)];
//        [imgV addGestureRecognizer:longPress];
//        imgV.userInteractionEnabled=YES;
//        [smallScr addSubview:imgV];
//        
//    }
    
    UIButton *confirmBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    confirmBtn.frame=CGRectMake(50, HEIGHT-70, WIDTH-100, 40);
    [confirmBtn setTitle:@"保存数据" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [confirmBtn setBackgroundColor:[UIColor grayColor]];
    [confirmBtn addTarget:self action:@selector(confirmBtnbtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0,60, 40);
    //    [btn setTitle:@"title" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    //    [btn setImage:[UIImage imageNamed:@"icon-40"] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:btn];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:btn];


    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [areaTextField resignFirstResponder];
    [priceTextField resignFirstResponder];
}
-(void)uiConfig
{
    [smallScr removeFromSuperview];
    smallScr=[[UIScrollView alloc]init];
//    smallScr.frame=CGRectMake(15, 400, 305, 90);
            smallScr.frame=CGRectMake(15, 260, WIDTH, 90);
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
-(void)uiConfigs
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
//    [self.view addSubview:scrollVC];
    
//    for (int i=0; i<4; i++) {
        [smallScr removeFromSuperview];
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(100, 0, 120, 40);
        //        [btn setTitle:@"竞品照" forState:UIControlStateNormal];
//        [btn setTitle:[NSString stringWithFormat:@"%@",typeArr[i]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(changeType:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:btn];
    
        smallScr=[[UIScrollView alloc]init];
        smallScr.frame=CGRectMake(15, 260, 305, 90);
//            smallScr.backgroundColor=[UIColor groupTableViewBackgroundColor];
        smallScr.contentSize=CGSizeMake(90 *_dataArr.count+80, 90);
        [self.view addSubview:smallScr];
        
        UILabel *nameLabel=[[UILabel alloc]init];
        nameLabel.frame=CGRectMake(10, 60, 80, 40);
        nameLabel.text=[NSString stringWithFormat:@"产品名:"];
        //    nameLabel.textAlignment=NSTextAlignmentCenter;
        [self.view addSubview:nameLabel];
    
        nameTextField=[[UITextField alloc]init];
        nameTextField.frame=CGRectMake(90, 60, 220, 40);
        [nameTextField setBorderStyle:UITextBorderStyleRoundedRect];
        nameTextField.delegate=self;
        nameTextField.tag=1001;
    nameTextField.userInteractionEnabled=NO;
//        [self.view addSubview:nameTextField];
    
    UILabel *nameLabel2=[[UILabel alloc]init];
    nameLabel2.frame=CGRectMake(90, 60, 220, 40);
    nameLabel2.text=[NSString stringWithFormat:@"%@",_productName];
    //    nameLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:nameLabel2];
    
        UILabel *phoneLabel=[[UILabel alloc]init];
        phoneLabel.frame=CGRectMake(10, 110, 80, 40);
        phoneLabel.text=[NSString stringWithFormat:@""];
        //    phoneLabel.textAlignment=NSTextAlignmentCenter;
//        [self.view addSubview:phoneLabel];
    
        //        UITextField *phoneTextField=[[UITextField alloc]init];
        //        phoneTextField.frame=CGRectMake(90+320*i, 210, 220, 40);
        //        phoneTextField.delegate=self;
        //        phoneTextField.tag=1002;
        //        [phoneTextField setBorderStyle:UITextBorderStyleRoundedRect];
        //        [scrollVC addSubview:phoneTextField];
        
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",nil];
        
        UISegmentedControl *segmentCtr=[[UISegmentedControl alloc]initWithItems:segmentedArray];
        segmentCtr.frame=CGRectMake(100, 110, 200, 40);
//        [self.view addSubview:segmentCtr];
    
        UILabel *IDLabel=[[UILabel alloc]init];
        IDLabel.frame=CGRectMake(10, 110,80,40);
        IDLabel.text=[NSString stringWithFormat:@"产品口味:"];
        //    label.textAlignment=NSTextAlignmentCenter;
        [self.view addSubview:IDLabel];
    
        //        UITextField *IDTextField=[[UITextField alloc]init];
        //        IDTextField.frame=CGRectMake(90+320*i,260, 220, 40);
        //        IDTextField.delegate=self;
        //        IDTextField.tag=1003;
        //        [IDTextField setBorderStyle:UITextBorderStyleRoundedRect];
        //        [scrollVC addSubview:IDTextField];
        
        cbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        cbtn.frame=CGRectMake(100, 110, 200, 40);
        [cbtn setTitle:@"选择口味" forState:UIControlStateNormal];
        [cbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cbtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:cbtn];
    
    UILabel *priceLabel=[[UILabel alloc]init];
    priceLabel.frame=CGRectMake(10, 160, 150, 40);
    priceLabel.text=[NSString stringWithFormat:@"零售价格(元):"];
    //    nameLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:priceLabel];
    
    priceTextField=[[UITextField alloc]init];
    priceTextField.frame=CGRectMake(160, 160, 150, 40);
    [priceTextField setBorderStyle:UITextBorderStyleRoundedRect];
    priceTextField.delegate=self;
    priceTextField.tag=1002;
    priceTextField.keyboardType=UIKeyboardTypeDecimalPad;

    [self.view addSubview:priceTextField];
    
    UILabel *areaLabel=[[UILabel alloc]init];
    areaLabel.frame=CGRectMake(10, 210, 150, 40);
    areaLabel.text=[NSString stringWithFormat:@"占地堆面积比(%%):"];
    //    nameLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:areaLabel];
    
    areaTextField=[[UITextField alloc]init];
    areaTextField.frame=CGRectMake(160, 210, 150, 40);
    [areaTextField setBorderStyle:UITextBorderStyleRoundedRect];
    areaTextField.delegate=self;
    areaTextField.tag=1003;
            areaTextField.keyboardType=UIKeyboardTypeNumberPad;
    [self.view addSubview:areaTextField];
    
    
        UILabel *sexLabel=[[UILabel alloc]init];
        sexLabel.frame=CGRectMake(10, 310, 80, 40);
        sexLabel.text=[NSString stringWithFormat:@"性别:"];
        //    sexLabel.textAlignment=NSTextAlignmentCenter;
//        [scrollVC addSubview:sexLabel];
    
        //        UITextField *sexTextField=[[UITextField alloc]init];
        //        sexTextField.frame=CGRectMake(90+320*i, 310, 70, 40);
        //        sexTextField.delegate=self;
        //        sexTextField.tag=1004;
        //        sexTextField.placeholder=[NSString stringWithFormat:@"女"];
        //        [sexTextField setBorderStyle:UITextBorderStyleRoundedRect];
        //        [scrollVC addSubview:sexTextField];
        
        NSArray *sexSegmentedArray = [[NSArray alloc]initWithObjects:@"男",@"女",nil];
        
        UISegmentedControl *sexSegmentCtr=[[UISegmentedControl alloc]initWithItems:sexSegmentedArray];
        sexSegmentCtr.frame=CGRectMake(90, 310, 70, 40);
//        [self.view addSubview:sexSegmentCtr];
    
        
        UITextView *textV=[[UITextView alloc]init];
        textV.frame=CGRectMake(10, 360, 300, 100);
        textV.text=@"情况介绍:\n1:...\n2:..\n3:..\n4:..";
//        [self.view addSubview:textV];
    
        UIButton *Photobtn=[UIButton buttonWithType:UIButtonTypeCustom];
        Photobtn.frame=CGRectMake(0, 0, 80, 80);
        //        [Photobtn setTitle:@"拍照" forState:UIControlStateNormal];
//                [Photobtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
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
        
//    UIButton *confirmBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    confirmBtn.frame=CGRectMake(50, 400, 220, 40);
//    [confirmBtn setTitle:@"保存" forState:UIControlStateNormal];
//    [confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [confirmBtn setBackgroundColor:[UIColor grayColor]];
//    [confirmBtn addTarget:self action:@selector(confirmBtnbtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:confirmBtn];

    
    
        
        
//    }
    
}
-(void)backBtnClick:(UIButton *)btn
{

    if (!issaved) {
        //        priceTextField.text=@"0";
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示:" message:@"数据未保存,是否确认退出?" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil, nil];
        alert.delegate=self;
        [alert show];
        return;
    }
    
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        return;
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)confirmBtnbtnClick:(UIButton *)btn
{
//    [btn setTitle:@"已保存" forState:UIControlStateNormal];
    
    if ([areaTextField.text isEqualToString:@""]) {
//        areaTextField.text=@"0";
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示:" message:@"占地堆面积比为空,请补充完整!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                return;
    }else if([areaTextField.text intValue]>100)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示:" message:@"占地堆面积比大于100,请重新填写!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        [alert show];
        return;
    }
    if ([priceTextField.text isEqualToString:@""]) {
//        priceTextField.text=@"0";
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示:" message:@"价格为空,请补充完整!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        [alert show];
        return;
    }else
    {
        
    }
    if (smellStr.length==0) {
        //        priceTextField.text=@"0";
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示:" message:@"请选择口味!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    issaved=YES;
    NSLog(@"%@,%@,%@,%@",smellStr,areaTextField.text,priceTextField.text,nameTextField.text);
    _model.ProductSmell=smellStr;
    _model.AreaRatio=areaTextField.text;
    _model.Price=priceTextField.text;
    _model.CreateDate=[self nowTime];
    
    
//    ProductModel *model=  [KeepSignInInfo selectMDDetailTable:[dic objectForKey:@"code"]];
//    if (model.Code) {
//        NSLog(@"存在,更新");
//        [KeepSignInInfo updataMDWithTheDictionary:productM];
//    }
//    else
//    {
//        NSLog(@"不存在,创建");
//        [KeepSignInInfo keepMDWithTheDictionary:productM];
//    }
    
    [KeepSignInInfo keepStoreWithTheDictionary:_model];
    [self.navigationController popViewControllerAnimated:YES];
    
}
//-(void)viewWillDisappear:(BOOL)animated
//{
//    if ([areaTextField.text isEqualToString:@""]) {
//        //        areaTextField.text=@"0";
//        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示:" message:@"占地堆面积比为空,请补充完整!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
//        return;
//    }else if([areaTextField.text intValue]>100)
//    {
//        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示:" message:@"占地堆面积比大于100,请重新填写!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
//        return;
//    }
//    if ([priceTextField.text isEqualToString:@""]) {
//        //        priceTextField.text=@"0";
//        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示:" message:@"价格为空,请补充完整!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
//        return;
//    }else
//    {
//        
//    }
//    if (smellStr.length==0) {
//        //        priceTextField.text=@"0";
//        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示:" message:@"请选择口味!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
//        return;
//    }
//    NSLog(@"%@,%@,%@,%@",smellStr,areaTextField.text,priceTextField.text,nameTextField.text);
//    _model.ProductSmell=smellStr;
//    _model.AreaRatio=areaTextField.text;
//    _model.Price=priceTextField.text;
//    _model.CreateDate=[self nowTime];
//    
//    
//    //    ProductModel *model=  [KeepSignInInfo selectMDDetailTable:[dic objectForKey:@"code"]];
//    //    if (model.Code) {
//    //        NSLog(@"存在,更新");
//    //        [KeepSignInInfo updataMDWithTheDictionary:productM];
//    //    }
//    //    else
//    //    {
//    //        NSLog(@"不存在,创建");
//    //        [KeepSignInInfo keepMDWithTheDictionary:productM];
//    //    }
//    
//    [KeepSignInInfo keepStoreWithTheDictionary:_model];
//}
- (NSString *)nowTime
{
    NSDate * date = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    return  [formatter stringFromDate:date];
}
-(void)btnClick:(UIButton *)btn
{

    
}
-(void)Update
{
    
//    for (NSObject *obj in choiceArr) {
//        if ([obj isEqual:@"YES"]) {
//            [selectedArr addObject:obj];
//        }
//    }
//    for (int i=0; i<choiceArr.count; i++) {
//        if ([choiceArr[i] isEqualToString:@"Yes"]) {
//            [selectedArr addObject:[NSString stringWithFormat:@"%d",i]];
//            NSLog(@"123");
//        }
//    }
    NSLog(@"selectedArr:%@",selectedArr);
    
    [cbtn setTitle:[NSString stringWithFormat:@"%@",smellStr] forState:UIControlStateNormal];
    
//    UILabel *label=[[UILabel alloc]init];
//    label.frame=CGRectMake(180, 260, 140, 40);
//    label.text=[NSString stringWithFormat:@"%@",choiceArr];
//    label.text=@"shenme ";
//    //    label.textAlignment=NSTextAlignmentCenter;
//    label.backgroundColor=[UIColor grayColor];
//    [scrollVC addSubview:label];
}
-(void)viewWillAppear:(BOOL)animated
{
//        _selectType=@"product";
//    _selectType=_productName;
//    _dataArr=[[NSMutableArray alloc]init];
//    _dataArr=[KeepSignInInfo selectPhotoWithType:_selectType andId:_model.Code];
    
//    [self uiConfig];
}
-(void)toDetail:(UITapGestureRecognizer *)tap
{
    self.tabBarController.tabBar.hidden = YES;
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
//        [imgV addSubview:typeLab];
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
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择照片类型" message:nil preferredStyle: UIAlertControllerStyleActionSheet];
//    
//    //    UIAlertAction *pailAction = [UIAlertAction actionWithTitle:@"排面照" style:UIAlertActionStyleDefault handler:nil];
//    UIAlertAction *pailAction = [UIAlertAction actionWithTitle:@"排面照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self presentViewController:imagePicker animated:YES completion:^{
            
        }];

    
}
-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"did");
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{

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
        
//        [NSThread detachNewThreadSelector:@selector(useImage:) toTarget:self withObject:imageDic];
        [self useImage:imageDic];
        
        NSString * storeCode =_model.Code;
//        [keepLocationInfo selectStroeCodeWithTheStoreName:_storeCode andProjectName:_projectName];
        NSString * identifier   = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        NSString * imageType = @"JPG";
        
        NSDate * date = [NSDate date];
        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        
        NSString * Createtime = [formatter stringFromDate:date];
        _keepInfo=[[NSMutableDictionary alloc]init];
//        [_keepInfo setValue:@"imgDoor" forKey:@"selectType"];
//        [_keepInfo setValue:@"2170"   forKey:@"storeCode"];
        [_keepInfo setValue:_productName forKey:@"selectType"];
        [_keepInfo setValue:_model.Code   forKey:@"storeCode"];
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
                [self useImage:imageDic];
        
//        dataArr=[KeepSignInInfo selectPhotoWithType:_selectType andId:_model.Code];
//        [self uiConfig];
//        [smallScr removeFromSuperview];
//        [self uiConfig];
        //        }
        //        else
        //        {
        //            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"定位失败,请重新操作" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //            [alert show];
        //        }
        
//        _dataArr = [KeepSignInInfo selectPhotoWithType:_selectType];
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
            dataArr=[KeepSignInInfo selectPhotoWithType:_selectType andId:_model.Code];
            [self uiConfig];
    dispatch_async(dispatch_get_main_queue(), ^{
        [_collection reloadData];
    });
}
-(void)dismiss:(UITapGestureRecognizer *)tap
{
    [otherScrollVC removeFromSuperview];
    
    //    self.tabBarController.tabBar.hidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


