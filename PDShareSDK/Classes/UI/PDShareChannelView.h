//
//  PDShareChannelView.h
//  PDShareSDK
//
//  Created by liang on 2021/2/9.
//

#import <UIKit/UIKit.h>
#import "PDShareSDKDefinition.h"

NS_ASSUME_NONNULL_BEGIN

@class PDShareChannelView;

@protocol PDShareChannelViewDelegate <NSObject>

@optional
- (void)channelView:(PDShareChannelView *)channelView didSelectAtChannel:(PDShareSDKChannel)channel;
- (void)channelViewDidCancel:(PDShareChannelView *)channelView;

@end

@protocol PDShareChannelViewDataSource <NSObject>

- (NSArray<PDShareChannelKey> *)channelsForChannelView:(PDShareChannelView *)channelView;

@end


@interface PDShareChannelView : UIView

@property (nonatomic, weak) id<PDShareChannelViewDelegate> delegate;
@property (nonatomic, weak) id<PDShareChannelViewDataSource> dataSource;

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
