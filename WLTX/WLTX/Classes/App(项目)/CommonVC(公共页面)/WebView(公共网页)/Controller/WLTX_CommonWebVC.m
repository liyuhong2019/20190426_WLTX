//
//  WLTX_CommonWebVC.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/4/30.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_CommonWebVC.h"
#import "WLTX_Home_ADContactUsVC.h"

@interface WLTX_CommonWebVC ()
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (nonatomic,strong) NSMutableArray *allPhoneNumber;
@end

@implementation WLTX_CommonWebVC
- (NSMutableArray *)allPhoneNumber
{
    if (_allPhoneNumber == nil) {
        _allPhoneNumber = [NSMutableArray array];
    }
    return _allPhoneNumber;
}
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
    NSString *lJs2 = @"document.documentElement.innerText"; //根据标识符获取不同内容
    NSString *lHtml2 = [self.webview stringByEvaluatingJavaScriptFromString:lJs2];
    NSLog(@"网页内容为: %@",lHtml2);
    NSString *string  = lHtml2;
 
    [self loadAllPhoneNumberWithContentStr:string];
    
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
    self.webview.dataDetectorTypes = UIDataDetectorTypeNone; // 防止固定电话默认样式
    [self aboutUsVC_settingsNav];
    [self addAllContactBarButton];
    
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


- (void)addAllContactBarButton
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
- (void)loadAllPhoneNumberWithContentStr:(NSString *)string
{
    NSString *pattern;
    
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


/**
 加载本地HTML文件
 - (void)loadLocalFile {
 NSURL *url = [[NSBundle mainBundle] urlForResource:@"localHtml.html" withExtension:nil];
 NSURLRequest *request = [NSURLRequest requestWithURL:url];
 [_webView loadRequest:request];
 }
 */
#pragma mark 📶(网络请求)Network end
#pragma mark - 💤 控件/对象懒加载 object start
#pragma mark 💤 控件/对象懒加载 object end

@end
