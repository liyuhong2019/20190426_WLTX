#import "WLTX_RegistViewController.h"

@interface WLTX_RegistViewController ()
@property (weak, nonatomic) IBOutlet UIView *view_phone;
@property (weak, nonatomic) IBOutlet UIView *view_verificationCode;
@property (weak, nonatomic) IBOutlet UIView *view_password;

// 文本框
@property (weak, nonatomic) IBOutlet UITextField *tf_phone;
@property (weak, nonatomic) IBOutlet UITextField *tf_code;
@property (weak, nonatomic) IBOutlet UITextField *tf_password;

// 按钮
@property (weak, nonatomic) IBOutlet JKCountDownButton *btn_getVerificationCode;
@property (weak, nonatomic) IBOutlet UIButton *btn_dirver;
@property (weak, nonatomic) IBOutlet UIButton *btn_shipper;
@property (weak, nonatomic) IBOutlet UIButton *btn_logisticsCompany;

@end

@implementation WLTX_RegistViewController
{
    RegistType registType;
    UserAgreement userAgreement;
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
    
    [self registVC_settingsInitData];
    [self registVC_settingsNav];
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
- (void)registVC_settingsInitData
{
    YHLog(@"初始化数据");
    self.btn_getVerificationCode.layer.cornerRadius = 13;
    self.btn_getVerificationCode.layer.masksToBounds = YES;
    
    registType = RegistType_Dirver;  // 注册类型默认是 司机
    userAgreement = UserAgreement_Agreed ; // 用户协议 默认是同意的
    
//    self.tf_phone.text = @"13246301428";
//    self.tf_code.text = @"1234";
//    self.tf_password.text = @"12345678";
    
}
/**
 登陆页面设置 nav
 */
- (void)registVC_settingsNav
{
    self.navigationItem.title = @"用户注册";
    self.view.backgroundColor = UIColorFromRGB(0xF5F5F5);
    
    //自定义返回按钮图片样式
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateHighlighted];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:15];
    // 让按钮内部的所有内容左对齐
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backButton addTarget:self action:@selector(registerVC_Action_Back) forControlEvents:UIControlEventTouchUpInside];
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0); // 这里微调返回键的位置可以让它看上去和左边紧贴
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

// 功能方法

- (void)function_SelectUserType:(UIButton *)sender
{
    self.btn_dirver.selected = NO;
    self.btn_shipper.selected = NO;
    self.btn_logisticsCompany.selected = NO;
    
    switch (sender.tag) {
        case RegistType_Dirver:
        {
            self.btn_dirver.selected = YES;
            NSLog(@"司机");
            //                [self cheackemail];
        }
            break;
        case RegistType_Shipper:
        {
            self.btn_shipper.selected = YES;
            NSLog(@"货主");
        }
            break;
        case RegistType_LogisticsCompany:
        {
            self.btn_logisticsCompany.selected = YES;
            NSLog(@"物流公司");
        }
            break;
            
        default:
            break;
    }
    
    // 点击之后 设置注册类型
    registType = sender.tag;
    NSLog(@"注册类型是 %ld",registType);
}

// 检测用户填写资料是否正确
- (void)function_CheckUserInfo
{
    // 判断用户信息
    // 1、如果不遵循协议直接提示
    if (!userAgreement) {
        [self.view makeToast:@"请遵守协议才能注册"];
        return;
    }
    // 2、先检测手机号、验证码、密码是不是空的
    if (self.tf_phone.text.length == 0 || self.tf_code.text.length == 0 || self.tf_password.text.length == 0) {
        [self.view makeToast:@"请检测你的手机号、验证码、密码是不是没有填写"];
        return;
    }
    
    // 3、效验用户输入的是不是正确的手机号、或者密码不能过于简单
    if (![self cheackPhone:self.tf_phone.text]) {
        [self.view makeToast:@"请输入正确的手机号码"];
        return;
    }
    
    if (self.tf_password.text.length <8) {
        [self.view makeToast:@"密码不能少于8位数"];
        return;
    }
    
    
    // 4、发送注册请求
    // ....
    
    NSDictionary *dict = @{
                           @"shouji":self.tf_phone.text,
                           @"yzm":self.tf_code.text
                           };
    [self netwrok_isRightVerificationCodeRequest:dict];
    
    // 5、最终提示 注册成功 是否要跳转到那个界面
//    [self.view makeToast:@"注册成功"];
}

#pragma mark ✍🏻 (自定义方法) custom method end

#pragma mark - ✍🏻 (事件处理) event Action start
- (void)registerVC_Action_Back
{
    [self dismissViewControllerAnimated:YES completion:nil];
    // 通知点击回到首页
}
- (IBAction)registerVC_SelectUserType:(UIButton *)sender {
    [self function_SelectUserType:sender];
}

