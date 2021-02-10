//
//  PDShareModule.h
//  PDShareSDK
//
//  Created by liang on 2021/2/8.
//

#import <Foundation/Foundation.h>
#import "PDShareSDKCallback.h"
#import "PDShareSDKDefinition.h"
#import "PDShareDataModel.h"
#import "PDShareError.h"

NS_ASSUME_NONNULL_BEGIN

typedef struct {
    const NSInteger channel;
    const char *classname;
} PDShareModuleExpInfo;

#define __PDSHARE_EXPORT_MODULE_EX(channel, classname)          \
__attribute__((used, section("__DATA , _pd_sharemodules")))     \
static const PDShareModuleExpInfo __pd_share_module_exp_##classname##__ = {channel, #classname};

#define PDSHARE_EXPORT_MODULE(channel, classname) __PDSHARE_EXPORT_MODULE_EX(channel, classname)

@interface PDShareModule : NSObject <PDShareSDKCallback>

- (BOOL)shouldCallbackWhenApplicationBecomeActive;
- (void)registerWithDataSource:(NSDictionary<NSString *, NSString *> *)registerMap;
- (void)shareData:(PDShareDataModel *)shareData onFinished:(void (^)(BOOL success, NSError * _Nullable error))onFinished;

@end

NS_ASSUME_NONNULL_END
