/**
 原本设置了圆角
 layer.cornerRadius = 15
 layer.masksToBounds = YES
 */
#import <UIKit/UIKit.h>

@class WLTX_SpecialLineModel;
NS_ASSUME_NONNULL_BEGIN

@interface WLTX_SpecialLineCell : UICollectionViewCell
@property (nonatomic,strong) WLTX_SpecialLineModel *model;
@end

NS_ASSUME_NONNULL_END
