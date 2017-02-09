//
//  ProductViewController.m
//  baishiTest
//
//  Created by EssIOS on 15/12/25.
//  Copyright © 2015年 ljh. All rights reserved.
//

#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width

#import "ProductViewController.h"
#import "ViewController.h"
#import "ProductDetailViewController.h"
#import "NetWorkTools.h"
#import "keepLocationInfo.h"
@interface ProductViewController ()
{
    NSMutableArray *dataArr;
    NSMutableArray *_dataArr;
    UIScrollView *otherScrollVC;
    UITableView *tableView;
    NSArray *listArr;
    NSMutableArray *idArr;
}
@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    [self.view addSubview:tableView];
    dataArr=[[NSMutableArray alloc]init];
    idArr=[[NSMutableArray alloc]init];
//    dataArr=[NSMutableArray arrayWithObjects:@"产品一",@"产品二",@"产品三", nil];
//    NSLog(@"_model-->%@",[_model description]);
    _dataArr=[[NSMutableArray alloc]init];
//    [self uiConfig];
//    NSLog(@"%@,%@",_StoreName,_projectName);
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0,80, 40);
    //    [btn setTitle:@"title" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"主页面" forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:@"60"] forState:UIControlStateNormal];
    //    [btn setImage:[UIImage imageNamed:@"icon-40"] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(returnBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:btn];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:btn];


}
-(void)returnBtnClick
{
//    [self.navigationController popToRootViewControllerAnimated:YES];
    UIViewController *viewCtl = self.navigationController.viewControllers[1];
    
    [self.navigationController popToViewController:viewCtl animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [dataArr removeAllObjects];
    [idArr removeAllObjects];
    [self loadData];
}
-(void)loadData
{

//    [NetWorkTools GetProductListWithProjectId:_model.ProjectId:^(NSString *result, NSError *error) {
//        NSData *data= [result dataUsingEncoding:NSUTF8StringEncoding];
//        id dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
//        NSLog(@"%@",[dictionary objectForKey:@"List"]);
//        dataArr=[dictionary objectForKey:@"List"];
//        NSLog(@"dictionary-->%@",dictionary);
//        [tableView reloadData];
//    }];
    if (!_model) {
        _model=[[ProductModel alloc]init];        //
                    _model.ProjectId  =  [[keepLocationInfo selectCodeWithTheStoreName:_StoreName andProjectName:_projectName] objectForKey:@"projectCode"];
        //            productVC.model=model;
//        NSLog(@"dic-->>%@",[[keepLocationInfo selectCodeWithTheStoreName:_StoreName andProjectName:_projectName] objectForKey:@"projectCode"]);
    }
    else
    {
   
    }
    
    [NetWorkTools GetProductListWithProjectId:_model.ProjectId withBlock:^(NSString *result, NSError *error) {
        NSData *data= [result dataUsingEncoding:NSUTF8StringEncoding];
        id dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
//        NSLog(@"%@",[dictionary objectForKey:@"List"]);
        listArr=[dictionary objectForKey:@"List"];
        for (int i=0;i<listArr.count; i++) {
            [dataArr addObject:[listArr[i] objectForKey:@"ProductName"]];
                        [idArr addObject:[listArr[i] objectForKey:@"ProductId"]];
        }
//        NSLog(@"dataArr%@",dataArr);
        //        NSLog(@"dictionary-->%@",dictionary);
        [tableView reloadData];
    }];
    
//    NSString *path;
//    path = [[NSBundle mainBundle] pathForResource:@"Contents" ofType:@"json"];
//      NSData *fileData = [[NSData alloc]init];
//    fileData = [NSData dataWithContentsOfFile:path];
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:0];
//    dic = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableLeaves error:nil];
//    NSLog(@"%@",dic);
//    
//    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *pathT=[paths objectAtIndex:0];
//    NSString *Json_path=[pathT stringByAppendingPathComponent:@"JsonFiles.json"];
//    
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    
//
//    
//    if(![fileManager fileExistsAtPath:Json_path]) //如果不存在
//        
//    {
//        NSLog(@"%@",[fileData writeToFile:Json_path atomically:YES] ? @"Succeed":@"Failed");
// 
//    }
//    else
//    {
//        return;
//    }
   
    
    
    //==写入文件

}
-(void)uiConfig
{
    UIScrollView *smallScr=[[UIScrollView alloc]init];
    smallScr.frame=CGRectMake(15, 480, 305, 90);
    //                smallScr.backgroundColor=[UIColor grayColor];
    smallScr.contentSize=CGSizeMake(90 *_dataArr.count+80, 90);
    [self.view addSubview:smallScr];
    
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
        [imgV addSubview:label];
        
        UILabel *Prolabel=[[UILabel alloc]init];
        Prolabel.frame=CGRectMake(0, 330, 300, 30);
        Prolabel.text=[NSString stringWithFormat:@"大波浪店促"];
        //    label.textAlignment=NSTextAlignmentCenter;
        [imgV addSubview:Prolabel];
        
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
//    }];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"堆头照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [self presentViewController:imagePicker animated:YES completion:^{
//            
//        }];
//    }];
//    
//    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"竞品照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [self presentViewController:imagePicker animated:YES completion:^{
//            
//        }];
//    }];
//    
//    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"其他" style:UIAlertActionStyleDefault handler:nil];
//    [alertController addAction:pailAction];
//    [alertController addAction:cancelAction];
//    [alertController addAction:deleteAction];
//    [alertController addAction:archiveAction];
//    [alertController addAction:otherAction];
//    [self presentViewController:alertController animated:YES completion:^{
//        
//    }];
    
}
-(void)dismiss:(UITapGestureRecognizer *)tap
{
    [otherScrollVC removeFromSuperview];
    
    self.tabBarController.tabBar.hidden = NO;
}
#pragma mark--tableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cellID";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        //        cell=[[[NSBundle mainBundle]loadNibNamed:@"BottleCell" owner:self options:nil]firstObject];
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    //    [cell setModel:dataArr[indexPath.row]];
    cell.textLabel.text=dataArr[indexPath.row];
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//            ViewController *detailVC=[[ViewController alloc]init];
//            detailVC.storeCode = _StoreNameLB.text;
//            detailVC.projectName = _ProjectNameLB.text;
//            [self.navigationController pushViewController:detailVC animated:YES];
    _model.ProductId=idArr[indexPath.row];
    
    ProductDetailViewController *productDetailVC=[[ProductDetailViewController alloc]init];
    productDetailVC.model=_model;
    productDetailVC.smellArr=[listArr[indexPath.row] objectForKey:@"Taste"];
    productDetailVC.productName=[listArr[indexPath.row] objectForKey:@"ProductName"];
    [self.navigationController pushViewController:productDetailVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
