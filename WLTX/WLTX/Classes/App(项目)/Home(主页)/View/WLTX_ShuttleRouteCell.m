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
//    self.img_route.layer.masksToBounds = YES;
    
    // 给label添加点击事件
    self.lb_number.userInteractionEnabled = YES;
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
    [self.lb_number addGestureRecognizer:labelTapGestureRecognizer];

}

- (void)setModel:(WLTX_ShuttleRouteModel *)model
{
    _model = model;
    
    
//    self
    [self.img_route sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.lb_route.text = model.title;
    self.lb_number.text = model.tel;
    
}

-(void) labelTouchUpInside:(UITapGestureRecognizer *)recognizer{
    
    UILabel *label=(UILabel*)recognizer.view;
    NSLog(@"%@被点击了",label.text);
    // 通过代理回传
    if ([self.delegate respondsToSelector:@selector(clickPhoneNumber:WithLabel:)]) {
        [self.delegate clickPhoneNumber:self WithLabel:label];
    }
}



@end
