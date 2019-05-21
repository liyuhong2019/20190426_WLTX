//
//  WLTX_SpecialLineQueryViewController.m
//  WLTX
//
//  Created by lee on 2019/3/6.
//  Copyright © 2019年 liyuhong165. All rights reserved.
//

#import "WLTX_SpecialLineQueryViewController.h"
#import "WLTX_SpecialLineQueryModel.h"
#import "WLTX_SpecialLineQueryCell.h"
#import "WLTX_SpecialLineSearchVC.h"
#import "WLTX_LocationSearchVC.h"
@interface WLTX_SpecialLineQueryViewController ()
<UITableViewDelegate,
UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong,nonatomic) NSMutableArray *specialLineArr;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger nextpage;
@end

@implementation WLTX_SpecialLineQueryViewController

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
    //    WLTX_LoginViewController *lgVC = [[WLTX_LoginViewController alloc]initWithNibName:NSStringFromClass([WLTX_LoginViewController class]) bundle:nil];
    //    LYHNavigationController *nav = [[LYHNavigationController alloc] initWithRootViewController:lgVC];
    //    [self presentViewController:nav animated:YES completion:nil];
    
    self.page = 1; // 初始化 为第0页
    NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
    [self netwrok_getmyCollectionListRequestWithPage:page Withappend:NO];

    
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
    self.cityStrs = [[NSMutableString alloc]init];
    //    self.view.backgroundColor = [UIColor whiteColor];
    [self SpecialLineQueryVC_settingsNav];
    [self SpecialLineQueryVC_CommonSettings];
    
    
    
    __weak typeof(self) weakSelf = self;
    [self.tableview addHeaderWithHeaderWithBeginRefresh:YES animation:YES refreshBlock:^(NSInteger pageIndex) {
        NSLog(@"pageIndex:%zd",pageIndex);
        //        weakSelf.page = pageIndex;
        self.page = 1; // 初始化 为第1页
//        [self netwrok_getmyCollectionListRequestWithappend:NO];
        NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
        [self netwrok_getmyCollectionListRequestWithPage:page Withappend:NO];
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
        [self netwrok_getmyCollectionListRequestWithPage:page Withappend:YES];
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
- (IBAction)go2SearchVC:(UIButton *)sender {
    WLTX_SpecialLineSearchVC *vc = [[WLTX_SpecialLineSearchVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)go2VoiceSearch:(UIButton *)sender {
    NSLog(@"语音识别");
    [self haveView];
}


#pragma mark - 📶(网络请求)Network start
// 1、综合页面里面查询
- (void)netwrok_getmyCollectionListRequestWithPage:(NSString *)page Withappend:(BOOL)append
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



#pragma mark - 讯飞科大
- (void)haveView
{
    if (_iflyRecognizerView == nil) {
        
        _iflyRecognizerView= [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
        NSLog(@"创建视图");
    }
    
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
//        [_iflyRecognizerView setParameter:@"" forKey:@""]
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
