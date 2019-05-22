// 综合查询

#import "WLTX_IntegratedQueryViewController.h"
#import "WLTX_IntegratedQueryView.h"
#import "WLTX_IntegratedQueryModel.h"
#import "WLTX_CoomonIntegratedQueryListVC.h"
#import "WLTX_CarListInfoVC.h"

@interface WLTX_IntegratedQueryViewController ()
<WLTX_IntegratedQueryViewDelegate>
@property (nonatomic,strong) WLTX_IntegratedQueryView *view_integratedQuery;
@end

@implementation WLTX_IntegratedQueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self IntegratedQueryVC_initData];
}

- (void)IntegratedQueryVC_initData
{
    YHLog(@"初始化数据");
    
    [self IntegratedQueryVC_settingsNav];
    
    [self.view addSubview:self.view_integratedQuery];
    
    
}
- (void)IntegratedQueryVC_settingsNav
{
    self.view.backgroundColor = UIColorFromRGB(0xF5F5F5);
    
    
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

- (WLTX_IntegratedQueryView *)view_integratedQuery
{
    if (!_view_integratedQuery) {
        _view_integratedQuery = [[WLTX_IntegratedQueryView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    }
    _view_integratedQuery.delegate = self;
//    NSLog(@"navigationController %f",CGRectGetHeight(self.navigationController.navigationItem.titleView.frame));
    
    return _view_integratedQuery;
}
- (void)wltx_IntegratedQueryViewClickItemWithModel:(WLTX_IntegratedQueryModel *)model ClickIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击的item 是 %@,点击的id 是 %@,indexpath row 是 %ld",model.name,model.id,indexPath.row);
    
    // 这里跳转到综合查询的列表页面
    // 1链接列表页   2链接到单页
    if ([model.type isEqualToString:@"1"]) {
        NSLog(@"1链接列表页 ");
        // 这里也要根据id去跳转到指定的页面
        // 已经知道 id 1是列表页面 其他也是列表界面
        if ([model.id isEqualToString:@"3"]) {
            NSLog(@"车源信息特殊处理");
            WLTX_CarListInfoVC *vc = [[WLTX_CarListInfoVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            WLTX_CoomonIntegratedQueryListVC *vc = [[WLTX_CoomonIntegratedQueryListVC alloc]init];
            NSString *idType = model.id;
            NSLog(@"idType %@",idType);
            NSInteger typeInt = [idType integerValue];
            NSLog(@"idType %ld",typeInt);

            CoomonIntegratedQueryListType type = (CoomonIntegratedQueryListType )typeInt;
            vc.type = type;
            vc.title = model.name;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        
        

    }
    else
    {
        NSLog(@"2链接到单页");
    }
    
}
@end
