//
//  WLTX_SpecialLineView.h
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/20.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLTX_SpecialLineModel;
@protocol WLTX_SpecialLineViewDelegate <NSObject>

- (void)wltx_SpecialLineViewClickItemWithModel:(WLTX_SpecialLineModel *)model ClickIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_BEGIN

@interface WLTX_SpecialLineView : UIView
@property (nonatomic,assign) id<WLTX_SpecialLineViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
