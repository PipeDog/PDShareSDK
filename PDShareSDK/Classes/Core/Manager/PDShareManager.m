//
//  PDShareManager.m
//  Pods
//
//  Created by liang on 2021/2/8.
//

#import "PDShareManager.h"
#import "PDShareManager+Internal.h"
#import "PDShareModule.h"
#import "PDShareModuleManager.h"
#import "PDShareDataModel.h"
#import "PDShareError.h"

PDShareChannelKey const PDShareChannelKeyFormat(PDShareSDKChannel channel) {
    return @(channel);
}

@interface PDShareChannelEvent : NSObject

@property (nonatomic, copy, readonly, nullable) void (^onSuccess)(PDShareSDKChannel);
@property (nonatomic, copy, readonly, nullable) void (^onFailure)(PDShareSDKChannel, NSError *);

- (instancetype)initWithSuccess:(void (^ _Nullable)(PDShareSDKChannel channel))onSuccess
                      onFailure:(void (^ _Nullable)(PDShareSDKChannel channel, NSError *error))onFailure;

@end

@implementation PDShareChannelEvent

- (instancetype)initWithSuccess:(void (^)(PDShareSDKChannel))onSuccess
                      onFailure:(void (^)(PDShareSDKChannel, NSError *))onFailure {
    self = [super init];
    if (self) {
        _onSuccess = [onSuccess copy];
        _onFailure = [onFailure copy];
    }
    return self;
}

@end

@interface PDShareManager ()

@property (nonatomic, assign) PDShareSDKChannel currentChannel;
@property (nonatomic, strong) NSMutableDictionary<PDShareChannelKey, PDShareChannelEvent *> *events;

@end

@implementation PDShareManager

static PDShareManager *__defaultManager;

+ (PDShareManager *)defaultManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (__defaultManager == nil) {
            __defaultManager = [[self alloc] init];
        }
    });
    return __defaultManager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    @synchronized (self) {
        if (__defaultManager == nil) {
            __defaultManager = [super allocWithZone:zone];
        }
    }
    return __defaultManager;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _currentChannel = PDShareSDKChannelUnknown;
        _events = [NSMutableDictionary dictionary];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActiveNotification:) name:UIApplicationDidBecomeActiveNotification object:nil];
    }
    return self;
}

- (void)shareToChannel:(PDShareSDKChannel)channel
             shareData:(void (^)(id<PDShareData> _Nonnull))shareData
             onSuccess:(void (^)(PDShareSDKChannel))onSuccess
             onFailure:(void (^)(PDShareSDKChannel, NSError * _Nonnull))onFailure {
    PDShareChannelEvent *event = [[PDShareChannelEvent alloc] initWithSuccess:onSuccess onFailure:onFailure];
    self.events[@(channel)] = event; self.currentChannel = channel;

    PDShareModule *shareModule = [[PDShareModuleManager defaultManager] shareModuleForChannel:channel];
    if (!shareModule) {
        NSError *error = PDShareError(PDShareSDKErrorCodeInvalidChannel, @"Unsupport share channel!");
        [self didFinishShare:NO withError:error];
        return;
    }
    
    PDShareDataModel *shareDataModel = [[PDShareDataModel alloc] initWithChannel:channel];
    !shareData ?: shareData(shareDataModel);
    
    if (shareDataModel.shareContentType == PDShareContentTypeUnknown) {
        NSError *error = PDShareError(PDShareSDKErrorCodeInvalidData, @"Invalid share data!");
        [self didFinishShare:NO withError:error];
        return;
    }
        
    [shareModule shareData:shareDataModel onFinished:^(BOOL success, NSError * _Nonnull error) {
        [self didFinishShare:success withError:error];
    }];
}

#pragma mark - PDShareSDKCallback
- (BOOL)handleURL:(NSURL *)URL {
    PDShareModule *shareModule = [[PDShareModuleManager defaultManager] shareModuleForChannel:self.currentChannel];
    if ([shareModule respondsToSelector:@selector(handleURL:)]) {
        return [shareModule handleURL:URL];
    }
    return YES;
}

- (BOOL)handleUniversalLink:(NSUserActivity *)userActivity {
    PDShareModule *shareModule = [[PDShareModuleManager defaultManager] shareModuleForChannel:self.currentChannel];
    if ([shareModule handleUniversalLink:userActivity]) {
        return [shareModule handleUniversalLink:userActivity];
    }
    return YES;
}

- (BOOL)handleURL:(NSURL *)URL sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    PDShareModule *shareModule = [[PDShareModuleManager defaultManager] shareModuleForChannel:self.currentChannel];
    if ([shareModule handleURL:URL sourceApplication:sourceApplication annotation:annotation]) {
        return [shareModule handleURL:URL sourceApplication:sourceApplication annotation:annotation];
    }
    return YES;
}

#pragma mark - Internal Methods
- (void)applicationDidBecomeActiveNotification:(NSNotification *)notification {
    PDShareModule *shareModule = [[PDShareModuleManager defaultManager] shareModuleForChannel:self.currentChannel];
    if (![shareModule shouldCallbackWhenApplicationBecomeActive]) {
        self.events[PDShareChannelKeyFormat(self.currentChannel)] = nil;
        self.currentChannel = PDShareSDKChannelUnknown;
        return;
    }
    
    NSError *error = PDShareError(PDShareSDKErrorCodeUserCancel, @"User cancel share!");
    [self didFinishShare:NO withError:error];
}

- (void)didFinishShare:(BOOL)success withError:(NSError *)error {
    PDShareSDKChannel channel = self.currentChannel;
    PDShareChannelEvent *event = self.events[PDShareChannelKeyFormat(channel)];
    if (success) {
        !event.onSuccess ?: event.onSuccess(channel);
    } else {
        !event.onFailure ?: event.onFailure(channel, error);
    }
    self.currentChannel = PDShareSDKChannelUnknown;
    self.events[PDShareChannelKeyFormat(channel)] = nil;
}

@end
