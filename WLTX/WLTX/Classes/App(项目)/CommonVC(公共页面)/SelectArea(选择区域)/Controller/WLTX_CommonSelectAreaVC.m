#import "WLTX_CommonSelectAreaVC.h"
#import "WLTX_CommonCityCell.h"
#import "ProvincesView.h"
#import "CityView.h"
#import "AreaView.h"

#import "CommonCityView.h"
#ifdef DEBUG

#define NSLog(format, ...) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )

#else

#define NSLog(format, ...)

#endif


@interface WLTX_CommonSelectAreaVC ()
<ProvincesViewDelegate,
CityViewDelegate,
AreaViewDelegate,
CommonCityViewDelegate,
UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UIView *view_coomonUseCity; // 常用城市
@property (weak, nonatomic) IBOutlet UIView *view_SelectCity;   // 选择城市

@property (weak, nonatomic) IBOutlet UIView *view_cityContent;

// 城市操作
//省数组
@property NSArray *arrProvince;
//市数组
@property NSArray *arrCity;
//区数组
@property NSArray *arrDistrict;
// 常用城市数据
@property NSMutableArray *commonUseCity;


// 选择操作
@property (weak, nonatomic) IBOutlet UIImageView *img_1;
@property (weak, nonatomic) IBOutlet UIButton *btn_1;

@property (weak, nonatomic) IBOutlet UIImageView *img_2;
@property (weak, nonatomic) IBOutlet UIButton *btn_2;

@property (weak, nonatomic) IBOutlet UIImageView *img_3;
@property (weak, nonatomic) IBOutlet UIButton *btn_3;


// search显示的内容
@property (nonatomic,strong) NSString *pStr;
@property (nonatomic,strong) NSString *cStr;
@property (nonatomic,strong) NSString *aStr;
@property (strong,nonatomic) NSString *recordClickAllCityTitle; // 记录点击城市区
@property (weak, nonatomic) IBOutlet UISearchBar *search;
@property (strong,nonatomic) NSMutableArray *showDataArr; //  显示的
@property (strong,nonatomic) NSMutableArray *selectDataArr; // 选择的时候 显示的

// 控件
@property (nonatomic,strong) ProvincesView *provincesView;
@property (nonatomic,strong) CityView *cityView;
@property (nonatomic,strong) AreaView *areaView;
@property (nonatomic,strong) CommonCityView *commonCityView;


//
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation WLTX_CommonSelectAreaVC

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
    [self commonSelectAreaVC_settingsInitData];
    
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
#pragma mark 🏃(代理)Delegate end
#pragma mark - ✍🏻(自定义方法) custom method start
/**
 登陆页面 初始化数据
 */
- (void)commonSelectAreaVC_settingsInitData
{
    NSLog(@"初始化数据");
    self.pStr = @"";
    self.cStr = @"";
    self.aStr = @"";
    [self CommonSelectAreaVC_settingsNav];
//    [self loadCityData]; 20190620 修改
    [self loadCityDataNetworkingData];
}
/**
 登陆页面设置 nav
 */
