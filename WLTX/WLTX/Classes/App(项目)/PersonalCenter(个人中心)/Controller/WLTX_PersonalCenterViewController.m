//
//  WLTX_PersonalCenterViewController.m
//  WLTX
//
//  Created by lee on 2019/3/6.
//  Copyright © 2019年 liyuhong165. All rights reserved.
//

#import "WLTX_PersonalCenterViewController.h"
@interface WLTX_PersonalCenterViewController ()
<UITableViewDelegate,UITableViewDataSource
>


// 视图控件
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *view_login;
@property (weak, nonatomic) IBOutlet UIView *view_isLogin;
@property (weak, nonatomic) IBOutlet UILabel *lb_name;
@property (weak, nonatomic) IBOutlet UILabel *lb_phone;
@property (weak, nonatomic) IBOutlet UIImageView *img_icon;

@end

@implementation WLTX_PersonalCenterViewController

NSString *WLTX_PersonalCenterCellID = @"WLTX_PersonalCenterCell";


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
    
    [self checkUserisLogin];
    
//    WLTX_LoginViewController *lgVC = [[WLTX_LoginViewController alloc]initWithNibName:NSStringFromClass([WLTX_LoginViewController class]) bundle:nil];
//    LYHNavigationController *nav = [[LYHNavigationController alloc] initWithRootViewController:lgVC];
//    [self presentViewController:nav animated:YES completion:nil];
    
}
- (void)checkUserisLogin
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *user_name =  [userDefault objectForKey:@"user_name"];
    NSString *user_shouji =  [userDefault objectForKey:@"user_shouji"];
    NSString *user_img =  [userDefault objectForKey:@"user_img"];
    NSLog(@"手机 is %@\n昵称 is %@\n头像 is %@",user_shouji,user_name,user_img);
    if (user_shouji == nil && user_name == nil) {
        NSLog(@"显示登录UI");
        self.view_isLogin.hidden = YES;
        self.view_login.hidden = NO;
//        self.img_icon.hidden = YES;
        self.img_icon.image = [UIImage imageNamed:@"头像"];
    }
    else
    {
        NSLog(@"显示用户数据");
        self.lb_name.text = user_name;
        self.lb_phone.text = user_shouji;
        self.view_isLogin.hidden = NO;
        self.view_login.hidden = YES;
        self.img_icon.hidden = NO;
        
        NSString *strUrl = [user_img stringByReplacingOccurrencesOfString:@".." withString:@""];
        NSLog(@"正确的图片地址");
        [self.img_icon sd_setImageWithURL:[NSURL URLWithString:strUrl]];
    }
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[AppProject getInstance].gloalBtn setHidden:NO];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[AppProject getInstance].gloalBtn setHidden:YES];
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
    NSArray *arrayIcons = @[@"收藏",@"个人信息",@"修改密码-1",@"关于我们",@"贡献值",@"PersonalCenterNew_39"];
    NSArray *arrayTitles = @[@"收藏",@"个人信息",@"我的发布",@"关于我们",@"贡献值",@"设置"];
    WLTX_PersonalCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:WLTX_PersonalCenterCellID];
    
    cell.img_icon.image = [UIImage imageNamed:arrayIcons[indexPath.row]];
    cell.lb_title.text = arrayTitles[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO]; // 设置取消点击效果
    
    
    UIViewController *vc;
    switch (indexPath.row) {
        case 0:
        {
            checkisLogin
            vc = [[WLTX_CollectionViewController alloc]init];
        }
            break;
        case 1:
        {
            checkisLogin
            vc = [[WLTX_PersonalInformationViewController alloc]init];
        }
            break;
        case 2:
        {
            checkisLogin
            
//            if (!kWltx_IsLogin) {
//                WLTX_LoginViewController *lg = [[WLTX_LoginViewController alloc]initWithNibName:NSStringFromClass([WLTX_LoginViewController class]) bundle:nil];
//                LYHNavigationController *nav = [[LYHNavigationController alloc]initWithRootViewController:lg];
//                [self presentViewController:nav animated:YES completion:nil];
//                return;
//            }

            vc = [[WLTX_IReleaseViewController alloc]init];
        }
            break;

        case 3:
        {
//            vc = [[WLTX_AboutUsViewController alloc]init];
            vc = [[WLTX_CommonWebVC alloc]initWithWLTX_CommonWebType:WLTX_CommonWebType_AboutUs AndNavTitle:@"关于我们"];

        }
            break;

        case 4:
        {
            checkisLogin
            vc = [[WLTX_ContributionValueViewController alloc]init];
        }
            break;

        case 5:
        {
//            vc = [[WLTX_ChangePasswordViewController
//                   alloc]init];
            vc = [[WLTX_SettingsViewController alloc]init];

        }
            break;

        default:
            break;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 🏃(代理)Delegate end
#pragma mark - ✍🏻(自定义方法) custom method start
- (void)personalCenterVC_initData
{
//    [self personalCenterVC_settingsNav];
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
    WLTX_SettingsViewController *sVC = [[WLTX_SettingsViewController alloc]initWithNibName:NSStringFromClass([WLTX_SettingsViewController class]) bundle:nil];
    [self.navigationController pushViewController:sVC animated:YES];
}

- (void)personalCenterVC_registPersonalCellID
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WLTX_PersonalCenterCell class]) bundle:nil] forCellReuseIdentifier:WLTX_PersonalCenterCellID];
}

- (IBAction)go2Login:(UIButton *)sender {
    WLTX_LoginViewController *lg = [[WLTX_LoginViewController alloc]initWithNibName:NSStringFromClass([WLTX_LoginViewController class]) bundle:nil];
    
    LYHNavigationController *nav = [[LYHNavigationController alloc]initWithRootViewController:lg];
    [self presentViewController:nav animated:YES completion:nil];
}
- (IBAction)go2Regist:(UIButton *)sender {
//    WLTX_LogisticsRecruitmentViewController *vc = [[WLTX_LogisticsRecruitmentViewController alloc]initWithNibName:NSStringFromClass([WLTX_LogisticsRecruitmentViewController class]) bundle:nil];
//    [self presentViewController:vc animated:YES completion:nil];

//    [self.navigationController pushViewController:vc animated:YES];
    
    WLTX_RegistViewController *rgVC = [[WLTX_RegistViewController alloc]initWithNibName:NSStringFromClass([WLTX_RegistViewController class]) bundle:nil];
    LYHNavigationController *nav = [[LYHNavigationController alloc]initWithRootViewController:rgVC];
    [self presentViewController:nav animated:YES completion:nil];

    
//    WLTX_LogisticsRecruitmentViewController *vc = [[WLTX_LogisticsRecruitmentViewController alloc]initWithNibName:NSStringFromClass([WLTX_LogisticsRecruitmentViewController class]) bundle:nil];
//    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark ✍🏻 (自定义方法) custom method end
#pragma mark - 📶(网络请求)Network start
#pragma mark 📶(网络请求)Network end
#pragma mark - 💤 控件/对象懒加载 object start
#pragma mark 💤 控件/对象懒加载 object end

@end
