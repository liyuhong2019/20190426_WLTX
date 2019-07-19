//
//  WLTX_ShuttleRouteCell.h
//  WLTX
//
//  Created by liyuhong2019 on 2019/4/16.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLTX_ShuttleRouteCell;
@protocol WLTX_ShuttleRouteCellDelegate <NSObject>

- (void)clickPhoneNumber:(WLTX_ShuttleRouteCell *)cell WithLabel:(UILabel *)label;

@end

@class WLTX_ShuttleRouteModel;
NS_ASSUME_NONNULL_BEGIN

@interface WLTX_ShuttleRouteCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *lb_route;     // 路线
@property (weak, nonatomic) IBOutlet UILabel *lb_number;    // 电话
@property (weak, nonatomic) IBOutlet UIImageView *img_route;   // 图片

@property (weak,nonatomic) id<WLTX_ShuttleRouteCellDelegate> delegate;

@property (strong,nonatomic) WLTX_ShuttleRouteModel *model;
@end

NS_ASSUME_NONNULL_END
