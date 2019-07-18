#import "AppDelegate.h"
#import <CoreTelephony/CTCall.h>
#import <CoreTelephony/CTCallCenter.h>

@interface AppDelegate ()

{
    CTCallCenter *callCenter;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 1、项目的一些配置
    [self callCallBack];

    AppProject *appProject = [AppProject getInstance];
    [appProject lyh_initAppProject];
    [appProject lyh_addGloalbtn];
    [appProject.gloalBtn cq_addEventHandler:^{
        NSLog(@"点击全局按钮");
    } forControlEvents:UIControlEventTouchUpInside];
    // 第三方SDK配置
   
#warning 这一块代码到时候封装到appProject里面
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.tabBarVC = [[AppTabBarViewController alloc] init];
    self.window.rootViewController = self.tabBarVC;
    [self.window makeKeyAndVisible];
    
//    [self setGlobalBtn];
    // 第三方SDK配置
   
    return YES;
}

// 拨打电话的回调
- (void)callCallBack
{
    
    callCenter = [[CTCallCenter alloc] init];
    callCenter.callEventHandler = ^(CTCall* call) {
        if ([call.callState isEqualToString:CTCallStateDisconnected])
        {
            NSLog(@"Call has been disconnected");
        }
        else if ([call.callState isEqualToString:CTCallStateConnected])
        {
            NSLog(@"Call has just been connected");
        }
        else if([call.callState isEqualToString:CTCallStateIncoming])
        {
            NSLog(@"Call is incoming");
        }
        else if ([call.callState isEqualToString:CTCallStateDialing])
        {
            NSLog(@"call is dialing");
            [self customMethodWithOtherPersonPhoneNumber:self.PhoneNumber];
        }
        else
        {
            NSLog(@"Nothing is done");
        }
    };
    
}
- (void)customMethodWithOtherPersonPhoneNumber:(NSString *)phoneNumber
{
    //    NSLog(@"%@",Common_citySearch(searchName));
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];

    if (kWltx_IsLogin) {
        NSLog(@"已经登录了");
        [dict setObject:phoneNumber forKey:@"shouji"];
        [dict setObject:kWltx_userShouji forKey:@"user"];
        [MobClick event:@"phone" label:kWltx_userShouji]; // 当前用户的手机
    }
    else
    {
        NSLog(@"未登录 不需要发送短信");
        [dict setObject:phoneNumber forKey:@"shouji"];
    }
//    [MobClick event:@"call" label:phoneNumber];

    NSString *str = @"";
    if ([phoneNumber containsString:@"-"]) {
        str  = @"固定电话";
    }
    else
    {
        str = @"手机";
    }

    [MobClick event:@"type" label:str];
    [MobClick event:@"name" label:self.companyName];
    
    NSString *myPhonenumber = kWltx_userShouji;
    NSLog(@" myPhonenumber %@",myPhonenumber);
    
    if (myPhonenumber == nil) {
        NSLog(@"手机是空的 就不需要发送接口了");
        return;
    }
    
    NSDictionary *dictcc =@{@"type":str,@"phone":kWltx_userShouji,@"name":self.companyName};
    [MobClick event:@"call" attributes:dictcc];
    NSLog(@"公司名称是 is %@",self.companyName);


    [AFNetworkingTool postWithURLString:my_callNumber parameters:dict resultClass:nil success:^(id result) {
        NSLog(@"result = %@",result);


    } failure:^(NSError *error) {

    }];
}


//- (void)customMethodWithOtherPersonPhoneNumber:(NSString *)phoneNumber
//{
//    //    NSLog(@"%@",Common_citySearch(searchName));
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//
//    if (kWltx_IsLogin) {
//        NSLog(@"已经登录了");
//        [dict setObject:phoneNumber forKey:@"shouji"];
//        [dict setObject:kWltx_userShouji forKey:@"user"];
//        //        [MobClick event:@"phone" label:kWltx_userShouji]; // 当前用户的手机
//    }
//    else
//    {
//        NSLog(@"未登录 不需要发送短信");
//        [dict setObject:phoneNumber forKey:@"shouji"];
//    }
//    //    [MobClick event:@"call" label:phoneNumber];
//
//    NSString *str = @"";
//    if ([phoneNumber containsString:@"-"]) {
//        str  = @"固定电话";
//    }
//    else
//    {
//        str = @"手机";
//    }
//
//    NSDictionary *dictcc =@{@"type":str,@"phone":kWltx_userShouji,@"name":self.companyName};
//
//    [MobClick event:@"phone" attributes:dictcc];
//    //    [MobClick beginEvent:@"type" primarykey:@"type" attributes:@{}]
//    //    [MobClick event:@"type" label:str];
//    //    [MobClick event:@"name" label:self.companyName];
//
//    NSLog(@"公司名称是 is %@",self.companyName);
//
//
//    [AFNetworkingTool postWithURLString:my_callNumber parameters:dict resultClass:nil success:^(id result) {
//        NSLog(@"result = %@",result);
//
//
//    } failure:^(NSError *error) {
//
//    }];
//}

