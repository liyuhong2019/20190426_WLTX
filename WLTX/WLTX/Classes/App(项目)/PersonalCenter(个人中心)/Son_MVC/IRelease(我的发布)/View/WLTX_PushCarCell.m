//
//  WLTX_PushCarCell.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/13.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_PushCarCell.h"
#import "WLTX_PushCarModel.h"

@interface WLTX_PushCarCell ()
@property (weak, nonatomic) IBOutlet UILabel *lb_carNumber;
@property (weak, nonatomic) IBOutlet UILabel *lb_time;
@property (weak, nonatomic) IBOutlet UILabel *lb_state;

@end

@implementation WLTX_PushCarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(WLTX_PushCarModel *)model
{
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[model.is_sh dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    _model = model;
    self.lb_carNumber.text = model.chepai;
    self.lb_time.text = model.time;
    self.lb_state.attributedText = attributedString;
    
    
}
@end
