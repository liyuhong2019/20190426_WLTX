/**
 方式二
 等比例设置ui
 */
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BSAdaptScreenWidthType) {
    AdaptScreenWidthTypeNone = 0,
    BSAdaptScreenWidthTypeConstraint = 1<<0, /**< 对约束的constant等比例 */
    BSAdaptScreenWidthTypeFontSize = 1<<1, /**< 对字体等比例 */
    BSAdaptScreenWidthTypeCornerRadius = 1<<2, /**< 对圆角等比例 */
    BSAdaptScreenWidthTypeAll = 1<<3, /**< 对现有支持的属性等比例 */
};

@interface UIView (BSAdaptScreen)

/**
 遍历当前view对象的subviews和constraints，对目标进行等比例换算
 
 @param type 想要和基准屏幕等比例换算的属性类型
 @param exceptViews 需要对哪些类进行例外
 */
- (void)adaptScreenWidthWithType:(BSAdaptScreenWidthType)type
                     exceptViews:(NSArray<Class> *)exceptViews;

@end

NS_ASSUME_NONNULL_END
