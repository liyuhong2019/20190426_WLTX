//
//  WLTX_PresentCommonSelectMsgTypeTableViewVC.h
//  WLTX
//
//  Created by 10.12 on 2019/7/16.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WLTX_PresentCommonSelectMsgTypeTableViewVC : UIViewController
<UITableViewDelegate,
UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

NS_ASSUME_NONNULL_END
