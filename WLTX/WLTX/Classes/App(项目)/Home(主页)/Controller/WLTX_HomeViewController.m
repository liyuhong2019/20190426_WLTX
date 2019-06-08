#import "WLTX_HomeViewController.h"
#import "AFNetworkingTool.h"
#import "WLTX_HomeAdModel.h"
#import "WLTX_ShuttleRouteModel.h"
#import "WLTX_CommonSelectAreaVC.h"
#import "WLTX_LocationSearchVC.h"
#import "WLTX_SpecialLineSearchVC.h"

@interface WLTX_HomeViewController ()
 <
SDCycleScrollViewDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource
>

{
    // content
    
    // header
    NSArray *_imagesURLStrings;
    SDCycleScrollView *_customCellScrollViewDemo;
    
    // center
    
    // footer
    
}

@property (weak, nonatomic) IBOutlet UIScrollView *scollview_content;

@property (weak, nonatomic) IBOutlet UIView *view_ad;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;
@property (strong, nonatomic)  NSMutableArray *data_ad;
@property (strong, nonatomic)  NSMutableArray *data_shuttleRoute;


//
@property (weak, nonatomic) IBOutlet UIView *view_voice;


// 开始、结束目的地
@property (weak, nonatomic) IBOutlet UILabel *lb_startLocation;
@property (weak, nonatomic) IBOutlet UILabel *lb_endLocation;

@property (nonatomic,strong) NSMutableString *cityStrs;
@end

@implementation WLTX_HomeViewController
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
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self netwrok_getAdRequest];
    [self netwrok_getShuttleRouteListRequest];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self addADView];
    

    [self homeVC_createCollectionView];
    [self homeVC_Config];
    
    
}

#pragma mark - header Action start
- (void)addADView
{
    // 情景二：采用网络图片实现
//    NSArray *imagesURLStrings = @[
//                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
//                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
//                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
//                                  ];
//    _imagesURLStrings = imagesURLStrings;
    
    
    
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view_ad.height) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    //    cycleScrollView2.titlesGroup = titles;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    [self.view_ad addSubview:cycleScrollView2];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView2.imageURLStringsGroup = _imagesURLStrings;
    });
    
}



#pragma mark  SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
    WLTX_HomeAdModel *model = self.data_ad[index];
    NSLog(@"%@",model);
    
    NSLog(@"点击的id 是 %@ ",model.id);
    WLTX_Home_ADDetailsViewController *vc = [[WLTX_Home_ADDetailsViewController alloc]initWithNibName:NSStringFromClass([WLTX_Home_ADDetailsViewController class]) bundle:nil];
    vc.adId = model.id;
    vc.weburl = model.url;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark header Action end

#pragma mark - Center Action start
#pragma mark  Center Action end

#pragma mark - Footer Action start
#pragma mark  Footer Action end


#pragma mark - 测试action
//- (IBAction)pushNestPage:(UIButton *)sender {
////    WLTX_NestPageViewController *vc = [[WLTX_NestPageViewController alloc]initWithNibName:NSStringFromClass([WLTX_NestPageViewController class]) bundle:nil];
//    WLTX_LogisticsRecruitmentViewController *vc = [[WLTX_LogisticsRecruitmentViewController alloc]initWithNibName:NSStringFromClass([WLTX_LogisticsRecruitmentViewController class]) bundle:nil];
//    
//    [self.navigationController pushViewController:vc animated:YES];
//}


- (IBAction)go2changeLocation:(UIButton *)sender {
    if ([self.lb_endLocation.text isEqualToString:@"目的地"]) {
        self.lb_startLocation.textColor = RGB(204, 204, 204);
        NSString *temp = self.lb_startLocation.text;
        self.lb_endLocation.text = temp;
        self.lb_endLocation.textColor = RGB(0, 0, 0);
        self.lb_startLocation.text = @"起始地";
    }
    else if ([self.lb_startLocation.text isEqualToString:@"起始地"])
    {
        self.lb_endLocation.textColor = RGB(204, 204, 204);
        NSString *temp = self.lb_endLocation.text;
        self.lb_startLocation.text = temp;
        self.lb_startLocation.textColor = RGB(0, 0, 0);
        self.lb_endLocation.text = @"目的地";

    }
    else
    {
        NSString *temp = self.lb_startLocation.text;
        self.lb_startLocation.text = self.lb_endLocation.text;
        self.lb_endLocation.text = temp;

    }
    
    
    
    
    
}

