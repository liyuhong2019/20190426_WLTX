//
//  WLTX_ReleaseCarInfoVC.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/15.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_ReleaseCarInfoVC.h"
#import "UIButton+WebCache.h"
@interface WLTX_ReleaseCarInfoVC ()
<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layout_scrollview_h;
@property (weak, nonatomic) IBOutlet UILabel *lb_city;
@property (weak, nonatomic) IBOutlet UILabel *lb_carlength;


@property (weak, nonatomic) IBOutlet UITextField *tf_carNumber;
@property (weak, nonatomic) IBOutlet UIView *view_line1;
@property (weak, nonatomic) IBOutlet UITextField *tf_carWeight;
@property (weak, nonatomic) IBOutlet UIView *view_line2;

@property (weak, nonatomic) IBOutlet UITextField *tf_location;

@property (weak, nonatomic) IBOutlet UIView *view_line3;
@property (weak, nonatomic) IBOutlet UITextField *tf_phoneNumber;
@property (weak, nonatomic) IBOutlet UIView *view_line4;

@property (weak, nonatomic) IBOutlet UITextField *tf_driverName;
@property (weak, nonatomic) IBOutlet UIView *view_line5;

@property (nonatomic,strong) YH_SystemImagePickerManager *manager;
@property (weak, nonatomic) IBOutlet UIButton *btn_img;

// 车长
@property (strong,nonatomic)  NSArray  *array;
// 图片数据
@property (strong,nonatomic) NSData *data;


@property (strong,nonatomic) NSString *uploadimage;
@end

