//
//  PDShareModule.h
//  PDShareSDK
//
//  Created by liang on 2021/2/8.
//

#import <Foundation/Foundation.h>
#import "PDShareSDKCallback.h"
#import "PDShareSDKDefinition.h"
#import "PDShareData.h"

NS_ASSUME_NONNULL_BEGIN

typedef struct {
    const PDShareSDKChannel channel;
    const char *classname;
} PDShareModuleExpInfo;

#define __PDSHARE_EXPORT_MODULE_EX(channel, classname)          \
__attribute__((used, section("__DATA , _pd_sharemodules")))     \
static const PDShareModuleExportInfo __pd_share_module_exp_##classname##__ = {channel, #classname};

#define PDSHARE_EXPORT_MODULE(modulename, classname) __PDSHARE_EXPORT_MODULE_EX(channel, classname)

@interface PDShareModule : NSObject <PDShareSDKCallback>

- (BOOL)shouldCallbackWhenApplicationBecomeActive;
- (void)registerWithDataSource:(NSDictionary<NSString *, NSString *> *)registerMap;
- (void)shareData:(id<PDShareData>)shareData onFinished:(void (^)(BOOL success, NSError *error))onFinished;

@end

NS_ASSUME_NONNULL_END
