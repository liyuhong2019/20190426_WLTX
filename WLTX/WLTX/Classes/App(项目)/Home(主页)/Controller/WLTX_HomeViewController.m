#import "WLTX_HomeViewController.h"
#import "AFNetworkingTool.h"
#import "WLTX_HomeAdModel.h"
#import "WLTX_ShuttleRouteModel.h"

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

- (IBAction)login:(UIButton *)sender {
    NSLog(@"%s,友盟SDK登录",__func__);
    [self go2WeChatLogin];
}


- (IBAction)share:(UIButton *)sender {
    NSLog(@"%s,友盟SD分享",__func__);
    [self go2WeChatShare];
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



#pragma mark - 🏃(代理)Delegate start
- (void)homeVC_Config
{
    self.scollview_content.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 1000);
    
    
    self.view_voice.layer.cornerRadius = self.view_voice.frame.size.height / 2-13;
    self.view_voice.layer.masksToBounds = YES;
    
    
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
    flowLayout.itemSize = CGSizeMake( ([UIScreen mainScreen].bounds.size.width - 5 - 30)/2 , 110);
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




@end
