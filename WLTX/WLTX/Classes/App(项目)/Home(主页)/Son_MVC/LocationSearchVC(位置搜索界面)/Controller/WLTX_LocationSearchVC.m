//
//  WLTX_LocationSearchVC.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/21.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_LocationSearchVC.h"
#import "WLTX_SpecialLineQueryModel.h"
#import "WLTX_SpecialLineQueryCell.h"
@interface WLTX_LocationSearchVC ()
@property (weak, nonatomic) IBOutlet UILabel *lb_startLocation;
@property (weak, nonatomic) IBOutlet UILabel *lb_endLocation;


@property (weak, nonatomic) IBOutlet UITableView *tableview;

// 用于tableview刷新的数据
@property (strong,nonatomic) NSMutableArray *specialLineArr;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger nextpage;

@end

@implementation WLTX_LocationSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCustomBackBarButton];
    [self SpecialLineQueryVC_settingsInitData];
    
}
- (void)addCustomBackBarButton
{
    //    self.view.backgroundColor = UIColorFromRGB(0x000000);
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateHighlighted];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:15];
    // 让按钮内部的所有内容左对齐
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backButton addTarget:self action:@selector(popRootViewWithButton:) forControlEvents:UIControlEventTouchUpInside];
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0); // 这里微调返回键的位置可以让它看上去和左边紧贴
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}
-(void)popRootViewWithButton:(UIButton *)btn
{
    NSLog(@"返回最顶层");
    self.navigationController.tabBarController.hidesBottomBarWhenPushed=NO;
    self.navigationController.tabBarController.selectedIndex=0;
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"old %@ ",self.startText);

    NSLog(@"new %@",self.lb_startLocation.text);
    
    

    
    self.lb_startLocation.text = self.startText;
    self.lb_endLocation.text = self.endText;
    
    //
    self.page = 1; // 初始化 为第0页
    NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
    // 测试数据
//    NSDictionary *dict = @{
//                           @"qsd":@"广州",
//                           @"mdd":@"合肥",
//                           @"page":page,
//                           };
//    [self netwrok_getLocationSearchRequestWithDict:dict WithAppend:NO];
    NSLog(@"self.lb_startLocation.text %@",self.lb_startLocation.text);
    NSLog(@"self.lb_endLocation.text %@",self.lb_endLocation.text);

    NSDictionary *dict = @{
                           @"qsd":self.lb_startLocation.text,
                           @"mdd":self.lb_endLocation.text,
                           @"page":page,
                           };
    [self netwrok_getLocationSearchRequestWithDict:dict WithAppend:NO];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}
