//
//  WLTX_CarListInfoVC.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/22.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_CarListInfoVC.h"
#import "WLTX_CarListInfoModel.h"
#import "WLTX_CarListInfoCell.h"
#import "WLTX_CarDetailsVC.h"

@interface WLTX_CarListInfoVC ()
<UITableViewDelegate,
UITableViewDataSource,
UITextFieldDelegate
>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong,nonatomic) NSMutableArray *specialLineArr;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger nextpage;

@property (nonatomic,strong) NSString *cityS;
@property (nonatomic,strong) NSString *carLengthS;
@property (weak, nonatomic) IBOutlet UILabel *lb_location;
@property (weak, nonatomic) IBOutlet UILabel *lb_carLength;
// 车长
@property (strong,nonatomic)  NSArray  *array;




//@property (weak, nonatomic) IBOutlet UISearchBar *search;
@property (weak, nonatomic) IBOutlet UITextField *tf_search;

@end

@implementation WLTX_CarListInfoVC

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
    [self SpecialLineQueryVC_settingsInitData];
}
- (void)dealloc
{
    //    [super dealloc];
    // 移除通知处理
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%s,在这里判断用户是否登录 如果没有登录。弹出登录界面",__func__);
    if ([self.lb_location.text isEqualToString:@""]) {
        self.cityS = @"广州";

    }else
    {
    }
    
    self.carLengthS = @"";
    self.lb_location.text = self.cityS;
//    self.lb_carLength.text = self.carLengthS;
    
    self.page = 1; // 初始化 为第0页
    NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
    NSDictionary *dict = @{
                           @"page":page,
                           @"city":self.lb_location.text,
                           @"length":self.carLengthS,
                           };
    [self netwrok_getCarListRequestWithDict:dict Withappend:NO];

//    [self netwrok_getmyCollectionListRequestWithPage:page Withappend:NO];
    
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[AppProject getInstance].gloalBtn setHidden:NO];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[AppProject getInstance].gloalBtn setHidden:YES];
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
    
    return self.specialLineArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 175;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WLTX_CarListInfoCell  *cell = [tableView dequeueReusableCellWithIdentifier:WLTX_CarListInfoCellID];
    
    //    if (!cell) {
    //        cell = (WLTX_CollectionCell *)[[NSBundle mainBundle]loadNibNamed:@"WLTX_CollectionCell" owner:nil options:nil].firstObject;
    //
    //    }
        cell.model = self.specialLineArr[indexPath.row];
//    cell.model = self.specialLineArr[indexPath.row];
    [cell.btn_phoneNumber cq_addEventHandler:^{
        NSLog(@"打电话");
        SharedAppDelegate.companyName = @"";
        [self vcCallPhoneNumber:cell.model.tel];
    } forControlEvents:UIControlEventTouchUpInside];
