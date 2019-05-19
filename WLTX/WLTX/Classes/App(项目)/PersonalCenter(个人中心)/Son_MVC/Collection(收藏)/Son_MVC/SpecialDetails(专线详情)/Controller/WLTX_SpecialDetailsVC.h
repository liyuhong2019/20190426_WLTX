//
//  WLTX_SpecialDetailsVC.h
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/15.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SpecialType) {
    SpecialType_Normal = 0,
    SpecialType_Other,

} API_AVAILABLE(macos(10.11), ios(9.0), watchos(2.0), tvos(9.0));

NS_ASSUME_NONNULL_BEGIN

@interface WLTX_SpecialDetailsVC : UIViewController

@property (nonatomic,assign) SpecialType type;
@property (nonatomic,strong) NSString *detailsId;
@end

NS_ASSUME_NONNULL_END
