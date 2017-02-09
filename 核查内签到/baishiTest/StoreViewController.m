//
//  StoreViewController.m
//  baishiTest
//
//  Created by EssIOS on 15/12/18.
//  Copyright © 2015年 ljh. All rights reserved.
//

#import "StoreViewController.h"
#import "keepLocationInfo.h"
#import "ViewController.h"
#import "ProductViewController.h"
@interface StoreViewController ()
{
    NSMutableArray *dataArr;
}
@end

@implementation StoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=_ProjectName;
    [self loadData];
    [self uiConfig];
}
-(void)loadData
{
    dataArr=[[NSMutableArray alloc]init];
    dataArr=[keepLocationInfo selectXMAndDQ:_ProjectName];
    NSLog(@"%@",dataArr);
    
}
-(void)uiConfig
{
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    [self.view addSubview:tableView];
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
    return 40;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ViewController *detailVC=[[ViewController alloc]init];
//    detailVC.StoreName=dataArr[indexPath.row];
//    [self.navigationController pushViewController:detailVC animated:YES];
    ProductViewController *productVC=[[ProductViewController alloc]init];
    [self.navigationController pushViewController:productVC animated:YES];
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