- (void)setGlobalBtn
{
    [[AppProject getInstance]lyh_addGloalbtn];
    [[AppProject getInstance].gloalBtn cq_addEventHandler:^{
//        NSLog(@"点击全局按钮");
        if (!kWltx_IsLogin) {
            WLTX_LoginViewController *lg = [[WLTX_LoginViewController alloc]initWithNibName:NSStringFromClass([WLTX_LoginViewController class]) bundle:nil];
            LYHNavigationController *nav = [[LYHNavigationController alloc]initWithRootViewController:lg];
            [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
            return;
        }
        
        [self showAlertController];
        [AppProject getInstance].gloalBtn.hidden = YES;
    } forControlEvents:UIControlEventTouchUpInside];
}

- (void)showAlertController
{
    //  使用alertview
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"请选择类型" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    NSArray *arr = @[@"物流供应",@"货源信",@"车源信息",@"物流招聘"];
    
    // 不能跳转 参考 https://www.jianshu.com/p/20f56bf7be84
    int index =  [self.tabBarVC selectedIndex];
    //拿到tabbar的当前分栏的NavigationController
    LYHNavigationController *nav = [self.tabBarVC.viewControllers objectAtIndex:self.tabBarVC.selectedIndex];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:arr[0] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了按钮1，进入按钮1的事件");
        WLTX_ReleaseCommonInfoVC *vc = [[WLTX_ReleaseCommonInfoVC alloc]init];
        //        vc.releaseType = ReleaseType_Logistics;
        //        vc.hidesBottomBarWhenPushed= YES;
        //        [(LYHNavigationController *)self.window.rootViewController.navigationController pushViewController:vc animated:YES];
        // 需要拿到当前的tabbar的导航栏进行跳转
        vc.releaseType = ReleaseType_Logistics;
        [nav pushViewController:vc animated:YES];
        NSLog(@"点击了按钮1，进入按钮1的事件 end");
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:arr[1] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [AppProject getInstance].gloalBtn.hidden = NO;
        WLTX_ReleaseCommonInfoVC *vc = [[WLTX_ReleaseCommonInfoVC alloc]init];
        vc.releaseType = ReleaseType_Cargo;
        [nav pushViewController:vc animated:YES];
        
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:arr[2] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [AppProject getInstance].gloalBtn.hidden = NO;
        WLTX_ReleaseCarInfoVC *vc = [[WLTX_ReleaseCarInfoVC alloc]init];
        [nav pushViewController:vc animated:YES];
        
        
        
    }];
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:arr[3] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [AppProject getInstance].gloalBtn.hidden = NO;
        
        WLTX_ReleaseCommonInfoVC *vc = [[WLTX_ReleaseCommonInfoVC alloc]init];
        vc.releaseType = ReleaseType_Reruitment;
        [nav pushViewController:vc animated:YES];
        //        [self.window.rootViewController.navigationController pushViewController:vc animated:YES];
        
        
    }];
    UIAlertAction *action5 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [AppProject getInstance].gloalBtn.hidden = NO;
        
        
    }];
    [actionSheet addAction:action1];
    [actionSheet addAction:action2];
    [actionSheet addAction:action3];
    [actionSheet addAction:action4];
    [actionSheet addAction:action5];
    [self.window.rootViewController presentViewController:actionSheet animated:YES completion:nil];
    
    
}

#pragma mark - App States (应用程序的状态)
- (void)applicationWillResignActive:(UIApplication *)application
{
    [[AppProject getInstance]appProject_applicationWillResignActive:application];
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[AppProject getInstance]appProject_applicationDidEnterBackground:application];
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[AppProject getInstance]appProject_applicationWillEnterForeground:application];
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[AppProject getInstance]appProject_applicationDidBecomeActive:application];
}
- (void)applicationWillTerminate:(UIApplication *)application {
    [[AppProject getInstance]appProject_applicationWillTerminate:application];
}
//当应用程序即将终止时调用，可以在applicationDidEnterBackground中保存数据
-(void)applicationSignificantTimeChange:(UIApplication *)application{
    [[AppProject getInstance]appProject_applicationSignificantTimeChange:application];
}
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    [[AppProject getInstance]appProject_applicationDidReceiveMemoryWarning:application];
}

#pragma mark 通知处理
//当一个运行着的应用程序收到一个远程的通知发送到此方法 7.0之前
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [[AppProject getInstance]appProject_application:application didReceiveRemoteNotification:userInfo];
}

//当一个运行着的应用程序收到一个远程的通知 发送此方法 7.0之后
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    [[AppProject getInstance]appProject_application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}

//当一个应用程序成功的注册一个推送服务（APS） 发送此方法
-(void) application :(UIApplication *) application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *) deviceToken{
    [[AppProject getInstance]appProject_application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

//当 APS无法成功的完成向程序进程推送时 发送此方法
-(void) application :(UIApplication *) application didFailToRegisterForRemoteNotificationsWithError:(NSError *) error{
    [[AppProject getInstance]appProject_application:application didFailToRegisterForRemoteNotificationsWithError:error];
}

//当一个运行着的应用程序收到一个本地的通知 发送此方法
-(void) application :(UIApplication *) application didReceiveLocalNotification:(UILocalNotification *)notification{
    [[AppProject getInstance]appProject_application:application didReceiveLocalNotification:notification];
}

#pragma mark - 打开一个URL 资源
//// iOS9之后
//-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
//{
//    return [[AppProject getInstance]appProject_application:app openURL:url options:options];
//}
//
//// iOS9之前
////请求委托打开一个 URL资源
//- (BOOL) application:(UIApplication *) application handleOpenURL:(NSURL *)url{
//    return [[AppProject getInstance]appProject_application:application handleOpenURL:url];
//}
//
////请求委托打开一个 URL资源
//- (BOOL) application:(UIApplication *) application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
//    return [[AppProject getInstance]appProject_application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
//}


// 设置系统回调
// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

@end
