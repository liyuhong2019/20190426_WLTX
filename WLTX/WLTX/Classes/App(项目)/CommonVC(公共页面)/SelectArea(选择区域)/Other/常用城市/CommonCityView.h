//
//  CommonCityView.h
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/21.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLTX_CommonCityCell;
@protocol CommonCityViewDelegate <NSObject>

- (void)commonCityViewClickItemCell:(WLTX_CommonCityCell *)cell clickItemIndexPath:(NSIndexPath *)indexPath ClickTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_BEGIN

@interface CommonCityView : UIView
@property (nonatomic,strong) NSMutableArray<NSDictionary *> *dataArr;
@property (nonatomic,assign) id<CommonCityViewDelegate> delegate;
@property(nonatomic,strong)UICollectionView *collectionView;
@end

NS_ASSUME_NONNULL_END
