//
//  AreaCell.m
//  20190518_SelectCity
//
//  Created by liyuhong2019 on 2019/5/20.
//  Copyright © 2019 liyuhong2018. All rights reserved.
//

#import "AreaCell.h"

@implementation AreaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
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
@end
