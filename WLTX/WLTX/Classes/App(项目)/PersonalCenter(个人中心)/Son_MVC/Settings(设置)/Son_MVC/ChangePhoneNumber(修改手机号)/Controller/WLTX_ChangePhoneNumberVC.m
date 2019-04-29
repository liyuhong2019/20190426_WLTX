//
//  WLTX_ChangePhoneNumberVC.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/4/29.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_ChangePhoneNumberVC.h"

@interface WLTX_ChangePhoneNumberVC ()

@end

@implementation WLTX_ChangePhoneNumberVC

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
    [self changePhoneNumberVC_initData];
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
#pragma mark 🏃(代理)Delegate end
#pragma mark - ✍🏻(自定义方法) custom method start
/**
 登陆页面 初始化数据
 */
- (void)changePhoneNumberVC_initData
{
    YHLog(@"初始化数据");
    //    self.view.backgroundColor = [UIColor whiteColor];
    [self changePwVC_settingsNav];
    
}
/**
 登陆页面设置 nav
 */
- (void)changePwVC_settingsNav
{
    self.navigationItem.title = @"更换新手机号";
    self.view.backgroundColor = UIColorFromRGB(0xF5F5F5);
    
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
//
//- (IBAction)ClickSettings:(UIButton *)sender {
//    switch (sender.tag) {
//        case 10:
//        {
//            [self settings_Action1_changePhoneNumber];
//        }
//            break;
//        case 30:
//        {
//            [self settings_Action2_resetPassword];
//        }
//            break;
//
//        case 50:
//        {
//            [self personalInformation_Action3_CheckVersionOnUpdate];
//        }
//            break;
//
//        default:
//            break;
//    }
//
//}

@end
