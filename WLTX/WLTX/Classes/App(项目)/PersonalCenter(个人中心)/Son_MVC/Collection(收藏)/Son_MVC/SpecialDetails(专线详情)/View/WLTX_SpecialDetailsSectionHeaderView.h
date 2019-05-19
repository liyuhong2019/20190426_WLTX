//
//  WLTX_SpecialDetailsSectionHeaderView.h
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/19.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WLTX_SpecialDetailsSectionHeaderView : UITableViewHeaderFooterView
@property (nonatomic, strong) UIImageView *img_icon;
- (instancetype)initWithReuseIdentifier:(NSString *)idname;
@end

NS_ASSUME_NONNULL_END
