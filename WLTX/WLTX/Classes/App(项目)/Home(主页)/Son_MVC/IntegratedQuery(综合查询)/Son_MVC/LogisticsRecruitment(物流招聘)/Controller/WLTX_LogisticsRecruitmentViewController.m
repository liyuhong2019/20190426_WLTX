// 物流招聘

#import "WLTX_LogisticsRecruitmentViewController.h"

@interface WLTX_LogisticsRecruitmentViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation WLTX_LogisticsRecruitmentViewController

NSString *WLT_LogisticsRecruitmentCellID = @"WLT_LogisticsRecruitmentCell";


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
    [self personalCenterVC_initData];
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
#pragma mark Tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    //    cell.textLabel.text = @"11";
    NSArray *arrayIcons = @[@"收藏",@"个人信息",@"修改密码-1",@"关于我们",@"贡献值",@"修改密码"];
    NSArray *arrayTitles = @[@"收藏",@"个人信息",@"我的发布",@"关于我们",@"贡献值",@"修改密码"];
    WLT_LogisticsRecruitmentCell *cell = [tableView dequeueReusableCellWithIdentifier:WLT_LogisticsRecruitmentCellID];
    
//    cell.img_icon.image = [UIImage imageNamed:arrayIcons[indexPath.row]];
//    cell.lb_title.text = arrayTitles[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO]; // 设置取消点击效果
}

#pragma mark 🏃(代理)Delegate end
#pragma mark - ✍🏻(自定义方法) custom method start
- (void)personalCenterVC_initData
{
    [self personalCenterVC_settingsNav];
    [self personalCenterVC_registPersonalCellID];
    //
#warning 这里导航栏会因为系统问题 导致导航栏颜色的色差、这里只能设置背景图片才能导致颜色一样
    //    [self.navigationController.navigationBar setBackgroundImage: [UIImage imageNamed:@"bg"] forBarMetrics:UIBarMetricsDefault];
    // 横线删除
    //    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
- (void)personalCenterVC_settingsNav
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"设置"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"设置"] forState:UIControlStateHighlighted];
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [backButton addTarget:self action:@selector(personalCenterVC_go2SettingsVC:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

- (void)personalCenterVC_go2SettingsVC:(UIButton *)btn
{
    YHLog(@"跳转到设置界面");
}

- (void)personalCenterVC_registPersonalCellID
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WLT_LogisticsRecruitmentCell class]) bundle:nil] forCellReuseIdentifier:WLT_LogisticsRecruitmentCellID];
}



#pragma mark ✍🏻 (自定义方法) custom method end
#pragma mark - 📶(网络请求)Network start
#pragma mark 📶(网络请求)Network end
#pragma mark - 💤 控件/对象懒加载 object start
#pragma mark 💤 控件/对象懒加载 object end



@end
