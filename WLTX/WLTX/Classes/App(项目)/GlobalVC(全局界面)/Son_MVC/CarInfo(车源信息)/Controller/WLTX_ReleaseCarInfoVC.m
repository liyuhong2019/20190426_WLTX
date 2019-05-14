//
//  WLTX_ReleaseCarInfoVC.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/15.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_ReleaseCarInfoVC.h"

@interface WLTX_ReleaseCarInfoVC ()

@end

@implementation WLTX_ReleaseCarInfoVC

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
    [self specialDetailsVC_initData];
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
- (void)specialDetailsVC_initData
{
    YHLog(@"初始化数据");
    [self specialDetailsVC_settingsNav];
    
}


/**
 登陆页面设置 nav
 */
- (void)specialDetailsVC_settingsNav
{
    self.navigationItem.title = @"专线详情";
    self.view.backgroundColor = UIColorFromRGB(0xF5F5F5);
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"PersonalCenterNew_10"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"PersonalCenterNew_10"] forState:UIControlStateHighlighted];
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [backButton addTarget:self action:@selector(specialDetailsVC_go2Share:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}
- (void)specialDetailsVC_go2Share:(UIButton *)btn
{
    NSLog(@"分享");
}
#pragma 事件操作

#pragma mark  ✍🏻(自定义方法) custom method end


@end
