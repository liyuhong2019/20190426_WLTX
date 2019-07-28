#import "AppTabBarViewController.h"
#import "AppDelegate.h"
//#import "WLTX_HomeViewController.h"                  // 主页
//#import "WLTX_SpecialLineQueryViewController.h"      // 专线查询
//#import "WLTX_PublishInformationViewController.h"    // 发布消息
//#import "WLTX_PersonalCenterViewController.h"        // 个人中心
//#import "LYHNavigationController.h"                  // 导航栏
//#import "LYHTabBar.h"                                // tabbar

@interface AppTabBarViewController ()

@end

@implementation AppTabBarViewController
#pragma mark - ♻️ 视图的生命周期 view life cycle start

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"%s 重写父类的方法",__FUNCTION__);
    [self setCustomtabbar];
    [self setupChildVc:[[WLTX_HomeViewController alloc] initWithNibName:NSStringFromClass([WLTX_HomeViewController class]) bundle:nil] title:@"首页" image:@"ic_no" selectedImage:@"ic" isHiddenNavgationBar:NO];
//    [self setupChildVc:[[WLTX_SpecialLineQueryViewController alloc] initWithNibName:NSStringFromClass([WLTX_SpecialLineQueryViewController class]) bundle:nil] title:@"专线查询" image:@"ic_line_no" selectedImage:@"ic_line" isHiddenNavgationBar:NO];
//    [self setupChildVc:[[WLTX_PublishInformationViewController alloc] initWithNibName:NSStringFromClass([WLTX_PublishInformationViewController class]) bundle:nil] title:@"发布消息" image:@"tabBar_find" selectedImage:@"tabBar_find_click" isHiddenNavgationBar:NO];
    
    [self setupChildVc:[[WLTX_PersonalCenterViewController alloc] initWithNibName:NSStringFromClass([WLTX_PersonalCenterViewController class]) bundle:nil] title:@"个人中心" image:@"ic_user_no" selectedImage:@"ic_user" isHiddenNavgationBar:NO];
    
    [[UITabBar appearance] setBackgroundImage:[self imageWithColor:[UIColor whiteColor]]];
    //  设置tabbar
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark ♻️ 视图的生命周期 view life cycle end
#pragma mark - TabBar Initialize start
- (void)setCustomtabbar
{
//    [super setCustomtabbar];
    LYHTabBar *tabbar = [[LYHTabBar alloc]init];
    [self setValue:tabbar forKeyPath:@"tabBar"];
    [tabbar.centerBtn addTarget:self action:@selector(centerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
//    [super tabBar:tabBar didSelectItem:item];
    NSLog(@"app 点击的item:%ld title:%@", item.tag, item.title);
}
- (void)centerBtnClick:(UIButton *)btn
{
//    [super centerBtnClick:btn];
//    NSLog(@"%s 重写父类的方法",__FUNCTION__);
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"你点击了订单按钮11" preferredStyle:UIAlertControllerStyleAlert];
//    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
//    [self presentViewController:alert animated:YES completion:nil];
//    [self showAlertController];
    
    if (!kWltx_IsLogin) {
        WLTX_LoginViewController *lg = [[WLTX_LoginViewController alloc]initWithNibName:NSStringFromClass([WLTX_LoginViewController class]) bundle:nil];
        LYHNavigationController *nav = [[LYHNavigationController alloc]initWithRootViewController:lg];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    [self presentListVC];




}
- (UIImage *)imageWithColor:(UIColor *)color{
//    [super imageWithColor:color];
//    NSLog(@"%s 重写父类的方法",__FUNCTION__);
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
    
}
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage isHiddenNavgationBar:(BOOL)isHidden
{
//    [super setupChildVc:vc title:title image:image selectedImage:selectedImage isHiddenNavgationBar:isHidden];
//
//    NSLog(@"%s 重写父类的方法",__FUNCTION__);
    static NSInteger index = 0;
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.tag = index;
    index++;
    LYHNavigationController *nav = [[LYHNavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.translucent = NO; // 导航栏会导致加载的控制器视图偏移往上64
    
    if (isHidden) {
        nav.navigationBar.hidden = YES;
    }
    
    [self addChildViewController:nav];
    
}



// 支持设备自动旋转
- (BOOL)shouldAutorotate
{
    [super shouldAutorotate];
    
    return NO;
}

+ (void)initialize
{
    [super initialize];
    NSLog(@"%s 重写父类的方法",__FUNCTION__);
    //设置未选中的TabBarItem的字体颜色、大小
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    //设置选中了的TabBarItem的字体颜色、大小
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectedAttrs[NSForegroundColorAttributeName] = BaseColor;
    
    UITabBarItem *item = [UITabBarItem appearance];
    
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

#pragma mark  TabBar Initialize end
#pragma mark - add fun

- (void)presentListVC
{
    NSLog(@"弹出列表选择");
    WLTX_PresentCommonSelectMsgTypeTableViewVC *VC = [[WLTX_PresentCommonSelectMsgTypeTableViewVC alloc]init];
    LYHNavigationController *nav = [[LYHNavigationController alloc]initWithRootViewController:VC];
    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate.window.rootViewController presentViewController:nav animated:YES completion:nil];
    
}


- (void)showAlertController
{
    //  使用alertview
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"请选择类型" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    NSArray *arr = @[@"物流供应",@"货源信息",@"车源信息",@"物流招聘"];
    
    // 不能跳转 参考 https://www.jianshu.com/p/20f56bf7be84
    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    int index =  [appDelegate.tabBarVC selectedIndex];
    //拿到tabbar的当前分栏的NavigationController
    LYHNavigationController *nav = [appDelegate.tabBarVC.viewControllers objectAtIndex:appDelegate.tabBarVC.selectedIndex];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:arr[0] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了按钮1，进入按钮1的事件");
        WLTX_ReleaseCommonInfoVC *vc = [[WLTX_ReleaseCommonInfoVC alloc]init];
        //        vc.releaseType = ReleaseType_Logistics;
        //        vc.hidesBottomBarWhenPushed= YES;
        //        [(LYHNavigationController *)self.window.rootViewController.navigationController pushViewController:vc animated:YES];
        // 需要拿到当前的tabbar的导航栏进行跳转
        vc.releaseType = ReleaseType_Logistics;
        [nav pushViewController:vc animated:YES];
        NSLog(@"点击了按钮1，进入按钮1的事件 end");
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:arr[1] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [AppProject getInstance].gloalBtn.hidden = NO;
        WLTX_ReleaseCommonInfoVC *vc = [[WLTX_ReleaseCommonInfoVC alloc]init];
        vc.releaseType = ReleaseType_Cargo;
        [nav pushViewController:vc animated:YES];
        
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:arr[2] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [AppProject getInstance].gloalBtn.hidden = NO;
        WLTX_ReleaseCarInfoVC *vc = [[WLTX_ReleaseCarInfoVC alloc]init];
        [nav pushViewController:vc animated:YES];
        
        
        
    }];
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:arr[3] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [AppProject getInstance].gloalBtn.hidden = NO;
        
        WLTX_ReleaseCommonInfoVC *vc = [[WLTX_ReleaseCommonInfoVC alloc]init];
        vc.releaseType = ReleaseType_Reruitment;
        [nav pushViewController:vc animated:YES];
        //        [self.window.rootViewController.navigationController pushViewController:vc animated:YES];
        
        
    }];
    UIAlertAction *action5 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [AppProject getInstance].gloalBtn.hidden = NO;
        
        
    }];
    [actionSheet addAction:action1];
    [actionSheet addAction:action2];
    [actionSheet addAction:action3];
    [actionSheet addAction:action4];
    [actionSheet addAction:action5];
    [appDelegate.window.rootViewController presentViewController:actionSheet animated:YES completion:nil];
    
    
}
@end