- (IBAction)registVC_go2SelectUserArggmentIsAgreed:(UIButton *)sender {
    sender.selected = !sender.selected;
    NSLog(@"%ld ",sender.selected);
    userAgreement = sender.selected;
    NSLog(@"是否同意遵循协议 %ld ",userAgreement);
}

- (IBAction)registVC_go2UserAgreement:(UIButton *)sender
{
    WLTX_UserAgreementViewController *vc = [[WLTX_UserAgreementViewController alloc]initWithNibName:NSStringFromClass([WLTX_UserAgreementViewController class]) bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)registerVC_getVerificationCode:(JKCountDownButton *)sender {
    
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
    NSDictionary *dict = @{
                           @"shouji":self.tf_phone.text
                           };
    [self netwrok_getVerificationCodeRequest:dict];

}


// 检查资料是否合法 如果合法提示注册成功

- (IBAction)registerVC_go2CheckUserInfo:(UIButton *)sender {
    
    [self function_CheckUserInfo];

    
}


#pragma mark ✍🏻 (事件处理)  event Action end

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

/** 效验 验证码是否正确
    手机号
    验证码
 */

- (void)netwrok_isRightVerificationCodeRequest:(NSDictionary *)dict
{
    [AFNetworkingTool postWithURLString:my_isRightVerificationCode parameters:dict resultClass:nil success:^(id result) {
        NSLog(@"result = %@",[result mj_JSONString]);
        NSDictionary *dataDict = result;
        NSString *status = dataDict[@"status"];
        if ([status intValue]) {
//            [self.view makeToast:@"证码正确"];
            
            // 验证码通过之后 才去注册
            NSString *yhtype = @"";
            switch (registType) {
                case RegistType_Dirver:
                {
                    yhtype = @"司机";
                }
                    break;
                case RegistType_Shipper:
                {
                    yhtype = @"货主";
                }
                    break;
                case RegistType_LogisticsCompany:
                {
                    yhtype = @"物流公司";
                }
                    break;
                default:
                    break;
            }
            NSLog(@"注册的用户类型是 %@",yhtype);
            NSDictionary *dict = @{
                                 @"yhtype":yhtype,
                                 @"xingming":self.tf_phone.text,
                                 @"shouji":self.tf_phone.text,
                                 @"yzm":self.tf_code.text,
                                 @"password":self.tf_password.text,
                                 @"yhxy":@"1",

                                 };
            [self netwrok_registerUserInfoReqeust:dict];
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

// 注册用户信息
-(void)netwrok_registerUserInfoReqeust:(NSDictionary *)dict
{
    [AFNetworkingTool postWithURLString:my_registerUserInfo parameters:dict resultClass:nil success:^(id result) {
        NSLog(@"result = %@",[result mj_JSONString]);
        NSDictionary *dataDict = result;
        NSString *status = dataDict[@"status"];
        switch ([status intValue]) {
            case 1:
                {
                    [self.view makeToast:@"注册成功"];
                    return ;
                }
                break;
            case 0:
            {
                [self.view makeToast:@"注册失败"];
                return ;
            }
                break;
            case 2:
            {
                [self.view makeToast:@"手机号已存在"];
                return ;
            }
                break;
            case 3:
            {
                [self.view makeToast:@"短信验证码错误"];
                return ;
            }
                break;
            default:
                break;
        }
        
        
    } failure:^(NSError *error) {
        NSString *errorMsg = [NSString stringWithFormat:@"%@",[error.localizedDescription mj_JSONString]];
        [self.view makeToast:errorMsg];
        
    }];
}


#pragma mark 📶(网络请求)Network end
#pragma mark - 💤 控件/对象懒加载 object start
#pragma mark 💤 控件/对象懒加载 object end
// 正则效验
- (BOOL)cheackPhone:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|18[0-9]|14[57])[0-9]{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    // 看到这里我们会发现evaluateWithObject:方法返回的是一个BOOL值，如果符合条件就返回YES，不符合就返回NO。
    BOOL isValid =
    [phoneTest evaluateWithObject:mobile];
    NSLog(@"是不是手机 %d",isValid);
    return isValid;
}


- (void)cheackemail
{
//    NSString *email = @"135343029899";
////    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
//    NSString *regex = @"(0|86|17951)?(13[0-9]|15[012356789]|18[0-9]|14[57])[0-9]{8}$";
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    BOOL isValid = [predicate evaluateWithObject:email];
    
    
    NSString *mobile = @"13534302989";
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|18[0-9]|14[57])[0-9]{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    BOOL isValid =
    [phoneTest evaluateWithObject:mobile];
    
    NSLog(@"是不是邮箱 %d",isValid);
}
@end
