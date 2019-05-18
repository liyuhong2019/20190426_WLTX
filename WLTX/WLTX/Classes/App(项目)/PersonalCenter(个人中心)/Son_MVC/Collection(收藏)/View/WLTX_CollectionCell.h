//
//  WLTX_CollectionCell.h
//  WLTX
//
//  Created by liyuhong2019 on 2019/4/29.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLTX_CollectionModel;
NS_ASSUME_NONNULL_BEGIN

@interface WLTX_CollectionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btn_phoneNumber;     // 手机号
@property (weak, nonatomic) IBOutlet UIButton *btn_companyNumber; // 公司固定电话

@property (strong,nonatomic) WLTX_CollectionModel *model;
@end

NS_ASSUME_NONNULL_END
