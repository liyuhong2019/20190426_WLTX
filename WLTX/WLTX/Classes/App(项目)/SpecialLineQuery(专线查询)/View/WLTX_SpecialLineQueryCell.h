//
//  WLTX_SpecialLineQueryCell.h
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/20.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLTX_SpecialLineQueryModel;
NS_ASSUME_NONNULL_BEGIN

@interface WLTX_SpecialLineQueryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btn_phoneNumber;     // 手机号
@property (weak, nonatomic) IBOutlet UIButton *btn_companyNumber; // 公司固定电话

@property (strong,nonatomic) WLTX_SpecialLineQueryModel *model;
@end

NS_ASSUME_NONNULL_END