@implementation WLTX_ReleaseCarInfoVC

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
    [self specialDetailsVC_initData];
}
- (void)dealloc
{
    //    [super dealloc];
    // 移除通知处理
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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


#pragma mark - ✍🏻(自定义方法) custom method start
/**
 登陆页面 初始化数据
 */
- (void)specialDetailsVC_initData
{
    YHLog(@"初始化数据");
    lyh_setting_xib_scrollviewHeight
    [self specialDetailsVC_settingsNav];
    self.array = @[@"面包车",@"3.米",@"4.2米",@"5.2米",@"6.2米",@"6.8米",@"7.6米",@"8.7米",@"9.6米"];
    self.data  =  [[NSData alloc]init];
 
    
    __weak typeof(self) weakSelf = self;
    [self.manager setDidSelectImageBlock:^(UIImage *img){
//        [weakSelf.btn_img setImage:img forState:0];
//        NSData *imageData = UIImagePNGRepresentation(img);
        NSData *imgData = [weakSelf imageZipToData:img];
        
        //        NSData *data = [NSData image]
        weakSelf.data = imgData;
        
        NSDictionary *dict  = @{
                                @"shouji":kWltx_userShouji,
                                };
        [weakSelf personInfarmationVC_netwrok_UpIconFileRequest:dict WithImageData:weakSelf.data];
        
    }];
    
}
- (NSData *)imageZipToData:(UIImage *)newImage{
    
    NSData *data = UIImageJPEGRepresentation(newImage, 1.0);
    
    if (data.length > 500 * 1024) {
        
        if (data.length>1024 * 1024) {//1M以及以上
            
            data = UIImageJPEGRepresentation(newImage, 0.5);
            
        }else if (data.length>512*1024) {//0.5M-1M
            
            data=UIImageJPEGRepresentation(newImage, 0.6);
            
        }else if (data.length>200*1024) { //0.25M-0.5M
            
            data=UIImageJPEGRepresentation(newImage, 0.9);
        }
    }
    return data;
}

/**
 登陆页面设置 nav
 */
- (void)specialDetailsVC_settingsNav
{
    self.navigationItem.title = @"车源信息";
    self.view.backgroundColor = UIColorFromRGB(0xF5F5F5);
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [backButton setImage:[UIImage imageNamed:@"PersonalCenterNew_10"] forState:UIControlStateNormal];
//    [backButton setImage:[UIImage imageNamed:@"PersonalCenterNew_10"] forState:UIControlStateHighlighted];
    [backButton setTitle:@"发布" forState:0];
    [backButton setTitleColor:[UIColor whiteColor] forState:0];
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [backButton addTarget:self action:@selector(specialDetailsVC_go2Share:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}
- (void)specialDetailsVC_go2Share:(UIButton *)btn
{
    if ([self.lb_city.text isEqualToString:@"请选择城市"] ||
[self.lb_carlength.text isEqualToString:@"请选择车辆长度"]) {
        [self.view makeToast:@"城市/车长不能为空"];
        return;
    }
    
    if (self.tf_carNumber.text.length == 0 ||  self.tf_carWeight.text.length == 0
        ||self.tf_location.text.length == 0 ||  self.tf_phoneNumber.text.length == 0
        || self.tf_driverName.text.length ==0
        ) {
        [self.view makeToast:@"车牌号/车载吨数/地址/电话/司机名称不能为空"];
        return;

    }
    
    if (_data.length ==0) {
        [self.view makeToast:@"图片不能为空"];
        return;
    }
    NSLog(@"发布");
    
    [self go2push];
    
}


- (IBAction)go2Action:(UIButton *)sender {
    switch (sender.tag) {
        case 10:
            {
                [self go2SelectCity];
            }
            break;
        case 20:
        {
            [self go2SelectCarLength];
        }
            break;
        case 30:
        {
            [self go2UpdateImage];
        }
        default:
            break;
    }
}

- (void)go2SelectCity
{
    WLTX_CommonSelectAreaVC *vc = [[WLTX_CommonSelectAreaVC alloc]init];
    vc.type = WLTX_CommonSelectAreaType_ReleaseCarInfo;
    vc.block = ^(NSString *cityName, WLTX_CommonSelectAreaType type)
    {
        // 这里需要拿到的是显示的城市 而不是传递的城市 。所以要在内部做一个类型判断
        NSLog(@"回调回来的城市是%@",cityName);
        self.lb_city.text = cityName;
    };
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)go2SelectCarLength
{
    NSLog(@"选择车长");
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"请选择车长" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:self.array[0] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.lb_carlength.text = self.array[0];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:self.array[1] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.lb_carlength.text = self.array[1];
        
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:self.array[2] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.lb_carlength.text = self.array[2];
    }];
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:self.array[3] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.lb_carlength.text = self.array[3];
    }];
    
    UIAlertAction *action5 = [UIAlertAction actionWithTitle:self.array[4] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.lb_carlength.text = self.array[4];
    }];
    UIAlertAction *action6 = [UIAlertAction actionWithTitle:self.array[5] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.lb_carlength.text = self.array[5];
    }];
    UIAlertAction *action7 = [UIAlertAction actionWithTitle:self.array[6] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.lb_carlength.text = self.array[6];
    }];
    UIAlertAction *action8 = [UIAlertAction actionWithTitle:self.array[7] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.lb_carlength.text = self.array[7];
    }];
    UIAlertAction *action9 = [UIAlertAction actionWithTitle:self.array[8] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.lb_carlength.text = self.array[8];
    }];
    UIAlertAction *action10 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    [actionSheet addAction:action1];
    [actionSheet addAction:action2];
    [actionSheet addAction:action3];
    [actionSheet addAction:action4];
    [actionSheet addAction:action5];
    [actionSheet addAction:action6];
    [actionSheet addAction:action7];
    [actionSheet addAction:action8];
    [actionSheet addAction:action9];
    [actionSheet addAction:action10];
    [self presentViewController:actionSheet animated:YES completion:nil];
}
- (void)go2UpdateImage
{
    NSLog(@"select image");
    [self.manager quickAlertSheetPickerImage];

}

- (YH_SystemImagePickerManager *)manager{
    if (!_manager) {
        _manager = [[YH_SystemImagePickerManager alloc] initWithViewController:self];
    }
    return _manager;
}
#pragma 事件操作

