//
//  WLTX_CoomonIntegratedQueryListVC.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/19.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_CoomonIntegratedQueryListVC.h"
#import "WLTX_CoomonIQDetailsVC.h"
#import "WLTX_CoomonIntegratedQueryListModel.h"

@interface WLTX_CoomonIntegratedQueryListVC ()
<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong,nonatomic) NSMutableArray<WLTX_CoomonIntegratedQueryListModel *> *dataListArr;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger nextpage;
@property (nonatomic ,strong) NSString *detailId;

@end

@implementation WLTX_CoomonIntegratedQueryListVC
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.page = 1;
    
    
    NSString *detailsId = self.detailId =  [NSString stringWithFormat:@"%ld",self.type];
    NSString *pageId =  [NSString stringWithFormat:@"%ld",self.page];

    [self netwrok_getintegrateQueryListRequestWithId:detailsId WithPage:pageId Withappend:NO];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self CoomonIntegratedQueryListVC_initData];
    
    [self CoomonIntegratedQueryListVC_setTableViewConfig];

}
- (void)CoomonIntegratedQueryListVC_initData
{
    NSLog(@"类型是 %ld",self.type);
    
    
}
- (void)CoomonIntegratedQueryListVC_setTableViewConfig
{
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([WLTX_CommonLogisticsCell class]) bundle:nil] forCellReuseIdentifier:WLTX_CommonLogisticsCellID];
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"customCell"];
    
    __weak typeof(self) weakSelf = self;
    self.tableview.tableFooterView = [[UIView alloc]init];
    [self.tableview addHeaderWithHeaderWithBeginRefresh:YES animation:YES refreshBlock:^(NSInteger pageIndex) {
        NSLog(@"下拉刷新 获取最开始的数据");
        NSLog(@"nextpage :%ld",self.nextpage);
        
        self.page = 1;
        NSString *detailsId =  [NSString stringWithFormat:@"%ld",self.type];
        NSString *pageId =  [NSString stringWithFormat:@"%ld",self.page];
        [self netwrok_getintegrateQueryListRequestWithId:detailsId WithPage:pageId Withappend:NO];

    }];
    
    [self.tableview addFooterWithWithHeaderWithAutomaticallyRefresh:NO loadMoreBlock:^(NSInteger pageIndex) {
        NSLog(@"上拉刷新 获取最新的数据");
        NSLog(@"nextpage :%ld",self.nextpage);
        
        // 这里逻辑判断
        if (self.nextpage == 0) {
            [self.tableview endFooterNoMoreData];
            return ;
        }
        
        NSString *detailsId =  [NSString stringWithFormat:@"%ld",self.type];
        NSString *pageId =  [NSString stringWithFormat:@"%ld",self.page];

        NSDictionary *dict = @{
                               @"shouji":kWltx_userShouji,
                               @"page":pageId,
                               };
        [self netwrok_getintegrateQueryListRequestWithId:detailsId WithPage:pageId Withappend:YES];
        [self.tableview endFooterRefresh];

    }];
    
}

#pragma mark - 🏃(代理)Delegate start
#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.type == CoomonIntegratedQueryListType_Logistics) {
        WLTX_CommonLogisticsCell  *cell = [tableView dequeueReusableCellWithIdentifier:WLTX_CommonLogisticsCellID];
        WLTX_CoomonIntegratedQueryListModel *model = self.dataListArr[indexPath.row];
        cell.model = model;
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"customCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }

    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"click index row %ld",indexPath.row);
//    if (<#condition#>) {
//        <#statements#>
//    }
    
    WLTX_CoomonIntegratedQueryListModel *model = self.dataListArr[indexPath.row];
    
    WLTX_CoomonIQDetailsVC *vc = [[WLTX_CoomonIQDetailsVC alloc]init];
    vc.detailsid =  self.detailId;
    vc.title = model.title;
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark - 📶(网络请求)Network start


// 专线路线
- (void)netwrok_getintegrateQueryListRequestWithId:(NSString *)detailsId WithPage:(NSString *)page Withappend:(BOOL)append
{
    [AFNetworkingTool postWithURLString:Coomon_integrateQueryList(detailsId,page) parameters:nil resultClass:nil success:^(id result) {
        NSLog(@"result = %@",result);
        NSArray *dataArr = result[@"data"];         // 列表数据
        NSString *all_num = result[@"all_num"];
        NSString *id = result[@"id"];
        NSString *name = result[@"name"];
        NSString *nextpage = result[@"nextpage"]; // 是不是可以下一页
        self.nextpage = [nextpage integerValue];
        self.page += [nextpage integerValue];
        
        // self.dataListArr =[WLTX_CoomonIntegratedQueryListModel mj_objectArrayWithKeyValuesArray:dataArr];
        if (!append) {
            [self.dataListArr removeAllObjects];
            self.dataListArr = [WLTX_CoomonIntegratedQueryListModel mj_objectArrayWithKeyValuesArray:dataArr];
        }
        else
        {
            for (NSDictionary *dict in dataArr) {
                WLTX_CoomonIntegratedQueryListModel *model = [WLTX_CoomonIntegratedQueryListModel mj_objectWithKeyValues:dict];
                [self.dataListArr addObject:model];
            }
        }
        NSLog(@"integratedQueryListArr %@",self.dataListArr);
        
        NSLog(@"dataListArr %@",self.dataListArr);
        
        [self.tableview reloadData];
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark 📶(网络请求)Network end


@end
