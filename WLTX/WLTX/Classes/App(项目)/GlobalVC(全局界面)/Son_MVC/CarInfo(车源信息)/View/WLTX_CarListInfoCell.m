//
//  WLTX_CarListInfoCell.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/22.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_CarListInfoCell.h"
#import "WLTX_CarListInfoModel.h"
@interface WLTX_CarListInfoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *img_icon;
@property (weak, nonatomic) IBOutlet UILabel *lb_carNumber;
@property (weak, nonatomic) IBOutlet UILabel *lb_carLength;
@property (weak, nonatomic) IBOutlet UILabel *lb_location;

@end


@implementation WLTX_CarListInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(WLTX_CarListInfoModel *)model
{
    _model = model;
    
    
    // 设置文本
    self.lb_carNumber.text = model.chepai;
    self.lb_location.text = model.dizhi;
    self.lb_carLength.text = model.length;

    // 其他设置
    [self.btn_phoneNumber setTitle:model.tel forState:0];
    
//    NSURL *fullUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImgBaseURL,model.img]];
    [self.img_icon sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@""]];

}
@end
