//
//  WLTX_SpecialDetailsVC.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/15.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_SpecialDetailsVC.h"
#import "WLTX_SpecialDetailsSectionHeaderView.h"
#import "WLTX_SpecialDetailsModel.h" // 专线模型
#import "WLTX_SpecialDetailsDhwdModel.h" // 底部模型
#import "WLTX_SpecialDetailsFbwdModel.h" // 头部模型

@interface WLTX_SpecialDetailsVC ()
<
SDCycleScrollViewDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource,
UITableViewDelegate,
UITableViewDataSource
>
{
    // content
    
    // header
    NSArray *_imagesURLStrings;
    SDCycleScrollView *_customCellScrollViewDemo;
    
    // center
    
    // footer
    
}

// 属性

@property (weak, nonatomic) IBOutlet UIView *view_ad;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

// headerView ContentView
@property (weak, nonatomic) IBOutlet UILabel *lb_companyName;
@property (weak, nonatomic) IBOutlet UILabel *lb_directLocation;
@property (weak, nonatomic) IBOutlet UILabel *lb_coverLocation;

@property (weak, nonatomic) IBOutlet UIButton *btn_phoneNumber;
@property (weak, nonatomic) IBOutlet UIButton *btn_telNumber;
@property (weak, nonatomic) IBOutlet UILabel *lb_companyLocation;
@property (weak, nonatomic) IBOutlet UIButton *btn_magName;
@property (weak, nonatomic) IBOutlet UIButton *btn_collection;

@property (strong, nonatomic) WLTX_SpecialDetailsModel *model;
@property (strong, nonatomic) NSMutableArray<WLTX_SpecialDetailsFbwdModel *>  *fmodels;
@property (strong, nonatomic) NSMutableArray<WLTX_SpecialDetailsDhwdModel *>  *dmodels;

@property (weak, nonatomic) IBOutlet UIView *view_header;
@property (weak, nonatomic) IBOutlet UIView *view_info;

@end

@implementation WLTX_SpecialDetailsVC

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
    [self specialDetailsVC_initData];
}
- (void)dealloc
{
    //    [super dealloc];
    // 移除通知处理
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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
// datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        NSArray *arr = self.model.fbwd;
        return self.fmodels.count;
    }
    else
    {
        NSArray *arr = self.model.dhwd;
        return self.dmodels.count;
    }
//    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLTX_SpecialDetailsCell  *cell = [tableView dequeueReusableCellWithIdentifier:WLTX_SpecialDetailsCellID];
    if (indexPath.section == 0) {
        WLTX_SpecialDetailsFbwdModel *model = self.fmodels[indexPath.row];
        cell.fModel = model;
        [cell.btn_phoneNumber cq_addEventHandler:^{
            [self vcCallPhoneNumber:cell.fModel.shouji];
        } forControlEvents:UIControlEventTouchUpInside];
        [cell.btn_telPhoneNumber cq_addEventHandler:^{
            [self vcCallPhoneNumber:cell.fModel.tel];
        } forControlEvents:UIControlEventTouchUpInside];


    }
    else
    {
        cell.dModel = self.dmodels[indexPath.row];
        
        [cell.btn_phoneNumber cq_addEventHandler:^{
            [self vcCallPhoneNumber:cell.dModel.shouji];
        } forControlEvents:UIControlEventTouchUpInside];
        [cell.btn_telPhoneNumber cq_addEventHandler:^{
            [self vcCallPhoneNumber:cell.dModel.tel];
        } forControlEvents:UIControlEventTouchUpInside];

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;

}

// delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 190;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
  
    
    WLTX_SpecialDetailsSectionHeaderView *view = [[WLTX_SpecialDetailsSectionHeaderView alloc]initWithReuseIdentifier:@"WLTX_SpecialDetailsSectionHeaderView"];
    if (section == 0) {
        view.img_icon.image= [UIImage imageNamed:@"分布网点标题"];
        if (self.model.fbwd == nil) {
            return nil;
        }
        else
        {
            return view;
        }
    }
    else
    {
        view.img_icon.image= [UIImage imageNamed:@"到货网点标题"];
        if (self.model.dhwd == nil) {
            return nil;
        }
        else
        {
            return view;
        }
    }
    
    
}

#pragma mark 🏃(代理)Delegate end
#pragma mark - ✍🏻(自定义方法) custom method start
/**
 登陆页面 初始化数据
 */
- (void)specialDetailsVC_initData
{
    YHLog(@"初始化数据");
    [self specialDetailsVC_settingsNav];
    
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([WLTX_SpecialDetailsCell class]) bundle:nil] forCellReuseIdentifier:WLTX_SpecialDetailsCellID];
    [self.tableview registerClass:[WLTX_SpecialDetailsSectionHeaderView class] forHeaderFooterViewReuseIdentifier:@"WLTX_SpecialDetailsSectionHeaderView"];
//    self.tableview.tableHeaderView.
    [self netwrok_getmySpecialDetailsWithId:self.detailsId];
}

- (void)setDataOrUpdateUI
{
    
}
/**
 登陆页面设置 nav
 */
