//
//  CityView.h
//  20190518_SelectCity
//
//  Created by liyuhong2019 on 2019/5/20.
//  Copyright © 2019 liyuhong2018. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CitysCell;
@protocol CityViewDelegate <NSObject>

- (void)cityViewClickItemCell:(CitysCell *)cell clickItemIndexPath:(NSIndexPath *)indexPath ClickTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_BEGIN

@interface CityView : UIView
@property(nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray<NSString *> *dataArr;
@property (nonatomic,assign) id<CityViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
