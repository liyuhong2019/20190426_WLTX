//
//  WLTX_CommonWebVC.h
//  WLTX
//
//  Created by liyuhong2019 on 2019/4/30.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,WLTX_CommonWebType)
{
    WLTX_CommonWebType_Other            = -1,
    // 预定义的网页页面类型
    WLTX_CommonWebType_AboutUs            = 0,  // 关于我们
   
    //用户自定义的平台
    WLTX_CommonWebType_UserDefine_Begin = 1000,
    WLTX_CommonWebType_UserDefine_End = 2000,
};

NS_ASSUME_NONNULL_BEGIN

@interface WLTX_CommonWebVC : UIViewController
@property (nonatomic,assign) WLTX_CommonWebType wltx_CommonWebType;
@property (nonatomic,strong) NSString *navTitle;


/**
 构造方法
 @param wltx_CommonWebType 加载那个网页的类型
 @param navTitle 导航栏的标题
 @return 返回当前控制器
 */
- (instancetype)initWithWLTX_CommonWebType:(WLTX_CommonWebType)wltx_CommonWebType AndNavTitle:(NSString *)navTitle;
@end

NS_ASSUME_NONNULL_END
