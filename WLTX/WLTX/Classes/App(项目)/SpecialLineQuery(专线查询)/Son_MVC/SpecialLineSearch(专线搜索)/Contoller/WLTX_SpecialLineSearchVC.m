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

// 讯飞科大
@property (nonatomic,strong) NSMutableString *cityStrs;

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
#pragma mark -键盘弹出添加监听事件
    // 键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    // 键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHiden:) name:UIKeyboardWillHideNotification object:nil];
    
    [self SpecialLineQueryVC_settingsInitData];
    
}
- (void)dealloc
{
    //    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
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
    self.cityStrs = [[NSMutableString alloc]init]; // 初始化语音搜索的结果
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
        [self.tableview resetNoMoreData]; // 重置之前可以刷新的数据

        if (!append) {
            [self.specialLineArr removeAllObjects];
            self.page = 1; // 移除数据 都需要清空分页
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
        NSLog(@"page 之前  %ld",self.page);

        self.page += [result[@"nextpage"] integerValue];
        
        self.nextpage = [result[@"nextpage"] integerValue];
        
        NSLog(@"integratedQueryListArr %ld",self.specialLineArr.count);
        NSLog(@"page is  %ld",self.page);
        
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

// 石井排名、太和排名
- (IBAction)go2Shiji_RangKing:(UIButton *)sender {
    NSLog(@"石井排名");
    [self.specialLineArr removeAllObjects]; // 先移除之前的数据
    self.tableview.tag = 20;
    // 加载最新的数据
    self.page = 1; // 初始化 为第0页
    NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
    NSDictionary *dict = @{
                           @"q":@"石井",
                           @"page":page,
                           };
    //        [self netwrok_getKeywordWithKey:string SpecialLineListRequestWithPage:page Withappend:NO];
    [self netwrok_getKeywordWithDict:dict Withappend:NO];
    
}


- (IBAction)go2Taihe_RangKing:(UIButton *)sender {
    // http://m.0201566.com/appapi//list.php?qsd=广州&mdd=广州&a=太和&page=1
    NSLog(@"太和排名");
    [self.specialLineArr removeAllObjects]; // 先移除之前的数据
    self.tableview.tag = 20;
    // 加载最新的数据
    self.page = 1; // 初始化 为第0页
    NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
    NSDictionary *dict = @{
                           @"q":@"太和",
                           @"page":page,
                           };
    //        [self netwrok_getKeywordWithKey:string SpecialLineListRequestWithPage:page Withappend:NO];
    [self netwrok_getKeywordWithDict:dict Withappend:NO];
    
}



- (IBAction)voiceSearch:(UIButton *)sender {
    NSLog(@"语音搜索");
    [self haveView];
}

#pragma mark - 讯飞科大

// 修改讯飞科大的文字

- (void)haveView
{
    if (_iflyRecognizerView == nil) {
        
        _iflyRecognizerView= [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
        for(UIView *tview in _iflyRecognizerView.subviews){
            NSLog(@"tview is %@",tview);
            if ([tview isKindOfClass:NSClassFromString(@"IFlyRecognizerViewImp")]) {
                
                
                for (UILabel *label in tview.subviews) {
                    if ([label isKindOfClass:[UILabel class]]) {
                        if ([label.text containsString:@"语音识别"]) {
                            //                            label.hidden = YES;
                            label.text = @"出发地到目的地 (如:广州到合肥)";
                        }
                    }
                }
            }
        }
        
        NSLog(@"创建视图");
    }
    
    // 设置title
    
    
    [_iflyRecognizerView setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
    
    //set recognition domain
    [_iflyRecognizerView setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    
    
    _iflyRecognizerView.delegate = self;
    
    if (_iflyRecognizerView != nil) {
        // 超时的时间
        //set timeout of recording
        [_iflyRecognizerView setParameter:@"5000" forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
        //set VAD timeout of end of speech(EOS)
        [_iflyRecognizerView setParameter:@"30000" forKey:[IFlySpeechConstant VAD_EOS]];
        //set VAD timeout of beginning of speech(BOS)
        [_iflyRecognizerView setParameter:@"30000" forKey:[IFlySpeechConstant VAD_BOS]];
        //set network timeout
        [_iflyRecognizerView setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
        
        //set sample rate, 16K as a recommended option
        [_iflyRecognizerView setParameter:@"16000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
        
        //set language
        [_iflyRecognizerView setParameter:@"zh_cn" forKey:[IFlySpeechConstant LANGUAGE]];
        //set accent
        [_iflyRecognizerView setParameter:@"mandarin" forKey:[IFlySpeechConstant ACCENT]];
        //set whether or not to show punctuation in recognition results
        [_iflyRecognizerView setParameter:@"1" forKey:[IFlySpeechConstant ASR_PTT]];
        [_iflyRecognizerView setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
        
        [_iflyRecognizerView start];
        
    }
}
- (void) noView
{
    //创建语音识别对象
    _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
    _iFlySpeechRecognizer.delegate = self;
    //设置识别参数
    //设置为听写模式
    [_iFlySpeechRecognizer setParameter: @"iat" forKey: [IFlySpeechConstant IFLY_DOMAIN]];
    //asr_audio_path 是录音文件名，设置value为nil或者为空取消保存，默认保存目录在Library/cache下。
    [_iFlySpeechRecognizer setParameter:@"iat.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    [_iFlySpeechRecognizer setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
    //启动识别服务
    [_iFlySpeechRecognizer startListening];
}

#pragma mark - IFlySpeechRecognizerDelegate
//IFlySpeechRecognizerDelegate协议实现
//识别结果返回代理
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast{
    
    NSLog(@"results is %@ isLast is %d",results,isLast);
    NSLog(@"results urldecode %@",results.firstObject);
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    NSLog(@"resultString 无界面识别器 %@",resultString);
    
    
    
}
//识别会话结束返回代理
- (void)onCompleted: (IFlySpeechError *) error{
    NSLog(@"error is %@ ",error.errorDesc);
    [_iflyRecognizerView cancel];
    
    if ([error.errorDesc isEqualToString:@"服务正常"]) {
        NSLog(@"cityStrs %@",self.cityStrs);
        NSLog(@"拼接的字符串是 %@",self.cityStrs);
        //  处理字符串
        
        NSString *str =self.cityStrs;
        
        NSLog(@"处理完。之后的字符串 %@",str);
        
        if ([self.cityStrs containsString:@"。"]) {
            str = [self.cityStrs stringByReplacingOccurrencesOfString:@"。" withString:@""];
            self.navigationItem.title = str;
            
            NSLog(@"包含结束符号"); // 才去搜索
            [self.specialLineArr removeAllObjects]; // 先移除之前的数据
            self.tableview.tag = 20;
            // 加载最新的数据
            self.page = 1; // 初始化 为第0页
            NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
            NSDictionary *dict = @{
                                   @"q":str,
                                   @"page":page
                                   };
            [self netwrok_getKeywordWithDict:dict Withappend:NO];
            self.cityStrs = [[NSMutableString alloc]init];
        }
        else
        {
            NSLog(@"没有结束符号");
        }
        
    }
    else
    {
        NSLog(@"语音搜索识别失败");
    }
    
}
//停止录音回调
- (void) onEndOfSpeech{
    NSLog(@"停止录音回调");
}
//开始录音回调
- (void) onBeginOfSpeech{
    NSLog(@"开始录音回调");
}
//音量回调函数
- (void) onVolumeChanged: (int)volume{
    NSLog(@"音量回调函数");
}
//会话取消回调
- (void) onCancel{
    NSLog(@"会话取消回调");
    
}


#pragma mark view delegate
/*!
 *  回调返回识别结果
 *
 *  @param resultArray 识别结果，NSArray的第一个元素为NSDictionary，NSDictionary的key为识别结果，sc为识别结果的置信度
 *  @param isLast      -[out] 是否最后一个结果
 */
- (void)onResult:(NSArray *)resultArray isLast:(BOOL) isLast
{
    NSLog(@"results is %@ isLast is %d",resultArray,isLast);
    
    NSLog(@"results urldecode %@",resultArray.firstObject);
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = resultArray[0];
    
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    NSLog(@"resultString cc %@",resultString);
    [self.cityStrs  appendFormat:resultString];
    NSLog(@"拼接的字符串是 %@",self.cityStrs);
}

#pragma mark -键盘监听方法
- (void)keyboardWasShown:(NSNotification *)notification
{
    // 获取键盘的高度
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat height = SCREEN_HEIGHT - frame.size.height;
    
    NSLog(@"HEIGHT %f",height);
    self.layout_bottom_h.constant = frame.size.height + 50;
    
//    if (height < 455.5) {
//        self.textFiledScrollView.frame = CGRectMake(0, 64, kViewWidth, height);
//    }
//
//    if (![self.titleTextView.text isEqualToString:@""]) {
//        self.titleTextView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    } else {
//        self.titleTextView.contentInset = UIEdgeInsetsMake(20, 0, -20, 0);// 光标偏移
//    }
    
}
- (void)keyboardWillBeHiden:(NSNotification *)notification
{
    self.layout_bottom_h.constant = 100;
}

@end
