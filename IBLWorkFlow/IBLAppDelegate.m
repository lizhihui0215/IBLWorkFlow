//
//  IBLAppDelegate.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLAppDelegate.h"
#import <PCCWFoundation/PCCWFoundation.h>
#import "UINavigationBar+IBLExtension.h"
//#import "UMessage.h"
#import "BPush.h"
#import <UserNotifications/UserNotifications.h>
#import "IBLNetworkServices.h"



@interface IBLAppDelegate () //< /*UNUserNotificationCenterDelegate*/>

@end

@implementation IBLAppDelegate

+ (instancetype)sharedDelegate{
    return (IBLAppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[AFNetworkActivityLogger sharedLogger] startLogging];
    
    [[[AFNetworkActivityLogger sharedLogger].loggers anyObject] setLevel:AFLoggerLevelDebug];
    
    [UINavigationBar setupAppearance];
    
    [[UIViewController appearance] setErrorOkTitle:@"OK"];
    [[UIViewController appearance] setConfirmOKTitle:@"OK"];

    
    
//    [PCCWFileManager setup];
    
    
//    [self setupNotificationWithLaunchOptions:launchOptions];
    
    [self setupBaiduNotificationWithLaunchOptions:launchOptions];
    
    return YES;
}

- (void)setupBaiduNotificationWithLaunchOptions:(NSDictionary *)launchOptions {
    // iOS10 下需要使用新的 API
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
        
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound + UNAuthorizationOptionBadge)
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                  // Enable or disable features based on authorization.
                                  if (granted) {
                                      [[UIApplication sharedApplication] registerForRemoteNotifications];
                                  }
                              }];
#endif
    }
    else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType myTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
    
#warning 上线 AppStore 时需要修改BPushMode为BPushModeProduction 需要修改Apikey为自己的Apikey
    
    // 在 App 启动时注册百度云推送服务，需要提供 Apikey
    [BPush registerChannel:launchOptions apiKey:@"h3cUEPGvymbRuPlnWk2q67D5" pushMode:BPushModeProduction withFirstAction:@"打开" withSecondAction:@"回复" withCategory:@"test" useBehaviorTextInput:YES isDebug:YES];
    // App 是用户点击推送消息启动
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        NSLog(@"从消息启动:%@",userInfo);
        [BPush handleNotification:userInfo];
    }
    //角标清0
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}




//- (void)setupNotificationWithLaunchOptions:(NSDictionary *)launchOptions{
//    //初始化方法,也可以使用(void)startWithAppkey:(NSString *)appKey launchOptions:(NSDictionary * )launchOptions httpsenable:(BOOL)value;这个方法，方便设置https请求。
//    [UMessage startWithAppkey:@"56fb8699e0f55ad78a001ec9" launchOptions:launchOptions];
//    
//    //注册通知，如果要使用category的自定义策略，可以参考demo中的代码。
//    [UMessage registerForRemoteNotifications];
//    
//    //iOS10必须加下面这段代码。
//    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
//    center.delegate = self;
//    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
//    [center requestAuthorizationWithOptions:types10     completionHandler:^(BOOL granted, NSError * _Nullable error) {
//        if (granted) {
//            //点击允许
//            //这里可以添加一些自己的逻辑
//        } else {
//            //点击不允许
//            //这里可以添加一些自己的逻辑
//        }
//    }];
//    
//    //打开日志，方便调试
//    [UMessage setLogEnabled:YES];
//}

//iOS10以下使用这个方法接收通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
//    [UMessage setAutoAlert:NO];
//    [UMessage didReceiveRemoteNotification:userInfo];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationReviced" object:userInfo];
}

// 在 iOS8 系统中，还需要添加这个方法。通过新的 API 注册推送服务
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    
    [application registerForRemoteNotifications];
}





- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"DeviceToken 获取失败，原因：%@",error);
}

//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{

    NSDictionary * userInfo = notification.request.content.userInfo;
    [BPush handleNotification:userInfo];

    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        //必须加这句代码
//        [UMessage didReceiveRemoteNotification:userInfo];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationReviced" object:userInfo];
    }else{
        //应用处于前台时的本地推送接受
    }
}

//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    [BPush handleNotification:userInfo];

    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationReviced" object:userInfo];
    }else{
        //应用处于后台时的本地推送接受
    }
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
//    NSString * deviceTokenString = [[[[deviceToken description]
//                                      stringByReplacingOccurrencesOfString: @"<" withString: @""]
//                                     stringByReplacingOccurrencesOfString: @">" withString: @""]
//                                    stringByReplacingOccurrencesOfString: @" " withString: @""];
//    
//    NSLog(@"token %@",deviceTokenString);
//    
    
    [BPush registerDeviceToken:deviceToken];
    [BPush bindChannelWithCompleteHandler:^(id result, NSError *error) {
        NSString * userId = result[@"channel_id"];
        NSString * cachedUserId = [[NSUserDefaults standardUserDefaults] stringForKey:@"channel_id"];
        if (![userId isEqualToString:cachedUserId]) {
            [[NSUserDefaults standardUserDefaults] setObject:result[@"channel_id"] forKey:@"channel_id"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        NSLog(@"result %@ error %@",result,error);
    }];

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [IBLNetworkServices setupURLWithURLString:IBLAPIBaseURLString completeHandler:nil];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
