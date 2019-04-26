//
//  WLTX_ShuttleRouteCell.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/4/16.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_ShuttleRouteCell.h"
#import "WLTX_ShuttleRouteModel.h"
@implementation WLTX_ShuttleRouteCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.img_route.layer.masksToBounds = YES;
}

- (void)setModel:(WLTX_ShuttleRouteModel *)model
{
    _model = model;
    
    
//    self
    [self.img_route sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.lb_route.text = model.title;
    self.lb_number.text = model.tel;
    
}

@end
