//
//  PDSharePanelView.h
//  PDShareSDK
//
//  Created by liang on 2021/2/9.
//

#import <UIKit/UIKit.h>
#import "PDShareSDKDefinition.h"
#import "PDShareData.h"

NS_ASSUME_NONNULL_BEGIN

@interface PDSharePanelView : UIView

- (void)showWithChannels:(NSArray<PDShareChannelKey> *)channels
                  inView:(UIView *_Nullable)inView
               shareData:(void (^)(id<PDShareData> shareData))shareData
               onSuccess:(void (^ _Nullable)(PDShareSDKChannel channel))onSuccess
               onFailure:(void (^ _Nullable)(PDShareSDKChannel channel, NSError *error))onFailure;

- (void)showWithChannels:(NSArray<PDShareChannelKey> *)channels
                  inView:(UIView *_Nullable)inView
               shareData:(void (^)(id<PDShareData> shareData))shareData
               onSuccess:(void (^ _Nullable)(PDShareSDKChannel channel))onSuccess
               onFailure:(void (^ _Nullable)(PDShareSDKChannel channel, NSError *error))onFailure
              onSelected:(void (^ _Nullable)(PDShareSDKChannel channel))onSelected;

- (void)dismissWithAnimated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
