//
//  WLTX_CoomonIQDetailsVC.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/19.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_CoomonIQDetailsVC.h"

@interface WLTX_CoomonIQDetailsVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layout_scrollview_h;
@property (weak, nonatomic) IBOutlet UILabel *lb_content;

@end

@implementation WLTX_CoomonIQDetailsVC
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self netwrok_getShuttleRouteListRequestWithid:self.detailsid];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    lyh_setting_xib_scrollviewHeight
    [self CoomonIQDetailsVC_initData];
    

}
- (void)CoomonIQDetailsVC_initData
{
    YHLog(@"初始化数据");
    
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
