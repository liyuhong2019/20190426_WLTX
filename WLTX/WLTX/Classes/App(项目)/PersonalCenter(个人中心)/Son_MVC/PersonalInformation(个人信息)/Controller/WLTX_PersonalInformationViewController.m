//
//  WLTX_PersonalInformationViewController.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/4/12.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_PersonalInformationViewController.h"

@interface WLTX_PersonalInformationViewController ()

// tool
@property (nonatomic,strong) YH_SystemImagePickerManager *manager;


//
@property (weak, nonatomic) IBOutlet UIImageView *img_userUrl;
@property (weak, nonatomic) IBOutlet UILabel *lb_nickName;

@end

@implementation WLTX_PersonalInformationViewController

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
    [self personalInformationVC_settingsInitData];
    
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
- (void)personalInformationVC_settingsInitData
{
    YHLog(@"初始化数据");
    //    self.view.backgroundColor = [UIColor whiteColor];
    [self personalInformation_settingsNav];
    
    
    __weak typeof(self) weakSelf = self;
    [self.manager setDidSelectImageBlock:^(UIImage *img){
        weakSelf.img_userUrl.image = img;
    }];
    
}
/**
 登陆页面设置 nav
 */
- (void)personalInformation_settingsNav
{
    self.navigationItem.title = @"个人信息";
    self.view.backgroundColor = UIColorFromRGB(0xF5F5F5);
    
}

#pragma 事件操作
- (void)personalInformation_Action1_selectImage
{
    NSLog(@"select image");
    [self.manager quickAlertSheetPickerImage];
}
#pragma mark  ✍🏻(自定义方法) custom method end
#pragma mark - 🎬 按钮/点击事件 Action start

- (IBAction)ClickPersonalInfoSettings:(UIButton *)sender {
    switch (sender.tag) {
        case 10:
        {
            [self personalInformation_Action1_selectImage];
        }
            break;
    
        default:
            break;
    }
    
}
#pragma mark 🎬 按钮/点击事件 Action end


#pragma mark - 📶(网络请求)Network start
#pragma mark 📶(网络请求)Network end
#pragma mark - 💤 控件/对象懒加载 object start
- (YH_SystemImagePickerManager *)manager{
    if (!_manager) {
        _manager = [[YH_SystemImagePickerManager alloc] initWithViewController:self];
    }
    return _manager;
}
#pragma mark 💤 控件/对象懒加载 object end

@end





#pragma mark -- 20190513 修改

////
////  WLTX_PersonalInformationViewController.m
////  WLTX
////
////  Created by liyuhong2019 on 2019/4/12.
////  Copyright © 2019 liyuhong165. All rights reserved.
////
//
//#import "WLTX_PersonalInformationViewController.h"
//
//@interface WLTX_PersonalInformationViewController ()
//
//// tool
//@property (nonatomic,strong) YH_SystemImagePickerManager *manager;
//
//
////
//@property (weak, nonatomic) IBOutlet UIImageView *img_userUrl;
//@property (weak, nonatomic) IBOutlet UILabel *lb_area;
//@property (weak, nonatomic) IBOutlet UILabel *lb_nickName;
//@property (weak, nonatomic) IBOutlet UILabel *lb_registerTime;
//@property (weak, nonatomic) IBOutlet UILabel *lb_realNameType;
//
//@end
//
//@implementation WLTX_PersonalInformationViewController
//
//#pragma mark - ♻️ 视图的生命周期 view life cycle start
///*
// 4-1、第一个执行的方法，加载UI：- (void)loadView{ }
// 4-2、第二个执行的方法，加载UI成功后调用：- (void)viewDidLoad{ }
// 4-3、第三个执行方法，UI即将显示时：- (void)viewWillAppear:(BOOL)animated{ }
// 4-4、第四个执行方法，UI已经显示时：- (void)viewDidAppear:(BOOL)animated{ }
// 4-5、第五个执行方法，UI即将消失时：- (void)viewWillDisappear:(BOOL)animated{ }
// 4-6、第六个执行方法，UI已经消失时：- (void)viewDidDisappear:(BOOL)animated{ }
// 4-7、最后执行方法，即视图控制器注销方法：- (void)dealloc { }
// 4-8、该方法在接收到内存警告时会调用，且系统会自动处理内存释放：- (void)didReceiveMemoryWarning { }
// */
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    [self personalInformationVC_settingsInitData];
//
//}
//- (void)dealloc
//{
//    //    [super dealloc];
//    // 移除通知处理
//}
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//
//}
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//}
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//}
//- (void)viewDidDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//}
//
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//}
//#pragma mark ♻️ 视图的生命周期 view life cycle end
//
//
//#pragma mark - 🏃(代理)Delegate start
//#pragma mark 🏃(代理)Delegate end
//#pragma mark - ✍🏻(自定义方法) custom method start
///**
// 登陆页面 初始化数据
// */
//- (void)personalInformationVC_settingsInitData
//{
//    YHLog(@"初始化数据");
//    //    self.view.backgroundColor = [UIColor whiteColor];
//    [self personalInformation_settingsNav];
//
//
//    __weak typeof(self) weakSelf = self;
//    [self.manager setDidSelectImageBlock:^(UIImage *img){
//        weakSelf.img_userUrl.image = img;
//    }];
//
//}
///**
// 登陆页面设置 nav
// */
//- (void)personalInformation_settingsNav
//{
//    self.navigationItem.title = @"个人信息";
//    self.view.backgroundColor = UIColorFromRGB(0xF5F5F5);
//
//}
//
//#pragma 事件操作
//- (void)personalInformation_Action1_selectImage
//{
//    NSLog(@"select image");
//    [self.manager quickAlertSheetPickerImage];
//}
//- (void)personalInformation_Action2_area
//{
//    NSLog(@"选择区域");
//    WLTX_CommonSelectAreaVC *vc = [[WLTX_CommonSelectAreaVC alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
//
//}
//- (void)personalInformation_Action3_go2realName
//{
//    NSLog(@"去实名认证");
//    // 判断是否实名
//    WLTX_RealNameCertificationVC *vc = [[WLTX_RealNameCertificationVC alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
//
//
//}
//
//#pragma mark  ✍🏻(自定义方法) custom method end
//#pragma mark - 🎬 按钮/点击事件 Action start
//
//- (IBAction)ClickPersonalInfoSettings:(UIButton *)sender {
//    switch (sender.tag) {
//        case 10:
//        {
//            [self personalInformation_Action1_selectImage];
//        }
//            break;
//        case 30:
//        {
//            [self personalInformation_Action2_area];
//        }
//            break;
//
//        case 50:
//        {
//            [self personalInformation_Action3_go2realName];
//        }
//            break;
//
//        default:
//            break;
//    }
//
//}
//#pragma mark 🎬 按钮/点击事件 Action end
//
//
//#pragma mark - 📶(网络请求)Network start
//#pragma mark 📶(网络请求)Network end
//#pragma mark - 💤 控件/对象懒加载 object start
//- (YH_SystemImagePickerManager *)manager{
//    if (!_manager) {
//        _manager = [[YH_SystemImagePickerManager alloc] initWithViewController:self];
//    }
//    return _manager;
//}
//#pragma mark 💤 控件/对象懒加载 object end
//
//@end




