//
//  WLTX_IReleaseViewController.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/4/12.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_IReleaseViewController.h"
#import "WLTX_PublishInformationModel.h"
#import "WLTX_PushCarModel.h"


@interface WLTX_IReleaseViewController ()
<UITableViewDelegate,
UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *btn_pushInformation;
@property (weak, nonatomic) IBOutlet UIButton *btn_pushCar;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *infomationModels;
@property (nonatomic, strong) NSMutableArray *carModels;

@end

@implementation WLTX_IReleaseViewController

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
#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView.tag == 10) {
        return self.infomationModels.count;
    }
    
    else
    {
        return self.carModels.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag == 10) {
        WLTX_PublishInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:WLTX_PublishInformationCellID];
        cell.model = self.infomationModels[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }
    else
    {
        WLTX_PushCarCell  *cell = [tableView dequeueReusableCellWithIdentifier:WLTX_PushCarCellID];
        cell.model = self.carModels[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark 🏃(代理)Delegate end
#pragma mark - ✍🏻(自定义方法) custom method start
/**
 登陆页面 初始化数据
 */
- (void)userAgreementVC_settingsInitData
{
    YHLog(@"初始化数据");
    //    self.view.backgroundColor = [UIColor whiteColor];
    [self userAgreement_settingsNav];
    self.tableview.tag = 10;
    self.tableview.tableFooterView = [[UIView alloc]init];
    
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([WLTX_PublishInformationCell class]) bundle:nil] forCellReuseIdentifier:WLTX_PublishInformationCellID];
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([WLTX_PushCarCell class]) bundle:nil] forCellReuseIdentifier:WLTX_PushCarCellID];

    self.page = 0;

    NSDictionary *dict = @{@"shouji":[[NSUserDefaults standardUserDefaults] objectForKey:@"user_shouji"],
                           };
    [self netwrok_getpushInformationRequest:dict];
    
    
    __weak typeof(self) weakSelf = self;
    [self.tableview addHeaderWithHeaderWithBeginRefresh:YES animation:YES refreshBlock:^(NSInteger pageIndex) {
        NSLog(@"pageIndex:%zd",pageIndex);
        weakSelf.page = pageIndex;
        [self loadData:YES];
    }];
    
    [self.tableview addFooterWithWithHeaderWithAutomaticallyRefresh:NO loadMoreBlock:^(NSInteger pageIndex) {
        NSLog(@"pageIndex:%zd",pageIndex);
        weakSelf.page = pageIndex;
        [self loadData:NO];
    }];
    
    [self loadData:YES];
    
}
- (void)loadData:(BOOL)isRef
{
    if (isRef) {
//        [self.listArr removeAllObjects];
    }
    
    if (self.page < 3) {
        for (int i = 0; i < 10; i ++) {
//            [self.listArr addObject:@(i)];
        }
        [self.tableview endFooterRefresh];
        [self.tableview reloadData];
    }
    else{
        [self.tableview endFooterNoMoreData];
    }
}
/**
 登陆页面设置 nav
 */
- (void)userAgreement_settingsNav
{
    self.navigationItem.title = @"我的发布";
    self.view.backgroundColor = UIColorFromRGB(0xF5F5F5);
    
}
#pragma mark  ✍🏻(自定义方法) custom method end

- (IBAction)relodData:(UIButton *)sender {
    [self.btn_pushInformation setTitleColor:[UIColor orangeColor] forState:0];
    [self.btn_pushCar setTitleColor:[UIColor blackColor] forState:0];
    
    NSDictionary *dict = @{@"shouji":[[NSUserDefaults standardUserDefaults] objectForKey:@"user_shouji"],
                           @"gage":@"0"
                           };
    
    [self netwrok_getpushInformationRequest:dict];
    self.tableview.tag = 10;
    [self.tableview reloadData];
}
- (IBAction)relodData2:(UIButton *)sender {
    [self.btn_pushCar setTitleColor:[UIColor orangeColor] forState:0];
    [self.btn_pushInformation setTitleColor:[UIColor blackColor] forState:0];
    
    NSDictionary *dict = @{@"shouji":[[NSUserDefaults standardUserDefaults] objectForKey:@"user_shouji"],
                           @"gage":@"0"
                           };
    [self netwrok_getpushCarRequest:dict];
    self.tableview.tag = 20;
    [self.tableview reloadData];
}

#pragma mark - 📶(网络请求)Network start
// 获取发布信息
- (void)netwrok_getpushInformationRequest:(NSDictionary *)dict
{
    [AFNetworkingTool getWithURLString:my_getpushInformationList parameters:dict resultClass:nil success:^(id result) {
        NSLog(@"获取发布信息 result = %@",[result mj_JSONString]);
        NSDictionary *dataDict = result;
        NSString *all_number = dataDict[@"all_num"];
        self.page = [[dataDict objectForKey:@"nextpage"] integerValue];
        NSArray *dataArr = dataDict[@"data"];
        NSMutableArray *dataMArr  =
        self.infomationModels = [WLTX_PublishInformationModel mj_objectArrayWithKeyValuesArray:dataArr];
        //NSLog(@"dataMArr %@",dataMArr);
        
        [self.tableview reloadData];
        
        
    } failure:^(NSError *error) {
        NSString *errorMsg = [NSString stringWithFormat:@"%@",[error.localizedDescription mj_JSONString]];
        [self.view makeToast:errorMsg];
        
    }];
}


- (void)netwrok_getpushCarRequest:(NSDictionary *)dict
{
    [AFNetworkingTool getWithURLString:my_getCarList parameters:dict resultClass:nil success:^(id result) {
        NSLog(@"result = %@",[result mj_JSONString]);
        NSDictionary *dataDict = result;
        NSString *all_number = dataDict[@"all_num"];
        self.page = [[dataDict objectForKey:@"nextpage"] integerValue];
        NSArray *dataArr = dataDict[@"data"];
        NSMutableArray *dataMArr  =self.carModels = [WLTX_PushCarModel mj_objectArrayWithKeyValuesArray:dataArr];
        //NSLog(@"dataMArr %@",dataMArr);
        
        [self.tableview reloadData];
        
    } failure:^(NSError *error) {
        NSString *errorMsg = [NSString stringWithFormat:@"%@",[error.localizedDescription mj_JSONString]];
        [self.view makeToast:errorMsg];
        
    }];
}

#pragma mark 📶(网络请求)Network end
#pragma mark - 💤 控件/对象懒加载 object start
#pragma mark 💤 控件/对象懒加载 object end

@end
