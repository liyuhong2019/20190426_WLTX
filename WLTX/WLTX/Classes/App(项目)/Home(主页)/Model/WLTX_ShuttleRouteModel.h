//
//  WLTX_ShuttleRouteModel.h
//  WLTX
//
//  Created by liyuhong2019 on 2019/4/16.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WLTX_ShuttleRouteModel : NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *tel;
@property (nonatomic,strong) NSString *img;
@property (nonatomic,strong) NSString *url; // 点击之后 跳转的url

- (instancetype)initWithDict:(NSDictionary *)dict;
/** 工厂方法 */
+ (instancetype)wltx_ShuttleRouteWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