//    [cell. btn_companyNumber cq_addEventHandler:^{
//        NSLog(@"打固定电话");
//        [self vcCallPhoneNumber:cell.model.tel];
//    } forControlEvents:UIControlEventTouchUpInside];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    WLTX_CarListInfoModel *model = self.specialLineArr[indexPath.row];
    WLTX_CarDetailsVC *vc = [[WLTX_CarDetailsVC alloc]init];
    vc.detailsId = model.id;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)selectAction:(UIButton *)sender {
    
    WLTX_CommonSelectAreaVC *vc = [[WLTX_CommonSelectAreaVC alloc]init];
    switch (sender.tag) {
        case 10:
        {
            NSLog(@"起始点");
            vc.title = @"起始点";
            vc.type = WLTX_CommonSelectAreaType_ReleaseCarInfo;
            vc.block = ^(NSString *cityName,WLTX_CommonSelectAreaType type)
            {
                if (type == WLTX_CommonSelectAreaType_StartLocation) {
                    self.lb_location.text = cityName;
                    self.lb_location.textColor = [UIColor blackColor];
                    
                }
                else
                {
                    self.cityS = cityName;
                    self.lb_location.text = cityName;
                    self.lb_location.textColor = [UIColor blackColor];
                }
                NSLog(@"A界面的block is %@",cityName);
                
                // 在这里检测是不是两个地址都填写了
                // 如果是都填写 就直接跳转到 搜索页面
                // 相当于执行了查询操作
            };
            
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 20:
        {
            [self go2SelectCarLength];
        }
            
    }
    
    
}

#pragma mark - ✍🏻(自定义方法) custom method start
/**
 登陆页面 初始化数据
 */
- (void)SpecialLineQueryVC_settingsInitData
{
    YHLog(@"初始化数据");
//    self.cityS = @"广州";
//    self.carLengthS = @"";
//    self.lb_location.text = self.cityS;
//    self.lb_carLength.text = self.carLengthS;
    //    self.view.backgroundColor = [UIColor whiteColor];
    self.array = @[@"面包车",@"3.米",@"4.2米",@"5.2米",@"6.2米",@"6.8米",@"7.6米",@"8.7米",@"9.6米",@"13米",@"17.5米",@"其他车长"];
    [self SpecialLineQueryVC_settingsNav];
    [self SpecialLineQueryVC_CommonSettings];
    
//    [self.tf_search addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];

    
    __weak typeof(self) weakSelf = self;
    [self.tableview addHeaderWithHeaderWithBeginRefresh:YES animation:YES refreshBlock:^(NSInteger pageIndex) {
        NSLog(@"pageIndex:%zd",pageIndex);
        //        weakSelf.page = pageIndex;
        self.page = 1; // 初始化 为第1页
        //        [self netwrok_getmyCollectionListRequestWithappend:NO];
        NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
        if ([self.lb_carLength.text isEqualToString:@"车长"]) {
            self.carLengthS = @"";
        }
        else
        {
            self.carLengthS = self.lb_carLength.text;
        }
        
        
        if (self.tf_search.text.length ==0) {
            NSLog(@"搜索框没内容");
            NSDictionary *dict = @{
                                   @"page":page,
                                   @"city":self.lb_location.text,
                                   @"length":self.carLengthS,
                                   };
            [weakSelf netwrok_getCarListRequestWithDict:dict Withappend:NO];
        }
        else
        {
            NSLog(@"搜索框有内容");
            NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
            NSDictionary *dict = @{
                                   @"q":self.tf_search.text,
                                   @"page":page
                                   };
            //        [self netwrok_getKeywordWithKey:string SpecialLineListRequestWithPage:page Withappend:NO];
            //        [self netwrok_getKeywordWithDict:dict Withappend:NO];
            [self netwrok_getCarInfoKeywordWithDict:dict Withappend:NO];

        }
        
      
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
        if ([self.lb_carLength.text isEqualToString:@"车长"]) {
            self.carLengthS = @"";
        }
        else
        {
            self.carLengthS = self.lb_carLength.text;
        }
        
        
        if (self.tf_search.text.length ==0) {
            NSLog(@"搜索框没内容");
            NSDictionary *dict = @{
                                   @"page":page,
                                   @"city":self.lb_location.text,
                                   @"length":self.carLengthS,
                                   };
            [weakSelf netwrok_getCarListRequestWithDict:dict Withappend:YES];
        }
        else
        {
            NSLog(@"搜索框有内容");
            NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
            NSDictionary *dict = @{
                                   @"q":self.tf_search.text,
                                   @"page":page
                                   };
            [self netwrok_getCarInfoKeywordWithDict:dict Withappend:YES];
        }
       
//        [self netwrok_getmyCollectionListRequestWithPage:page Withappend:YES];
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
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([WLTX_CarListInfoCell class]) bundle:nil] forCellReuseIdentifier:WLTX_CarListInfoCellID];
    
}



#pragma mark - 📶(网络请求)Network start
// 1、综合页面里面查询
- (void)netwrok_getCarListRequestWithDict:(NSDictionary *)dict Withappend:(BOOL)append
{
    [AFNetworkingTool getWithURLString:Coomon_CarList parameters:dict resultClass:nil success:^(id result) {
        NSLog(@"result = %@",[result mj_JSONObject]);
        NSArray *data = result[@"data"];
        
        NSMutableArray *tempArrModel = [NSMutableArray array];
        if (!append) {
            [self.specialLineArr removeAllObjects];
            self.specialLineArr = [WLTX_CarListInfoModel mj_objectArrayWithKeyValuesArray:data];
        }
        else
        {
            for (NSDictionary *dict in data) {
                WLTX_CarListInfoModel *model = [WLTX_CarListInfoModel mj_objectWithKeyValues:dict];
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
#pragma mark - 📶(网络请求)Network end
#pragma mark - 💤 控件/对象懒加载 object start
- (NSMutableArray *)specialLineArr
{
    if (_specialLineArr == nil) {
        _specialLineArr = [NSMutableArray array];
    }
    return _specialLineArr;
}
#pragma mark 💤 控件/对象懒加载 object end
- (void)againNetwrokWith:(NSString *)length
{
//    [self.specialLineArr removeAllObjects];
    self.page = 1;
    NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
    NSDictionary *dict = @{
                           @"page":page,
                           @"city":self.lb_location.text,
                           @"length":length,
                           };
    [self netwrok_getCarListRequestWithDict:dict Withappend:NO];
}
//
- (void)go2SelectCarLength
{
    NSLog(@"选择车长");
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"请选择车长" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:self.array[0] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.lb_carLength.text = self.array[0];
        
        // 重新请求
        [self againNetwrokWith:self.array[0]];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:self.array[1] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.lb_carLength.text = self.array[1];
        [self againNetwrokWith:self.array[1]];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:self.array[2] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.lb_carLength.text = self.array[2];
        [self againNetwrokWith:self.array[2]];
    }];
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:self.array[3] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.lb_carLength.text = self.array[3];
        [self againNetwrokWith:self.array[3]];
    }];
    
    UIAlertAction *action5 = [UIAlertAction actionWithTitle:self.array[4] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.lb_carLength.text = self.array[4];
        [self againNetwrokWith:self.array[4]];
    }];
    UIAlertAction *action6 = [UIAlertAction actionWithTitle:self.array[5] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.lb_carLength.text = self.array[5];
        [self againNetwrokWith:self.array[5]];
    }];
    UIAlertAction *action7 = [UIAlertAction actionWithTitle:self.array[6] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.lb_carLength.text = self.array[6];
        [self againNetwrokWith:self.array[6]];
    }];
    UIAlertAction *action8 = [UIAlertAction actionWithTitle:self.array[7] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.lb_carLength.text = self.array[7];
        [self againNetwrokWith:self.array[7]];
    }];
    UIAlertAction *action9 = [UIAlertAction actionWithTitle:self.array[8] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.lb_carLength.text = self.array[8];
        [self againNetwrokWith:self.array[8]];
    }];
    
    UIAlertAction *action91 = [UIAlertAction actionWithTitle:self.array[9] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.lb_carLength.text = self.array[9];
        [self againNetwrokWith:self.array[9]];
    }];
    UIAlertAction *action92 = [UIAlertAction actionWithTitle:self.array[10] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.lb_carLength.text = self.array[10];
        [self againNetwrokWith:self.array[10]];
    }];
    UIAlertAction *action93 = [UIAlertAction actionWithTitle:self.array[11] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.lb_carLength.text = self.array[11];
        [self againNetwrokWith:self.array[11]];
    }];
    UIAlertAction *action10 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    [actionSheet addAction:action1];
    [actionSheet addAction:action2];
    [actionSheet addAction:action3];
    [actionSheet addAction:action4];
    [actionSheet addAction:action5];
    [actionSheet addAction:action6];
    [actionSheet addAction:action7];
    [actionSheet addAction:action8];
    [actionSheet addAction:action9];
    [actionSheet addAction:action10];
    [actionSheet addAction:action91];
    [actionSheet addAction:action92];
    [actionSheet addAction:action93];

    [self presentViewController:actionSheet animated:YES completion:nil];
    
}

