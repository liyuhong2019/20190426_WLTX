//
//  WLTX_PersonalInformationViewController.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/4/12.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_PersonalInformationViewController.h"

@interface WLTX_PersonalInformationViewController ()

// tool
@property (nonatomic,strong) YH_SystemImagePickerManager *manager;


//
@property (weak, nonatomic) IBOutlet UIImageView *img_userUrl;
@property (weak, nonatomic) IBOutlet UILabel *lb_nickName;
@property (weak, nonatomic) IBOutlet UILabel *lb_loginNumber;
@property (weak, nonatomic) IBOutlet UILabel *lb_lgoinType;

@end

@implementation WLTX_PersonalInformationViewController

#pragma mark - ♻️ 视图的生命周期 view life cycle start
/*
 4-1、第一个执行的方法，加载UI：- (void)loadView{ }
 4-2、第二个执行的方法，加载UI成功后调用：- (void)viewDidLoad{ }
 4-3、第三个执行方法，UI即将显示时：- (void)viewWillAppear:(BOOL)animated{ }
 4-4、第四个执行方法，UI已经显示时：- (void)viewDidAppear:(BOOL)animated{ }
 4-5、第五个执行方法，UI即将消失时：- (void)viewWillDisappear:(BOOL)animated{ }
 4-6、第六个执行方法，UI已经消失时：- (void)viewDidDisappear:(BOOL)animated{ }
 4-7、最后执行方法，即视图控制器注销方法：- (void)dealloc { }
 4-8、该方法在接收到内存警告时会调用，且系统会自动处理内存释放：- (void)didReceiveMemoryWarning { }
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self personalInformationVC_settingsInitData];
    
}
- (void)dealloc
{
    //    [super dealloc];
    // 移除通知处理
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!kWltx_IsLogin) {
        [self.view makeToast:@"用户还没有登陆"];
        return;
    }
    
    NSDictionary *dict  = @{
                            @"shouji":kWltx_userShouji,
                            };
    
    [self personInfarmationVC_netwrok_getPersonInfoRequest:dict];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark ♻️ 视图的生命周期 view life cycle end


#pragma mark - 🏃(代理)Delegate start
#pragma mark 🏃(代理)Delegate end
#pragma mark - ✍🏻(自定义方法) custom method start
/**
 登陆页面 初始化数据
 */
- (void)personalInformationVC_settingsInitData
{
    YHLog(@"初始化数据");
    //    self.view.backgroundColor = [UIColor whiteColor];
    [self personalInformation_settingsNav];
    
    
    __weak typeof(self) weakSelf = self;
    [self.manager setDidSelectImageBlock:^(UIImage *img){
        // 讲image 上传
            NSData *imageData = UIImageJPEGRepresentation(img, 0.8);
        NSDictionary *dict  = @{
                                @"shouji":kWltx_userShouji,
                                };
        [weakSelf personInfarmationVC_netwrok_UpIconFileRequest:dict WithImageData:imageData];
        
//        NSData *imageData = UIImageJPEGRepresentation(img, 0.8);
//        NSDictionary *dict  = @{
//                                @"shouji":kWltx_userShouji,
//                                };
//
//        [weakSelf uploadPictureWith:@"http://m.0201566.com/appapi/up.php" parameters:dict data:imageData success:^(id responseObject) {
//            NSLog(@"%@ is res",responseObject);
//        } failure:^(NSError * _Nullable error) {
//
//        }];
    }];
    
}

-(NSData *)imageData:(UIImage *)myimage
{
 NSData *data=UIImageJPEGRepresentation(myimage, 1.0);
if (data.length>1024 *1024) {
    if (data.length>10240*1024) {//10M以及以上
           data=UIImageJPEGRepresentation(myimage, 0.1);//压缩之后1M~
     }else if (data.length>5120*1024){//5M~10M
           data=UIImageJPEGRepresentation(myimage, 0.2);//压缩之后1M~2M
       }else if (data.length>2048*1024){//2M~5M
          data=UIImageJPEGRepresentation(myimage, 0.5);//压缩之后1M~2.5M
      }
         //1M~2M不压缩
  }
    return data;
}

/**
 登陆页面设置 nav
 */
- (void)personalInformation_settingsNav
{
    self.navigationItem.title = @"个人信息";
    self.view.backgroundColor = UIColorFromRGB(0xF5F5F5);
    
}

#pragma 事件操作
- (void)personalInformation_Action1_selectImage
{
    NSLog(@"select image");
    [self.manager quickAlertSheetPickerImage];
}
#pragma mark  ✍🏻(自定义方法) custom method end
#pragma mark - 🎬 按钮/点击事件 Action start

- (IBAction)ClickPersonalInfoSettings:(UIButton *)sender {
    switch (sender.tag) {
        case 10:
        {
            [self personalInformation_Action1_selectImage];
        }
            break;
            
        default:
            break;
    }
    
}
#pragma mark 🎬 按钮/点击事件 Action end


