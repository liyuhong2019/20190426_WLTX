//
//  WLTX_SpecialLineSearchVC.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/21.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_SpecialLineSearchVC.h"
#import "WLTX_SpecialLineQueryModel.h"
#import "WLTX_SpecialLineQueryCell.h"

@interface WLTX_SpecialLineSearchVC ()
<UITableViewDelegate,
UITableViewDataSource,
UITextFieldDelegate>
//@property (weak, nonatomic) IBOutlet UISearchBar *search;
@property (weak, nonatomic) IBOutlet UITextField *tf_search;

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong,nonatomic) NSMutableArray *specialLineArr;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger nextpage;
@end

@implementation WLTX_SpecialLineSearchVC

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
//    [self SpecialLineQueryVC_settingsInitData];
//    _search.barTintColor = [UIColor whiteColor];
//    _search.backgroundImage = [[UIImage alloc] init];

    
//    _searchBar.layer.borderWidth = 1;
//    
//    _searchBar.layer.borderColor = NAVC_COLOR.CGColor;
    
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
    self.page = 1; // 初始化 为第0页
    NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
    [self netwrok_getmySpecialLineListRequestWithPage:page Withappend:NO];
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
#pragma mark - textFieldDelegate

- (IBAction)go2Search:(UIButton *)sender {
    [self.tf_search resignFirstResponder];
    
    if ([self.tf_search.text isEqualToString:@""]) {
        NSLog(@"搜索最开始的数据");
        self.tableview.tag = 10;
        self.page = 1; // 初始化 为第0页
        NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
        [self netwrok_getmySpecialLineListRequestWithPage:page Withappend:NO];
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
        [self netwrok_getKeywordWithDict:dict Withappend:NO];
        
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
        [self netwrok_getmySpecialLineListRequestWithPage:page Withappend:NO];
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
        [self netwrok_getKeywordWithDict:dict Withappend:NO];

    }
}


#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.specialLineArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 175;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WLTX_SpecialLineQueryCell  *cell = [tableView dequeueReusableCellWithIdentifier:WLTX_SpecialLineQueryCellID];
    
    //    if (!cell) {
    //        cell = (WLTX_CollectionCell *)[[NSBundle mainBundle]loadNibNamed:@"WLTX_CollectionCell" owner:nil options:nil].firstObject;
    //
    //    }
    //    cell.model = self.carModels[indexPath.row];
    cell.model = self.specialLineArr[indexPath.row];
    [cell.btn_phoneNumber cq_addEventHandler:^{
        NSLog(@"打电话");
        [self vcCallPhoneNumber:cell.model.shouji];
    } forControlEvents:UIControlEventTouchUpInside];
    [cell. btn_companyNumber cq_addEventHandler:^{
        NSLog(@"打固定电话");
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
    [self SpecialLineQueryVC_CommonSettings];
    [self SpecialLineVC_settingsNav];
    
    __weak typeof(self) weakSelf = self;
    [self.tableview addHeaderWithHeaderWithBeginRefresh:YES animation:YES refreshBlock:^(NSInteger pageIndex) {
        NSLog(@"pageIndex:%zd",pageIndex);
        //        weakSelf.page = pageIndex;
        
        if (self.tableview.tag == 20) {
            self.page = 1; // 初始化 为第0页
            NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
//            [self netwrok_getKeywordWithKey:self.tf_search.text SpecialLineListRequestWithPage:page Withappend:NO];
            NSDictionary *dict = @{
                                   @"q":self.tf_search.text,
                                   @"page":page
                                   };
            //        [self netwrok_getKeywordWithKey:string SpecialLineListRequestWithPage:page Withappend:NO];
            [self netwrok_getKeywordWithDict:dict Withappend:NO];
            return ;
        }
        
        self.page = 1; // 初始化 为第1页
        //        [self netwrok_getmyCollectionListRequestWithappend:NO];
        NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
        [self netwrok_getmySpecialLineListRequestWithPage:page Withappend:NO];
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
        
        if (self.tableview.tag == 20) {
            NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
//            [self netwrok_getKeywordWithKey:self.tf_search.text SpecialLineListRequestWithPage:page Withappend:YES];
            NSDictionary *dict = @{
                                   @"q":self.tf_search.text,
                                   @"page":page
                                   };
            //        [self netwrok_getKeywordWithKey:string SpecialLineListRequestWithPage:page Withappend:NO];
            [self netwrok_getKeywordWithDict:dict Withappend:YES];

            [self.tableview endFooterRefresh];
            return ;
        }
        
        NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
        [self netwrok_getmySpecialLineListRequestWithPage:page Withappend:YES];
        [self.tableview endFooterRefresh];
        
    }];
    
    
}
- (void)SpecialLineVC_settingsNav
{
    self.view.backgroundColor = UIColorFromRGB(0xF5F5F5);
    self.navigationItem.title = @"搜索";
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"fenxiang16"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"fenxiang16"] forState:UIControlStateHighlighted];
//    [backButton setTitle:@"发布" forState:0];
    [backButton setTitleColor:[UIColor blackColor] forState:0];
    //    [backButton settitf]
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [backButton addTarget:self action:@selector(IntegratedQueryVC_go2Share:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}
- (void)IntegratedQueryVC_go2Share:(UIButton *)btn
{
    NSLog(@"分享");
    [self openUMShareUI];
}

- (void)openUMShareUI
{
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_WechatFavorite)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        NSLog(@"paltformType %ld",platformType);
        //        [self shareWebPageToPlatformType:platformType];
        [self shareWebPageToPlatformType:platformType withThumbUrlStr:@"" withTitleStr:@"到物流" withSubTitleStr:@"" withWebPageUrl:@"http://m.0201566.com/list.php?ss=1&qsd=&mdd=&sflx=2&sfname=&from=singlemessage"];
        NSLog(@"userInfo %@",userInfo);
    }];
}

// 分享到其他地方

// 分享line 链接
//- (void)


- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
                   withThumbUrlStr:(NSString *)thumbURL
                      withTitleStr:(NSString *)title
                   withSubTitleStr:(NSString *)subTitle
                    withWebPageUrl:(NSString *)webUrl
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    //    NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png"; // 分享图标
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject
                                         shareObjectWithTitle:title
                                         descr:subTitle
                                         thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = webUrl;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
    }];
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
    
    // 监听textfiled 内容改变的时候
    [self.tf_search addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];

}
#pragma mark - 📶(网络请求)Network start
// 1、所有的数据
- (void)netwrok_getmySpecialLineListRequestWithPage:(NSString *)page Withappend:(BOOL)append
{
    [AFNetworkingTool getWithURLString:SpecialLine_ListUrl(page) parameters:nil resultClass:nil success:^(id result) {
        NSLog(@"result = %@",[result mj_JSONObject]);
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

// 2、关键字搜索的数据
//- (void)netwrok_getKeywordWithKey:(NSString *)keyword SpecialLineListRequestWithPage:(NSString *)page Withappend:(BOOL)append
- (void)netwrok_getKeywordWithDict:(NSDictionary *)dict Withappend:(BOOL)append
{
    [AFNetworkingTool getWithURLString:SpecialLine_Search parameters:dict resultClass:nil success:^(id result) {
        NSLog(@"result = %@",[result mj_JSONObject]);
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
#pragma mark - 📶(网络请求)Network end
- (NSMutableArray *)specialLineArr
{
    if (_specialLineArr == nil) {
        _specialLineArr = [NSMutableArray array];
    }
    return _specialLineArr;
}

@end
