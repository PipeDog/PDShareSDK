//
//  PDAppDelegate.m
//  PDShareSDK
//
//  Created by liang on 02/07/2021.
//  Copyright (c) 2021 liang. All rights reserved.
//

#import "PDAppDelegate.h"
#import <PDShareSDKEngine.h>
#import <PDShareUIManager.h>

@implementation PDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    // Launch shareSDK
    [[PDShareSDKEngine sharedInstance] startEngine];
    
    // Register share channel
    [[PDShareSDKEngine sharedInstance] registerChannel:PDShareSDKChannelWeChatSession withBlock:^NSDictionary<NSString *,NSString *> * _Nonnull{
        return @{
            @"appKey": @"wechatAppKey",
            @"appSecret": @"wechatAppSecret"
        };
    }];
    
    // Set image and title
    PDShareUIManager *defaultManager = [PDShareUIManager defaultManager];

    [defaultManager setStyleForChannel:PDShareSDKChannelWeChatSession withBlock:^(id<PDShareChannelStyle>  _Nonnull style) {
        style.image = [UIImage imageNamed:@"share_icon_weixin"];
        style.title = @"微信";
    }];
    
    [defaultManager setStyleForChannel:PDShareSDKChannelWeChatTimeline withBlock:^(id<PDShareChannelStyle>  _Nonnull style) {
        style.image = [UIImage imageNamed:@"share_icon_timeline"];
        style.title = @"朋友圈";
    }];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [[PDShareSDKEngine sharedInstance] handleURL:url sourceApplication:nil annotation:nil];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation {
    return [[PDShareSDKEngine sharedInstance] handleURL:url sourceApplication:sourceApplication annotation:annotation];
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    return [[PDShareSDKEngine sharedInstance] handleUniversalLink:userActivity];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
