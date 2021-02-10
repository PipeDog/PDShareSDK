//
//  PDShareModule.m
//  PDShareSDK
//
//  Created by liang on 2021/2/8.
//

#import "PDShareModule.h"

@implementation PDShareModule

- (BOOL)shouldCallbackWhenApplicationBecomeActive {
    return YES;
}

- (BOOL)registerWithDataSource:(NSDictionary<NSString *,NSString *> *)registerMap {
    // Override this method if needed.
    return YES;
}

- (void)shareData:(PDShareDataModel *)shareData onFinished:(void (^)(BOOL, NSError * _Nullable))onFinished {
    NSAssert(NO, @"Override this method!");
}

@end
