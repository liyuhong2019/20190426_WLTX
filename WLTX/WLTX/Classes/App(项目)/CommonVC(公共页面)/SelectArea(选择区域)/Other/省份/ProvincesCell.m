//
//  ProvincesCell.m
//  20190518_SelectCity
//
//  Created by liyuhong2019 on 2019/5/20.
//  Copyright © 2019 liyuhong2018. All rights reserved.
//

#import "ProvincesCell.h"

@implementation ProvincesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

// 设置选中和取消选中的颜色 https://segmentfault.com/q/1010000004660468
- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        //......
        self.lb_title.textColor = [UIColor orangeColor];
    }
    else {
        //......
        self.lb_title.textColor = [UIColor blackColor];
    }
}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//    // 这个判断selected，设置子试图状态
//
//}


@end
