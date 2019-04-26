//
//  WLTX_ShuttleRouteModel.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/4/16.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_ShuttleRouteModel.h"

@implementation WLTX_ShuttleRouteModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        // 使用setValuesForKeys要求类的属性必须在字典中存在，可以比字典中的键值多，但是不能少。
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
/** 工厂方法 */
+ (instancetype)wltx_ShuttleRouteWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key
{
    NSLog(@"%s 缺少的字段 is %@",__func__,key);
}
@end
