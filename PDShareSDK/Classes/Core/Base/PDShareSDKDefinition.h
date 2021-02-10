//
//  PDShareSDKDefinition.h
//  Pods
//
//  Created by liang on 2021/2/8.
//

#ifndef PDShareSDKDefinition_h
#define PDShareSDKDefinition_h

/// @enum PDShareSDKChannel
/// @brief 分享渠道定义
typedef NS_ENUM(NSInteger, PDShareSDKChannel) {
    PDShareSDKChannelNone           = 0, ///< 无效平台类型
    PDShareSDKChannelCopyLink       = 1, ///< 复制链接
    PDShareSDKChannelWeChatSession  = 2, ///< 微信好友
    PDShareSDKChannelWeChatTimeline = 3, ///< 微信朋友圈
    PDShareSDKChannelEWeChat        = 4, ///< 企业微信
    PDShareSDKChannelQQ             = 5, ///< QQ
    PDShareSDKChannelQQZone         = 6, ///< QQ空间
    PDShareSDKChannelSina           = 7, ///< 新浪微博
    PDShareSDKChannelSaveToLocal    = 8, ///< 保存到本地
};

/// @enum PDShareMiniAppType
/// @brief 小程序类型
typedef NS_ENUM(NSUInteger, PDShareMiniAppType) {
    PDShareMiniAppTypeRelease = 0,  ///< 正式版
    PDShareMiniAppTypeTest    = 1,  ///< 测试版
    PDShareMiniAppTypePreview = 2,  ///< 体验版
};

/// @enum PDShareContentType
/// @brief 分享内容的类型
typedef NS_ENUM(NSUInteger, PDShareContentType) {
    PDShareContentTypeUnknow    = 0,  ///< 未知类型
    PDShareContentTypeText      = 1,  ///< 文本类型
    PDShareContentTypeImage     = 2,  ///< 图片类型
    PDShareContentTypeWebPage   = 3,  ///< 网页类型
    PDShareContentTypeMiniApp   = 4,  ///< 小程序类型
    PDShareContentTypeCustom    = 5,  ///< 自定义类型
};

typedef NSNumber * PDShareChannelKey;

FOUNDATION_EXPORT PDShareChannelKey const PDShareChannelKeyFormat(PDShareSDKChannel channel);

#endif /* PDShareSDKDefinition_h */
