//
//  PDShareUIUtils.m
//  PDShareSDK
//
//  Created by liang on 2021/2/9.
//

#import "PDShareUIUtils.h"

UIWindow *PDShareGetKeyWindow(void) {
    if ([UIApplication sharedApplication].delegate.window) {
        return [UIApplication sharedApplication].delegate.window;
    }
    
    if (@available(iOS 13.0, *)) {
        NSArray *array = [[UIApplication sharedApplication].connectedScenes allObjects];
        UIWindowScene *windowScene = (UIWindowScene *)[array firstObject];
        UIWindow *mainWindow = [windowScene valueForKeyPath:@"delegate.window"];
        return mainWindow ?: [UIApplication sharedApplication].windows.lastObject;
    } else {
        return [UIApplication sharedApplication].keyWindow;
    }
}
