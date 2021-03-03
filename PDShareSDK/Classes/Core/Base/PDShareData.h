//
//  PDShareData.h
//  PDShareSDK
//
//  Created by liang on 2021/2/8.
//

#import <UIKit/UIKit.h>
#import "PDShareSDKDefinition.h"

NS_ASSUME_NONNULL_BEGIN

/// 文字类型分享数据协议包，业务层使用
@protocol PDShareTextData <NSObject>

@optional
@property (nonatomic, strong) NSString *title;              ///< 消息标题

@end

/// 图片类型分享数据协议包，业务层使用
@protocol PDShareImageData <NSObject>

@optional
@property (nonatomic, strong) NSString *title;              ///< 消息标题
@property (nonatomic, strong) NSString *content;            ///< 描述内容
@property (nonatomic, strong) UIImage *shareImage;          ///< 分享图片
@property (nonatomic, strong) UIImage *thumbImage;          ///< 缩略图片
@property (nonatomic, strong) NSString *shareImageURL;      ///< 分享图片URL
@property (nonatomic, strong) NSString *thumbImageURL;      ///< 缩略图URL
@property (nonatomic, strong) NSString *shareImageFilePath; ///< 分享图片本地文件路径
@property (nonatomic, strong) NSString *thumbImageFilePath; ///< 缩略图本地文件路径

@end

/// 网页类型分享数据协议包，业务层使用
@protocol PDShareWebPageData <NSObject>

@optional
@property (nonatomic, strong) NSString *title;              ///< 消息标题
@property (nonatomic, strong) NSString *content;            ///< 描述内容
@property (nonatomic, strong) NSString *webPageURL;         ///< 分享链接 URL
@property (nonatomic, strong) UIImage *thumbImage;          ///< 缩略图
@property (nonatomic, strong) NSString *thumbImageURL;      ///< 缩略图URL
@property (nonatomic, strong) NSString *thumbImageFilePath; ///< 缩略图本地文件路径

@end

/// 小程序类型分享数据协议包，业务层使用
@protocol PDShareMiniAppData <NSObject>

@optional
@property (nonatomic, strong) NSString *title;                              ///< 消息标题
@property (nonatomic, strong) NSString *content;                            ///< 描述内容
@property (nonatomic, strong) NSString *miniAppID;                          ///< 小程序 appID
@property (nonatomic, strong) NSString *miniAppPath;                        ///< 小程序页面路径
@property (nonatomic, strong) NSString *webPageURL;                         ///< 分享链接 URL
@property (nonatomic, strong) UIImage *thumbImage;                          ///< 缩略图
@property (nonatomic, strong) NSString *thumbImageURL;                      ///< 缩略图URL
@property (nonatomic, strong) NSString *thumbImageFilePath;                 ///< 缩略图本地文件路径
@property (nonatomic, assign) BOOL withShareTicket;                         ///< 是否使用带shareTicket的分享
@property (nonatomic, assign) PDShareMiniAppType miniAppType;               ///< 小程序类型
@property (nonatomic, assign) PDShareMiniAppActionType miniAppActionType;   ///< 小程序动作类型

@end

/// @protocol PDShareData
/// @brief 分享数据类型
@protocol PDShareData <PDShareTextData, PDShareImageData, PDShareWebPageData, PDShareMiniAppData>

@property (nonatomic, strong) NSDictionary<NSString *, id> *extandInfoMap;  ///< 扩展信息，一般用于传递业务相关信息

@end

NS_ASSUME_NONNULL_END
