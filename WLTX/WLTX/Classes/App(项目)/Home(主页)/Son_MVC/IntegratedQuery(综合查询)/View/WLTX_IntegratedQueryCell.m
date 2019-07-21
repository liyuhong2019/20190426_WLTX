//
//  WLTX_IntegratedQueryCell.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/19.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_IntegratedQueryCell.h"
#import "WLTX_IntegratedQueryModel.h"

@interface WLTX_IntegratedQueryCell ()
@property (weak, nonatomic) IBOutlet UIImageView *img_icon;
@property (weak, nonatomic) IBOutlet UILabel *lb_title;


@end
@implementation WLTX_IntegratedQueryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.img_icon.layer.masksToBounds = YES;
//    self.img_icon.layer.cornerRadius =  ([UIScreen mainScreen].bounds.size.width-24*5)/4;
    self.img_icon.layer.cornerRadius =  self.img_icon.frame.size.height/2-5;

    
    NSLog(@"img w %f",self.img_icon.frame.size.width);
    NSLog(@"img h %f",self.img_icon.frame.size.height);

}

- (void)setModel:(WLTX_IntegratedQueryModel *)model
{
    _model = model;
    
    
    
    
//    self.lb_title.text = model.name;
    
    [self.img_icon sd_setImageWithURL:[NSURL URLWithString:model.img]];

    
}
@end
