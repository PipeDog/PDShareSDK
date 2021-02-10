//
//  PDShareModuleManager.h
//  PDShareSDK
//
//  Created by liang on 2021/2/8.
//

#import <Foundation/Foundation.h>
#import "PDShareSDKDefinition.h"

NS_ASSUME_NONNULL_BEGIN

@class PDShareModule;

@interface PDShareModuleManager : NSObject

@property (class, strong, readonly) PDShareModuleManager *defaultManager;

- (void)loadShareModules;
- (PDShareModule *)shareModuleForChannel:(PDShareSDKChannel)channel;
- (NSDictionary<PDShareChannelKey, PDShareModule *> *)shareModuleMap;

@end

NS_ASSUME_NONNULL_END
