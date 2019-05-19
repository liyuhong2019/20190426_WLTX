//
//  WLTX_SpecialDetailsCell.h
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/19.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLTX_SpecialDetailsDhwdModel;
@class WLTX_SpecialDetailsFbwdModel;

NS_ASSUME_NONNULL_BEGIN

@interface WLTX_SpecialDetailsCell : UITableViewCell
@property (nonatomic,strong) WLTX_SpecialDetailsDhwdModel *dModel;// 底部
@property (nonatomic,strong) WLTX_SpecialDetailsFbwdModel *fModel;// 头部



// 按钮暴露出来用来在外面处理事件
@property (weak, nonatomic) IBOutlet UIButton *btn_phoneNumber;
@property (weak, nonatomic) IBOutlet UIButton *btn_telPhoneNumber;

@end

NS_ASSUME_NONNULL_END
