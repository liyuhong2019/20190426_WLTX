//
//  WLTX_CoomonIntegratedQueryListVC.h
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/19.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CoomonIntegratedQueryListType) {
    CoomonIntegratedQueryListType_Normal = 0,
    CoomonIntegratedQueryListType_Logistics = 1,
    CoomonIntegratedQueryListType_Other,
    
} API_AVAILABLE(macos(10.11), ios(9.0), watchos(2.0), tvos(9.0));

NS_ASSUME_NONNULL_BEGIN

@interface WLTX_CoomonIntegratedQueryListVC : UIViewController
@property (nonatomic,assign) CoomonIntegratedQueryListType type;
@end

NS_ASSUME_NONNULL_END