- (IBAction)go2change:(UIButton *)sender {
    NSString *temp =  self.lb_startLocation.text;
    self.lb_startLocation.text = self.lb_endLocation.text;
    self.lb_endLocation.text = temp;
}
- (IBAction)go2SelectCity:(UIButton *)sender {
    WLTX_CommonSelectAreaVC *vc = [[WLTX_CommonSelectAreaVC alloc]init];
    switch (sender.tag) {
        case 10:
        {
            NSLog(@"起始点");
            vc.title = @"起始点";
            vc.type = WLTX_CommonSelectAreaType_StartLocation;
            
        }
            break;
        case 20:
        {
            NSLog(@"目的地");
            vc.title = @"目的地";
            vc.startLocation = self.lb_startLocation.text;
            vc.type = WLTX_CommonSelectAreaType_EndLocation;
        }
            break;
            
        default:
            break;
    }
    vc.block = ^(NSString *cityName,WLTX_CommonSelectAreaType type)
    {
        if (type == WLTX_CommonSelectAreaType_StartLocation) {
            self.startText = cityName;
            self.lb_startLocation.text = cityName;
            self.lb_startLocation.textColor = [UIColor blackColor];
            
        }
        else
        {
            self.endText = cityName;
            self.lb_endLocation.text = cityName;
            self.lb_endLocation.textColor = [UIColor blackColor];
        }
        NSLog(@"A界面的block is %@",cityName);
        
        // 在这里检测是不是两个地址都填写了
        // 如果是都填写 就直接跳转到 搜索页面
        // 相当于执行了查询操作
    };
    
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 🏃(代理)Delegate start
#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.specialLineArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 175;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WLTX_SpecialLineQueryCell  *cell = [tableView dequeueReusableCellWithIdentifier:WLTX_SpecialLineQueryCellID];

    cell.model = self.specialLineArr[indexPath.row];
    [cell.btn_phoneNumber cq_addEventHandler:^{
        NSLog(@"打电话");
        SharedAppDelegate.companyName = cell.model.gsname;
        [self vcCallPhoneNumber:cell.model.shouji];
    } forControlEvents:UIControlEventTouchUpInside];
    [cell. btn_companyNumber cq_addEventHandler:^{
        NSLog(@"打固定电话");
        SharedAppDelegate.companyName = cell.model.gsname;
        [self vcCallPhoneNumber:cell.model.tel];
    } forControlEvents:UIControlEventTouchUpInside];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    WLTX_SpecialLineQueryModel *model = self.specialLineArr[indexPath.row];
    WLTX_SpecialDetailsVC *vc = [[WLTX_SpecialDetailsVC alloc]init];
    vc.detailsId = model.id;
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark - ✍🏻(自定义方法) custom method start
/**
 登陆页面 初始化数据
 */
- (void)SpecialLineQueryVC_settingsInitData
{
    YHLog(@"初始化数据");
    //    self.view.backgroundColor = [UIColor whiteColor];
    [self SpecialLineQueryVC_settingsNav];
    [self SpecialLineQueryVC_CommonSettings];
    
//    NSLog(@"self.lb_startLocation.text %@",self.lb_startLocation.text);
//    NSLog(@"self.lb_endLocation.text %@",self.lb_endLocation.text);

    __weak typeof(self) weakSelf = self;
    [self.tableview addHeaderWithHeaderWithBeginRefresh:YES animation:YES refreshBlock:^(NSInteger pageIndex) {
        NSLog(@"pageIndex:%zd",pageIndex);
        //        weakSelf.page = pageIndex;
        self.page = 1; // 初始化 为第1页
        //        [self netwrok_getmyCollectionListRequestWithappend:NO];
        NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
        NSDictionary *dict = @{
                               @"qsd":self.lb_startLocation.text,
                               @"mdd":self.lb_endLocation.text,
                               @"page":page,
                               };
        [self netwrok_getLocationSearchRequestWithDict:dict WithAppend:NO];
    }];
    
    [self.tableview addFooterWithWithHeaderWithAutomaticallyRefresh:NO loadMoreBlock:^(NSInteger pageIndex) {
        //NSLog(@"pageIndex:%zd",pageIndex);
        
        NSLog(@"下拉刷新");
        NSLog(@"self.page :%zd",self.page);
        NSLog(@"nextpage :%zd",self.nextpage);
        
        // 这里逻辑判断
        if (self.nextpage == 0) {
            [self.tableview endFooterNoMoreData];
            return ;
        }
        
        NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
//        [self netwrok_getmyCollectionListRequestWithPage:page Withappend:YES];
        
        NSDictionary *dict = @{
                               @"qsd":self.lb_startLocation.text,
                               @"mdd":self.lb_endLocation.text,
                               @"page":page,
                               };
        [self netwrok_getLocationSearchRequestWithDict:dict WithAppend:YES];
        
        [self.tableview endFooterRefresh];
        
    }];
    
    
}
/**
 登陆页面设置 nav
 */
- (void)SpecialLineQueryVC_settingsNav
{
    self.navigationItem.title = @"专线查询";
    self.view.backgroundColor = UIColorFromRGB(0xF5F5F5);
    
}

/**
 初始化一些公共设置
 */
- (void)SpecialLineQueryVC_CommonSettings
{
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    
    // 空页面的数据源、数据代理设置
    //    self.tableview.emptyDataSetSource = self;
    //    self.tableview.emptyDataSetDelegate = self;
    
    //    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WLT_LogisticsRecruitmentCell class]) bundle:nil] forCellReuseIdentifier:WLT_LogisticsRecruitmentCellID];
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([WLTX_SpecialLineQueryCell class]) bundle:nil] forCellReuseIdentifier:WLTX_SpecialLineQueryCellID];
    
}

