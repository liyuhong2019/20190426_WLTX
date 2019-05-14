//
//  WLTX_CollectionViewController.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/4/12.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_CollectionViewController.h"
#import "WLTX_CollectionModel.h"
@interface WLTX_CollectionViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
DZNEmptyDataSetSource,
DZNEmptyDataSetDelegate
>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic, assign) NSInteger page;
@end

@implementation WLTX_CollectionViewController

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
    [self collectionVC_settingsInitData];
    
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
#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 240;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WLTX_CollectionCell  *cell = [tableView dequeueReusableCellWithIdentifier:WLTX_CollectionCellID];
//    cell.model = self.carModels[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    WLTX_SpecialDetailsVC *vc = [[WLTX_SpecialDetailsVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark - DZNEmptyDataSetSource Methods

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"No Application Found";
    return [[NSAttributedString alloc] initWithString:text attributes:nil];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    UISearchBar *searchBar = self.searchDisplayController.searchBar;
    
    NSString *text = [NSString stringWithFormat:@"There are no empty dataset examples for \"%@\".", searchBar.text];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:nil];
    
    [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17.0] range:[attributedString.string rangeOfString:searchBar.text]];
    
    return attributedString;
}

//- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
//{
//    NSString *text = @"Search on the App Store";
//    UIFont *font = [UIFont systemFontOfSize:16.0];
//    UIColor *textColor = [UIColor colorWithHex:(state == UIControlStateNormal) ? @"007aff" : @"c6def9"];
//
//    NSMutableDictionary *attributes = [NSMutableDictionary new];
//    [attributes setObject:font forKey:NSFontAttributeName];
//    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
//
//    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
//}
//
//- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
//{
//    return [UIColor whiteColor];
//}
//
//- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
//{
//    return -64.0;
//}

#pragma mark - DZNEmptyDataSetDelegate Methods

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    
    UISearchBar *searchBar = self.searchDisplayController.searchBar;
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.com/apps/%@", searchBar.text]];
    
    if ([[UIApplication sharedApplication] canOpenURL:URL]) {
        [[UIApplication sharedApplication] openURL:URL];
    }
}




#pragma mark 🏃(代理)Delegate end
#pragma mark - ✍🏻(自定义方法) custom method start
/**
 登陆页面 初始化数据
 */
- (void)collectionVC_settingsInitData
{
    YHLog(@"初始化数据");
    //    self.view.backgroundColor = [UIColor whiteColor];
    [self collection_settingsNav];
    [self collection_CommonSettings];
    
    
    __weak typeof(self) weakSelf = self;
    [self.tableview addHeaderWithHeaderWithBeginRefresh:YES animation:YES refreshBlock:^(NSInteger pageIndex) {
        NSLog(@"pageIndex:%zd",pageIndex);
        weakSelf.page = pageIndex;
        [self loadData:YES];
    }];
    
    [self.tableview addFooterWithWithHeaderWithAutomaticallyRefresh:NO loadMoreBlock:^(NSInteger pageIndex) {
        NSLog(@"pageIndex:%zd",pageIndex);
        weakSelf.page = pageIndex;
        [self loadData:NO];
    }];
    
    [self loadData:YES];
    
}
/**
 登陆页面设置 nav
 */
- (void)collection_settingsNav
{
    self.navigationItem.title = @"收藏";
    self.view.backgroundColor = UIColorFromRGB(0xF5F5F5);
    
}

/**
 初始化一些公共设置
 */
- (void)collection_CommonSettings
{
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    
    // 空页面的数据源、数据代理设置
    self.tableview.emptyDataSetSource = self;
    self.tableview.emptyDataSetDelegate = self;

//    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WLT_LogisticsRecruitmentCell class]) bundle:nil] forCellReuseIdentifier:WLT_LogisticsRecruitmentCellID];

    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([WLTX_CollectionCell class]) bundle:nil] forCellReuseIdentifier:WLTX_CollectionCellID];
    
}


- (void)loadData:(BOOL)isRef
{
    if (isRef) {
//        [self.listArr removeAllObjects];
    }
    
    if (self.page < 3) {
        for (int i = 0; i < 10; i ++) {
//            [self.listArr addObject:@(i)];
        }
        [self.tableview endFooterRefresh];
        [self.tableview reloadData];
    }
    else{
        [self.tableview endFooterNoMoreData];
    }
}

// 去显示石井和太和
- (IBAction)go2ShowSjOrTh:(UIButton *)sender {
    switch (sender.tag) {
        case 10:
            {
                NSLog(@"石井");
            }
            break;
        case 20:
        {
            NSLog(@"太和");
        }
            break;

        default:
            break;
    }
    
}


#pragma mark  ✍🏻(自定义方法) custom method end


#pragma mark - 📶(网络请求)Network start
#pragma mark 📶(网络请求)Network end
#pragma mark - 💤 控件/对象懒加载 object start

#pragma mark 💤 控件/对象懒加载 object end

@end
