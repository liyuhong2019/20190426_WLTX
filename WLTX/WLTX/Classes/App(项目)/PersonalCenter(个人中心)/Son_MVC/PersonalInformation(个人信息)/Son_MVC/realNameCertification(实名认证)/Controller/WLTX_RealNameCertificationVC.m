//
//  WLTX_RealNameCertificationVC.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/4/29.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_RealNameCertificationVC.h"

@interface WLTX_RealNameCertificationVC ()
// tool
@property (nonatomic,strong) YH_SystemImagePickerManager *manager;
@property (nonatomic,strong) YH_SystemImagePickerManager *manager2;
@property (nonatomic,strong) YH_SystemImagePickerManager *manager3;

/**
 positive
 On the back
 personal
 */
@property (weak, nonatomic) IBOutlet UIImageView *img_positivePic;
@property (weak, nonatomic) IBOutlet UIImageView *img_backPic;
@property (weak, nonatomic) IBOutlet UIImageView *img_personalPic;

@property (weak, nonatomic) IBOutlet UILabel *lb_positive;
@property (weak, nonatomic) IBOutlet UILabel *lb_back;
@property (weak, nonatomic) IBOutlet UILabel *lb_personal;


@end

@implementation WLTX_RealNameCertificationVC

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
    [self realNameCertificationVC_settingsInitData];
    
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
- (void)realNameCertificationVC_settingsInitData
{
    YHLog(@"初始化数据");
    //    self.view.backgroundColor = [UIColor whiteColor];
    [self RealNameCertificationVC_settingsNav];
    
    __weak typeof(self) weakSelf = self;
    [self.manager setDidSelectImageBlock:^(UIImage *img){
        weakSelf.img_positivePic.image = img;
        NSData *imageData = UIImagePNGRepresentation(img);
//        NSData *data = [NSData image]
        weakSelf.lb_positive.text = @"";
    }];
    
    [self.manager2 setDidSelectImageBlock:^(UIImage *img){
        weakSelf.img_backPic.image = img;
        weakSelf.lb_back.text = @"";
    }];
    [self.manager3 setDidSelectImageBlock:^(UIImage *img){
        weakSelf.img_personalPic.image = img;
        weakSelf.lb_personal.text = @"";

    }];
}
/**
 登陆页面设置 nav
 */
- (void)RealNameCertificationVC_settingsNav
{
    self.navigationItem.title = @"实名认证";
    self.view.backgroundColor = UIColorFromRGB(0xF5F5F5);
    
}

#pragma 事件操作
- (void)personalInformation_Action1_selectImage
{
    NSLog(@"select image");
    [self.manager quickAlertSheetPickerImage];
}
- (void)personalInformation_Action2_area
{

    [self.manager2 quickAlertSheetPickerImage];

}
- (void)personalInformation_Action3_go2realName
{

    [self.manager3 quickAlertSheetPickerImage];

}

#pragma mark  ✍🏻(自定义方法) custom method end
#pragma mark - 🎬 按钮/点击事件 Action start

- (IBAction)ClickRealNameCertificationSettings:(UIButton *)sender {
    switch (sender.tag) {
        case 10:
        {
            [self personalInformation_Action1_selectImage];
        }
            break;
        case 30:
        {
            [self personalInformation_Action2_area];
        }
            break;
            
        case 50:
        {
            [self personalInformation_Action3_go2realName];
        }
            break;
            
        default:
            break;
    }
    
}
#pragma mark 🎬 按钮/点击事件 Action end

#pragma mark - 💤 控件/对象懒加载 object start
- (YH_SystemImagePickerManager *)manager{
    if (!_manager) {
        _manager = [[YH_SystemImagePickerManager alloc] initWithViewController:self];
    }
    return _manager;
}
- (YH_SystemImagePickerManager *)manager2{
    if (!_manager2) {
        _manager2 = [[YH_SystemImagePickerManager alloc] initWithViewController:self];
    }
    return _manager2;
}
- (YH_SystemImagePickerManager *)manager3{
    if (!_manager3) {
        _manager3 = [[YH_SystemImagePickerManager alloc] initWithViewController:self];
    }
    return _manager3;
}
#pragma mark 💤 控件/对象懒加载 object end
@end
