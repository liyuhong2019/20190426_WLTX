//
//  UIViewController+Extion.h
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/8.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Extion)
- (BOOL)vcExtion_cheackPhone:(NSString *)mobile;
- (void)vcCallPhoneNumber:(NSString *)PhoneNumber;
@end

NS_ASSUME_NONNULL_END
