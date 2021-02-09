//
//  PDShareSDKUIConfiguration.h
//  PDShareSDK
//
//  Created by liang on 2021/2/9.
//

#import <Foundation/Foundation.h>
#import "PDShareSDKDefinition.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PDShareChannelStyle <NSObject>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *image;

@end

@interface PDShareSDKUIConfiguration : NSObject

@property (class, strong, readonly) PDShareSDKUIConfiguration *defaultUIConfiguration;

- (void)setStyleForChannel:(PDShareSDKChannel)channel withBlock:(void (^)(id<PDShareChannelStyle> style))block;

@end

FOUNDATION_EXPORT id<PDShareChannelStyle> PDShareSDKGetStyle(PDShareSDKChannel channel);

NS_ASSUME_NONNULL_END
