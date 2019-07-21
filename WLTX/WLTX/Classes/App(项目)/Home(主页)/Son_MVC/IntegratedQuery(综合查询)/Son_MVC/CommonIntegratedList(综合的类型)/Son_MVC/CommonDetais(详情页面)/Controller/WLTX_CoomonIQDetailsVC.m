//
//  WLTX_CoomonIQDetailsVC.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/19.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_CoomonIQDetailsVC.h"
#import "WLTX_Home_ADContactUsVC.h"

@interface WLTX_CoomonIQDetailsVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layout_scrollview_h;
@property (weak, nonatomic) IBOutlet UILabel *lb_content;
@property (nonatomic,strong) NSMutableArray *allPhoneNumber;

@end

@implementation WLTX_CoomonIQDetailsVC

- (NSMutableArray *)allPhoneNumber
{
    if (_allPhoneNumber == nil) {
        _allPhoneNumber = [NSMutableArray array];
    }
    return _allPhoneNumber;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self netwrok_getShuttleRouteListRequestWithid:self.detailsid];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    lyh_setting_xib_scrollviewHeight
//    [self CoomonIQDetailsVC_initData];
    
    [self addAllContactBarButton];
    self.lb_content.text = self.contentStr;
    [self loadAllPhoneNumberWithContentStr:self.contentStr];
    
    
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

- (void)CoomonIQDetailsVC_initData
{
    YHLog(@"初始化数据");
    YHLog(@"⚠️ 在这个页面获取内容 截取电话");

//    [self CoomonIQDetailsVC_settingsNav];
}
- (void)CoomonIQDetailsVC_settingsNav
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
}


// 专线路线
- (void)netwrok_getShuttleRouteListRequestWithid:(NSString *)detailsId
{
    [AFNetworkingTool postWithURLString:my_integrateQueryDetails(detailsId) parameters:nil resultClass:nil success:^(id result) {
        NSLog(@"result = %@",result);
        NSDictionary *data = result[@"data"];
        NSString *content = data[@"content"];
        self.lb_content.text = content;
        
    } failure:^(NSError *error) {
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
