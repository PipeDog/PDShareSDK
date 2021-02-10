//
//  PDShareSDKEngine.m
//  PDShareSDK
//
//  Created by liang on 2021/2/8.
//

#import "PDShareSDKEngine.h"
#import "PDShareModuleManager.h"
#import "PDShareModule.h"
#import "PDShareManager+Internal.h"

@implementation PDShareSDKEngine

static PDShareSDKEngine *__sharedInstance = nil;

+ (PDShareSDKEngine *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (__sharedInstance == nil) {
            __sharedInstance = [[self alloc] init];
        }
    });
    return __sharedInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    @synchronized (self) {
        if (__sharedInstance == nil) {
            __sharedInstance = [super allocWithZone:zone];
        }
    }
    return __sharedInstance;
}

- (void)startEngine {
    [[PDShareModuleManager defaultManager] loadShareModules];
}

- (BOOL)registerChannel:(PDShareSDKChannel)channel
              withBlock:(NSDictionary<NSString *,NSString *> * _Nonnull (^)(void))block {
    PDShareModule *shareModule = [[PDShareModuleManager defaultManager] shareModuleForChannel:channel];
    NSDictionary *info = block ? block() : nil;
    return [shareModule registerWithDataSource:info];
}

#pragma mark - PDShareSDKCallback
- (BOOL)handleURL:(NSURL *)URL {
    return [[PDShareManager defaultManager] handleURL:URL];
}

- (BOOL)handleUniversalLink:(NSUserActivity *)userActivity {
    return [[PDShareManager defaultManager] handleUniversalLink:userActivity];
}

- (BOOL)handleURL:(NSURL *)URL sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[PDShareManager defaultManager] handleURL:URL sourceApplication:sourceApplication annotation:annotation];
}

@end