#pragma mark - 📶(网络请求)Network start
// 获取个人信息
- (void)personInfarmationVC_netwrok_getPersonInfoRequest:(NSDictionary *)dict
{
    [AFNetworkingTool getWithURLString:my_getmy_grxx parameters:dict resultClass:nil success:^(id result) {
        NSLog(@"result = %@",result);
        NSDictionary *dataDict = result[@"data"];
        NSString *shouji = dataDict[@"shouji"];
        NSString *yhtype = dataDict[@"yhtype"];
        NSString *name = dataDict[@"name"];
        NSString *img = dataDict[@"img"];
    
        NSLog(@"img = %@",img);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.lb_nickName.text = name;
            self.lb_loginNumber.text = shouji;
            self.lb_lgoinType.text = yhtype;
            
            NSString *strUrl = [img stringByReplacingOccurrencesOfString:@".." withString:@""];
            NSLog(@"正确的图片地址 %@",strUrl);
            // 设置更换本地新的URL
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:strUrl forKey:@"user_img"];
            [defaults synchronize]; // 立即写入
            NSLog(@"defaults 图片地址 %@",[defaults objectForKey:@"user_img"]);

            
            [self.img_userUrl sd_setImageWithURL:[NSURL URLWithString:strUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if (error) {
                    NSLog(@"图片 上传不了错误信息:%@",error);
                }
                else
                {
//                    UIImage *imagea = [UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString:img]]];
//                    self.img_userUrl.image = imagea;

                }

            }];
            
            
            
        });
        
        
    } failure:^(NSError *error) {
        
    }];
}

// 上传图片
- (void)personInfarmationVC_netwrok_UpIconFileRequest:(NSDictionary *)dict WithImageData:(NSData *)imgData
{
    [AFNetworkingTool uploadPictureWith:my_UpiconFile parameters:dict data:imgData success:^(id  _Nonnull responseObject) {
        NSLog(@"请求成功：%@",responseObject);
        NSDictionary *dict = [responseObject mj_JSONObject];
        NSString *status = dict[@"status"];
        NSString *img = dict[@"img"];
        [self.img_userUrl sd_setImageWithURL:[NSURL URLWithString:img]];
        // 图片存储到本地
        NSString *strUrl = [img stringByReplacingOccurrencesOfString:@".." withString:@""];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:strUrl forKey:@"user_img"];
        [defaults synchronize]; // 立即写入
        NSLog(@"defaults 图片地址 %@",[defaults objectForKey:@"user_img"]);

    } failure:^(NSError * _Nullable error) {
        
    }];
    
}

/**
 *  上传单张图片
 */
- (void)uploadPictureWith:(NSString *)URLString
               parameters:(id)parameters
                     data:(NSData *)data
                  success:(nullable void (^)(id  responseObject))success
                  failure:(nullable void (^)(NSError *_Nullable error))failure{
    // 1.请求管理器
    //    AFNetworkReachabilityManager
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    
    //2.取token（项目中的应用）
//    NSString *cookiesdata = [[NSUserDefaults standardUserDefaults] valueForKey:@"token"]?[[NSUserDefaults standardUserDefaults] valueForKey:@"token"]:@"";
    
    //3.传token
//    [sessionManager.requestSerializer setValue:kWltx_userShouji forHTTPHeaderField:@"shouji"];
    NSString *url = @"http://m.0201566.com/appapi/up.php";
//    if ([URLString containsString:BaseAPI]) {
//        url = URLString;
//    }else{
//        url = [NSString stringWithFormat:@"%@%@",BaseAPI,URLString];
//    }
    //2.上传文件
    [sessionManager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        
        NSString *fileName = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
        
        //上传文件参数
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //打印上传进度
        CGFloat progress = 100.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
        NSLog(@"%f",progress);
//        [SVProgressHUD showWithStatus:@"正在上传..."];
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
//        ResponseObject *response = [ResponseObject mj_objectWithKeyValues:responseObject];
        // 回调成功之后的block
//        NSLog(@"%@",response);
        
//        success(response);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [SVProgressHUD dismiss];
        });
        //请求成功
        NSLog(@"请求成功：%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 回调失败之后的block
//        [SVProgressHUD showErrorWithStatus:@"上传失败~"];
//        failure(error);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [SVProgressHUD dismiss];
        });
    }];
}



#pragma mark 📶(网络请求)Network end
#pragma mark - 💤 控件/对象懒加载 object start
- (YH_SystemImagePickerManager *)manager{
    if (!_manager) {
        _manager = [[YH_SystemImagePickerManager alloc] initWithViewController:self];
    }
    return _manager;
}
#pragma mark 💤 控件/对象懒加载 object end

@end


/**
 个人信息
 http://m.0201566.com/appapi/my_grxx.php?shouji=手机号
 get   参数1  shouji=手机号码
 {"data":
 {"shouji":"", 登陆账号
 "name":"",   姓名
 "yhtype":""  用户类型
 "img":""   用户头像， 用户可上传头像
 }
 }
 */



