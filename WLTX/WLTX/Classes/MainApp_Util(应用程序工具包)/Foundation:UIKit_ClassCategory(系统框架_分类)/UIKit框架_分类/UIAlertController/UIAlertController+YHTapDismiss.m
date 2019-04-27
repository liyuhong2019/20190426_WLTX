//
//  UIAlertController+YHTapDismiss.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/4/27.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "UIAlertController+YHTapDismiss.h"

@implementation UIAlertController (YHTapDismiss)
- (void)alertTapDismiss {
    
    NSArray * arrayViews = [UIApplication sharedApplication].keyWindow.subviews;
    if (arrayViews.count>0) {
        //array会有两个对象，一个是UILayoutContainerView，另外一个是UITransitionView，我们找到最后一个
        UIView * backView = arrayViews.lastObject;
        
        backView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        tap.delegate = self;
        [backView addGestureRecognizer:tap];
    }
    
}

- (void)tap {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    UIView *tapView = gestureRecognizer.view;
    CGPoint point = [touch locationInView:tapView];
    CGPoint conPoint = [self.view convertPoint:point fromView:tapView];
    BOOL isContains = CGRectContainsPoint(self.view.bounds, conPoint);
    if (isContains) {
        // 单击点包含在alert区域内 不响应tap手势
        return NO;
    }
    return YES;
}
@end
