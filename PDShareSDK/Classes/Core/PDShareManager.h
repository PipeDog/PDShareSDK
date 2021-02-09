//
//  PDShareManager.h
//  Pods
//
//  Created by liang on 2021/2/8.
//

#import <Foundation/Foundation.h>
#import "PDShareSDKDefinition.h"
#import "PDShareData.h"

NS_ASSUME_NONNULL_BEGIN

@interface PDShareManager : NSObject

@property (class, strong, readonly) PDShareManager *defaultManager;

- (void)shareToChannel:(PDShareSDKChannel)channel
             shareData:(void (^)(id<PDShareData> shareData))shareData
             onSuccess:(void (^)(PDShareSDKChannel channel))onSuccess
             onFailure:(void (^)(PDShareSDKChannel channel, NSError *error))onFailure;

@end

NS_ASSUME_NONNULL_END
