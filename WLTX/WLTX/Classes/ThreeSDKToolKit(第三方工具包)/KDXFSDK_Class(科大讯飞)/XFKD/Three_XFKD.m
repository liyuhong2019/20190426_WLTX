
#import "Three_XFKD.h"
#import "AppDelegate.h"
#import <iflyMSC/iflyMSC.h>

// 宏定义

// Appid 用来初始化sdk的
#define XFKD_AppID @"5c49aff3f1f5561476000197"

// 类扩展
@interface Three_XFKD ()
@property (strong,nonatomic) AppDelegate *appDelegate;
@end

@implementation Three_XFKD
// 单例对象
+ (Three_XFKD *)getInstance{
    static Three_XFKD *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

// 初始化的时候调用
- (id)init{
    if (self = [super init]) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.appDelegate = appDelegate;
        NSLog(@"%s ,🍀 初始化 讯飞科大 SDK start 🍀",__func__);
        //        NSLog(@"%s , 初始化h5",__func__);
//        [self lyh_initTThreeSDK_XFKD_YYTX];
        NSLog(@"%s ,🍀 初始化 讯飞科大 SDK end 🍀",__func__);
        
        
        
    }
    return self;
}


#pragma mark - 讯飞科大 语音听写sdk start
// 参考文章 https://doc.xfyun.cn/msc_ios/语音听写.html
- (void)lyh_initTThreeSDK_XFKD_YYTX;
{
    NSLog(@"%s 初始化 讯飞科大的《语音听写》功能 start",__func__);
    // 初始化 讯飞科大 语音听写功能sdk
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@", @"5cd92052"];
    [IFlySpeechUtility createUtility:initString];
    NSLog(@"%s 初始化 讯飞科大的《语音听写》功能 end",__func__);
}
@end
