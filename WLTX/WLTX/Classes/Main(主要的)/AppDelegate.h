//
//  AppDelegate.h
//  WLTX
//
//  Created by lee on 2019/3/6.
//  Copyright © 2019年 liyuhong165. All rights reserved.
//

#import <UIKit/UIKit.h>
// singleton
#import "AppProject.h"
// Controller
#import "AppTabBarViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AppTabBarViewController *tabBarVC;


@end

