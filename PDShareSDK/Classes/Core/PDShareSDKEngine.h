//
//  PDShareSDKEngine.h
//  PDShareSDK
//
//  Created by liang on 2021/2/8.
//

#import <Foundation/Foundation.h>
#import "PDShareSDKDefinition.h"
#import "PDShareSDKCallback.h"

NS_ASSUME_NONNULL_BEGIN

@interface PDShareSDKEngine : NSObject <PDShareSDKCallback>

@property (class, strong, readonly) PDShareSDKEngine *sharedInstance;

- (void)startEngine;

- (void)registerChannel:(PDShareSDKChannel)channel
              withBlock:(NSDictionary<NSString *, NSString *> *(^)(void))block;

@end

NS_ASSUME_NONNULL_END
