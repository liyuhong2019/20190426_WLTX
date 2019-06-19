//
//  WLTX_Home_ADDetailsViewController.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/4/12.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_Home_ADDetailsViewController.h"

@interface WLTX_Home_ADDetailsViewController ()
<
UIWebViewDelegate
>
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation WLTX_Home_ADDetailsViewController

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
    [self userAgreementVC_settingsInitData];
    
}
- (void)dealloc
{
    //    [super dealloc];
    // 移除通知处理
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self aboutUsVC_netwrok_getADdetailRequest];
//    [self loadWebData];
    
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


//- (void)webViewDidFinishLoad:(UIWebView*)theWebView
//{
//    //  https://www.xuebuyuan.com/3193142.html
//    // 代码作用 :  iOS 禁用UIWebView 加载 网页的长按事件
//    [self.webview stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
//    [self.webview stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
//
//
//    // https://blog.csdn.net/weisubao/article/details/50832060
//    // 代码作用 :  iOS webView 图片适应屏幕问题
//    // 1、只对本地html资源的图片有效果
//    NSString *js = @"function imgAutoFit() { \
//    var imgs = document.getElementsByTagName('img'); \
//    for (var i = 0; i < imgs.length; ++i) {\
//    var img = imgs[i];   \
//    img.style.maxWidth = %f;   \
//    } \
//    }";
//    js = [NSString stringWithFormat:js, [UIScreen mainScreen].bounds.size.width - 20];
//    [self.webview stringByEvaluatingJavaScriptFromString:js];
//    [self.webview stringByEvaluatingJavaScriptFromString:@"imgAutoFit()"];
//
//
//}
#pragma mark 🏃(代理)Delegate end
#pragma mark - ✍🏻(自定义方法) custom method start
- (void)loadWebData
{
    NSURL *url = [NSURL URLWithString:self.weburl];
    
    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 3. 发送请求给服务器
    [self.webview loadRequest:request];

}

/**
 登陆页面 初始化数据
 */
- (void)userAgreementVC_settingsInitData
{
    YHLog(@"初始化数据");
    //    self.view.backgroundColor = [UIColor whiteColor];
    [self adDetails_settingsNav];
}
/**
 登陆页面设置 navD
 */
- (void)adDetails_settingsNav
{
//    self.navigationItem.title = @"广告详情";
    self.navigationItem.title = @"物流天地";
    self.view.backgroundColor = UIColorFromRGB(0xF5F5F5);
    
}
#pragma mark  ✍🏻(自定义方法) custom method end


#pragma mark - 📶(网络请求)Network start
- (void)aboutUsVC_netwrok_getADdetailRequest
{
    NSString *url = [NSString stringWithFormat:@"%@%@",Home_AdDetail,self.adId];
    [AFNetworkingTool postWithURLString:url parameters:nil resultClass:nil success:^(id result) {
        NSLog(@"result = %@",result);
        NSDictionary *dataDict = result[@"data"];
        NSString *content = dataDict[@"content"];   
        
        NSLog(@"content %@",content);
        [self.webview loadHTMLString:content baseURL:nil];
        
        
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark 📶(网络请求)Network end
#pragma mark - 💤 控件/对象懒加载 object start
#pragma mark 💤 控件/对象懒加载 object end

@end