#pragma mark - search

#pragma mark - textFieldDelegate

- (IBAction)go2Search:(UIButton *)sender {
    [self.tf_search resignFirstResponder];
    
    if ([self.tf_search.text isEqualToString:@""]) {
        NSLog(@"搜索最开始的数据");
        self.tableview.tag = 10;
        self.page = 1; // 初始化 为第0页
        NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
//        [self netwrok_getmySpecialLineListRequestWithPage:page Withappend:NO];
    }
    else
    {
        NSLog(@"搜索其他数据");
        // 这里以tag 区分会比较好
        
        [self.specialLineArr removeAllObjects]; // 先移除之前的数据
        self.tableview.tag = 20;
        // 加载最新的数据
        self.page = 1; // 初始化 为第0页
        NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
        NSDictionary *dict = @{
                               @"q":self.tf_search.text,
                               @"page":page
                               };
        //        [self netwrok_getKeywordWithKey:string SpecialLineListRequestWithPage:page Withappend:NO];
//        [self netwrok_getKeywordWithDict:dict Withappend:NO];
            [self netwrok_getCarInfoKeywordWithDict:dict Withappend:NO];

    }
    
}
- (void)textFieldChanged:(UITextField*)textField{
    
    NSString *string = textField.text;
    NSLog(@"change msg is %@",string);
    if ([string isEqualToString:@""]) {
        NSLog(@"搜索最开始的数据");
        self.tableview.tag = 10;
        self.page = 1; // 初始化 为第0页
        NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
//        [self netwrok_getmySpecialLineListRequestWithPage:page Withappend:NO];
    }
    else
    {
        NSLog(@"搜索其他数据");
        // 这里以tag 区分会比较好
        
        [self.specialLineArr removeAllObjects]; // 先移除之前的数据
        self.tableview.tag = 20;
        // 加载最新的数据
        self.page = 1; // 初始化 为第0页
        NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
        NSDictionary *dict = @{
                               @"q":string,
                               @"page":page
                               };
        //        [self netwrok_getKeywordWithKey:string SpecialLineListRequestWithPage:page Withappend:NO];
//        [self netwrok_getKeywordWithDict:dict Withappend:NO];
  
        //        [self netwrok_getKeywordWithDict:dict Withappend:NO];

    }
}


