//
//  WLTX_CarListInfoCell.h
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/22.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLTX_CarListInfoModel;
NS_ASSUME_NONNULL_BEGIN

@interface WLTX_CarListInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btn_phoneNumber;

@property (nonatomic,strong) WLTX_CarListInfoModel *model;
@end

NS_ASSUME_NONNULL_END