#pragma mark  ✍🏻(自定义方法) custom method end

#pragma mark - 🏃(代理)Delegate start
#pragma mark  🏃(代理)Delegate end


// 上传图片
- (void)personInfarmationVC_netwrok_UpIconFileRequest:(NSDictionary *)dict WithImageData:(NSData *)imgData
{
    [AFNetworkingTool uploadPictureWith:Coomon_upCarImg parameters:dict data:imgData success:^(id  _Nonnull responseObject) {
        NSLog(@"请求成功：%@",responseObject);
        NSDictionary *dict = [responseObject mj_JSONObject];
        NSString *status = dict[@"status"];
        NSString *img = self.uploadimage = dict[@"imgurl"];
        [self.btn_img sd_setBackgroundImageWithURL:[NSURL URLWithString:img] forState:0];
        
//        [self.btn_img ]
        // 图片存储到本地
        NSString *strUrl = [img stringByReplacingOccurrencesOfString:@".." withString:@""];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:strUrl forKey:@"user_img"];
        [defaults synchronize]; // 立即写入
        NSLog(@"defaults 图片地址 %@",[defaults objectForKey:@"user_img"]);
        
    } failure:^(NSError * _Nullable error) {
        
    }];
    
}

#pragma mark - tf
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.view_line1.backgroundColor = [UIColor lightGrayColor];
    self.view_line2.backgroundColor = [UIColor lightGrayColor];
    self.view_line3.backgroundColor = [UIColor lightGrayColor];
    self.view_line4.backgroundColor = [UIColor lightGrayColor];
    self.view_line5.backgroundColor = [UIColor lightGrayColor];

    if (textField == self.tf_carNumber) {
        self.view_line1.backgroundColor = RGB(255, 72, 139);
    }
    else if (textField == self.tf_carWeight)
    {
        self.view_line2.backgroundColor = RGB(255, 72, 139);
    }
    
    else if (textField == self.tf_location)
    {
        self.view_line3.backgroundColor = RGB(255, 72, 139);
    }
    else if (textField == self.tf_phoneNumber)
    {
        self.view_line4.backgroundColor = RGB(255, 72, 139);
    }
    else if (textField == self.tf_driverName)
    {
        self.view_line5.backgroundColor = RGB(255, 72, 139);
    }
    
    

}

// http://m.0201566.com/appapi/up_cheyuan.php

#pragma mark -
- (void)go2push
{
    // 4、发送注册请求
    // ....
    
    NSDictionary *dict = @{
                           @"fblx":@"3",
                           @"shouji":kWltx_userShouji,
                           @"city":self.tf_location.text,
                           @"length":self.lb_carlength.text,
                           @"img":self.uploadimage,
                           @"chepai":self.tf_carNumber.text,
                           @"chezai":self.tf_carWeight.text,
                           @"dizhi":self.tf_location.text,
                           @"tel":self.tf_phoneNumber.text,
                           @"siji":self.tf_driverName.text
                           };
    [self netwrok_ReleaseRequest:dict];
}
// http://m.0201566.com/appapi/up_cheyuan.php

// go2 net
- (void)netwrok_ReleaseRequest:(NSDictionary *)dict
{
    NSLog(@"登录__网络请求");
    [AFNetworkingTool postWithURLString:Coomon_Release parameters:dict resultClass:nil success:^(id result) {
        NSLog(@"result = %@",[result mj_JSONString]);
        NSDictionary *dataDict = result;
        NSString *status = dataDict[@"status"];
        NSLog(@"");
        if ([status integerValue] == 1) {
            [self.view makeToast:@"添加成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        else
        {
            [self.view makeToast:status];
        }
        
    } failure:^(NSError *error) {
        NSString *errorMsg = [NSString stringWithFormat:@"%@",[error.localizedDescription mj_JSONString]];
        [self.view makeToast:errorMsg];
        
    }];
}

@end
