//
//  WLTX_ContributionValueViewController.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/4/12.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_ContributionValueViewController.h"

@interface WLTX_ContributionValueViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layout_scrollview_h;
@property (weak, nonatomic) IBOutlet UILabel *lb_contributionValue;

@end

@implementation WLTX_ContributionValueViewController

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
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    lyh_setting_xib_scrollviewHeight
    
    NSDictionary *dict = @{
                           @"shouji":[[NSUserDefaults standardUserDefaults] objectForKey:@"user_shouji"],
                           };
    [self netwrok_getContributionValueRequest:dict];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self userAgreementVC_settingsInitData];
    
}
- (void)dealloc
{
    //    [super dealloc];
    // 移除通知处理
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
- (void)userAgreementVC_settingsInitData
{
    YHLog(@"初始化数据");
    //    self.view.backgroundColor = [UIColor whiteColor];
    [self userAgreement_settingsNav];
}
/**
 登陆页面设置 nav
 */
- (void)userAgreement_settingsNav
{
    self.navigationItem.title = @"贡献值";
    self.view.backgroundColor = UIColorFromRGB(0xF5F5F5);
    
}
#pragma mark  ✍🏻(自定义方法) custom method end

- (IBAction)go2howGetWebVC:(UIButton *)sender {
}

#pragma mark - 📶(网络请求)Network start
- (void)netwrok_getContributionValueRequest:(NSDictionary *)dict
{
    NSLog(@"贡献值__网络请求");
    [AFNetworkingTool getWithURLString:my_getSumContributionValue parameters:dict resultClass:nil success:^(id result) {
        NSLog(@"result = %@",[result mj_JSONString]);
        NSDictionary *dataDict = result;
        NSString *sum = dataDict[@"sum"];
//        if ([status intValue]) {
//            [self.view makeToast:@"获取成功"];
//
//        }
//        else
//        {
//            [self.view makeToast:@"获取失败"];
//        }
        self.lb_contributionValue.text = sum;
        
    } failure:^(NSError *error) {
        NSString *errorMsg = [NSString stringWithFormat:@"%@",[error.localizedDescription mj_JSONString]];
        [self.view makeToast:errorMsg];
        
    }];
}
#pragma mark 📶(网络请求)Network end
#pragma mark - 💤 控件/对象懒加载 object start
#pragma mark 💤 控件/对象懒加载 object end

@end
