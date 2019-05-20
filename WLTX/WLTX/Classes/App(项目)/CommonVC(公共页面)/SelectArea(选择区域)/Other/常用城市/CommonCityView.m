//
//  CommonCityView.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/21.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "CommonCityView.h"
#import "WLTX_CommonCityCell.h"
@interface CommonCityView ()
<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) NSArray *integratedQueryListArr;
@property (nonatomic,strong) NSMutableArray *temp1;
@property (nonatomic,strong) NSMutableArray *temp2;

@end
@implementation CommonCityView

static NSString * const WLTX_CommonCityCellID = @"WLTX_CommonCityCell";
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //        self.backgroundColor = [UIColor whiteColor];
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
    [collectionView registerNib:[UINib nibWithNibName:@"WLTX_CommonCityCell" bundle:nil]
     forCellWithReuseIdentifier:WLTX_CommonCityCellID];
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //    return self.integratedQueryListArr.count;
    return self.dataArr.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WLTX_CommonCityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WLTX_CommonCityCellID forIndexPath:indexPath];
    cell.lb_title.text = self.temp1[indexPath.row];
    return cell;
}
#pragma mark - UICollectionViewDelegateFlowLayout method
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = ([UIScreen mainScreen].bounds.size.width-24*5)/4;
    //    return (CGSize){width,(self.height-2)/2};
    return (CGSize){width,width};
    
}
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
    WLTX_CommonCityCell *cell = (WLTX_CommonCityCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    //       MsgCell  *selectCell = [self.msgTableView cellForRowAtIndexPath:indexPath]；
    NSLog(@"%@",self.dataArr[indexPath.row]);
    if ([self.delegate respondsToSelector:@selector(commonCityViewClickItemCell:clickItemIndexPath:ClickTitle:)]) {
        [self.delegate commonCityViewClickItemCell:cell clickItemIndexPath:indexPath ClickTitle:self.temp2[indexPath.row]];
    }
}

#pragma mark - 列表
// http://m.0201566.com/appapi/zhcx.php

- (void)setDataArr:(NSMutableArray<NSDictionary *> *)dataArr
{
    _dataArr = dataArr;
    
    NSMutableArray *temp =  [NSMutableArray array];
    NSMutableArray *temp2 =  [NSMutableArray array];
    for (NSDictionary *dict in dataArr) {
        [temp addObject:dict[@"showTitle"]];
        [temp2 addObject:dict[@"getTitle"]];
    }
    self.temp1 = temp;
    self.temp2 = temp2;
    [self.collectionView reloadData];
}


@end
