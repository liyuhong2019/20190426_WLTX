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

@property (nonatomic,strong) NSMutableString *cityStrs;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layout_bottom_h;
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
    self.cityStrs = [[NSMutableString alloc]init]; // 初始化语音搜索的结果
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
    NSLog(@"添加语音按钮");
    
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


#pragma mark - 讯飞科大
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
//            NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
//            NSDictionary *dict = @{
//                                   @"q":str,
//                                   @"page":page
//                                   };
//            [self netwrok_getKeywordWithDict:dict Withappend:NO];
            NSMutableArray *array = [NSMutableArray array];
            if ([str  containsString:@"到"]) {
                NSArray *arr = [str componentsSeparatedByString:@"到"];//匹配得到的下标
                array  = arr;
                NSLog(@"array:%@",array); //结果是adfsfsfs和dfsdf
                
                self.page = 1;
                NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
                if (array.count ==2) {
                    NSString *startCity = array[0];
                    NSString *endCity = array[1];
                    NSLog(@"%@ -  %@",startCity,endCity);
                    self.lb_startLocation.text = startCity;
                    self.lb_endLocation.text = endCity;
                    self.lb_startLocation.textColor = [UIColor blackColor];
                    self.lb_endLocation.textColor = [UIColor blackColor];
                    NSDictionary *dict = @{
                                           @"qsd":self.lb_startLocation.text,
                                           @"mdd":self.lb_endLocation.text,
                                           @"page":page,
                                           };
                    [self netwrok_getLocationSearchRequestWithDict:dict WithAppend:NO];
                    //  这里进行去跳转到下一个页面
                    
                    //                WLTX_LocationSearchVC *vc = [[WLTX_LocationSearchVC alloc]init];
                    //                vc.startText = startCity;
                    //                vc.endText = endCity;
                    //                [self.navigationController pushViewController:vc animated:YES];
                    
                }
                else if (array.count ==1)
                {
                    NSLog(@"只有结束目的地");
                    NSString *endCity = array[0];
                    self.lb_startLocation.textColor = [UIColor blackColor];
                    self.lb_endLocation.textColor = [UIColor blackColor];
                    self.lb_endLocation.text = endCity;
                    NSDictionary *dict = @{
                                           @"qsd":self.lb_startLocation.text,
                                           @"mdd":self.lb_endLocation.text,
                                           @"page":page,
                                           };
                    [self netwrok_getLocationSearchRequestWithDict:dict WithAppend:NO];
                    
                }
                else
                {
                    NSLog(@"没有说话");
                }
                
            }
            else
            {
                NSLog(@"没有到");
                self.page = 1;
                NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];

                self.lb_startLocation.textColor = [UIColor blackColor];
                self.lb_endLocation.textColor = [UIColor blackColor];
                self.lb_endLocation.text = str;
                NSDictionary *dict = @{
                                       @"qsd":self.lb_startLocation.text,
                                       @"mdd":self.lb_endLocation.text,
                                       @"page":page,
                                       };
                [self netwrok_getLocationSearchRequestWithDict:dict WithAppend:NO];

            }
           
            
            
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