#pragma mark -- 20190513 修改

////
////  WLTX_PersonalInformationViewController.m
////  WLTX
////
////  Created by liyuhong2019 on 2019/4/12.
////  Copyright © 2019 liyuhong165. All rights reserved.
////
//
//#import "WLTX_PersonalInformationViewController.h"
//
//@interface WLTX_PersonalInformationViewController ()
//
//// tool
//@property (nonatomic,strong) YH_SystemImagePickerManager *manager;
//
//
////
//@property (weak, nonatomic) IBOutlet UIImageView *img_userUrl;
//@property (weak, nonatomic) IBOutlet UILabel *lb_area;
//@property (weak, nonatomic) IBOutlet UILabel *lb_nickName;
//@property (weak, nonatomic) IBOutlet UILabel *lb_registerTime;
//@property (weak, nonatomic) IBOutlet UILabel *lb_realNameType;
//
//@end
//
//@implementation WLTX_PersonalInformationViewController
//
//#pragma mark - ♻️ 视图的生命周期 view life cycle start
///*
// 4-1、第一个执行的方法，加载UI：- (void)loadView{ }
// 4-2、第二个执行的方法，加载UI成功后调用：- (void)viewDidLoad{ }
// 4-3、第三个执行方法，UI即将显示时：- (void)viewWillAppear:(BOOL)animated{ }
// 4-4、第四个执行方法，UI已经显示时：- (void)viewDidAppear:(BOOL)animated{ }
// 4-5、第五个执行方法，UI即将消失时：- (void)viewWillDisappear:(BOOL)animated{ }
// 4-6、第六个执行方法，UI已经消失时：- (void)viewDidDisappear:(BOOL)animated{ }
// 4-7、最后执行方法，即视图控制器注销方法：- (void)dealloc { }
// 4-8、该方法在接收到内存警告时会调用，且系统会自动处理内存释放：- (void)didReceiveMemoryWarning { }
// */
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    [self personalInformationVC_settingsInitData];
//
//}
//- (void)dealloc
//{
//    //    [super dealloc];
//    // 移除通知处理
//}
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//
//}
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//}
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//}
//- (void)viewDidDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//}
//
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//}
//#pragma mark ♻️ 视图的生命周期 view life cycle end
//
//
//#pragma mark - 🏃(代理)Delegate start
//#pragma mark 🏃(代理)Delegate end
//#pragma mark - ✍🏻(自定义方法) custom method start
///**
// 登陆页面 初始化数据
// */
//- (void)personalInformationVC_settingsInitData
//{
//    YHLog(@"初始化数据");
//    //    self.view.backgroundColor = [UIColor whiteColor];
//    [self personalInformation_settingsNav];
//
//
//    __weak typeof(self) weakSelf = self;
//    [self.manager setDidSelectImageBlock:^(UIImage *img){
//        weakSelf.img_userUrl.image = img;
//    }];
//
//}
///**
// 登陆页面设置 nav
// */
//- (void)personalInformation_settingsNav
//{
//    self.navigationItem.title = @"个人信息";
//    self.view.backgroundColor = UIColorFromRGB(0xF5F5F5);
//
//}
//
//#pragma 事件操作
//- (void)personalInformation_Action1_selectImage
//{
//    NSLog(@"select image");
//    [self.manager quickAlertSheetPickerImage];
//}
//- (void)personalInformation_Action2_area
//{
//    NSLog(@"选择区域");
//    WLTX_CommonSelectAreaVC *vc = [[WLTX_CommonSelectAreaVC alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
//
//}
//- (void)personalInformation_Action3_go2realName
//{
//    NSLog(@"去实名认证");
//    // 判断是否实名
//    WLTX_RealNameCertificationVC *vc = [[WLTX_RealNameCertificationVC alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
//
//
//}
//
//#pragma mark  ✍🏻(自定义方法) custom method end
//#pragma mark - 🎬 按钮/点击事件 Action start
//
//- (IBAction)ClickPersonalInfoSettings:(UIButton *)sender {
//    switch (sender.tag) {
//        case 10:
//        {
//            [self personalInformation_Action1_selectImage];
//        }
//            break;
//        case 30:
//        {
//            [self personalInformation_Action2_area];
//        }
//            break;
//
//        case 50:
//        {
//            [self personalInformation_Action3_go2realName];
//        }
//            break;
//
//        default:
//            break;
//    }
//
//}
//#pragma mark 🎬 按钮/点击事件 Action end
//
//
//#pragma mark - 📶(网络请求)Network start
//#pragma mark 📶(网络请求)Network end
//#pragma mark - 💤 控件/对象懒加载 object start
//- (YH_SystemImagePickerManager *)manager{
//    if (!_manager) {
//        _manager = [[YH_SystemImagePickerManager alloc] initWithViewController:self];
//    }
//    return _manager;
//}
//#pragma mark 💤 控件/对象懒加载 object end
//
//@end




