//
//  PDShareModuleManager.m
//  PDShareSDK
//
//  Created by liang on 2021/2/8.
//

#import "PDShareModuleManager.h"
#import <dlfcn.h>
#import <mach-o/getsect.h>
#import "PDShareModule.h"

@implementation PDShareModuleManager {
    NSMutableDictionary<PDShareChannelKey, PDShareModule *> *_shareModuleMap;
}

static PDShareModuleManager *__defaultManager;

+ (PDShareModuleManager *)defaultManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (__defaultManager == nil) {
            __defaultManager = [[self alloc] init];
        }
    });
    return __defaultManager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    @synchronized (self) {
        if (__defaultManager == nil) {
            __defaultManager = [super allocWithZone:zone];
        }
    }
    return __defaultManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _shareModuleMap = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)loadShareModules {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self _loadShareModules];
    });
}

- (PDShareModule *)shareModuleForChannel:(PDShareSDKChannel)channel {
    return _shareModuleMap[PDShareChannelKeyFormat(channel)];
}

- (NSDictionary<PDShareChannelKey,PDShareModule *> *)shareModuleMap {
    return _shareModuleMap;
}

#pragma mark - Internal Methods
- (void)_loadShareModules {
    Dl_info info; dladdr(&__defaultManager, &info);
    
#ifdef __LP64__
    uint64_t addr = 0; const uint64_t mach_header = (uint64_t)info.dli_fbase;
    const struct section_64 *section = getsectbynamefromheader_64((void *)mach_header, "__DATA", "_pd_sharemodules");
#else
    uint32_t addr = 0; const uint32_t mach_header = (uint32_t)info.dli_fbase;
    const struct section *section = getsectbynamefromheader((void *)mach_header, "__DATA", "_pd_sharemodules");
#endif
    
    if (section == NULL) { return; }
    
    for (addr = section->offset; addr < section->offset + section->size; addr += sizeof(PDShareModuleExpInfo)) {
        PDShareModuleExpInfo *info = (PDShareModuleExpInfo *)(mach_header + addr);
        if (!info) { continue; }
        
        PDShareChannelKey key = @(info->channel);
        if (_shareModuleMap[key]) {
            NSAssert(NO, @"Duplicate channel!");
            continue;
        }
        
        NSString *classname = [NSString stringWithUTF8String:info->classname];
        Class shareModuleClass = NSClassFromString(classname);
        if (!shareModuleClass) {
            NSAssert(NO, @"Invalid module class!");
            continue;
        }
        
        PDShareModule *shareModule = [[shareModuleClass alloc] init];
        _shareModuleMap[key] = shareModule;
    }
}

@end
