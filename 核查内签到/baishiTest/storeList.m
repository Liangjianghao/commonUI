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
#import "DBManager.h"
#import "storeList.h"


@interface storeList ()
{
    NSMutableArray *dataArr;
    UITableView *myTableView;
}
@end

@implementation storeList

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArr=[[NSMutableArray alloc]init];
    NSLog(@"_projectID%@",_projectID);
    dataArr=[DBManager selectStoreInfo:_projectID];
    
//    [self loadData];
    
    myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    [self.view addSubview:myTableView];
    
}


-(void)loadData
{
    NSArray *myarr=[DBManager selectStoreInfo:_projectID];
            dataArr=myarr;
    
    [myTableView reloadData];
//    NSString * userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
//
//    NSDictionary *newdic=[NSDictionary dictionaryWithObjectsAndKeys:userID,@"userid",_projectID,@"projectid",nil];
//    
//    NSString *newurlAddress=[NSString stringWithFormat:@"http://wxapi.egocomm.cn/Perfetti/service/app.ashx?action=loadstore"];
//    
//    
//    [NetWorkTools requestWithAddress:newurlAddress andParameters:newdic withSuccessBlock:^(NSDictionary *result, NSError *error) {
//        
//        NSArray * basedataArr=[result objectForKey:@"Data"];
//        //        NSLog(@"%lu",(unsigned long)basedataArr.count);
//        //
//        //        NSLog(@"%@",[basedataArr[0] objectForKey:@"Name"]);
//        //        NSArray *tableArr=[basedataArr[0] objectForKey:@"Tables"];
//        dataArr=basedataArr;
//        [myTableView reloadData];
//        
//    } andFailedBlock:^(NSString *result, NSError *error) {
//        
//    }];

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
    return 40;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    ViewController *uiViewController =[[ViewController alloc]init];
    //    uiViewController.rowArr=[dataArr[indexPath.row] objectForKey:@"Rows"];
    //    uiViewController.ID=[dataArr[indexPath.row] objectForKey:@"ID"];
    //    [self.navigationController pushViewController:uiViewController animated:YES];
    
    tableViewController *tableList=[[tableViewController alloc]init];
    tableList.baseDataArr=_baseDataArr;
    
    tableList.storeID=[dataArr[indexPath.row] objectForKey:@"ID"];
    tableList.projectID=_projectID;
    [self.navigationController pushViewController:tableList animated:YES];
}

@end
