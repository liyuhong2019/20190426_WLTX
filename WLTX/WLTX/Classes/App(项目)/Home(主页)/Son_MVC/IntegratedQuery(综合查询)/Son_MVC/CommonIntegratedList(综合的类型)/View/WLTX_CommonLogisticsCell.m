//
//  WLTX_CommonLogisticsCell.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/19.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_CommonLogisticsCell.h"
#import "WLTX_CoomonIntegratedQueryListModel.h"
@interface WLTX_CommonLogisticsCell ()
@property (weak, nonatomic) IBOutlet UILabel *lb_title;
@property (weak, nonatomic) IBOutlet UILabel *lb_time;

@end

@implementation WLTX_CommonLogisticsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(WLTX_CoomonIntegratedQueryListModel *)model
{
    _model = model;
    self.lb_time.text = model.time;
    self.lb_title.text = model.title;

}
@end
