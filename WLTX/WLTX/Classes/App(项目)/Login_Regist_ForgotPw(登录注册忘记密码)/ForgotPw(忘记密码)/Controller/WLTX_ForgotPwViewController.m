//#import "WLTX_ForgotPwViewController.h"
//
//@interface WLTX_ForgotPwViewController ()
//
//@end
//
//@implementation WLTX_ForgotPwViewController
//
//
//#pragma mark - ♻️ 视图的生命周期 view life cycle start

#import "WLTX_ForgotPwViewController.h"

@interface WLTX_ForgotPwViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tf_phone;
@property (weak, nonatomic) IBOutlet UITextField *tf_pw;
@property (weak, nonatomic) IBOutlet UITextField *tf_again_pw;
@property (weak, nonatomic) IBOutlet UITextField *tf_code;

@end

@implementation WLTX_ForgotPwViewController


- (IBAction)go2changePassword:(UIButton *)sender {
    
    if (self.tf_phone.text.length == 0 ||self.tf_pw.text.length == 0||self.tf_again_pw.text.length == 0||self.tf_code.text.length == 0 ) {
        [self.view makeToast:@"请检测你的手机号、验证码、密码是不是没有填写"];
        return;
    }
    
    // 3、效验用户输入的是不是正确的手机号、或者密码不能过于简单
    if (![self vcExtion_cheackPhone:self.tf_phone.text]) {
        [self.view makeToast:@"请输入正确的手机号码"];
        return;
    }
    if (self.tf_pw.text.length <8) {
        [self.view makeToast:@"密码不能少于8位数"];
        return;
    }
    
    if (![self.tf_pw.text isEqualToString:self.tf_again_pw.text]) {
        [self.view makeToast:@"两次密码不一致"];
        return;
    }
    
    
    // 2、发送修改密码请求
    
    NSDictionary *dict = @{
                           @"shouji":self.tf_phone.text,
                           @"yzm":self.tf_code.text
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
                           @"shouji":self.tf_phone.text
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
                                   @"shouji":self.tf_phone.text,
                                   @"yzm":self.tf_code.text,
                                   @"password":self.tf_pw.text
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
    
    [self forgotPwVC_settingsInitData];
    [self forgotPwVC_settingsNav];
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


#pragma mark - 🏃(代理)Delegate start
#pragma mark 🏃(代理)Delegate end
#pragma mark - ✍🏻(自定义方法) custom method start

/**
 登陆页面 初始化数据
 */
- (void)forgotPwVC_settingsInitData
{
    YHLog(@"初始化数据");
}
/**
 登陆页面设置 nav
 */
- (void)forgotPwVC_settingsNav
{
    self.navigationItem.title = @"忘记密码";
    
}


#pragma mark ✍🏻 (自定义方法) custom method end

#pragma mark - ✍🏻 (事件处理) event Action start

- (IBAction)changePhoneNumberVC_getVerificationCode:(JKCountDownButton *)sender {
    
    sender.backgroundColor = [UIColor lightGrayColor];
    sender.enabled = NO;
    //button type要 设置成custom 否则会闪动
    [sender startCountDownWithSecond:10];
    
    [sender countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
        //        NSString *title = [NSString stringWithFormat:@"%zd秒",second];
        NSString *title = [NSString stringWithFormat:@"已发送"];
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
//    NSDictionary *dict = @{
//                           @"shouji":self.tf_phone.text
//                           };
    //    [self netwrok_getVerificationCodeRequest:dict];
    
}

//- (IBAction)forgotVC_Action_go2SettingNewPasswordVC:(UIButton *)sender
//{
//    WLTX_ForgotPw2ViewController *setPwVC = [[WLTX_ForgotPw2ViewController alloc]initWithNibName:NSStringFromClass([WLTX_ForgotPw2ViewController class]) bundle:nil
//                                        ];
//    [self.navigationController pushViewController:setPwVC animated:YES];
//
//    
//    
//}
#pragma mark ✍🏻 (事件处理)  event Action end

#pragma mark - 📶(网络请求)Network start
#pragma mark 📶(网络请求)Network end
#pragma mark - 💤 控件/对象懒加载 object start
#pragma mark 💤 控件/对象懒加载 object end

@end
