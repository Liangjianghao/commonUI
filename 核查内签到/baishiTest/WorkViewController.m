//
//  WorkViewController.m
//  baishiTest
//
//  Created by EssIOS on 15/12/18.
//  Copyright © 2015年 ljh. All rights reserved.
//

#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width

#import "ViewController.h"
#import "SignInLayerViewController.h"
#import "WorkViewController.h"
#import "LoginController.h"

#import "KeepSignInInfo.h"
#import "PhotoModel.h"

#import "UpDataTool.h"
#import "UpDataServer.h"

#import "NetWorkTools.h"
#import "signInModel.h"
#import "keepLocationInfo.h"
#import "programList.h"

#define WINDOW  [UIApplication sharedApplication].windows[0]
@interface WorkViewController ()
{
    NSMutableArray *dataArr;
     UIAlertView * _alert;
    UIAlertView * _alert1;
    NSArray     * _imageArr;
}
@end

@implementation WorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    [self.view addSubview:tableView];
#pragma mark 底部空白
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    
    dataArr=[NSMutableArray arrayWithObjects:@"签到",@"上传",@"数据更新",@"切换用户", nil];
        _imageArr = @[@"more_report",@"androidcamera",@"original_9",@"keifficon_contact",@"plan",@"isread"];
        _alert = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
}
#pragma mark--tableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *cellID=@"cellID";
//    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
//    if (!cell) {
//        //        cell=[[[NSBundle mainBundle]loadNibNamed:@"BottleCell" owner:self options:nil]firstObject];
//        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
//    }
//    //    [cell setModel:dataArr[indexPath.row]];
//    cell.textLabel.text=dataArr[indexPath.row];
//    cell.textLabel.textAlignment=NSTextAlignmentCenter;
//    return cell;
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 30, 30)];
        imgView.tag           = 10000;
        [cell addSubview:imgView];
        
        
        UILabel * textLB = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, self.view.frame.size.width -80, 40)];
        textLB.tag       =  20000;
        textLB.textColor = [UIColor blackColor];
        [cell addSubview:textLB];
        
    }
    
    UILabel * textLB = (UILabel *)[cell viewWithTag:20000];
    textLB.text      = dataArr[indexPath.row];
    
    
    UIImageView * imgView = (UIImageView *)[cell viewWithTag:10000];
    
    imgView.image         = [UIImage imageNamed:_imageArr[indexPath.row]];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//
//    UIView *spaceView=[[UIView alloc]initWithFrame:CGRectZero];
//    
//    return spaceView;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SignInLayerViewController *signVC=[[SignInLayerViewController alloc]init];
    programList *proList=[[programList alloc]init];
    
    ViewController *detailVC=[[ViewController alloc]init];
     UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"确认退出?\n退出后将返回登陆界面!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag=1001;
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:proList animated:YES];
            break;
            case 1:
//            [self.navigationController pushViewController:detailVC animated:YES];
//            [self uploadProductData];
            
