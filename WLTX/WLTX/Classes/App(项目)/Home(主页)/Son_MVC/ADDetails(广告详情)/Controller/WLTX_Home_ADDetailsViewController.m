/**
 20190717  更新
 1、识别页面的内容          https://www.jianshu.com/p/b4f2951e07c4
 2、获取页面的电话          https://www.cnblogs.com/adampei-bobo/p/8375931.html
 3、删除页面的电话下划线     https://www.jianshu.com/p/b44cfcc3d851
 4、webview 自适应屏幕    https://blog.csdn.net/qq_31258413/article/details/82018301
 5、webview 禁止长按     https://www.jianshu.com/p/eb63e93d04e6
 参考
 https://www.jianshu.com/p/6bbcc438b188
 
 */

#import "WLTX_Home_ADDetailsViewController.h"
#import "WLTX_Home_ADContactUsVC.h"

@interface WLTX_Home_ADDetailsViewController ()
<
UIWebViewDelegate
>
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@property (nonatomic,strong) NSMutableArray *allPhoneNumber;
@end

@implementation WLTX_Home_ADDetailsViewController

- (NSMutableArray *)allPhoneNumber
{
    if (_allPhoneNumber == nil) {
        _allPhoneNumber = [NSMutableArray array];
    }
    return _allPhoneNumber;
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
//    [self aboutUsVC_netwrok_getADdetailRequest];
    [_allPhoneNumber removeAllObjects];
    [self loadWebData];
    
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

/**加载页面的数据
 
 */
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"网页加载完成才能获取");
    
    NSString *lJs2 = @"document.documentElement.innerText"; //根据标识符获取不同内容
    NSString *lHtml2 = [webView stringByEvaluatingJavaScriptFromString:lJs2];
    NSLog(@"网页内容为: %@",lHtml2);
    NSString *string  = lHtml2;
    NSString *pattern;

    
    
//    pattern=@"0\\d{2,3}[- ]\\d{7,8}";

//    pattern=@"\\d{3,4}[- ]?\\d{7,8}";

    
    pattern=@"\\d{3,4}[- ]?\\d{7,8}";
    
//    string=@"2017-02-12 上报人:张三 15930384756";
    NSError *error;
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSLog(@"%@",error.userInfo);
    
    [regex enumerateMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        if (NSMatchingReportProgress==flags) {
//            NSLog(@"result %@",result);
        }else{
            /**
             *  系统内置方法
             */
//            NSLog(@"result %@",result);

            if (NSTextCheckingTypePhoneNumber==result.resultType) {
                NSLog(@"%@",[string substringWithRange:result.range]);
            }
            /**
             *  长度为11位的数字串、12是固定电话 xxx - xxxxxx
             */
            if (result.range.length==11 || result.range.length == 12) {
                NSLog(@"电话有 : %@",[string substringWithRange:result.range]);
                NSString *phoneNumber = [string substringWithRange:result.range];
                [self.allPhoneNumber addObject:phoneNumber];
            }
            
        }
    }];
    NSLog(@"所有的手机号码 %@",self.allPhoneNumber);
    
// 禁止长按
    [self.webview stringByEvaluatingJavaScriptFromString:(@"document.documentElement.style.webkitUserSelect='none';")];
    [self.webview stringByEvaluatingJavaScriptFromString:(@"document.documentElement.style.webkitTouchCallout='none';")];


    
// 
    NSString *js = [NSString stringWithFormat:@"function autoFit() { \
                                          var imgs = document.getElementsByTagName('img'); \
                                          for (var i = 0; i < imgs.length; ++i) {\
                                          var img = imgs[i];   \
                                          img.style.width = %f ;   \
                                          img.style.height = 'auto';   \
                                          } \
                                          }",[UIScreen mainScreen].bounds.size.width-20];
    [self.webview stringByEvaluatingJavaScriptFromString:js];
    [self.webview stringByEvaluatingJavaScriptFromString:@"autoFit()"];
  
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return nil;
    
}

#pragma mark 🏃(代理)Delegate end
#pragma mark - ✍🏻(自定义方法) custom method start
/**
 获取页面信息 https://www.jianshu.com/p/b4f2951e07c4
 
 */
- (void)loadWebData
{
    
    NSString * url = [NSString stringWithFormat:@"%@%@%@",WLTX_DomainOrIpUrl,Home_AdDetail,self.adId];
    NSURL *weburl = [NSURL URLWithString:url];
    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:weburl];
    // 3. 发送请求给服务器
    [self.webview loadRequest:request];
    self.webview.dataDetectorTypes = UIDataDetectorTypeNone; // 防止固定电话默认样式

    
    


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
    
    [self adDetails_BarbuttonItem];
}

- (void)adDetails_BarbuttonItem
{
//    self.view.backgroundColor = UIColorFromRGB(0x000000);
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:@"联系我们" forState:0];
    [backButton setTitleColor:[UIColor whiteColor] forState:0];
    backButton.titleLabel.font = [UIFont systemFontOfSize:13];

    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [backButton addTarget:self action:@selector(adContactUs:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

/**参考
 https://www.jianshu.com/p/63737bb81d82
 */
- (void)adContactUs:(UIButton *)btn
{
    NSLog(@"联系我们");
    
//    NSLog(@"联系我们 %@",self.allPhoneNumber);
    WLTX_Home_ADContactUsVC *VC = [[WLTX_Home_ADContactUsVC alloc]init];
    VC.AllNumberArr = self.allPhoneNumber;
    LYHNavigationController *nav = [[LYHNavigationController alloc]initWithRootViewController:VC];
    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate.window.rootViewController presentViewController:nav animated:YES completion:nil];
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
