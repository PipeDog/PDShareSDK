//
//  PDShareSDKUIConfiguration.m
//  PDShareSDK
//
//  Created by liang on 2021/2/9.
//

#import "PDShareSDKUIConfiguration.h"

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

@interface PDShareSDKUIConfiguration ()

@property (nonatomic, strong) NSMutableDictionary<PDShareChannelKey, id<PDShareChannelStyle>> *styleMap;

@end

@implementation PDShareSDKUIConfiguration

static PDShareSDKUIConfiguration *__defaultUIConfiguration;

+ (PDShareSDKUIConfiguration *)defaultUIConfiguration {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (__defaultUIConfiguration == nil) {
            __defaultUIConfiguration = [[self alloc] init];
        }
    });
    return __defaultUIConfiguration;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    @synchronized (self) {
        if (__defaultUIConfiguration == nil) {
            __defaultUIConfiguration = [super allocWithZone:zone];
        }
    }
    return __defaultUIConfiguration;
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
    PDShareSDKUIConfiguration *configuration = [PDShareSDKUIConfiguration defaultUIConfiguration];
    id<PDShareChannelStyle> style = configuration.styleMap[@(channel)];
    return style;
}
