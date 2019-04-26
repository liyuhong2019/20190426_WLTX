#import "WLTX_HomeViewController.h"

@interface WLTX_HomeViewController ()
 <
SDCycleScrollViewDelegate
>
{
    // header
    NSArray *_imagesURLStrings;
    SDCycleScrollView *_customCellScrollViewDemo;
    
    // center
    
    // footer
    
}



// view
@property (weak, nonatomic) IBOutlet UISearchBar *searchbar;
@property (weak, nonatomic) IBOutlet UIView *view_ad;

@end

@implementation WLTX_HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addADView];
    
}

#pragma mark - header Action start
- (void)addADView
{
    // 情景二：采用网络图片实现
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    _imagesURLStrings = imagesURLStrings;
    
    
    
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view_ad.height) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    //    cycleScrollView2.titlesGroup = titles;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    [self.view_ad addSubview:cycleScrollView2];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
    });
    
}



#pragma mark  SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
    //    [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
}

#pragma mark header Action end

#pragma mark - Center Action start
#pragma mark  Center Action end

#pragma mark - Footer Action start
#pragma mark  Footer Action end


#pragma mark - 测试action
- (IBAction)pushNestPage:(UIButton *)sender {
    WLTX_NestPageViewController *vc = [[WLTX_NestPageViewController alloc]initWithNibName:NSStringFromClass([WLTX_NestPageViewController class]) bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)login:(UIButton *)sender {
    NSLog(@"%s,友盟SDK登录",__func__);
    [self go2WeChatLogin];
}


- (IBAction)share:(UIButton *)sender {
    NSLog(@"%s,友盟SD分享",__func__);
    [self go2WeChatShare];
}



/** 微信登录 */
- (void)go2WeChatLogin
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        
        UMSocialUserInfoResponse *resp = result;
        
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        NSLog(@" uid: %@", resp.uid);
        NSLog(@" openid: %@", resp.openid);
        NSLog(@" accessToken: %@", resp.accessToken);
        NSLog(@" refreshToken: %@", resp.refreshToken);
        NSLog(@" expiration: %@", resp.expiration);
        
        // 用户数据
        NSLog(@" name: %@", resp.name);
        NSLog(@" iconurl: %@", resp.iconurl);
        NSLog(@" gender: %@", resp.unionGender);
        
        // 第三方平台SDK原始数据
        NSLog(@" originalResponse: %@", resp.originalResponse);
    }];
}
#pragma mark - 分享网页 - 需要传递平台类型

/** 微信分享 */
- (void)go2WeChatShare
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"分享标题" descr:@"分享内容描述" thumImage:[UIImage imageNamed:@"logo"]]; // lyh165_thumb 是分享链接的图片
    //设置网页地址
    shareObject.webpageUrl =@"http://www.baidu.com";
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
            
        }
    }];
}


@end
