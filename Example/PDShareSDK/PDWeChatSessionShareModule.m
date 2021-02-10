//
//  PDWeChatSessionShareModule.m
//  PDShareSDK_Example
//
//  Created by liang on 2021/2/10.
//  Copyright © 2021 liang. All rights reserved.
//

#import "PDWeChatSessionShareModule.h"

@implementation PDWeChatSessionShareModule

- (BOOL)shouldCallbackWhenApplicationBecomeActive {
    return YES;
}

- (void)registerWithDataSource:(NSDictionary<NSString *,NSString *> *)registerMap {
    // TODO: register wechat app id...
}

- (void)shareData:(PDShareDataModel *)shareData onFinished:(void (^)(BOOL, NSError * _Nullable))onFinished {
    // TODO: share to wechat session
    
    NSError *error = PDShareError(PDShareSDKErrorCodeCommmon, @"分享失败");
    !onFinished ?: onFinished(NO, error);
}

@end
