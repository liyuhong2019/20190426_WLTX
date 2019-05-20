//
//  WLTX_SpecialLineVC.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/15.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_SpecialLineVC.h"
#import "WLTX_SpecialLineView.h"
#import "WLTX_SpecialLineModel.h"

@interface WLTX_SpecialLineVC ()
<WLTX_SpecialLineViewDelegate>
@property (nonatomic,strong) WLTX_SpecialLineView *view_SpecialLine;
@end

@implementation WLTX_SpecialLineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self SpecialLineVC_initData];

}
- (void)SpecialLineVC_initData
{
    YHLog(@"初始化数据");
    
    [self SpecialLineVC_settingsNav];
    
    [self.view addSubview:self.view_SpecialLine];
    
    
}
- (void)SpecialLineVC_settingsNav
{
    self.view.backgroundColor = UIColorFromRGB(0xF5F5F5);
    self.navigationItem.title = @"专线";
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [backButton setImage:[UIImage imageNamed:@"PersonalCenterNew_10"] forState:UIControlStateNormal];
    //    [backButton setImage:[UIImage imageNamed:@"PersonalCenterNew_10"] forState:UIControlStateHighlighted];
    [backButton setTitle:@"发布" forState:0];
    [backButton setTitleColor:[UIColor blackColor] forState:0];
    //    [backButton settitf]
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [backButton addTarget:self action:@selector(IntegratedQueryVC_go2Share:) forControlEvents:UIControlEventTouchUpInside];
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}
- (void)IntegratedQueryVC_go2Share:(UIButton *)btn
{
    NSLog(@"发布");
}

#pragma mark - 懒加载
- (WLTX_SpecialLineView *)view_SpecialLine
{
    if (!_view_SpecialLine) {
        _view_SpecialLine = [[WLTX_SpecialLineView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.origin.x, 44, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 44)];
        _view_SpecialLine.delegate = self;
    }
    return _view_SpecialLine;
}
- (void)wltx_SpecialLineViewClickItemWithModel:(WLTX_SpecialLineModel *)model ClickIndexPath:(NSIndexPath *)indexPath
{
    WLTX_SpecialDetailsVC *vc = [[WLTX_SpecialDetailsVC alloc]init];
    vc.detailsId = model.id;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
