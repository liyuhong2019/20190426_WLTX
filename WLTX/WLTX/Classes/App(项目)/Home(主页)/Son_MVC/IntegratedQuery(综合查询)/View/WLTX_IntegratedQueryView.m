//
//  WLTX_IntegratedQueryView.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/19.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_IntegratedQueryView.h"
#import "WLTX_IntegratedQueryCell.h"
#import "WLTX_IntegratedQueryModel.h"

@interface WLTX_IntegratedQueryView()
<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong) NSArray *integratedQueryListArr;

@end

@implementation WLTX_IntegratedQueryView
static NSString * const WLTX_IntegratedQueryCellID = @"WLTX_IntegratedQueryCell";
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
    [collectionView registerNib:[UINib nibWithNibName:@"WLTX_IntegratedQueryCell" bundle:nil]
     forCellWithReuseIdentifier:WLTX_IntegratedQueryCellID];
    
    
    [self network_getIntegratedQueryListRequest];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.integratedQueryListArr.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WLTX_IntegratedQueryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WLTX_IntegratedQueryCellID forIndexPath:indexPath];
    WLTX_IntegratedQueryModel *model = self.integratedQueryListArr[indexPath.row];
    cell.model = model;
    
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
    if ([self.delegate respondsToSelector:@selector(wltx_IntegratedQueryViewClickItemWithModel:ClickIndexPath:)]) {
        [self.delegate wltx_IntegratedQueryViewClickItemWithModel:self.integratedQueryListArr[indexPath.row] ClickIndexPath:indexPath];
    }
}

#pragma mark - 列表
// http://m.0201566.com/appapi/zhcx.php


// 专线路线
- (void)network_getIntegratedQueryListRequest
{
    [AFNetworkingTool postWithURLString:Home_IntegratedQueryListUrl parameters:nil resultClass:nil success:^(id result) {
        NSLog(@" 综合查询 result = %@",result);
        NSArray *data = result[@"listdata"];
        NSArray *array = [WLTX_IntegratedQueryModel mj_objectArrayWithKeyValuesArray:data];
        self.integratedQueryListArr = array;

   
        
        [self.collectionView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}
@end
