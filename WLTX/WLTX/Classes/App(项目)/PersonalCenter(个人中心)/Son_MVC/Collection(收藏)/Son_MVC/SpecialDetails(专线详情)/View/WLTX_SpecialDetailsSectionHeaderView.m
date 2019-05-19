//
//  WLTX_SpecialDetailsSectionHeaderView.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/19.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_SpecialDetailsSectionHeaderView.h"
@interface WLTX_SpecialDetailsSectionHeaderView ()
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIView *viewOfBottom;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIImageView *imageViewOfMore;

@end
@implementation WLTX_SpecialDetailsSectionHeaderView

// init
- (instancetype)initWithReuseIdentifier:(NSString *)idname{
    self = [super initWithReuseIdentifier:idname];
    if (self) {
        [self createSubViews];
    }
    return self;
}
// 创建子视图
- (void)createSubViews {
    
    self.label = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_label];
    self.label.textColor = [UIColor redColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    _label.backgroundColor = [UIColor greenColor];
    self.viewOfBottom = [[UIView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_viewOfBottom];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.viewOfBottom addSubview:_button];
    //    _button.backgroundColor = [UIColor whiteColor];
    self.button.tintColor = [UIColor lightGrayColor];
    self.button.titleLabel.font = [UIFont systemFontOfSize:13];
    self.button.titleLabel.textAlignment = NSTextAlignmentRight;
    
    self.imageViewOfMore = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.viewOfBottom addSubview:_imageViewOfMore];
    //    _imageViewOfMore.backgroundColor = [UIColor yellowColor];
    
    self.img_icon = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.img_icon.contentMode = UIViewContentModeCenter; // 设置图片的内容模式
    
    [self.contentView addSubview:_img_icon];
    
}
// Layout布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.contentView.bounds);
    CGFloat height = CGRectGetHeight(self.contentView.bounds);
    self.img_icon.frame = CGRectMake(width / 4, 0, width / 2, height);


    
 
}
- (void)setImg_icon:(UIImageView *)img_icon
{
    _img_icon = img_icon;
}
@end
