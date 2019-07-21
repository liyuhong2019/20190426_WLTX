//
//  WLTX_SpecialDetailsCell.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/19.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_SpecialDetailsCell.h"
#import "WLTX_SpecialDetailsDhwdModel.h"
#import "WLTX_SpecialDetailsFbwdModel.h"

@interface WLTX_SpecialDetailsCell ()
// 
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layout_contact_top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layout_contact_bottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layout_contact_height;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layout_btnTel_height;


@property (weak, nonatomic) IBOutlet UILabel *lb_title;
@property (weak, nonatomic) IBOutlet UILabel *lb_location;
@property (weak, nonatomic) IBOutlet UILabel *lb_contact;

@end

@implementation WLTX_SpecialDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setDModel:(WLTX_SpecialDetailsDhwdModel *)dModel
{
    NSLog(@"name %@",dModel.name);
    _dModel = dModel;
    self.lb_title.text = dModel.name;
//    self.lb_contact.text = [NSString stringWithFormat:@"联系人:%@",dModel.lxr];
    self.lb_location.text = [NSString stringWithFormat:@"地址:%@",dModel.dizhi];
    
    if ([dModel.lxr  isEqualToString:@""]) {
        self.layout_contact_top.constant = 0;
        self.layout_contact_bottom.constant = 0;
        self.layout_contact_height.constant = -20;
        self.lb_contact.hidden = YES;
        
    }
    else
    {
        self.lb_contact.hidden = NO;
        self.layout_contact_top.constant = 6;
        self.layout_contact_bottom.constant = 6;
        self.layout_contact_height.constant = 21;
        self.lb_contact.text = [NSString stringWithFormat:@"联系人:%@",dModel.lxr];
    }
    
    [self.btn_phoneNumber setTitle:[NSString stringWithFormat:@"%@",dModel.shouji] forState:0];
    
    if ([dModel.tel isEqualToString:@""]) {
        self.btn_telPhoneNumber.hidden = YES;
        self.layout_btnTel_height.constant = 0;
    }
    else
    {
        self.layout_btnTel_height.constant = 20;
        self.btn_telPhoneNumber.hidden = NO;
        [self.btn_telPhoneNumber setTitle:[NSString stringWithFormat:@"%@",dModel.tel] forState:0];
    }

//    self.btn_phoneNumber.titleLabel.text = [NSString stringWithFormat:@"%@",dModel.shouji];
//    self.btn_telPhoneNumber.titleLabel.text = [NSString stringWithFormat:@"%@",dModel.tel];

}
- (void)setFModel:(WLTX_SpecialDetailsFbwdModel *)fModel
{
    _fModel = fModel;
    self.lb_title.text = fModel.name;
    
    if ([fModel.lxr  isEqualToString:@""]) {
        self.layout_contact_top.constant = 0;
        self.layout_contact_bottom.constant = 0;
        self.layout_contact_height.constant = -20;
        self.lb_contact.hidden = YES;

    }
    else
    {
        self.lb_contact.hidden = NO;
        self.layout_contact_top.constant = 6;
        self.layout_contact_bottom.constant = 6;
        self.layout_contact_height.constant = 21;
        self.lb_contact.text = [NSString stringWithFormat:@"联系人:%@",fModel.lxr];
    }
//    self.lb_contact.text = [NSString stringWithFormat:@"联系人:%@",fModel.lxr];

    self.lb_location.text = [NSString stringWithFormat:@"地址:%@",fModel.dizhi];
    
    [self.btn_phoneNumber setTitle:[NSString stringWithFormat:@"%@",fModel.shouji] forState:0];
    
    
    if ([fModel.tel isEqualToString:@""]) {
        self.btn_telPhoneNumber.hidden = YES;
        self.layout_btnTel_height.constant = 0;
    }
    else
    {
        self.layout_btnTel_height.constant = 20;
        self.btn_telPhoneNumber.hidden = NO;
        [self.btn_telPhoneNumber setTitle:[NSString stringWithFormat:@"%@",fModel.tel] forState:0];
    }
    



}

@end