- (IBAction)go2SelectLocation:(UIButton *)sender {
    WLTX_CommonSelectAreaVC *vc = [[WLTX_CommonSelectAreaVC alloc]init];
    switch (sender.tag) {
        case 10:
        {
            NSLog(@"起始点");
            vc.title = @"起始点";
            vc.type = WLTX_CommonSelectAreaType_StartLocation;
//            [vc returnSelectCityName:^(NSString * _Nullable cityName) {
//                NSLog(@"A界面的block is %@",cityName);
//            }];
           
            
        }
        break;
        case 20:
        {
            NSLog(@"目的地");
            vc.title = @"目的地";
            vc.type = WLTX_CommonSelectAreaType_EndLocation;
        }
            break;

        default:
            break;
    }
    vc.block = ^(NSString *cityName,WLTX_CommonSelectAreaType type)
    {
        if (type == WLTX_CommonSelectAreaType_StartLocation) {
            self.lb_startLocation.text = cityName;
            self.lb_startLocation.textColor = [UIColor blackColor];

        }
        else
        {
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
- (IBAction)go2VoiceSearch:(UIButton *)sender {
    NSLog(@"语音识别");
    [self haveView];
}

- (IBAction)textSearch:(UIButton *)sender {
    NSLog(@"文字查询");
    
    NSString *startLb = self.lb_startLocation.text;
    NSString *endLb = self.lb_endLocation.text;
    
    NSLog(@"去搜索 ");
    if ([self.lb_startLocation.text isEqualToString:@"起始地"] || [self.lb_endLocation.text isEqualToString:@"目的地"] || [self.lb_startLocation.text isEqualToString:@""] || [self.lb_endLocation.text isEqualToString:@""]) {
        [self.view makeToast:@"起始地/目的地不能为空"];
        return;
    }
    
    // vc .startLb
    WLTX_LocationSearchVC *vc = [[WLTX_LocationSearchVC alloc]init];
    vc.startText = startLb;
    vc.endText = endLb;
    [self.navigationController pushViewController:vc animated:YES];
}



- (IBAction)login:(UIButton *)sender {
    NSLog(@"%s,友盟SDK登录",__func__);
    [self go2WeChatLogin];
}


- (IBAction)share:(UIButton *)sender {
    NSLog(@"%s,友盟SD分享",__func__);
    [self go2WeChatShare];
    
    /**
     设置分享面板
     #import <UShareUI/UShareUI.h>
     [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession)]];
     [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
     // 根据获取的platformType确定所选平台进行下一步操作
     }];
     */
    
}
- (IBAction)go2IntegratedQuery:(UIButton *)sender {
    WLTX_IntegratedQueryViewController *vc = [[WLTX_IntegratedQueryViewController alloc]init];
    [self.navigationController pushViewController: vc animated:YES];
}



/** 微信登录 */
- (void)go2WeChatLogin
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        
        UMSocialUserInfoResponse *resp = result;
        
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        NSLog(@" uid: %@", resp.uid);
        NSLog(@" openid: %@", resp.openid);
        NSLog(@" accessToken: %@", resp.accessToken);
        NSLog(@" refreshToken: %@", resp.refreshToken);
        NSLog(@" expiration: %@", resp.expiration);
        
        // 用户数据
        NSLog(@" name: %@", resp.name);
        NSLog(@" iconurl: %@", resp.iconurl);
        NSLog(@" gender: %@", resp.unionGender);
        
        // 第三方平台SDK原始数据
        NSLog(@" originalResponse: %@", resp.originalResponse);
    }];
}
#pragma mark - 分享网页 - 需要传递平台类型

/** 微信分享 */
- (void)go2WeChatShare
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"分享标题" descr:@"分享内容描述" thumImage:[UIImage imageNamed:@"logo"]]; // lyh165_thumb 是分享链接的图片
    //设置网页地址
    shareObject.webpageUrl =@"http://www.baidu.com";
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
            
        }
    }];
}

