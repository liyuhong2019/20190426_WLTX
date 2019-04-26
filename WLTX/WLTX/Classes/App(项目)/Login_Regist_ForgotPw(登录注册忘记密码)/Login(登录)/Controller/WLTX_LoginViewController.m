

#import "WLTX_LoginViewController.h"

@interface WLTX_LoginViewController ()

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
- (void)loginVC_settingsInitData
{
    YHLog(@"初始化数据");
    
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

#pragma mark ✍🏻 (事件处理)  event Action end

#pragma mark - 📶(网络请求)Network start
#pragma mark 📶(网络请求)Network end
#pragma mark - 💤 控件/对象懒加载 object start
#pragma mark 💤 控件/对象懒加载 object end

@end