- (void)CommonSelectAreaVC_settingsNav
{
    self.view.backgroundColor = UIColorFromRGB(0xF5F5F5);
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:@"确定" forState:0];
    [backButton setTitleColor:[UIColor blackColor] forState:0];
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [backButton addTarget:self action:@selector(determineSelectCity:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}
- (void)determineSelectCity:(UIButton *)btn
{
    NSLog(@"确定");
    // 将显示的内容 添加本地并且缓存起来
    // 如果点击 需要处理 拿到城市区里面的市 并且去掉市
    // 如果是点击tableview的item 都要记录起来
    // 最多保存10条
    NSLog(@"添加数据到常用城市里面");
    
    //    NSDictionary *
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.recordClickAllCityTitle forKey:@"showTitle"];
    [dict setObject:self.cStr forKey:@"getTitle"];
    if (self.commonUseCity.count >=10) {
        NSLog(@"第0个下标的数组是 %@",self.commonUseCity[0]);
        [self.commonUseCity removeObjectAtIndex:0];
        
    }
    [self.commonUseCity addObject:dict];
    NSLog(@"commonUseCity %@",self.commonUseCity);
    // 保存到本地
    NSArray *arr = [self.commonUseCity copy];
    // 存储
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    [userD setObject:arr forKey:@"commonUseCity"];
    NSLog(@"commonUseCity %@",[userD objectForKey:@"commonUseCity"]);
    [self.tableview reloadData];
    
    
    if (self.type == WLTX_CommonSelectAreaType_ReleaseCarInfo) {
        self.block(self.recordClickAllCityTitle,self.type);
    }
    else
    {
        
        if (self.block) {
            if ([self.recordClickAllCityTitle containsString:@"-"]) {
                
                NSArray *array = [self.recordClickAllCityTitle componentsSeparatedByString:@"-"];
                NSString *lastObjc = [array lastObject];
                NSLog(@"最后的字符串是 %@",lastObjc);
                NSLog(@"回传的字符串 省市区 %@",self.recordClickAllCityTitle);
                self.block(lastObjc,self.type);
            }
            else
            {
                
                NSLog(@"回传的字符串 省市区 %@",self.recordClickAllCityTitle);
                self.block(self.recordClickAllCityTitle,self.type);
            }
          
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark  ✍🏻(自定义方法) custom method end

- (IBAction)selectType:(UIButton *)sender {
    // 统一回复默认操作
    //
    [self.btn_1 setTitleColor:[UIColor whiteColor] forState:0];
    [self.btn_2 setTitleColor:[UIColor whiteColor] forState:0];
    [self.btn_3 setTitleColor:[UIColor whiteColor] forState:0];
    
    
    self.img_1.image = [UIImage imageNamed:@""];
    self.img_2.image = [UIImage imageNamed:@""];
    self.img_3.image = [UIImage imageNamed:@""];
    
    switch (sender.tag) {
        case 11:
        {
            NSLog(@"省份");
            [self.btn_1 setTitleColor:[UIColor orangeColor] forState:0];
            self.img_1.image = [UIImage imageNamed:@"integratedQuery_tu03"];
            self.cityView.hidden = YES;
            self.areaView.hidden = YES;
            self.provincesView.hidden = NO;
        }
            break;
        case 12:
        {
            NSLog(@"市");
            [self.btn_2 setTitleColor:[UIColor orangeColor] forState:0];
            self.img_2.image = [UIImage imageNamed:@"integratedQuery_tu04"];
            self.provincesView.hidden = YES;
            self.areaView.hidden = YES;
            self.cityView.hidden = NO;
            
        }
            break;
        case 13:
        {
            NSLog(@"区");
            [self.btn_3 setTitleColor:[UIColor orangeColor] forState:0];
            self.img_3.image = [UIImage imageNamed:@"integratedQuery_tu04"];
            self.provincesView.hidden = YES;
            self.cityView.hidden = YES;
            self.areaView.hidden = NO;
            
        }
            break;
            
        default:
            break;
    }
}

- (void)loadCityData
{
    NSBundle *bundle = [NSBundle mainBundle];
    //    NSString *plistPath = [bundle pathForResource:@"address" ofType:@"plist"];
    NSString *plistPath = [bundle pathForResource:@"area20190608" ofType:@"plist"];
    NSDictionary*addressDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    //    _arrProvince=[addressDic objectForKey:@"address"];
    //    _arrCity=[[_arrProvince objectAtIndex:0] objectForKey:@"sub"];
    //    _arrDistrict=[[_arrCity objectAtIndex:0] objectForKey:@"sub"];
    
    _arrProvince=[addressDic objectForKey:@"address"];
    _arrCity=[[_arrProvince objectAtIndex:0] objectForKey:@"city"];
    _arrDistrict=[[_arrCity objectAtIndex:0] objectForKey:@"area"];
    
    //    NSLog(@" 省份 is %@, 城市 is %@, 区域 is %@",_arrProvince,_arrCity,_arrDistrict);
    
    NSLog(@" 省份 is %@",_arrProvince);
    
    NSMutableArray <NSString *> *provinceStrArr = [NSMutableArray array];
    for (NSDictionary *dict in _arrProvince) {
        NSString *provinceName = dict[@"name"];
        [provinceStrArr addObject:provinceName];
    }
    
    NSLog(@"ProvinceArr %@",provinceStrArr);
    
    _arrCity = [[_arrProvince objectAtIndex:2]objectForKey:@"city"];
    // NSLog(@"选中省份的城市 %@",_arrCity);
    NSMutableArray <NSString *> *arrCityStrArr = [NSMutableArray array];
    for (NSDictionary *dict in _arrCity) {
        NSString *arrCityName = dict[@"name"];
        [arrCityStrArr addObject:arrCityName];
    }
    NSLog(@"arrCityStrArr %@",arrCityStrArr);
    
    
    _arrDistrict = [[_arrCity objectAtIndex:0]objectForKey:@"area"];
    // NSLog(@"选中省份的城市 %@",_arrCity);
    NSMutableArray <NSString *> *arrDistrictStrArr = [NSMutableArray array];
    for (NSString *arrDistrictName in _arrDistrict) {
        //        NSString *arrDistrictName = dict[@"name"];
        [arrDistrictStrArr addObject:arrDistrictName];
    }
    NSLog(@"arrDistrictStrArr %@",arrDistrictStrArr);
    
    
    NSLog(@"select index 1 is arrDistrictStrArr %@",arrDistrictStrArr[1]);
    
    [self.view_coomonUseCity addSubview:self.commonCityView];
    self.commonCityView.dataArr = self.commonUseCity;
    [self.view_SelectCity addSubview:self.provincesView];
    self.provincesView.dataArr = provinceStrArr;
}

- (void)loadCityDataNetworkingData
{
    NSLog(@"w网络获取城市数据");
    [self netwrok_getJsonCityData];
//    NSBundle *bundle = [NSBundle mainBundle];
//    //    NSString *plistPath = [bundle pathForResource:@"address" ofType:@"plist"];
//    NSString *plistPath = [bundle pathForResource:@"area20190608" ofType:@"plist"];
//    NSDictionary*addressDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
//
//    //    _arrProvince=[addressDic objectForKey:@"address"];
//    //    _arrCity=[[_arrProvince objectAtIndex:0] objectForKey:@"sub"];
//    //    _arrDistrict=[[_arrCity objectAtIndex:0] objectForKey:@"sub"];
//
//    _arrProvince=[addressDic objectForKey:@"address"];
//    _arrCity=[[_arrProvince objectAtIndex:0] objectForKey:@"city"];
//    _arrDistrict=[[_arrCity objectAtIndex:0] objectForKey:@"area"];
//
//    //    NSLog(@" 省份 is %@, 城市 is %@, 区域 is %@",_arrProvince,_arrCity,_arrDistrict);
//
//    NSLog(@" 省份 is %@",_arrProvince);
//
//    NSMutableArray <NSString *> *provinceStrArr = [NSMutableArray array];
//    for (NSDictionary *dict in _arrProvince) {
//        NSString *provinceName = dict[@"name"];
//        [provinceStrArr addObject:provinceName];
//    }
//
//    NSLog(@"ProvinceArr %@",provinceStrArr);
//
//    _arrCity = [[_arrProvince objectAtIndex:2]objectForKey:@"city"];
//    // NSLog(@"选中省份的城市 %@",_arrCity);
//    NSMutableArray <NSString *> *arrCityStrArr = [NSMutableArray array];
//    for (NSDictionary *dict in _arrCity) {
//        NSString *arrCityName = dict[@"name"];
//        [arrCityStrArr addObject:arrCityName];
//    }
//    NSLog(@"arrCityStrArr %@",arrCityStrArr);
//
//
//    _arrDistrict = [[_arrCity objectAtIndex:0]objectForKey:@"area"];
//    // NSLog(@"选中省份的城市 %@",_arrCity);
//    NSMutableArray <NSString *> *arrDistrictStrArr = [NSMutableArray array];
//    for (NSString *arrDistrictName in _arrDistrict) {
//        //        NSString *arrDistrictName = dict[@"name"];
//        [arrDistrictStrArr addObject:arrDistrictName];
//    }
//    NSLog(@"arrDistrictStrArr %@",arrDistrictStrArr);
//
//
//    NSLog(@"select index 1 is arrDistrictStrArr %@",arrDistrictStrArr[1]);
//
//    [self.view_coomonUseCity addSubview:self.commonCityView];
//    self.commonCityView.dataArr = self.commonUseCity;
//    [self.view_SelectCity addSubview:self.provincesView];
//    self.provincesView.dataArr = provinceStrArr;
}

#pragma mark - 懒加载
- (ProvincesView *)provincesView
{
    if (!_provincesView) {
        NSLog(@"provincesView %2f %p",self.view_SelectCity.frame.size.height,self.view_SelectCity);
        NSLog(@"view_cityContent.frame %2f",CGRectGetMaxY(self.view_cityContent.frame));
        NSLog(@"view_cityContent.frame %2f",[UIScreen mainScreen].bounds.size.height);
        NSLog(@"view_cityContent.frame %2f",[UIScreen mainScreen].bounds.size.height);
        
        //        _provincesView = [[ProvincesView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,  CGRectGetHeight(self.view_SelectCity.frame))];
        _provincesView = [[ProvincesView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,  CGRectGetHeight(self.view_SelectCity.frame))];
        
        _provincesView.delegate = self;
    }
    return _provincesView;
}
- (CityView *)cityView
{
    if (!_cityView) {
        NSLog(@"provincesView %2f",self.view_SelectCity.frame.size.height);
        _cityView = [[CityView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,  CGRectGetHeight(self.view_SelectCity.frame))];
        _cityView.delegate = self;
    }
    return _cityView;
}
- (AreaView *)areaView
{
    if (!_areaView) {
        NSLog(@"provincesView %2f",self.view_SelectCity.frame.size.height);
        _areaView = [[AreaView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,  CGRectGetHeight(self.view_SelectCity.frame))];
        _areaView.delegate = self;
    }
    return _areaView;
}

- (CommonCityView *)commonCityView
{
    if (!_commonCityView) {
        NSLog(@"provincesView %2f",self.view_coomonUseCity.frame.size.height);
        _commonCityView = [[CommonCityView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,  CGRectGetHeight(self.view_coomonUseCity.frame))];
        _commonCityView.delegate = self;
    }
    return _commonCityView;
}
//- (void)provincesViewClickItem:(NSIndexPath *)indexPath ClickTitle:(NSString *)title
//{
//    NSLog(@"click item title is %@",title);
//}


#pragma mark - custom delegate

// 常用城市的点击
- (void)commonCityViewClickItemCell:(WLTX_CommonCityCell *)cell clickItemIndexPath:(NSIndexPath *)indexPath ClickTitle:(NSString *)title
{
    NSLog(@"click item cell %@",cell);
    NSLog(@"click item title is %@",title);
    NSString *selectItemName = title;
    if (self.block) {
        
        if (self.type == WLTX_CommonSelectAreaType_ReleaseCarInfo) {
            self.block(cell.lb_title.text,self.type);
        }
        else
        {
            if ([selectItemName containsString:@"市"]) {
                selectItemName = [selectItemName stringByReplacingOccurrencesOfString:@"市"withString:@""];
            }
            self.block(selectItemName,self.type);
        }
        
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

// 省份点击
- (void)provincesViewClickItemCell:(ProvincesCell *)cell clickItemIndexPath:(NSIndexPath *)indexPath ClickTitle:(NSString *)title
{
    NSLog(@"click item cell %@",cell);
    NSLog(@"click item title is %@",title);
    self.pStr = title;
    self.recordClickAllCityTitle = @""; // 每次点击省份都要将之前的数据清空
    self.recordClickAllCityTitle = title; // 记录点击省份 用于后面进行拼接
    self.search.text = self.pStr;
    [self.btn_1 setTitleColor:[UIColor whiteColor] forState:0];
    [self.btn_2 setTitleColor:[UIColor whiteColor] forState:0];
    [self.btn_3 setTitleColor:[UIColor whiteColor] forState:0];
    
    
    self.img_1.image = [UIImage imageNamed:@""];
    self.img_2.image = [UIImage imageNamed:@""];
    self.img_3.image = [UIImage imageNamed:@""];
    
    
    
    [self.btn_2 setTitleColor:[UIColor orangeColor] forState:0];
    self.img_2.image = [UIImage imageNamed:@"integratedQuery_tu04"];
    
    
    self.provincesView.hidden = YES;
    self.areaView.hidden = YES;
    self.cityView.hidden = NO;
    // 拿到省份下面的城市数据
    _arrCity = [[_arrProvince objectAtIndex:indexPath.row]objectForKey:@"city"];
    // NSLog(@"选中省份的城市 %@",_arrCity);
    NSMutableArray <NSString *> *arrCityStrArr = [NSMutableArray array];
    for (NSDictionary *dict in _arrCity) {
        NSString *arrCityName = dict[@"name"];
        [arrCityStrArr addObject:arrCityName];
    }
    NSLog(@"arrCityStrArr %@",arrCityStrArr);
    
    [self.view_SelectCity addSubview:self.cityView];
    self.cityView.dataArr = arrCityStrArr;
    
}

// 市点击
- (void)cityViewClickItemCell:(CitysCell *)cell clickItemIndexPath:(NSIndexPath *)indexPath ClickTitle:(NSString *)title
{
    NSLog(@"click item cell %@",cell);
    NSLog(@"click item title is %@",title);
    self.cStr = title;
    self.recordClickAllCityTitle = @"";
    self.recordClickAllCityTitle = [NSString stringWithFormat:@"%@-%@",self.pStr,title]; // 拼接起来
    self.search.text = self.recordClickAllCityTitle;
    
    [self.btn_1 setTitleColor:[UIColor whiteColor] forState:0];
    [self.btn_2 setTitleColor:[UIColor whiteColor] forState:0];
    [self.btn_3 setTitleColor:[UIColor whiteColor] forState:0];
    
    
    self.img_1.image = [UIImage imageNamed:@""];
    self.img_2.image = [UIImage imageNamed:@""];
    self.img_3.image = [UIImage imageNamed:@""];
    
    
    
    [self.btn_3 setTitleColor:[UIColor orangeColor] forState:0];
    self.img_3.image = [UIImage imageNamed:@"integratedQuery_tu04"];
    
    
    self.provincesView.hidden = YES;
    self.cityView.hidden = YES;
    self.areaView.hidden = NO;
    
    // 拿到省份下面的城市数据
    _arrDistrict = [[_arrCity objectAtIndex:0]objectForKey:@"area"];
    // NSLog(@"选中省份的城市 %@",_arrCity);
    NSMutableArray <NSString *> *arrDistrictStrArr = [NSMutableArray array];
    for (NSString *arrDistrictName in _arrDistrict) {
        //        NSString *arrDistrictName = dict[@"name"];
        [arrDistrictStrArr addObject:arrDistrictName];
    }
    
    //
    [self.view_SelectCity addSubview:self.areaView];
    self.areaView.dataArr = arrDistrictStrArr;
}

// 区域点击 保存搜索
- (void)areaViewClickItemCell:(AreaCell *)cell clickItemIndexPath:(NSIndexPath *)indexPath ClickTitle:(NSString *)title
{
    NSLog(@"click item title is %@",title);
    self.aStr = title;
    self.recordClickAllCityTitle = @"";
    self.recordClickAllCityTitle = [NSString stringWithFormat:@"%@-%@-%@",self.pStr,self.cStr,title]; // 拼接起来
    self.search.text = self.recordClickAllCityTitle;
    NSLog(@"将数据显示在inputview %@",self.recordClickAllCityTitle);
}
#pragma mark  ✍🏻(自定义方法) custom method end




#pragma mark delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
    NSLog(@"return 点击");
    return [textField resignFirstResponder];
    
}
// return 按钮的点击
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //    if ([searchText isEqualToString:@"\n"]) {
    //        NSLog(@"回车操作");
    //        [searchBar resignFirstResponder];
    //        return;
    //    }else
    if ([searchText isEqualToString:@""]) {
        NSLog(@"重置UI");
        [self resetData];
        return;
    }
    NSLog(@"去搜索 searchtext is %@",searchText);
    //    [self netwrok_getSearchCityRequestWithName:searchText];
    
    NSDictionary *dict = @{
                           @"name":searchText,
                           };
    [self netwrok_getSearchCityRequestWithName:searchText withDict:dict];
    
}
- (void)resetData
{
    self.tableview.hidden = YES;
    [self.search resignFirstResponder];
    
    [self.btn_1 setTitleColor:[UIColor whiteColor] forState:0];
    [self.btn_2 setTitleColor:[UIColor whiteColor] forState:0];
    [self.btn_3 setTitleColor:[UIColor whiteColor] forState:0];
    self.img_1.image = [UIImage imageNamed:@""];
    self.img_2.image = [UIImage imageNamed:@""];
    self.img_3.image = [UIImage imageNamed:@""];
    
    
    //
    [self.btn_1 setTitleColor:[UIColor orangeColor] forState:0];
    self.img_1.image = [UIImage imageNamed:@"integratedQuery_tu03"];
    self.cityView.hidden = YES;
    self.areaView.hidden = YES;
    self.provincesView.hidden = NO;
    
    NSMutableArray <NSString *> *provinceStrArr = [NSMutableArray array];
    for (NSDictionary *dict in _arrProvince) {
        NSString *provinceName = dict[@"name"];
        [provinceStrArr addObject:provinceName];
    }
    // 重置需要删除所有的数据
    [self.provincesView.dataArr removeAllObjects];
    [self.cityView.dataArr removeAllObjects];
    [self.areaView.dataArr removeAllObjects];
    [self.cityView.collectionView reloadData];
    [self.areaView.collectionView reloadData];
    [self.provincesView.collectionView reloadData];
    
    self.provincesView.dataArr = provinceStrArr;
    
}


#pragma mark - 🏃(代理)Delegate start
#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.showDataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    WLTX_SpecialLineQueryCell  *cell = [tableView dequeueReusableCellWithIdentifier:WLTX_SpecialLineQueryCellID];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.showDataArr[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *showData = self.showDataArr[indexPath.row];
    NSString *selectData = self.selectDataArr[indexPath.row];
    NSLog(@"显示的内容是 %@",showData);
    NSLog(@"最终选择显示的内容是 %@",selectData);
    
    self.search.text = selectData;
    // 这里需要把值回调到上一个页面
    //    if (self.block) {
    //        self.block(selectData);
    //        [self.navigationController popViewControllerAnimated:YES];
    //    }
    //    [self returnSelectCityName:^(NSString * _Nullable cityName) {
    //        self.block(selectData);
    //        [self.navigationController popViewControllerAnimated:YES];
    //
    //    }];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:showData forKey:@"showTitle"];
    [dict setObject:selectData forKey:@"getTitle"];
    if (self.commonUseCity.count >=10) {
        NSLog(@"第0个下标的数组是 %@",self.commonUseCity[0]);
        [self.commonUseCity removeObjectAtIndex:0];
        
    }
    [self.commonUseCity addObject:dict];
    NSLog(@"commonUseCity %@",self.commonUseCity);
    // 保存到本地
    NSArray *arr = [self.commonUseCity copy];
    // 存储
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    [userD setObject:arr forKey:@"commonUseCity"];
    NSLog(@"commonUseCity %@",[userD objectForKey:@"commonUseCity"]);
    
    if (self.block) {
        self.block(selectData,self.type);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 📶(网络请求)Network start
// 城市数据
- (void)netwrok_getJsonCityData
{
    //    NSLog(@"%@",Common_citySearch(searchName));
    [AFNetworkingTool getWithNotApiURLString:Common_cityJson parameters:nil resultClass:nil success:^(id result) {
        NSLog(@"result = %@",result);
    
        NSArray *jsonDataArr = result;
            _arrProvince= result;
            _arrCity=[[_arrProvince objectAtIndex:0] objectForKey:@"city"];
            _arrDistrict=[[_arrCity objectAtIndex:0] objectForKey:@"area"];
        
            //    NSLog(@" 省份 is %@, 城市 is %@, 区域 is %@",_arrProvince,_arrCity,_arrDistrict);
        
            NSLog(@" 省份 is %@",_arrProvince);
        
            NSMutableArray <NSString *> *provinceStrArr = [NSMutableArray array];
            for (NSDictionary *dict in _arrProvince) {
                NSString *provinceName = dict[@"name"];
                [provinceStrArr addObject:provinceName];
            }
        
            NSLog(@"ProvinceArr %@",provinceStrArr);
        
            _arrCity = [[_arrProvince objectAtIndex:2]objectForKey:@"city"];
            // NSLog(@"选中省份的城市 %@",_arrCity);
            NSMutableArray <NSString *> *arrCityStrArr = [NSMutableArray array];
            for (NSDictionary *dict in _arrCity) {
                NSString *arrCityName = dict[@"name"];
                [arrCityStrArr addObject:arrCityName];
            }
            NSLog(@"arrCityStrArr %@",arrCityStrArr);
        
        
            _arrDistrict = [[_arrCity objectAtIndex:0]objectForKey:@"area"];
            // NSLog(@"选中省份的城市 %@",_arrCity);
            NSMutableArray <NSString *> *arrDistrictStrArr = [NSMutableArray array];
            for (NSString *arrDistrictName in _arrDistrict) {
                //        NSString *arrDistrictName = dict[@"name"];
                [arrDistrictStrArr addObject:arrDistrictName];
            }
            NSLog(@"arrDistrictStrArr %@",arrDistrictStrArr);
        
        
            NSLog(@"select index 1 is arrDistrictStrArr %@",arrDistrictStrArr[1]);
        
            [self.view_coomonUseCity addSubview:self.commonCityView];
            self.commonCityView.dataArr = self.commonUseCity;
            [self.view_SelectCity addSubview:self.provincesView];
            self.provincesView.dataArr = provinceStrArr;
        
        
    } failure:^(NSError *error) {
//        [self.view makeToast:error.userInfo];
    }];
}
// 专线路线
- (void)netwrok_getSearchCityRequestWithName:(NSString *)searchName withDict:(NSDictionary *)dict
{
    NSLog(@"搜索的内容 是 %@",searchName);
    //    NSLog(@"%@",Common_citySearch(searchName));
    [AFNetworkingTool getWithURLString:Common_citySearch parameters:dict resultClass:nil success:^(id result) {
        NSLog(@"result = %@",result);
        NSMutableArray *name = result[@"name"];
        NSMutableArray *data = result[@"data"];
        if (name.count <=0) {
            self.tableview.hidden = YES;
            return ;
        }
        NSLog(@"name %@",name);
        NSLog(@"data %@",data);
        
        self.showDataArr = name;
        self.selectDataArr = data;
        
        self.tableview.hidden = NO;
        [self.tableview reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}
- (NSMutableArray *)commonUseCity
{
    if (!_commonUseCity) {
        _commonUseCity = [NSMutableArray array];
        
        NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
        NSArray *array = [userD objectForKey:@"commonUseCity"];
        if (array.count >0) {
            _commonUseCity = [NSMutableArray arrayWithArray:array];
        }
        else
        {
            NSLog(@"本次缓存没数据");
        }
        
    }
    return _commonUseCity;
}
#pragma mark 📶(网络请求)Network end

@end
