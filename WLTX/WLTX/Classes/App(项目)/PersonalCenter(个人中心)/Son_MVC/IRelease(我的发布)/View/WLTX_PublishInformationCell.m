//
//  WLTX_PublishInformationCell.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/13.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_PublishInformationCell.h"
#import "WLTX_PublishInformationModel.h"

@interface WLTX_PublishInformationCell()
@property (weak, nonatomic) IBOutlet UILabel *lb_title;
@property (weak, nonatomic) IBOutlet UILabel *lb_content;
@property (weak, nonatomic) IBOutlet UILabel *lb_time;
@property (weak, nonatomic) IBOutlet UILabel *lb_state;

@end

@implementation WLTX_PublishInformationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setModel:(WLTX_PublishInformationModel *)model
{
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[model.is_sh dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    _model = model;
    self.lb_title.text = model.title;
    self.lb_time.text = model.time;
    self.lb_state.attributedText = attributedString;
    self.lb_content.text = model.tyle;
    /**
     
     */
}
@end
