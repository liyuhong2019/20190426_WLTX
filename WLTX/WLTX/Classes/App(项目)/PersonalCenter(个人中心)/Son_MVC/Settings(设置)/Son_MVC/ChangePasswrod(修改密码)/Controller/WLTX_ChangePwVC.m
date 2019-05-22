//
//  WLTX_ChangePwVC.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/4/29.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_ChangePwVC.h"

@interface WLTX_ChangePwVC ()
@property (weak, nonatomic) IBOutlet UILabel *lb_phone;
@property (weak, nonatomic) IBOutlet UITextField *tf_verificationCode;
@property (weak, nonatomic) IBOutlet UITextField *tf_newPw;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layout_scrollview_h;

@end

@implementation WLTX_ChangePwVC

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
    [self changePwVC_initData];
}
- (void)dealloc
{
    //    [super dealloc];
    // 移除通知处理
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%s,在这里判断用户是否登录 如果没有登录。弹出登录界面",__func__);
    
//    self.layout_scrollview_h.constant = [UIScreen mainScreen].bounds.size.height;
    lyh_setting_xib_scrollviewHeight
    
//    NSLog(@"%2f",[UIScreen mainScreen].bounds.size.height);
//    NSLog(@"%2f",xib_iphonex_ScrollviewH);
//
//    if (IS_IPHONE_X||IS_IPHONE_Xs_Max||IS_IPHONE_Xr||IS_IPHONE_Xs) {
//        self.layout_scrollview_h.constant = xib_iphonex_ScrollviewH;
//    }
//    else
//    {
//        self.layout_scrollview_h.constant = xib_iphone678_ScrollviewH;
//    }
    
    //    WLTX_LoginViewController *lgVC = [[WLTX_LoginViewController alloc]initWithNibName:NSStringFromClass([WLTX_LoginViewController class]) bundle:nil];
    //    LYHNavigationController *nav = [[LYHNavigationController alloc] initWithRootViewController:lgVC];
    //    [self presentViewController:nav animated:YES completion:nil];
    
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
- (void)changePwVC_initData
{
    YHLog(@"初始化数据");
    //    self.view.backgroundColor = [UIColor whiteColor];
    [self changePwVC_settingsNav];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *phone =  [userDefault objectForKey:@"user_shouji"];
    self.lb_phone.text = phone;
    
}


/**
 修改密码页面设置 nav
 */
- (void)changePwVC_settingsNav
{
    self.navigationItem.title = @"修改密码";
    self.view.backgroundColor = UIColorFromRGB(0xF5F5F5);
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [backButton setImage:[UIImage imageNamed:@"设置"] forState:UIControlStateNormal];
//    [backButton setImage:[UIImage imageNamed:@"设置"] forState:UIControlStateHighlighted];
    [backButton setTitle:@"保存" forState:0];
    [backButton setTitleColor:[UIColor blackColor] forState:0];
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [backButton addTarget:self action:@selector(saveChange:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
}
- (void)saveChange:(UIButton *)btn
{
//    MyFunc
    // 1、先检测手机号、验证码、密码是不是空的
    if (self.tf_verificationCode.text.length == 0 || self.tf_newPw.text.length == 0) {
        [self.view makeToast:@"请检测你的验证码、密码是不是没有填写"];
        return;
    }
    
    
    
    if (self.tf_newPw.text.length <8) {
        [self.view makeToast:@"密码不能少于8位数"];
        return;
    }
    
    // 2、发送修改密码请求
    
    NSDictionary *dict = @{
                           @"shouji":self.lb_phone.text,
                           @"yzm":self.tf_verificationCode.text
                           };
    [self netwrok_isRightVerificationCodeRequest:dict];
    
}
#pragma 事件操作
//- (void)settings_Action1_changePhoneNumber
//{
//    NSLog(@"change phone");
//}
//- (void)settings_Action2_resetPassword
//{
//    NSLog(@"reast password");
//
//
//}
//- (void)personalInformation_Action3_CheckVersionOnUpdate
//{
//    NSLog(@"check version");
//}

#pragma mark  ✍🏻(自定义方法) custom method end
#pragma mark - 🎬 按钮/点击事件 Action start

- (IBAction)go2SaveNewPw:(UIButton *)sender {
//    MyFunc
    
    // 1、先检测手机号、验证码、密码是不是空的
    if (self.tf_verificationCode.text.length == 0 || self.tf_newPw.text.length == 0) {
        [self.view makeToast:@"请检测你的验证码、密码是不是没有填写"];
        return;
    }
    
  
    
    if (self.tf_newPw.text.length <8) {
        [self.view makeToast:@"密码不能少于8位数"];
        return;
    }
    
    // 2、发送修改密码请求
    
    NSDictionary *dict = @{
                           @"shouji":self.lb_phone.text,
                           @"yzm":self.tf_verificationCode.text
                           };
    [self netwrok_isRightVerificationCodeRequest:dict];
}


- (IBAction)changeVC_getVerificationCode:(JKCountDownButton *)sender {
    
    sender.backgroundColor = [UIColor lightGrayColor];
    sender.enabled = NO;
    //button type要 设置成custom 否则会闪动
    [sender startCountDownWithSecond:60];
    
    [sender countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
        NSString *title = [NSString stringWithFormat:@"%zd秒",second];
//        NSString *title = [NSString stringWithFormat:@"已发送"];
        return title;
    }];
    [sender countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
        //        countDownButton.enabled = YES;
        //        return @"点击重新获取";
        countDownButton.backgroundColor = UIColorFromRGB(0xFFAA24) ;
        countDownButton.enabled = YES;
        return @"发送验证码";
        
    }];
    // 发送网络请求
    NSDictionary *dict = @{
                           @"shouji":self.lb_phone.text
                           };
        [self netwrok_getVerificationCodeRequest:dict];
    
}
#pragma mark - 📶(网络请求)Network start

// 获取验证码
- (void)netwrok_getVerificationCodeRequest:(NSDictionary *)dict
{
    [AFNetworkingTool postWithURLString:my_getVerificationCode parameters:dict resultClass:nil success:^(id result) {
        NSLog(@"result = %@",[result mj_JSONString]);
        NSDictionary *dataDict = result;
        NSString *status = dataDict[@"status"];
        if ([status intValue]) {
            [self.view makeToast:@"发送短信验证码成功"];
        }
        else
        {
            [self.view makeToast:@"发送失败"];
        }
        
    } failure:^(NSError *error) {
        NSString *errorMsg = [NSString stringWithFormat:@"%@",[error.localizedDescription mj_JSONString]];
        [self.view makeToast:errorMsg];
        
    }];
}

- (void)netwrok_isRightVerificationCodeRequest:(NSDictionary *)dict
{
    [AFNetworkingTool postWithURLString:my_isRightVerificationCode parameters:dict resultClass:nil success:^(id result) {
        NSLog(@"验证码核对 result = %@",[result mj_JSONString]);
        NSDictionary *dataDict = result;
        NSString *status = dataDict[@"status"];
        if ([status intValue]) {
            //            [self.view makeToast:@"证码正确"];
            
            // 验证码通过之后 才去注册
          
            NSDictionary *dict = @{
                                   @"shouji":self.lb_phone.text,
                                   @"yzm":self.tf_verificationCode.text,
                                   @"password":self.tf_newPw.text
                                   };
            [self netwrok_changePasswordRequest:dict];
        }
        else
        {
            [self.view makeToast:@"验证码错误"];
        }
        
    } failure:^(NSError *error) {
        NSString *errorMsg = [NSString stringWithFormat:@"%@",[error.localizedDescription mj_JSONString]];
        [self.view makeToast:errorMsg];
        
    }];
}

// 修改密码

- (void)netwrok_changePasswordRequest:(NSDictionary *)dict
{
    [AFNetworkingTool postWithURLString:my_changePasswrod parameters:dict resultClass:nil success:^(id result) {
        NSLog(@"result = %@",[result mj_JSONString]);
        NSDictionary *dataDict = result;
        NSString *status = dataDict[@"status"];
        if ([status intValue]) {
            [self.view makeToast:@"修改密码成功,请下一次使用新密码登录"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        else
        {
            [self.view makeToast:@"修改失败"];
        }
        
    } failure:^(NSError *error) {
        NSString *errorMsg = [NSString stringWithFormat:@"%@",[error.localizedDescription mj_JSONString]];
        [self.view makeToast:errorMsg];
        
    }];
}
@end
