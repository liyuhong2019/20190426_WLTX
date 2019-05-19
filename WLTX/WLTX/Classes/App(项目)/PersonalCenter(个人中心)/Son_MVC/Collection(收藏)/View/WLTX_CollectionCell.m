//
//  WLTX_CollectionCell.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/4/29.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "WLTX_CollectionCell.h"
#import "WLTX_CollectionModel.h"
@interface WLTX_CollectionCell ()

@property (weak, nonatomic) IBOutlet UIImageView *img_icon;
@property (weak, nonatomic) IBOutlet UIImageView *img_gold;
@property (weak, nonatomic) IBOutlet UIImageView *img_validation;
@property (weak, nonatomic) IBOutlet UILabel *lb_company;
@property (weak, nonatomic) IBOutlet UILabel *lb_isValidation;
@property (weak, nonatomic) IBOutlet UILabel *lb_browseNumber;  // 浏览数
@property (weak, nonatomic) IBOutlet UILabel *lb_destination; // 目的地
@property (weak, nonatomic) IBOutlet UILabel *lb_location; // 位置


@end

@implementation WLTX_CollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma setter
- (void)setModel:(WLTX_CollectionModel *)model
{
    _model = model;
    // 设置图片
    if ([model.is_rz isEqualToString:@"0"]) {
        NSLog(@"未认证的图标")
        [self.img_validation setImage:[UIImage imageNamed:@"未认证"]];
    }
    else
    {
        NSLog(@"未认证的图标")
        [self.img_validation setImage:[UIImage imageNamed:@"认证"]];
    }

    if ([model.is_jpxl isEqualToString:@"0"]) {
        NSLog(@"🏅️的图标");
        [self.img_gold setImage:[UIImage imageNamed:@"pthy"]];

    }
    else
    {
        NSLog(@"未🏅️的图标")
        [self.img_gold setImage:[UIImage imageNamed:@"jp"]];

        
    }

    
    // 设置文本
    self.lb_company.text = model.gsname;
    self.lb_destination.text = [NSString stringWithFormat:@"直达:%@",model.zhida] ;
    self.lb_location.text = model.dizhi;
    self.lb_browseNumber.text =  [NSString stringWithFormat:@"%@浏览",model.click];

    // 其他设置
    [self.btn_phoneNumber setTitle:model.shouji forState:0];
//    [self.btn_companyNumber setImage:[UIImage imageNamed:@"座机2"] forState:0];
    [self.btn_companyNumber setTitle:model.tel forState:0];
    
    NSURL *fullUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImgBaseURL,model.img]];
    [self.img_icon sd_setImageWithURL:fullUrl placeholderImage:[UIImage imageNamed:@""]];
    
    // http://www.0201566.com/tupian/image/20190105/20190105202524_30394.jpg
    // http://m.0201566.com/tupian/image/20190105/20190105202524_30394.jpg
    [self.img_icon sd_setImageWithURL:fullUrl placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"image Url is %@",imageURL.absoluteString);
        if (image){
            // Set your image over here
        }else{
            //something went wrong
        }

    }];


    
}
@end