//            [_alert setMessage:@"努力上传数据中,请稍候..."];
//            [_alert show];
//            [self uploadStoreData];
//            [self upSignInData];
            [self uploadProductData];
            [self uploadPic];

            
            break;
        case 2:
            [self updataData];
            break;
        case 3:
           
            [alertView show];
            break;
            
        default:
            break;
    }
}
// 上传签到信息
- (void)upSignInData
{
    NSMutableArray * arr =[KeepSignInInfo selectSginInTable];
    
    
    for (signInModel * signIn in arr ) {
        if ([signIn.checkOutTime isEqualToString:@"null"]) {
            _alert1 = [[UIAlertView alloc]initWithTitle:@"警告!" message:@"当前有未签出项,请签出后进行上传" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"前往签出", nil];
            
            [_alert1 show];
                        [_alert dismissWithClickedButtonIndex:0 animated:YES];
            return;
        }
    }
    if ([self arrayIsNullWithArr:arr] == NO) {
        return ;
    }else
    {
        [self alertShow];
    }
    
    
    NSString *jsonString = nil;
    NSError *error;
    
    for (int i=0; i<arr.count; i++) {
        
        if ([[arr[i] btnSelect] isEqualToString:@"YES"]) {
            NSString *finalStr =nil;
            NSString *imei=@"null";
            if ([[arr[i] checkOutImei] isEqualToString:@""]) {
                imei=@"0";
            }
            else{
                imei=[arr[i] checkOutImei] ;
            }
            NSDictionary *dicT = [NSDictionary dictionaryWithObjectsAndKeys:
                                  imei,                          @"checkInImei",
                                  [arr[i] checkInLatitude],                          @"checkInLatitude",
                                  [arr[i] checkInLocationTime],                          @"checkInLocationTime",
                                  [arr[i] checkInLocationType],                          @"checkInLocationType",
                                  [arr[i] checkInLongitude],                          @"checkInLongitude",
                                  [arr[i] checkInTime],                          @"checkInTime",
                                  
                                  imei,                          @"checkOutImei",
                                  [arr[i] checkOutLatitude],                          @"checkOutLatitude",
                                  [arr[i] checkOutLocationType],                          @"checkOutLocationTime",
                                  [arr[i] checkOutLocationTime],                          @"checkOutLocationType",
                                  [arr[i] checkOutLongitude],                          @"checkOutLongitude",
                                  [arr[i] checkOutTime],                          @"checkOutTime",
                                  
                                  [arr[i] companyCode],                          @"companyCode",
                                  [arr[i] itemCode],                          @"itemCode",
                                  [arr[i] StoreCode],                          @"storeCode",
                                  [arr[i] companyName],                          @"companyName",
                                  [arr[i] projectName],                          @"projectName",
                                  
                                  
                                  [NSNumber numberWithInt:[[arr[i] userID] intValue]],                          @"uid",
                                  nil];
            
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicT                                                           options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                                 error:&error];
            jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            //            NSLog(@"jsonString-->>%@",jsonString);
            if (!finalStr) {
                finalStr=jsonString;
            }
            //            else
            //            {
            //                finalStr=[finalStr stringByAppendingString:jsonString];
            //            }
            NSString *soapMessage = [NSString stringWithFormat:
                                     @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                                     "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                     "<soap:Body>"
                                     "<UploadAttendance xmlns=\"http://tempuri.org/\">"
                                     //                             "<jsonStr><![CDATA[%@]]></jsonStr>"
                                     "<jsonStr>%@</jsonStr>"
                                     "</UploadAttendance>"
                                     "</soap:Body>"
                                     "</soap:Envelope>",jsonString];
            NSString *baseApiURL = @"http://pm.essenceimc.com/Service/appwebservice.asmx";
            NSLog(@"上传签到soap-->>  %@",soapMessage);
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:baseApiURL]];
            
            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSString * UpDataType = [NSString stringWithFormat:@"http://tempuri.org/%@",@"UploadAttendance"];
            [request setValue:UpDataType forHTTPHeaderField:@"SOAPAction"];
            [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
            
            AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request] ;
            
            operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
            //        operation.responseSerializer = [AFHTTPResponseSerializer serializer];
            //    operation.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/plain"];
            
            [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id XML) {
                NSString *result = operation.responseString;
                //                NSLog(@"RR---%@",result);
                NSLog(@"成功");
                [KeepSignInInfo upLoadSignInWithTheDictionary:dicT];
                [_alert dismissWithClickedButtonIndex:3 animated:YES];
                //                [self resultUpdataWithXMLPath:nil alertMessage:@"上传成功"];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"%@",error.localizedDescription);
                [_alert dismissWithClickedButtonIndex:3 animated:YES];
            }];
            [operation start];
            
        }
        
        
        else
        {
            
            //                    [_alert dismissWithClickedButtonIndex:1 animated:YES];
//            [self resultUpdataWithXMLPath:nil alertMessage:@"没有可上传资源"];
            
        }
    }
    
    
    
    
}
-(void)updataData
{
    [_alert setMessage:@"努力更新数据中~"];
    [_alert show];
//   UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示:" message:@"数据更新中,请稍侯" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
//    
//    [alert show];
    NSDate * date = [[NSUserDefaults standardUserDefaults]valueForKey:@"lastUpdate"];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString  *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [NetWorkTools getUpdateBaseDataWithUserID:userID nowTime:[formatter stringFromDate:date] withBlock:^(NSString *result, NSError *error) {
//            NSLog(@"%@",result);
//            [_alert setMessage:@"数据更新完成!"];
//            [_alert show];
//            [NSThread sleepForTimeInterval:2.0];
//            [UIView animateWithDuration:8 animations:^{
//                [_alert dismissWithClickedButtonIndex:0 animated:YES];
//            }];
//            
//        } failedBlock:^(NSString *result, NSError *error) {
//            [_alert setMessage:@"数据更新失败,请尽量在wifi下进行更新!"];
//            [_alert show];
//            [UIView animateWithDuration:8 animations:^{
//                [_alert dismissWithClickedButtonIndex:0 animated:YES];
//            }];
//
//        }];
        NSDictionary *newdic=[NSDictionary dictionaryWithObjectsAndKeys:userID,@"userid",nil];
        
        NSString *newurlAddress=[NSString stringWithFormat:@"http://wxapi.egocomm.cn/Perfetti/service/app.ashx?action=loadstore"];
        [NetWorkTools requestWithAddress:newurlAddress andParameters:newdic withSuccessBlock:^(NSDictionary *result, NSError *error) {
//            [alert dismissWithClickedButtonIndex:0 animated:YES];
                            [_alert dismissWithClickedButtonIndex:0 animated:YES];

            [keepLocationInfo keepallStoreDataWithDictionary:result];
            
        } andFailedBlock:^(NSString *result, NSError *error) {
//            [alert dismissWithClickedButtonIndex:0 animated:YES];
            [_alert dismissWithClickedButtonIndex:0 animated:YES];

        }];
        
        
        NSString * userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
        
        NSDictionary *newdic2=[NSDictionary dictionaryWithObjectsAndKeys:userID,@"userid",nil];
        
        NSString *newurlAddress2=[NSString stringWithFormat:@"http://wxapi.egocomm.cn/Perfetti/service/app.ashx?action=loadconfig"];
        
        [NetWorkTools requestWithAddress:newurlAddress2 andParameters:newdic2 withSuccessBlock:^(NSDictionary *result, NSError *error) {
            
            NSArray * basedataArr=[result objectForKey:@"Data"];
            
//          NSMutableArray *myArr =[NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"Myarr"]];
//            
////            [[NSUserDefaults standardUserDefaults] setObject:[result objectForKey:@"Data"] forKey:@"Myarr"];
//            NSMutableArray *mutableCopyArr = [myArr mutableCopy];
//            [mutableCopyArr addObject:result];
//            
//            [[NSUserDefaults standardUserDefaults] setObject:mutableCopyArr forKey:@"Myarr"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
            NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *path=[paths objectAtIndex:0];
            NSString *Json_path=[path stringByAppendingPathComponent:@"JsonFile.json"];
            //==写入文件
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:basedataArr];

            NSLog(@"%@",[data writeToFile:Json_path atomically:YES] ? @"Succeed":@"Failed");

            
        } andFailedBlock:^(NSString *result, NSError *error) {
            
        }];
        
        
    }
                   );
}
-(void)uploadStoreData
{

    NSMutableArray *productArr=[KeepSignInInfo selectAllMDDetailTable];
//        NSMutableArray *productArr=[KeepSignInInfo selectProductDetailTable];
    if (productArr.count==0) {
        [_alert dismissWithClickedButtonIndex:0 animated:YES];
        return;
    }
     [_alert dismissWithClickedButtonIndex:0 animated:YES];
    NSLog(@"%@",productArr);
    //    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    NSDictionary * dictionary;
    
    
    NSMutableArray *jsonArr=[[NSMutableArray alloc]init];
    for (int i=0; i<productArr.count; i++) {
//        NSString *str2=[productArr[i] ProductSmell];
//        
//        NSArray *array=[str2 componentsSeparatedByString:@" "];
//        NSLog(@"%@",array);
        dictionary = [NSDictionary dictionaryWithObjectsAndKeys:[productArr[i] ProjectId],@"ProjectId",
                      [productArr[i] StoreId],@"StoreId",
                      [productArr[i] Code],@"Code",
                      [productArr[i] DiDui],@"DiDui",
                      [productArr[i] Area],@"Area",
                      [productArr[i] CreateDate],@"CreateDate",
                      [productArr[i] CreateUserId],@"CreateUserId",
                      [productArr[i] Position],@"Position",
                      [productArr[i] POSM], @"POSM",
//                      [productArr[i] MDstate], @"state",
                      [productArr[i] MDstate],@"Expand1",
                      [productArr[i] Expand2],@"Expand2",
                      [productArr[i] Expand3],@"Expand3",
                      [productArr[i] Expand4],@"Expand4",
                      [productArr[i] Expand5],@"Expand5",
                      nil];
        
        
        [jsonArr addObject:dictionary];
    }
    
    
    
    //    NSArray *dataArr=[NSArray arrayWithObjects:dictionary, nil];
    NSString *jsonStr=[self DataTOjsonString:jsonArr];
    
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                             "<soap:Body>"
                             "<UploadStoreData xmlns=\"http://tempuri.org/\">"
                             "<json><![CDATA[%@]]></json>"
                             "</UploadStoreData>"
                             "</soap:Body>"
                             "</soap:Envelope>",jsonStr];
    NSLog(@"soapMessage\n%@",soapMessage);
    NSString *url = @"http://pm.essenceimc.com/service/pepsiwebservice.asmx";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *UpDataType = [NSString stringWithFormat:@"http://tempuri.org/%@",@"UploadStoreData"];
    [request setValue:UpDataType forHTTPHeaderField:@"SOAPAction"];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id XML) {
        NSString *result = operation.responseString;
//        [KeepSignInInfo deleteProductWithImageUrl:nil];
        [KeepSignInInfo deleteMDWithImageUrl:nil];
        NSLog(@"上传成功=========%@",result);
//                    [self uploadProductData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"上传失败=========%@",error.localizedDescription);
        
        NSLog(@"%@",error.localizedDescription);
    }];
    [operation start];
}
- (NSString *)nowTime
{
    NSDate * date = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    return  [formatter stringFromDate:date];
//    return date;
}
-(void)uploadProductData
{
    [_alert setTitle:@"上传数据中，请稍候..."];
    [_alert show];

    NSArray *controlArr=[KeepSignInInfo selectControlWithInfo:nil];
    NSString * userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];

    NSDictionary *uploadDic=[NSDictionary dictionaryWithObjectsAndKeys:userID,@"userid",controlArr,@"Items", nil];
    
    NSString *uploadUrlAddress=[NSString stringWithFormat:@"http://wxapi.egocomm.cn/Perfetti/service/uploaddata.ashx"];
    
    
    NSLog(@"uploadDic\n%@",uploadDic);
    [NetWorkTools requestWithAddress:uploadUrlAddress andParameters:uploadDic withSuccessBlock:^(NSDictionary *result, NSError *error) {
        NSLog(@"上传成功返回%@",result);
        [_alert setTitle:@"上传成功!"];
        [_alert show];
        [UIView animateWithDuration:4 animations:^{
            [_alert dismissWithClickedButtonIndex:0 animated:YES];
        }];
        NSLog(@"删除多少次");
        [KeepSignInInfo deleteControlTable];
    } andFailedBlock:^(NSString *result, NSError *error) {
        NSLog(@"上传失败返回%@",result);
        [_alert setTitle:@"上传失败!"];
        [_alert show];
        [UIView animateWithDuration:4 animations:^{
            [_alert dismissWithClickedButtonIndex:0 animated:YES];
        }];
    }];
    
    
}
-(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}
#pragma mark-

    //上传图片
