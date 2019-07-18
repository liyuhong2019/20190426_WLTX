//
//  WLTX_PresentCommonSelectMsgTypeTableViewVC.m
//  WLTX
//
//  Created by 10.12 on 2019/7/16.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_PresentCommonSelectMsgTypeTableViewVC.h"
#import "WLTX_IntegratedQueryModel.h"

@interface WLTX_PresentCommonSelectMsgTypeTableViewVC ()
@property(retain,nonatomic) NSArray *selectMsgTypeDataA;
@end

@implementation WLTX_PresentCommonSelectMsgTypeTableViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
}


// http://m.0201566.com/appapi//zhcx.php
- (void)initData
{
//    NSArray *provinces=[[NSArray alloc] initWithObjects:@"湖南",@"湖北",@"山东",@"山西",@"河南",@"河北",@"广东",@"广西",@"黑龙江",@"内蒙古",@"新疆",@"西藏",@"台湾",@"香港",@"澳门", nil];

//    NSArray *provinces=[[NSArray alloc] initWithObjects:@"物流供求",@"找车",@"找货",@"找专线",@"货车信息",@"今日特价",@" 物流招聘",@"印刷厂家",@"网络公司",@"企业彩铃",@"招租转让",@"微信开发",@"地图定位",@"代理记账",@"VI品牌设计",@"综合保险",@"物流软件",@"专业叉车",@"运输发票",@"油卡出售", nil];
//    self.selectMsgTypeDataA = provinces;
    
    
    [self network_getIntegratedQueryListRequest];
    
    self.tableview.rowHeight = 50;
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    self.tableview.tableFooterView = [[UIView alloc]init];
    
    [self CommonSelectAreaVC_settingsNav];
}

// 专线路线
- (void)network_getIntegratedQueryListRequest
{
    [AFNetworkingTool postWithURLString:Home_IntegratedQueryListUrl parameters:nil resultClass:nil success:^(id result) {
        NSLog(@" 综合查询 result = %@",result);
        NSArray *data = result[@"listdata"];
        NSArray *array = [WLTX_IntegratedQueryModel mj_objectArrayWithKeyValuesArray:data];
        self.selectMsgTypeDataA = array;
        
        
        
        [self.tableview reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}


- (void)CommonSelectAreaVC_settingsNav
{
    self.navigationItem.title = @"信息发布";
    self.view.backgroundColor = UIColorFromRGB(0xF5F5F5);
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [backButton setTitle:@"关闭" forState:0];
//    [backButton setTitleColor:[UIColor blackColor] forState:0];
    [backButton setImage:[UIImage imageNamed:@"integratedQuery_tu1"] forState:0];

    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [backButton addTarget:self action:@selector(clickCloseVC:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

#pragma mark - BtnAction

- (void)clickCloseVC:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - tableview dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.selectMsgTypeDataA.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    //单元格ID
    static NSString *CellTableIndentifier = @"CellTableIdentifier";
    
    //重用单元格
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIndentifier];
    //初始化单元格
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellTableIndentifier];
        //自带有两种基础的tableView样式，UITableViewCellStyleValue1、2. 后面的文章会讲解自定义样式
    }
    
    //    UIImage *img = [UIImage imageNamed:@"tachi.png"];
    //    cell.imageView.image = img;
    //添加图片
    
    WLTX_IntegratedQueryModel *model = [self.selectMsgTypeDataA objectAtIndex:indexPath.row];
    cell.textLabel.text = model.name;
//    cell.textLabel.text = [self.selectMsgTypeDataA objectAtIndex:indexPath.row];
//    cell.detailTextLabel.text = @"省份";
    //添加右侧注释
    
    return cell;
}

#pragma mark - tableview Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"deselectRowAtIndexPath 取消选择索引路径处的行");
    [tableView deselectRowAtIndexPath:indexPath animated:NO]; // 取消选择索引路径处的行
    NSLog(@"选中的城市是 %@",self.selectMsgTypeDataA[indexPath.row]);
    WLTX_ReleaseCommonInfoVC *vc = [[WLTX_ReleaseCommonInfoVC alloc]init];
    //        vc.releaseType = ReleaseType_Logistics;
    //        vc.hidesBottomBarWhenPushed= YES;
    //        [(LYHNavigationController *)self.window.rootViewController.navigationController pushViewController:vc animated:YES];
    // 需要拿到当前的tabbar的导航栏进行跳转
    NSInteger indexrow = indexPath.row;
    
    WLTX_IntegratedQueryModel *model = [self.selectMsgTypeDataA objectAtIndex:indexPath.row];
    vc.releaseType = [[NSString stringWithFormat:@"%@",model.id] intValue] ;
    
    if (vc.releaseType == 3) {
        NSLog(@"货车信息");
        

        WLTX_ReleaseCarInfoVC *carvc = [[WLTX_ReleaseCarInfoVC alloc]init];
        [self.navigationController pushViewController:carvc animated:YES];
    }
    else
    {
        NSLog(@"____ releasetype %d",vc.releaseType);
        [self.navigationController pushViewController:vc animated:YES];

    }
    
    
    NSLog(@"点击了按钮1，进入按钮1的事件 end");
    
    
}

@end
