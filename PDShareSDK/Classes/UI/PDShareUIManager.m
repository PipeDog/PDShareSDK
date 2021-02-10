//
//  PDShareUIManager.m
//  PDShareSDK
//
//  Created by liang on 2021/2/9.
//

#import "PDShareUIManager.h"

@interface PDShareChannelStyle : NSObject <PDShareChannelStyle>

@end

@implementation PDShareChannelStyle

@synthesize title = _title;
@synthesize image = _image;

- (BOOL)isValid {
    if (!self.title.length) { return NO; }
    if (!self.image) { return NO; }

    return YES;
}

@end

@interface PDShareUIManager ()

@property (nonatomic, strong) NSMutableDictionary<PDShareChannelKey, id<PDShareChannelStyle>> *styleMap;

@end

@implementation PDShareUIManager

static PDShareUIManager *__defaultManager;

+ (PDShareUIManager *)defaultManager {
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

- (instancetype)init {
    self = [super init];
    if (self) {
        _styleMap = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)setStyleForChannel:(PDShareSDKChannel)channel withBlock:(void (^)(id<PDShareChannelStyle> _Nonnull))block {
    PDShareChannelStyle *style = self.styleMap[@(channel)];
    if (!style) {
        style = [[PDShareChannelStyle alloc] init];
        self.styleMap[@(channel)] = style;
    }
    
    !block ?: block(style);
    NSAssert([style isValid], @"Invalid UI item!");
}

@end

id<PDShareChannelStyle> PDShareSDKGetStyle(PDShareSDKChannel channel) {
    PDShareUIManager *defaultManager = [PDShareUIManager defaultManager];
    id<PDShareChannelStyle> style = defaultManager.styleMap[@(channel)];
    return style;
}
