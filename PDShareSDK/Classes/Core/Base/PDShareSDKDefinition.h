//
//  PDShareSDKDefinition.h
//  Pods
//
//  Created by liang on 2021/2/8.
//

#ifndef PDShareSDKDefinition_h
#define PDShareSDKDefinition_h

/// 分享渠道定义
typedef NSInteger PDShareSDKChannel NS_TYPED_EXTENSIBLE_ENUM;
static PDShareSDKChannel const PDShareSDKChannelUnknown         = 0; ///< 未知平台类型
static PDShareSDKChannel const PDShareSDKChannelCopyLink        = 1; ///< 复制链接
static PDShareSDKChannel const PDShareSDKChannelWeChatSession   = 2; ///< 微信好友
static PDShareSDKChannel const PDShareSDKChannelWeChatTimeline  = 3; ///< 微信朋友圈
static PDShareSDKChannel const PDShareSDKChannelEWeChat         = 4; ///< 企业微信
static PDShareSDKChannel const PDShareSDKChannelQQ              = 5; ///< QQ
static PDShareSDKChannel const PDShareSDKChannelQQZone          = 6; ///< QQ 空间
static PDShareSDKChannel const PDShareSDKChannelSina            = 7; ///< 新浪微博

/// @enum PDShareMiniAppType
/// @brief 小程序类型
typedef NS_ENUM(NSUInteger, PDShareMiniAppType) {
    PDShareMiniAppTypeUnknown = 0,  ///< 未知类型
    PDShareMiniAppTypeRelease = 1,  ///< 正式版
    PDShareMiniAppTypeTest    = 2,  ///< 测试版
    PDShareMiniAppTypePreview = 3,  ///< 体验版
};

/// @enum PDShareMiniAppActionType
/// @brief 小程序动作类型
typedef NS_ENUM(NSUInteger, PDShareMiniAppActionType) {
    PDShareMiniAppActionTypeShare   = 0,    ///< 分享到微信小程序
    PDShareMiniAppActionTypeLaunch  = 1     ///< 调起微信小程序
};

/// @enum PDShareContentType
/// @brief 分享内容的类型
typedef NS_ENUM(NSUInteger, PDShareContentType) {
    PDShareContentTypeUnknown   = 0,  ///< 未知类型
    PDShareContentTypeText      = 1,  ///< 文本类型
    PDShareContentTypeImage     = 2,  ///< 图片类型
    PDShareContentTypeWebPage   = 3,  ///< 网页类型
    PDShareContentTypeMiniApp   = 4,  ///< 小程序类型
    PDShareContentTypeCustom    = 5,  ///< 自定义类型
};

typedef NSNumber * PDShareChannelKey;

FOUNDATION_EXPORT PDShareChannelKey const PDShareChannelKeyFormat(PDShareSDKChannel channel);

#endif /* PDShareSDKDefinition_h */
