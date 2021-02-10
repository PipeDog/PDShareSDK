//
//  PDShareMacro.h
//  Pods
//
//  Created by liang on 2021/2/9.
//

#ifndef PDShareMacro_h
#define PDShareMacro_h

#define PDShareSDKBundleName    @"PDShareSDK.bundle"
#define PDShareSDKBundlePath    [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:PDShareSDKBundleName]
#define PDShareSDKBundle        [NSBundle bundleWithPath:PDShareSDKBundlePath]

#ifndef PDShareSDKImage
#define PDShareSDKImage(_name_) [UIImage imageNamed:_name_ inBundle:PDShareSDKBundle compatibleWithTraitCollection:nil]
#endif

#endif /* PDShareMacro_h */
