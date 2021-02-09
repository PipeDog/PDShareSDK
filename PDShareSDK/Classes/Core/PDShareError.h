//
//  PDShareError.h
//  PDShareSDK
//
//  Created by liang on 2021/2/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSInteger PDShareSDKErrorCode NS_TYPED_ENUM;

FOUNDATION_EXPORT PDShareSDKErrorCode const PDShareSDKErrorCodeCommmon;
FOUNDATION_EXPORT PDShareSDKErrorCode const PDShareSDKErrorCodeAuthDenied;
FOUNDATION_EXPORT PDShareSDKErrorCode const PDShareSDKErrorCodeUninstall;
FOUNDATION_EXPORT PDShareSDKErrorCode const PDShareSDKErrorCodeInvalidChannel;
FOUNDATION_EXPORT PDShareSDKErrorCode const PDShareSDKErrorCodeUserCancel;
FOUNDATION_EXPORT PDShareSDKErrorCode const PDShareSDKErrorCodeLoadFailed;
FOUNDATION_EXPORT PDShareSDKErrorCode const PDShareSDKErrorCodeInvalidData;

/// @brief 构建 NSError 实例
/// @param domain 错误域
/// @param code 错误码
/// @param fmt 错误信息
/// @return NSError 实例对象
FOUNDATION_EXPORT NSError *PDShareErrorWithDomain(NSErrorDomain domain, NSInteger code, NSString *fmt, ...);

/// @brief 构建 NSError 实例
/// @param code 错误码
/// @param fmt 错误信息
/// @return NSError 实例对象
FOUNDATION_EXPORT NSError *PDShareError(NSInteger code, NSString *fmt, ...);

/// @brief 获取 NSError 的 domain 内容
/// @param error NSError 实例对象
/// @return domain 内容
FOUNDATION_EXPORT NSErrorDomain PDShareErrorGetDomain(NSError *error);

/// @brief 获取 NSError 的错误码
/// @param error NSError 实例对象
/// @return 错误码
FOUNDATION_EXPORT NSInteger PDShareErrorGetCode(NSError *error);

/// @brief 获取 NSError 的错误信息
/// @param error NSError 实例对象
/// @return 错误信息
FOUNDATION_EXPORT NSString *PDShareErrorGetMessage(NSError *error);

NS_ASSUME_NONNULL_END
