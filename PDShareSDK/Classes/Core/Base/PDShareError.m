//
//  PDShareError.m
//  PDShareSDK
//
//  Created by liang on 2021/2/9.
//

#import "PDShareError.h"

PDShareSDKErrorCode const PDShareSDKErrorCodeCommmon        = 100;
PDShareSDKErrorCode const PDShareSDKErrorCodeAuthDenied     = 200;
PDShareSDKErrorCode const PDShareSDKErrorCodeUninstall      = 300;
PDShareSDKErrorCode const PDShareSDKErrorCodeInvalidChannel = 400;
PDShareSDKErrorCode const PDShareSDKErrorCodeUserCancel     = 500;
PDShareSDKErrorCode const PDShareSDKErrorCodeLoadFailed     = 600;
PDShareSDKErrorCode const PDShareSDKErrorCodeInvalidData    = 700;

static NSString *const PDShareErrorDomain = @"PDShareErrorDomain";

NSError *PDShareErrorWithDomain(NSErrorDomain domain, NSInteger code, NSString *fmt, ...) {
    va_list args;
    va_start(args, fmt);
    NSString *message = [[NSString alloc] initWithFormat:fmt arguments:args];
    va_end(args);
    
    NSError *error = [NSError errorWithDomain:domain code:code userInfo:@{@"message": message ?: @""}];
    return error;
}

NSError *PDShareError(NSInteger code, NSString *fmt, ...) {
    va_list args;
    va_start(args, fmt);
    NSString *message = [[NSString alloc] initWithFormat:fmt arguments:args];
    va_end(args);
    
    NSError *error = [NSError errorWithDomain:PDShareErrorDomain code:code userInfo:@{@"message": message ?: @""}];
    return error;
}

NSErrorDomain PDShareErrorGetDomain(NSError *error) {
    if (!error) {
        return nil;
    }
    return error.domain;
}

NSInteger PDShareErrorGetCode(NSError *error) {
    if (!error) {
        return 0;
    }
    return error.code;
}

NSString *PDShareErrorGetMessage(NSError *error) {
    if (!error) {
        return nil;
    }
    
    NSDictionary *userInfo = error.userInfo;
    NSString *message = userInfo[@"message"];
    return message;
}
