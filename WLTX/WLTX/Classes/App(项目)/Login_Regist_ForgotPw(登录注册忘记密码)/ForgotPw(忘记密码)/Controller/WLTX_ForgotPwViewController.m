#import "WLTX_ForgotPwViewController.h"

@interface WLTX_ForgotPwViewController ()

@end

@implementation WLTX_ForgotPwViewController


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