// 2、关键字搜索的数据
//- (void)netwrok_getKeywordWithKey:(NSString *)keyword SpecialLineListRequestWithPage:(NSString *)page Withappend:(BOOL)append
- (void)netwrok_getCarInfoKeywordWithDict:(NSDictionary *)dict Withappend:(BOOL)append
{
    [AFNetworkingTool getWithURLString:Coomon_CarList parameters:dict resultClass:nil success:^(id result) {
        NSLog(@"result = %@",[result mj_JSONObject]);
        NSArray *data = result[@"data"];
        
        NSMutableArray *tempArrModel = [NSMutableArray array];
        [self.tableview resetNoMoreData]; // 重置之前可以刷新的数据
        
        if (!append) {
            
            // WLTX_CarListInfoModel *model
            [self.specialLineArr removeAllObjects];
            self.page = 1; // 移除数据 都需要清空分页
            self.specialLineArr = [WLTX_CarListInfoModel mj_objectArrayWithKeyValuesArray:data];
        }
        else
        {
            for (NSDictionary *dict in data) {
                WLTX_CarListInfoModel *model = [WLTX_CarListInfoModel mj_objectWithKeyValues:dict];
                [self.specialLineArr addObject:model];
            }
        }
        NSLog(@"integratedQueryListArr %@",self.specialLineArr);
        
        
        //        self.data_ad = tempArr;
        NSLog(@"page 之前  %ld",self.page);
        
        self.page += [result[@"nextpage"] integerValue];
        
        self.nextpage = [result[@"nextpage"] integerValue];
        
        NSLog(@"integratedQueryListArr %ld",self.specialLineArr.count);
        NSLog(@"page is  %ld",self.page);
        
        [self.tableview reloadData];
        
        
    } failure:^(NSError *error) {
        
    }];
}


@end