// 石井排名、太和排名
- (IBAction)go2Shiji_RangKing:(UIButton *)sender {
    NSLog(@"石井排名");
    // http://m.0201566.com/appapi//list.php?qsd=广州&mdd=广州&a=石井&page=1
    self.page = 1; // 初始化 为第0页
    NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
    // 测试数据
    //    NSDictionary *dict = @{
    //                           @"qsd":@"广州",
    //                           @"mdd":@"合肥",
    //                           @"page":page,
    //                           };
    //    [self netwrok_getLocationSearchRequestWithDict:dict WithAppend:NO];
    
    NSDictionary *dict = @{
                           @"qsd":self.lb_startLocation.text,
                           @"mdd":self.lb_endLocation.text,
                           @"a" : @"石井",
                           @"page":page,
                           };
    [self netwrok_getLocationSearchRequestWithDict:dict WithAppend:NO];
}


- (IBAction)go2Taihe_RangKing:(UIButton *)sender {
    // http://m.0201566.com/appapi//list.php?qsd=广州&mdd=广州&a=太和&page=1
    NSLog(@"太和排名");
    self.page = 1; // 初始化 为第0页
    NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
    // 测试数据
    //    NSDictionary *dict = @{
    //                           @"qsd":@"广州",
    //                           @"mdd":@"合肥",
    //                           @"page":page,
    //                           };
    //    [self netwrok_getLocationSearchRequestWithDict:dict WithAppend:NO];
    
    NSDictionary *dict = @{
                           @"qsd":self.lb_startLocation.text,
                           @"mdd":self.lb_endLocation.text,
                           @"a" : @"太和",
                           @"page":page,
                           };
    [self netwrok_getLocationSearchRequestWithDict:dict WithAppend:NO];
}



#pragma mark - 📶(网络请求)Network start

- (void)netwrok_getLocationSearchRequestWithDict:(NSDictionary *)dict WithAppend:(BOOL)append
{
    [AFNetworkingTool getWithURLString:Home_Search parameters:dict resultClass:nil success:^(id result) {
        NSLog(@"result = %@",result);
        NSArray *data = result[@"data"];
        
        NSMutableArray *tempArrModel = [NSMutableArray array];
        if (!append) {
            [self.specialLineArr removeAllObjects];
            self.specialLineArr = [WLTX_SpecialLineQueryModel mj_objectArrayWithKeyValuesArray:data];
        }
        else
        {
            for (NSDictionary *dict in data) {
                WLTX_SpecialLineQueryModel *model = [WLTX_SpecialLineQueryModel mj_objectWithKeyValues:dict];
                [self.specialLineArr addObject:model];
            }
        }
        NSLog(@"integratedQueryListArr %@",self.specialLineArr);
        
        
        //        self.data_ad = tempArr;
        self.page += [result[@"nextpage"] integerValue];
        
        self.nextpage = [result[@"nextpage"] integerValue];
        
        [self.tableview reloadData];
    
        
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark 📶(网络请求)Network end


- (IBAction)go2Search:(UIButton *)sender {
    self.page = 1; // 初始化 为第0页
    NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
    NSLog(@"self.lb_startLocation.text %@",self.lb_startLocation.text);
    NSLog(@"self.lb_endLocation.text %@",self.lb_endLocation.text);
    
    NSDictionary *dict = @{
                           @"qsd":self.lb_startLocation.text,
                           @"mdd":self.lb_endLocation.text,
                           @"page":page,
                           };
    [self netwrok_getLocationSearchRequestWithDict:dict WithAppend:NO];
}

@end
