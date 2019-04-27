//
//  UIButton+CQBlock.h
//  CQKit
//
//  Created by 蔡强 on 2017/10/18.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CQBlock)

/**
 给按钮绑定事件回调block

 @param block 回调的block
 @param controlEvents 回调block的事件
 */
- (void)cq_addEventHandler:(void(^)(void))block forControlEvents:(UIControlEvents)controlEvents;

@end