- (void)specialDetailsVC_settingsNav
{
    self.navigationItem.title = @"专线详情";
    self.view.backgroundColor = UIColorFromRGB(0xF5F5F5);
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"fenxiang16"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"fenxiang16"] forState:UIControlStateHighlighted];
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [backButton addTarget:self action:@selector(specialDetailsVC_go2Share:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

- (void)specialDetailsVC_go2Share:(UIButton *)btn
{
    NSLog(@"分享");
}
// 广告view
- (void)addADView
{
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view_ad.height) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    [self.view_ad addSubview:cycleScrollView2];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView2.imageURLStringsGroup = _imagesURLStrings;
    });
    
}
// 设置头部数据
- (void)setHeaderDataWithDict:(WLTX_SpecialDetailsModel *)model
{
    self.lb_companyName.text = model.gsname;
    self.lb_directLocation.text = [NSString stringWithFormat:@"直达:%@",model.zhida];
    self.lb_coverLocation.text = [NSString stringWithFormat:@"覆盖:%@",model.fgqu];
    self.lb_companyLocation.text = model.dizhi;
    
    [self.btn_magName setTitle:model.lxr forState:0];
    [self.btn_phoneNumber setTitle:model.shouji forState:0];
    [self.btn_telNumber setTitle:model.tel forState:0];
    

    // 拿到默认的地址的y值 获取当前地址的y值 相减 得到 没有上下的间距
    // 再加上 上下间距 就得到计算好的布局间距
    // 然后重新设置 UI的frame
    // 然后刷新tableview
    CGFloat lb_directLocation_mar = CGRectGetHeight(self.lb_directLocation.frame) ;

    CGFloat mar = CGRectGetMaxY(self.lb_companyLocation.frame) - 155.0+16;// 16上下艰巨
    
    self.view_header.frame = CGRectMake(0, 0, self.view_header.width, self.view_header.height+mar+CGRectGetHeight(self.lb_companyLocation.frame));
    NSLog(@"view_header height %f",self.view_header.height);
    [self.tableview reloadData];

    // 按钮事件处理
    [self.btn_phoneNumber cq_addEventHandler:^{
        [self vcCallPhoneNumber:model.shouji];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.btn_telNumber cq_addEventHandler:^{
        [self vcCallPhoneNumber:model.tel];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.btn_collection cq_addEventHandler:^{
        NSLog(@"收藏、取消收藏请求");
        // 先判断用户是否登录
        checkisLogin
        [self netwrok_CollectionRequest:self.detailsId WithPhoneNumber:kWltx_userShouji];
    } forControlEvents:UIControlEventTouchUpInside];


}
#pragma 事件操作

#pragma mark  ✍🏻(自定义方法) custom method end
#pragma mark - 🎬 按钮/点击事件 Action start



#pragma mark - 🎬 按钮/点击事件 Action end
#pragma mark - 📶(网络请求)Network start
#pragma mark -
// 专线详情
- (void)netwrok_getmySpecialDetailsWithId:(NSString *)sid
{
    [AFNetworkingTool getWithURLString:my_specialDetails(sid) parameters:nil resultClass:nil success:^(id result) {
        NSLog(@"  专线详情 result = %@",[result mj_JSONObject]);
        
        NSDictionary *dataDict = [result mj_JSONObject];
        WLTX_SpecialDetailsModel *model = [WLTX_SpecialDetailsModel mj_objectWithKeyValues:dataDict];
        self.model = model;
        //NSLog(@"model %@",model.banner);
        //NSLog(@"model %@",self.model.fgqu);

        id adArr = self.model.banner;
        if ([adArr isKindOfClass:[NSArray class]]) {
            NSArray *adImgs = adArr = dataDict[@"banner"];
            _imagesURLStrings = adImgs;
            NSLog(@"adarr %@",adArr);
            [self addADView];
        }
        else
        {
            NSLog(@"字符串 不需要操作");
        }
        
        [self setHeaderDataWithDict:self.model];

        id fbwd = self.model.fbwd;

        if ([fbwd isKindOfClass:[NSString class]]) {
            NSLog(@"什么都不做");
        }
        else if ([fbwd isKindOfClass:[NSArray class]])
        {
           self.fmodels = [WLTX_SpecialDetailsFbwdModel mj_objectArrayWithKeyValuesArray:fbwd];
            
            NSLog(@"刷新 tableview %@",self.fmodels);
        }
        
        id dhwd = self.model.dhwd;
        if ([dhwd isKindOfClass:[NSString class]]) {
            NSLog(@"什么都不做");
        }
        else if ([dhwd isKindOfClass:[NSArray class]])
        {
           
            self.dmodels = [WLTX_SpecialDetailsDhwdModel mj_objectArrayWithKeyValuesArray:dhwd];
            NSLog(@"刷新 tableview %@",self.dmodels);
        }
        
        [self.tableview reloadData];
    } failure:^(NSError *error) {
        
    }];
}

// 收藏 取消收藏
- (void)netwrok_CollectionRequest:(NSString *)detailsId WithPhoneNumber:(NSString *)phoneNumber
{
    [AFNetworkingTool getWithURLString:my_specialCollection(detailsId,phoneNumber) parameters:nil resultClass:nil success:^(id result) {
        NSLog(@"result = %@",[result mj_JSONObject]);
//        NSArray *data = result[@"data"];
        
        NSDictionary *statusDict = [result mj_JSONObject];
        NSString *status = statusDict[@"status"];
        NSInteger statusInt = [status integerValue];
        
        switch (statusInt) {
            case 1:
                {
                    [self.view makeToast:@"收藏成功"];
                    [self.btn_collection setImage:[UIImage imageNamed:@"已收藏"] forState:0];
                }
                break;
            case 2:
            {
                [self.view makeToast:@"收藏失败"];
            }
                break;
            case 3:
            {
                [self.view makeToast:@"取消收藏成功"];
                [self.btn_collection setImage:[UIImage imageNamed:@"未收藏"] forState:0];
            }
                break;
            case 4:
            {
                [self.view makeToast:@"取消收藏失败"];
            }
                break;
            default:
                break;
        }
        
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark 📶(网络请求)Network end
@end
