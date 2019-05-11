

#import "WLTX_LoginViewController.h"

@interface WLTX_LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *view_content;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layout_h;
@property (weak, nonatomic) IBOutlet UITextField *tf_phone;
@property (weak, nonatomic) IBOutlet UITextField *tf_password;

@end

@implementation WLTX_LoginViewController

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
    
    [self loginVC_settingsInitData];
    [self loginVC_settingsNav];
}
- (void)dealloc
{
    //    [super dealloc];
    // 移除通知处理
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.layout_h.constant = [UIScreen mainScreen].bounds.size.height;
    
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
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.tf_phone) {
        
        if (textField.text.length > 11) {
            return NO;
        }
        
    }
  
    return YES;
    
}
#pragma mark 🏃(代理)Delegate end
#pragma mark - ✍🏻(自定义方法) custom method start

/**
 登陆页面 初始化数据
 */
- (void)loginVC_settingsInitData
{
    YHLog(@"初始化数据");
/* 测试账号信息*/
    self.tf_phone.text = @"13246301428";
    self.tf_password.text = @"12345678";
    
}
/**
 登陆页面设置 nav
 */
- (void)loginVC_settingsNav
{
    self.navigationItem.title = @"登陆";
    
    //自定义返回按钮图片样式
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateHighlighted];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:15];
    // 让按钮内部的所有内容左对齐
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backButton addTarget:self action:@selector(loginVC_Action_Back) forControlEvents:UIControlEventTouchUpInside];
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0); // 这里微调返回键的位置可以让它看上去和左边紧贴
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}


#pragma mark ✍🏻 (自定义方法) custom method end

#pragma mark - ✍🏻 (事件处理) event Action start

- (void)loginVC_Action_Back
{
    [self dismissViewControllerAnimated:YES completion:nil];
    // 通知点击回到首页
}
- (IBAction)loginVC_Action_go2RegistVC:(UIButton *)sender {
    
    WLTX_RegistViewController *rgVC = [[WLTX_RegistViewController alloc]initWithNibName:NSStringFromClass([WLTX_RegistViewController class]) bundle:nil];
    
    [self.navigationController pushViewController:rgVC animated:YES];
}
- (IBAction)loginVC_Action_go2ForgotPwVC:(UIButton *)sender
{
    WLTX_ForgotPwViewController *fgVC = [[WLTX_ForgotPwViewController alloc]initWithNibName:NSStringFromClass([WLTX_ForgotPwViewController class]) bundle:nil];

    [self.navigationController pushViewController:fgVC animated:YES];
}


- (IBAction)go2LoginCheckInputInfo:(UIButton *)sender {
    [self loginVC_checkInputInfo];
}
- (void)loginVC_checkInputInfo
{
    // 2、先检测手机号、验证码、密码是不是空的
    if (self.tf_phone.text.length == 0 ||  self.tf_password.text.length == 0) {
        [self.view makeToast:@"请检测你的手机号、密码是不是没有填写"];
        return;
    }
    
    // 3、效验用户输入的是不是正确的手机号、或者密码不能过于简单
    if (![self vcExtion_cheackPhone:self.tf_phone.text]) {
        [self.view makeToast:@"请输入正确的手机号码"];
        return;
    }
    
//    if (self.tf_password.text.length <8) {
//        [self.view makeToast:@"密码不能少于8位数"];
//        return;
//    }
    
    
    // 4、发送注册请求
    // ....
    
    NSDictionary *dict = @{
                           @"shouji":self.tf_phone.text,
                           @"password":self.tf_password.text
                           };
    [self netwrok_LoginRequest:dict];
}

#pragma mark ✍🏻 (事件处理)  event Action end

#pragma mark - 📶(网络请求)Network start
- (void)netwrok_LoginRequest:(NSDictionary *)dict
{
    NSLog(@"登录__网络请求");
    [AFNetworkingTool postWithURLString:my_login parameters:dict resultClass:nil success:^(id result) {
        NSLog(@"result = %@",[result mj_JSONString]);
        NSDictionary *dataDict = result;
        NSString *status = dataDict[@"status"];
        NSDictionary *user = dataDict[@"user"];
        if ([status intValue]) {
            [self.view makeToast:@"登录成功"];
            // .... 因此界面 并且设置用户的手机号和名称
            NSString *user_shouji = user[@"shouji"];
            NSString *user_name = user[@"name"];
            NSString *user_img = user[@"img"];
            
            NSLog(@"手机 is %@\n昵称 is %@\n头像 is %@",user_shouji,user_name,user_img);

            // ... 将数据存储到本地
            
//            1、NSUserDefaults 用来存储 用户设置 系统配置等一些小的数据。2、NSUserDefaults 是定时把缓存中的数据写入磁盘的，而不是即时写入，为了防止在写完NSUserDefaults后程序退出导致的数据丢失，可以在写入数据后使用synchronize强制立即将数据写入磁盘：
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            //1、获取 NSUserDefaults 单例
            [defaults setObject:user_shouji forKey:@"user_shouji"];
            //将数据保存到系统配置里面
            [defaults setObject:user_name forKey:@"user_name"];
            [defaults setObject:user_img forKey:@"user_img"];
            [defaults synchronize]; // 立即写入

            // ... 做页面的变化
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            [self.view makeToast:@"登录失败"];
        }
        
    } failure:^(NSError *error) {
        NSString *errorMsg = [NSString stringWithFormat:@"%@",[error.localizedDescription mj_JSONString]];
        [self.view makeToast:errorMsg];
        
    }];
}
#pragma mark 📶(网络请求)Network end
#pragma mark - 💤 控件/对象懒加载 object start
#pragma mark 💤 控件/对象懒加载 object end

@end
