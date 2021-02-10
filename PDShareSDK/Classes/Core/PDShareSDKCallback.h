//
//  PDShareSDKCallback.h
//  PDShareSDK
//
//  Created by liang on 2021/2/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PDShareSDKCallback <NSObject>

@optional
- (BOOL)handleURL:(NSURL *)URL;
- (BOOL)handleUniversalLink:(NSUserActivity *)userActivity;
- (BOOL)handleURL:(NSURL *)URL sourceApplication:(NSString * _Nullable)sourceApplication annotation:(id _Nullable)annotation;

@end

NS_ASSUME_NONNULL_END
