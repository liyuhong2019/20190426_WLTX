//
//  WLTX_IntegratedQueryView.h
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/19.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLTX_IntegratedQueryModel;
@protocol WLTX_IntegratedQueryViewDelegate <NSObject>

- (void)wltx_IntegratedQueryViewClickItemWithModel:(WLTX_IntegratedQueryModel *)model ClickIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_BEGIN

@interface WLTX_IntegratedQueryView : UIView
@property (weak,nonatomic) id<WLTX_IntegratedQueryViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