-(void)uploadPic
{
    NSMutableArray * arr = [KeepSignInInfo selectPatrolPicture];
    if (arr.count==0) {
//        [_alert setMessage:@"没有照片"];
//        [_alert show];
//        [UIView animateWithDuration:4 animations:^{
//            [_alert dismissWithClickedButtonIndex:0 animated:YES];
//        }];
        return;
    }

    
    
    
        for (PhotoModel * photo in arr) {
//        PhotoModel *photo=arr[0];
    
            UIImage *newimage=[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/Library/%@.jpg",NSHomeDirectory(),photo.imageUrl]];
    NSString *path=[NSString stringWithFormat:@"%@/Library/%@.jpg",NSHomeDirectory(),photo.imageUrl];
    NSData * Imagedata = UIImageJPEGRepresentation(newimage, 0.5f);
    
    NSString * _encodedImageStr=[Imagedata base64EncodedStringWithOptions:0];
    
            NSString * userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];

//    NSString *URLString =[NSString stringWithFormat:@"http://wxapi.egocomm.cn/Perfetti/service/uploadfile.ashx?lng=%@&lat=%@&userID=%@&storeID=%@&controlID=%@&createDate=%@",@"121.1",@"31.2",userID,@"26",@"3",[NSString stringWithFormat:@"%@",[NSDate date]]];
//    NSString *URLString =[NSString stringWithFormat:@"http://wxapi.egocomm.cn/Perfetti/service/uploadfile.ashx?lng=%@&lat=%@&userID=%@&storeID=%@&controlID=%@&createDate=%@",photo.Longitude,photo.Latitude,userID,photo.storeCode,photo.selectType,[NSString stringWithFormat:@"%@",[NSDate date]]];
            
             NSString *URLString =[NSString stringWithFormat:@"http://wxapi.egocomm.cn/Perfetti/service/uploadfile.ashx?lng=%@&lat=%@&userID=%@&storeID=%@&controlID=%@&createDate=%@",photo.Longitude,photo.Latitude,userID,photo.storeCode,photo.selectType,photo.Createtime];
      
    NSLog(@"上传照片url-->>%@",URLString);


    NSString * imageType = @"JPG";
    NSDate * date = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString * Createtime = [formatter stringFromDate:date];
    
    
    NSString *uploadUrlAddress=[NSString stringWithFormat:@"http://wxapi.egocomm.cn/Perfetti/service/uploadfile.ashx?type=json"];
    
    

    NSDictionary *uploadDic=[NSDictionary dictionaryWithObjectsAndKeys:photo.Longitude,@"lng",photo.Latitude,@"lat",photo.userID,@"userID",photo.storeCode,@"storeID",photo.selectType,@"controlID",photo.Createtime,@"createDate",_encodedImageStr,@"picBase64",nil];
    
    [NetWorkTools requestWithAddress:uploadUrlAddress andParameters:uploadDic withSuccessBlock:^(NSDictionary *result, NSError *error) {
        [KeepSignInInfo deletePatrolPictureWithImageUrl:photo.imageUrl];
        // 删除上传成功后的图片
        NSString * imageUrl = [NSString stringWithFormat:@"%@/Library/%@",NSHomeDirectory(),photo.imageUrl];
        [[NSFileManager defaultManager] removeItemAtPath:imageUrl error:nil];
        NSLog(@"上传zhao成功返回%@",result);
    } andFailedBlock:^(NSString *result, NSError *error) {
        
        NSLog(@"上传zhao失败返回%@",result);
    }];
        }
    
}
- (void)alertShow
{
    [_alert setMessage:@"正在上传,请稍等~"];
    [_alert show];
}
#pragma mark -- serverTools
- (BOOL)arrayIsNullWithArr:(NSMutableArray*)arr
{
    if (arr.count == 0) {
        
        [self resultUpdataWithXMLPath:nil alertMessage:@"没有可上传资源"];
        
        return NO;
    }
    return YES;
}
#pragma mark -- UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1001) {
        if (buttonIndex == 1) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"mmpswType"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"autoLogType"];
            [WINDOW setRootViewController:[[LoginController alloc]init]];
        }
    }
    else{
        if (buttonIndex == 1) {
        SignInLayerViewController *signVC=[[SignInLayerViewController alloc]init];

        [self.navigationController pushViewController:signVC animated:YES];
        }
    }
  
}
- (void)resultUpdataWithXMLPath:(NSString *)xmlPath alertMessage:(NSString *)message
{
    [[NSFileManager defaultManager] removeItemAtPath:xmlPath error:nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        [_alert setMessage:message];
        [_alert show];
        [UIView animateWithDuration:8 animations:^{
            [_alert dismissWithClickedButtonIndex:0 animated:YES];
        }];
    });
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
