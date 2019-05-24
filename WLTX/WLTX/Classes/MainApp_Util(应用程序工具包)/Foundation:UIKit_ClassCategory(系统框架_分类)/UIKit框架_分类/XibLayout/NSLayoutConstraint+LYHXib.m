//
//  NSLayoutConstraint+LYHXib.m
//  WLTX
//
//  Created by liyuhong2019 on 2019/5/25.
//  Copyright © 2019 liyuhong165. All rights reserved.
//

#import "NSLayoutConstraint+LYHXib.h"
#import <objc/runtime.h>

#define kLayoutConstraintScreenWidth [UIScreen mainScreen].bounds.size.width
#define kLayoutConstraintScale(x) (CGFloat)kLayoutConstraintScreenWidth / 375.0 * x

@implementation NSLayoutConstraint (LYHXib)
//+ (void)load {
//    
//    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
//    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
//    method_exchangeImplementations(imp, myImp);
//}
//
//- (id)myInitWithCoder:(NSCoder *)aDecode {
//    
//    [self myInitWithCoder:aDecode];
//    if (self) {
//        
//        if (![self.identifier isEqualToString:@"333"]) {
//            self.constant = kLayoutConstraintScale(self.constant);
//        }
//    }
//    return self;
//}
@end
