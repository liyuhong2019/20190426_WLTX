//
//  Three_XFKD.h
//  20190517_xfkd_yytx
//
//  Created by liyuhong2019 on 2019/5/17.
//  Copyright © 2019 liyuhong2018. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Three_XFKD : NSObject
+ (Three_XFKD *)getInstance;
// 初始化 语音听写
- (void)lyh_initTThreeSDK_XFKD_YYTX;
@end

NS_ASSUME_NONNULL_END
