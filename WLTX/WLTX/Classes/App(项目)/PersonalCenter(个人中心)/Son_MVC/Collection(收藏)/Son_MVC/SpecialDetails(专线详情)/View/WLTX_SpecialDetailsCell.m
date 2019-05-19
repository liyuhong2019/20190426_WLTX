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
    self.lb_contact.text = [NSString stringWithFormat:@"联系人:%@",dModel.lxr];
    self.lb_location.text = [NSString stringWithFormat:@"地址:%@",dModel.dizhi];
    
    
    
}
- (void)setFModel:(WLTX_SpecialDetailsFbwdModel *)fModel
{
    _fModel = fModel;
    self.lb_title.text = fModel.name;
    self.lb_contact.text = [NSString stringWithFormat:@"联系人:%@",fModel.lxr];
    self.lb_location.text = [NSString stringWithFormat:@"地址:%@",fModel.dizhi];


}

@end
