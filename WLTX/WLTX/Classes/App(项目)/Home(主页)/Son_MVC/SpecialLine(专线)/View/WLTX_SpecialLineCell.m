//
//  WLTX_SpecialLineCell.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/20.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_SpecialLineCell.h"
#import "WLTX_SpecialLineModel.h"

@interface WLTX_SpecialLineCell()

@property (weak, nonatomic) IBOutlet UIImageView *img_icon;

@property (weak, nonatomic) IBOutlet UILabel *lb_title;
@property (weak, nonatomic) IBOutlet UILabel *lb_tel;

@end
@implementation WLTX_SpecialLineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(WLTX_SpecialLineModel *)model
{
    _model = model;
    
    self.lb_title.text = model.title;
    self.lb_tel.text = model.tel;
    [self.img_icon sd_setImageWithURL:[NSURL URLWithString:model.img]];
    
    
    
}
@end
