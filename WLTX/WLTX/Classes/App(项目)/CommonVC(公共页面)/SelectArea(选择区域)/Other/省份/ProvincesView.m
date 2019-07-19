//
//  ProvincesView.m
//  20190518_SelectCity
//
//  Created by liyuhong2019 on 2019/5/20.
//  Copyright © 2019 liyuhong2018. All rights reserved.
//

#import "ProvincesView.h"
#import "ProvincesCell.h"
@interface ProvincesView ()
<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) NSArray *integratedQueryListArr;

@end
@implementation ProvincesView
static NSString * const ProvincesCellID = @"ProvincesCell";
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //        self.backgroundColor = [UIColor whiteColor];
//        [self adaptScreenWidthWithType:BSAdaptScreenWidthTypeAll exceptViews:nil];
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //设置自动滚动的方向 垂直或者横向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor clearColor];
    // 每一行cell之间的间距
    //    flowLayout.minimumLineSpacing = 5;
    // 设置第一个cell和最后一个cell,与父控件之间的间距
    //    flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
    collectionView.delegate = self;
    collectionView.dataSource = self;
    //    collectionView.scrollEnabled = NO;
    collectionView.showsHorizontalScrollIndicator=NO;
    collectionView.showsVerticalScrollIndicator = NO;
    [self addSubview:collectionView];
    self.collectionView=collectionView;
    [collectionView registerNib:[UINib nibWithNibName:@"ProvincesCell" bundle:nil]
     forCellWithReuseIdentifier:ProvincesCellID];
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    return self.integratedQueryListArr.count;
    return self.dataArr.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ProvincesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ProvincesCellID forIndexPath:indexPath];
    cell.lb_title.text = self.dataArr[indexPath.row];
//    WLTX_IntegratedQueryModel *model = self.integratedQueryListArr[indexPath.row];
//    cell.model = model;
    return cell;
}
#pragma mark - UICollectionViewDelegateFlowLayout method
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = ([UIScreen mainScreen].bounds.size.width-24*5)/4;
    //    return (CGSize){width,(self.height-2)/2};
    return (CGSize){width,40};
    
}
// <ProvincesCell: 0x7ffa1c46a200; baseClass = UICollectionViewCell; frame = (24 0; 73.5 73.5); clipsToBounds = YES; opaque = NO; layer = <CALayer: 0x6000002b19c0>>

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(0, 24, 0, 21);
    //        return UIEdgeInsetsZero;
}


//设置纵向的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 8;
}
//设置单元格间的横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 23;
}


//点击item触发的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath====%ld",(long)indexPath.row);
    //    if ([self.delegate respondsToSelector:@@sele]) {
    //        [self.delegate eightMaiWeiWithIndex:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
    //    }
    ProvincesCell *cell = (ProvincesCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
//       MsgCell  *selectCell = [self.msgTableView cellForRowAtIndexPath:indexPath]；
    NSLog(@"%@",self.dataArr[indexPath.row]);
    if ([self.delegate respondsToSelector:@selector(provincesViewClickItemCell:clickItemIndexPath:ClickTitle:)]) {
        [self.delegate provincesViewClickItemCell:cell clickItemIndexPath:indexPath ClickTitle:self.dataArr[indexPath.row]];
    }
}

#pragma mark - 列表
// http://m.0201566.com/appapi/zhcx.php

- (void)setDataArr:(NSMutableArray<NSString *> *)dataArr
{
    _dataArr = dataArr;
    [self.collectionView reloadData];
}
@end
