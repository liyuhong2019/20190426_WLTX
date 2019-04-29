/**
 使用方法
 1、导入工具类
 #import "YH_SystemImagePickerManager.h"
 2、在类扩展里面添加两个属性
 @interface ViewController ()
 @property (nonatomic,strong) YH_SystemImagePickerManager *manager;
 @property (weak, nonatomic) IBOutlet UIImageView *imageView;   //  选填 用一个属性保存图片
 @end
 3、使用
 3.1 懒加载工具类
 3.2 监听用户 使用相册那些功能
 3.3 block回调拿到选中的图片
 
 
 3.1 实现
     - (YH_SystemImagePickerManager *)manager{
     if (!_manager) {
     _manager = [[YH_SystemImagePickerManager alloc] initWithViewController:self];
     }
     return _manager;
     }
 3.2 实现
     - (IBAction)click:(UIButton *)sender {
     switch (sender.tag) {
     case 0:
     {
     ///相册
     [self.manager openPhoto];
 
     }
     break;
 
     case 1:
     {
     ///相机
     [self.manager openCamera];
     }
     break;
 
     case 2:
     {
 
     [self.manager quickAlertSheetPickerImage];
 
     }
     break;
 
 
     default:
     break;
     }
     }
 3.3 实现
 
     - (void)viewDidLoad {
     [super viewDidLoad];
     __weak typeof(self) weakSelf = self;
     [self.manager setDidSelectImageBlock:^(UIImage *img){
     weakSelf.imageView.image = img;
     }];
 
     }
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>

NS_ASSUME_NONNULL_BEGIN

@interface YH_SystemImagePickerManager : NSObject
/// 创建这样一个管理类对象
- (instancetype)initWithViewController:(UIViewController *)VC;

///选择图片的回调block
@property (nonatomic,copy) void(^didSelectImageBlock) (UIImage *image);

/// 相册选择器对象
@property (nonatomic,strong) UIImagePickerController *imagePicker;

///最大视频时长
@property (nonatomic,assign) NSTimeInterval videoMaximumDuration;

@property (nonatomic,assign) BOOL isVideo;

#pragma mark- 快速创建一个图片选择弹出窗
- (void)quickAlertSheetPickerImage ;

#pragma mark- 打开相机
- (void)openCamera;

#pragma mark- 打开相册
- (void)openPhoto ;
@end

NS_ASSUME_NONNULL_END
