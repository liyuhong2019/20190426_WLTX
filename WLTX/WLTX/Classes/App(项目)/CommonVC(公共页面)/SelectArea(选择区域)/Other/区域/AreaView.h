//
//  AreaView.h
//  20190518_SelectCity
//
//  Created by liyuhong2019 on 2019/5/20.
//  Copyright © 2019 liyuhong2018. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AreaCell;
@protocol AreaViewDelegate <NSObject>

- (void)areaViewClickItemCell:(AreaCell *)cell clickItemIndexPath:(NSIndexPath *)indexPath ClickTitle:(NSString *)title;

@end
NS_ASSUME_NONNULL_BEGIN

@interface AreaView : UIView
@property (nonatomic,strong) NSMutableArray<NSString *> *dataArr;
@property (nonatomic,assign) id<AreaViewDelegate> delegate;
@property(nonatomic,strong)UICollectionView *collectionView;
@end

NS_ASSUME_NONNULL_END