- (IBAction)go2moreSpecialLine:(UIButton *)sender {
    NSLog(@"查看更多专线");
    WLTX_SpecialLineVC *vc = [[WLTX_SpecialLineVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)go2SearchVc:(UIButton *)sender {
    WLTX_SpecialLineSearchVC *vc = [[WLTX_SpecialLineSearchVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)go2Sign:(UIButton *)sender {
    // http://m.0201566.com/appapi/my_gxz.php
    if (!kWltx_IsLogin) {
        WLTX_LoginViewController *lg = [[WLTX_LoginViewController alloc]initWithNibName:NSStringFromClass([WLTX_LoginViewController class]) bundle:nil];
        LYHNavigationController *nav = [[LYHNavigationController alloc]initWithRootViewController:lg];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    
    NSDictionary *dict = @{
                           @"shouji":kWltx_userShouji,
                           };
    [self network_signInRequest:dict];
    
}
- (void)network_signInRequest:(NSDictionary *)dict
{
    [AFNetworkingTool getWithURLString:Home_Sign parameters:dict resultClass:nil success:^(id result) {
        NSLog(@"result = %@",result);
        NSNumber *status = result[@"status"];
        NSString *tishi = result[@"tishi"];
        
        // {"status":1,"sum":"4","tishi":"签到成功，贡献值+2"}
        if ([status integerValue] == 1) {
            [self.view makeToast:tishi];
        }
        else
        {
            [self.view makeToast:tishi];
        }
        
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 🏃(代理)Delegate start
- (void)homeVC_Config
{
    self.cityStrs = [[NSMutableString alloc]init]; // 初始化语音搜索的结果
    self.lb_startLocation.text = @"广州";// 设置默认开始地址为广州
    self.lb_startLocation.textColor = [UIColor blackColor];
    
    self.scollview_content.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 1000);
    
    
//    self.view_voice.layer.cornerRadius = self.view_voice.frame.size.height / 2-13;
//    self.view_voice.layer.masksToBounds = YES;
    
    
    NSLog(@"%f cc",self.scollview_content.size.height);
    
}
- (void)homeVC_createCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    // 设置 上下左右 空白的大小
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumInteritemSpacing = 7.0f; // 两个单元格之间
    //设置代理
    self.collectionview.delegate = self;
    self.collectionview.dataSource = self;
    // 水平滚动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 布局对象
//    flowLayout.itemSize = CGSizeMake( ([UIScreen mainScreen].bounds.size.width - 5 - 30)/2 , 110);
    flowLayout.itemSize = CGSizeMake( ([UIScreen mainScreen].bounds.size.width - 15)/2 , 130);
    self.collectionview.collectionViewLayout = flowLayout;
    //注册 xib cell
    [self.collectionview registerNib:[UINib nibWithNibName:@"WLTX_ShuttleRouteCell" bundle:nil] forCellWithReuseIdentifier:@"WLTX_ShuttleRouteCell"];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.data_shuttleRoute.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath

{
    // 为单元格 定义一个静态字符串d作为标识符
    static NSString *cellId =@"WLTX_ShuttleRouteCell";
    // 从可重用单元格的队列中 取出一个单元格
    WLTX_ShuttleRouteCell *cell =(WLTX_ShuttleRouteCell *) [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.model = self.data_shuttleRoute[indexPath.row];
    
    
    return cell;
}
#pragma mark -- item点击跳转

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"主页 点击 专线展示的 item is %ld",indexPath.row);
    WLTX_ShuttleRouteModel *model = self.data_shuttleRoute[indexPath.row];
    WLTX_SpecialDetailsVC *vc = [[WLTX_SpecialDetailsVC alloc]init];
    vc.detailsId = model.id;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
#pragma mark 🏃(代理)Delegate end


#pragma mark - 📶(网络请求)Network start
- (void)netwrok_getAdRequest
{
    [AFNetworkingTool postWithURLString:Home_AdUrl parameters:nil resultClass:nil success:^(id result) {
        NSLog(@"result = %@",result);
        NSArray *data = result[@"data"];
        
        NSMutableArray *tempArr = [NSMutableArray array];
        NSMutableArray *tempArrModel = [NSMutableArray array];

        for (NSDictionary *dict in data) {
//            NSString *imgUrl = objc[@"img"]
            WLTX_HomeAdModel *ad = [WLTX_HomeAdModel mj_objectWithKeyValues:dict];
            [tempArr addObject:ad.img];
            [tempArrModel addObject:ad];

        }
        self.data_ad = tempArrModel;

//        self.data_ad = tempArr;
        NSLog(@"tempArr %@",tempArr);
        _imagesURLStrings = tempArr;
        
        [self addADView];

        
    } failure:^(NSError *error) {
        
    }];
}
// 专线路线
- (void)netwrok_getShuttleRouteListRequest
{
    [AFNetworkingTool postWithURLString:Home_ShuttleRouteUrl parameters:nil resultClass:nil success:^(id result) {
        NSLog(@"result = %@",result);
        NSArray *data = result[@"listdata"];
        
        NSMutableArray *tempArrModel = [NSMutableArray array];
        
        for (NSDictionary *dict in data) {
            //            NSString *imgUrl = objc[@"img"]
            WLTX_ShuttleRouteModel *routeModel = [WLTX_ShuttleRouteModel wltx_ShuttleRouteWithDict:dict];
            [tempArrModel addObject:routeModel];
        }
        self.data_shuttleRoute = tempArrModel;
        
        //        self.data_ad = tempArr;
        NSLog(@"data_shuttleRoute %@",tempArrModel);
        
        [self.collectionview reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark 📶(网络请求)Network end


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
        
        NSString *str = [self.cityStrs stringByReplacingOccurrencesOfString:@"。" withString:@""];
        NSLog(@"处理完。之后的字符串 %@",str);
        NSMutableArray *array = [NSMutableArray array];
        if ([str  containsString:@"到"]) {
            NSArray *arr = [str componentsSeparatedByString:@"到"];//匹配得到的下标
            array  = arr;
            NSLog(@"array:%@",array); //结果是adfsfsfs和dfsdf
        }
        if (array.count >=1) {
            NSString *startCity = array[0];
            NSString *endCity = array[1];
            NSLog(@"%@ -  %@",startCity,endCity);
            self.lb_startLocation.text = startCity;
            self.lb_endLocation.text = endCity;
            self.lb_startLocation.textColor = [UIColor blackColor];
            self.lb_endLocation.textColor = [UIColor blackColor];

            //  这里进行去跳转到下一个页面
            
            WLTX_LocationSearchVC *vc = [[WLTX_LocationSearchVC alloc]init];
            vc.startText = startCity;
            vc.endText = endCity;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
        // 处理解析不出来的语音文字
        self.cityStrs = [[NSMutableString alloc]init];

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
//    self.cityStrs = [self.cityStrs appendFormat:resultString];
}

@end
