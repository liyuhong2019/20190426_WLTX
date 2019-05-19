//
//  WLTX_ReleaseCommonInfoVC.h
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/15.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_OPTIONS(NSUInteger, ReleaseType) {
    ReleaseType_Logistics = 1,  // 物流供求
    ReleaseType_Cargo,          // 货源信
    ReleaseType_Reruitment =5,     // 物流招聘
    
};
NS_ASSUME_NONNULL_BEGIN

@interface WLTX_ReleaseCommonInfoVC : UIViewController
@property (nonatomic,assign) ReleaseType releaseType;

@end

NS_ASSUME_NONNULL_END
