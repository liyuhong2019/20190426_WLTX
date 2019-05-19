//
//  WLTX_ReleaseCommonInfoVC.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/15.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_ReleaseCommonInfoVC.h"

@interface WLTX_ReleaseCommonInfoVC ()
<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layout_scrollview_h;

// 标题
@property (weak, nonatomic) IBOutlet UITextField *tf_title;
@property (weak, nonatomic) IBOutlet UIView *view_titleLine;

// 内容
@property (weak, nonatomic) IBOutlet UITextField *tf_content;
@property (weak, nonatomic) IBOutlet UIView *view_contentLine;

@end

@implementation WLTX_ReleaseCommonInfoVC

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
    lyh_setting_xib_scrollviewHeight
    [self specialDetailsVC_initData];

}
- (void)dealloc
{
    //    [super dealloc];
    // 移除通知处理
    // 255 72 139
    
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
#pragma mark - 🏃(代理)Delegate start
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //开始编辑时触发，文本字段将成为first responder
    if (textField == self.tf_title) {
        self.view_contentLine.backgroundColor = [UIColor grayColor];
        self.view_titleLine.backgroundColor = RGB(255, 72, 139);
    }
    else
    {
        self.view_titleLine.backgroundColor = [UIColor grayColor];
        self.view_contentLine.backgroundColor = RGB(255, 72, 139);

    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.tf_content) {
        
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
- (void)specialDetailsVC_initData
{
    YHLog(@"初始化数据");
    YHLog(@"类型是 %ld",self.releaseType);
    
    [self specialDetailsVC_settingsNav];
    
    switch (self.releaseType) {
        case ReleaseType_Logistics:
        {
            self.navigationItem.title = @"物流供求";
        }
            break;
        case ReleaseType_Cargo:
        {
            self.navigationItem.title = @"货源信";
        }
            break;
        case ReleaseType_Reruitment:
        {
            self.navigationItem.title = @"物流招聘";
        }
            break;
        default:
            break;
    }
}


/**
 登陆页面设置 nav
 */
- (void)specialDetailsVC_settingsNav
{
    self.view.backgroundColor = UIColorFromRGB(0xF5F5F5);
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [backButton setImage:[UIImage imageNamed:@"PersonalCenterNew_10"] forState:UIControlStateNormal];
//    [backButton setImage:[UIImage imageNamed:@"PersonalCenterNew_10"] forState:UIControlStateHighlighted];
    [backButton setTitle:@"发布" forState:0];
    [backButton setTitleColor:[UIColor blackColor] forState:0];
//    [backButton settitf]
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [backButton addTarget:self action:@selector(specialDetailsVC_go2Share:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}
- (void)specialDetailsVC_go2Share:(UIButton *)btn
{
    NSLog(@"发布");
    // 这里处理不能为空的操作
    if (self.tf_title.text.length == 0 ||  self.tf_content.text.length == 0) {
        [self.view makeToast:@"请检测你的标题、内容是不是没有填写"];
        return;
    }
    
   
    
    // 4、发送注册请求
    // ....
    
    NSDictionary *dict = @{
                           @"fblx":[NSString stringWithFormat:@"%ld",self.releaseType],
                           @"shouji":kWltx_userShouji,
                           @"title":self.tf_title.text,
                           @"content":self.tf_content.text

                           };
    [self netwrok_ReleaseRequest:dict];
}
#pragma 事件操作

#pragma mark  ✍🏻(自定义方法) custom method end

#pragma mark - 📶(网络请求)Network start

- (void)netwrok_ReleaseRequest:(NSDictionary *)dict
{
    NSLog(@"登录__网络请求");
    [AFNetworkingTool postWithURLString:Coomon_Release parameters:dict resultClass:nil success:^(id result) {
        NSLog(@"result = %@",[result mj_JSONString]);
        NSDictionary *dataDict = result;
        NSString *status = dataDict[@"status"];
        NSLog(@"");
        if ([status integerValue] == 1) {
            [self.view makeToast:@"添加成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        else
        {
            [self.view makeToast:status];
        }
        
    } failure:^(NSError *error) {
        NSString *errorMsg = [NSString stringWithFormat:@"%@",[error.localizedDescription mj_JSONString]];
        [self.view makeToast:errorMsg];
        
    }];
}
#pragma mark 📶(网络请求)Network end

@end
