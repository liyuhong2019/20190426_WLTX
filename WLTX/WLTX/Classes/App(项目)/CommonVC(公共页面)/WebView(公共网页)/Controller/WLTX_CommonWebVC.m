//
//  WLTX_CommonWebVC.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/4/30.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_CommonWebVC.h"

@interface WLTX_CommonWebVC ()
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@end

@implementation WLTX_CommonWebVC

- (instancetype)initWithWLTX_CommonWebType:(WLTX_CommonWebType)wltx_CommonWebType AndNavTitle:(NSString *)navTitle
{
    if (self = [super init]) {
        _wltx_CommonWebType = wltx_CommonWebType;
        _navTitle = navTitle;
    }
    return self;
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
    [self AboutUsVC_settingsInitData];
    
}
- (void)dealloc
{
    //    [super dealloc];
    // 移除通知处理
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    switch (self.wltx_CommonWebType) {
        case WLTX_CommonWebType_AboutUs:
        {
            NSLog(@"加载关于我们");
            [self aboutUsVC_netwrok_getAboutUsRequest];
        }
            break;
        case WLTX_CommonWebType_UserDefine_Begin:
        {
            NSLog(@"加载 用户自定义的");
        }
            break;

        default:
            break;
    }
    
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
- (void)webViewDidFinishLoad:(UIWebView*)theWebView
{
    //  https://www.xuebuyuan.com/3193142.html
    // 代码作用 :  iOS 禁用UIWebView 加载 网页的长按事件
    [self.webview stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    [self.webview stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    
}
#pragma mark 🏃(代理)Delegate end
#pragma mark - ✍🏻(自定义方法) custom method start
/**
 登陆页面 初始化数据
 */
- (void)AboutUsVC_settingsInitData
{
    YHLog(@"初始化数据");
    NSLog(@"当前网页的类型 是 %ld",self.wltx_CommonWebType);
    [self aboutUsVC_settingsNav];
    
}
/**
 登陆页面设置 nav
 */
- (void)aboutUsVC_settingsNav
{
//    self.navigationItem.title = @"关于我们";
    self.navigationItem.title = self.navTitle;
    self.view.backgroundColor = UIColorFromRGB(0xF5F5F5);
    
}

#pragma mark  ✍🏻(自定义方法) custom method end


#pragma mark - 📶(网络请求)Network start
- (void)aboutUsVC_netwrok_getAboutUsRequest
{
    [AFNetworkingTool postWithURLString:my_AboutUsUrl parameters:nil resultClass:nil success:^(id result) {
        NSLog(@"result = %@",result);
        NSString *data = result[@"data"];
        NSLog(@"data %@",data);
        [self.webview loadHTMLString:data baseURL:nil];
        
        
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark 📶(网络请求)Network end
#pragma mark - 💤 控件/对象懒加载 object start
#pragma mark 💤 控件/对象懒加载 object end

@end
