//
//  WLTX_SpecialLineView.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/20.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_SpecialLineView.h"
#import "WLTX_SpecialLineCell.h"
#import "WLTX_SpecialLineModel.h"

@interface WLTX_SpecialLineView ()
<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong) NSArray *specailLineListArr;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger nextpage;
@end

@implementation WLTX_SpecialLineView

static NSString * const WLTX_SpecialLineCellID = @"WLTX_SpecialLineCell";
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
    [collectionView registerNib:[UINib nibWithNibName:@"WLTX_SpecialLineCell" bundle:nil]
     forCellWithReuseIdentifier:WLTX_SpecialLineCellID];
    
    [self collectionCofig];
    [self network_getIntegratedQueryListRequest];
}

- (void)collectionCofig
{
    [self.collectionView addHeaderWithHeaderWithBeginRefresh:YES animation:YES refreshBlock:^(NSInteger pageIndex) {
        NSLog(@"pageIndex:%zd",pageIndex);
        //        weakSelf.page = pageIndex;
        self.page = 1; // 初始化 为第1页
        [self network_getIntegratedQueryListRequest];
    }];
    
    [self.collectionView addFooterWithWithHeaderWithAutomaticallyRefresh:NO loadMoreBlock:^(NSInteger pageIndex) {
        //NSLog(@"pageIndex:%zd",pageIndex);
        
        NSLog(@"下拉刷新");
        NSLog(@"self.page :%zd",self.page);
        NSLog(@"nextpage :%zd",self.nextpage);
        
//        // 这里逻辑判断
//        if (self.nextpage == 0) {
            [self.collectionView endFooterNoMoreData];
//            [self.collectionView endFooterRefresh];
//            return ;
//        }
//
//        NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
//        [self netwrok_getmyCollectionListRequestWithPage:page Withappend:YES];
//        [self.collectionView endFooterRefresh];
//
    }];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.specailLineListArr.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WLTX_SpecialLineCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WLTX_SpecialLineCellID forIndexPath:indexPath];
    WLTX_SpecialLineModel *model = self.specailLineListArr[indexPath.row];
    cell.model = model;
    return cell;
}
#pragma mark - UICollectionViewDelegateFlowLayout method
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = ([UIScreen mainScreen].bounds.size.width-5*3)/2;
    //    return (CGSize){width,(self.height-2)/2};
    return (CGSize){width,width};
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
//    return UIEdgeInsetsMake(0, 24, 0, 21);
            return UIEdgeInsetsZero;
}


//设置纵向的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 3;
}
//设置单元格间的横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}


//点击item触发的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath====%ld",(long)indexPath.row);
    //    if ([self.delegate respondsToSelector:@@sele]) {
    //        [self.delegate eightMaiWeiWithIndex:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1]];
    //    }
    if ([self.delegate respondsToSelector:@selector(wltx_SpecialLineViewClickItemWithModel:ClickIndexPath:)]) {
        [self.delegate wltx_SpecialLineViewClickItemWithModel:self.specailLineListArr[indexPath.row] ClickIndexPath:indexPath];
    }
}

#pragma mark - 列表
// http://m.0201566.com/appapi/zhcx.php


// 专线路线
- (void)network_getIntegratedQueryListRequest
{
    [AFNetworkingTool postWithURLString:Home_ShuttleRouteUrl parameters:nil resultClass:nil success:^(id result) {
        NSLog(@" 综合查询 result = %@",result);
        NSArray *data = result[@"listdata"];
        NSArray *array = [WLTX_SpecialLineModel mj_objectArrayWithKeyValuesArray:data];
        self.specailLineListArr = array;
        
        
        
        [self.collectionView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}


@end
