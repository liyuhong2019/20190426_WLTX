//
//  UIViewController+Extion.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/8.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "UIViewController+Extion.h"
#import "AppDelegate.h"

@implementation UIViewController (Extion)
// 正则效验
- (BOOL)vcExtion_cheackPhone:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|18[0-9]|14[57])[0-9]{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    // 看到这里我们会发现evaluateWithObject:方法返回的是一个BOOL值，如果符合条件就返回YES，不符合就返回NO。
    BOOL isValid =
    [phoneTest evaluateWithObject:mobile];
    NSLog(@"是不是手机 %d",isValid);
    return isValid;
}

// 打电话
- (void)vcCallPhoneNumber:(NSString *)PhoneNumber
{
    // 先发送一个请求 请求成功之后 记录事件统计一下
    NSLog(@"%s ,打电话",__func__);
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.PhoneNumber = PhoneNumber;
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",PhoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

}


@end
