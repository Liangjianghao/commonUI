//
//  programList.m
//  ljhUI
//
//  Created by mac on 17/1/18.
//  Copyright © 2017年 mac. All rights reserved.
//
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width

#import "ViewController.h"
#import "NetWorkTools.h"
#import "tableViewController.h"

#import "programList.h"
#import "storeList.h"

@interface programList ()
{
    NSMutableArray *dataArr;
    UITableView *myTableView;
}
@end

@implementation programList

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArr=[[NSMutableArray alloc]init];
    
    [self loadData];
    
    myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    [self.view addSubview:myTableView];
  
}


-(void)loadData
{
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path=[paths objectAtIndex:0];
    NSString *Json_path=[path stringByAppendingPathComponent:@"JsonFile.json"];
    //==Json数据
    NSData *data=[NSData dataWithContentsOfFile:Json_path];
    NSError *error;
    //==JsonObject
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:data];

    NSLog(@"array %@",array);
    
    if (array.count!=0) {
        dataArr=[NSMutableArray arrayWithArray:array];
        [myTableView reloadData];
        NSLog(@"已存在");
    }
    /*
    else
    {
    NSString * userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];

    NSDictionary *newdic=[NSDictionary dictionaryWithObjectsAndKeys:userID,@"userid",nil];
    
    NSString *newurlAddress=[NSString stringWithFormat:@"http://wxapi.egocomm.cn/Perfetti/service/app.ashx?action=loadconfig"];
    
    //    NSDictionary *newdic=[NSDictionary dictionaryWithObjectsAndKeys:@"3",@"userid",nil];
    //
    //    NSString *newurlAddress=[NSString stringWithFormat:@"http://192.168.60.50/hecha/service/app.ashx?action=loadstore"];
    
    [NetWorkTools requestWithAddress:newurlAddress andParameters:newdic withSuccessBlock:^(NSDictionary *result, NSError *error) {
        
        NSArray * basedataArr=[result objectForKey:@"Data"];
//        NSLog(@"%lu",(unsigned long)basedataArr.count);
//        
//        NSLog(@"%@",[basedataArr[0] objectForKey:@"Name"]);
//        NSArray *tableArr=[basedataArr[0] objectForKey:@"Tables"];
        dataArr=basedataArr;
        
        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path=[paths objectAtIndex:0];
        NSString *Json_path=[path stringByAppendingPathComponent:@"JsonFile.json"];
        //==写入文件
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:basedataArr];
        
        NSLog(@"%@",[data writeToFile:Json_path atomically:YES] ? @"Succeed":@"Failed");

        [myTableView reloadData];
        
    } andFailedBlock:^(NSString *result, NSError *error) {
        
    }];
    }
    */
    
    
//    NSString * writePath = [NSString stringWithFormat:@"%@/Library/new.json",NSHomeDirectory()];
//    
//        NSData *fileData = [[NSData alloc]init];
//        fileData = [NSData dataWithContentsOfFile:writePath];
//        NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:0];
//        dic = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableLeaves error:nil];
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
    cell.textLabel.text=[dataArr[indexPath.row] objectForKey:@"Name"];
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ViewController *uiViewController =[[ViewController alloc]init];
//    uiViewController.rowArr=[dataArr[indexPath.row] objectForKey:@"Rows"];
//    uiViewController.ID=[dataArr[indexPath.row] objectForKey:@"ID"];
//    [self.navigationController pushViewController:uiViewController animated:YES];
    
//    tableViewController *tableList=[[tableViewController alloc]init];
//    tableList.baseDataArr=[dataArr[indexPath.row] objectForKey:@"Tables"];
//    [self.navigationController pushViewController:tableList animated:YES];
    
    storeList *storeL=[[storeList alloc]init];
    storeL.baseDataArr=[dataArr[indexPath.row] objectForKey:@"Tables"];
    storeL.projectID=[dataArr[indexPath.row] objectForKey:@"ID"];
    [self.navigationController pushViewController:storeL animated:YES];
    
}

@end
