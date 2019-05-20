//
//  WLTX_CommonSelectAreaVC.h
//  WLTX
//
//  Created by liyuhong2019 on 2019/4/29.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,WLTX_CommonSelectAreaType)
{
    WLTX_CommonSelectAreaType_Normal            = 0,
    WLTX_CommonSelectAreaType_StartLocation,
    WLTX_CommonSelectAreaType_EndLocation,
};

// block 参考 https://www.jianshu.com/p/e82bc3acc2c9
//typedef void (^selectCityNameBlock)( NSString * _Nullable cityName);//给block重命名,方便调用
typedef void(^selectCityNameBlock) (NSString *cityName,WLTX_CommonSelectAreaType type);



NS_ASSUME_NONNULL_BEGIN

@interface WLTX_CommonSelectAreaVC : UIViewController
@property (nonatomic,assign) WLTX_CommonSelectAreaType type;
//@property (nonatomic, copy) selectCityNameBlock block;//声明一个block属性
//- (void)returnSelectCityName:(selectCityNameBlock)block;//加上后方便第A视图书写该block方法
@property(nonatomic,copy)selectCityNameBlock block;



@end

NS_ASSUME_NONNULL_END
