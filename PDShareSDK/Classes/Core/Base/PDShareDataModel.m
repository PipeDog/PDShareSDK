//
//  PDShareDataModel.m
//  PDShareSDK
//
//  Created by liang on 2021/2/8.
//

#import "PDShareDataModel.h"

@implementation PDShareDataModel

@synthesize title = _title;
@synthesize content = _content;
@synthesize shareImage = _shareImage;
@synthesize thumbImage = _thumbImage;
@synthesize shareImageURL = _shareImageURL;
@synthesize thumbImageURL = _thumbImageURL;
@synthesize shareImageFilePath = _shareImageFilePath;
@synthesize thumbImageFilePath = _thumbImageFilePath;
@synthesize webPageURL = _webPageURL;
@synthesize miniAppID = _miniAppID;
@synthesize miniAppPath = _miniAppPath;
@synthesize withShareTicket = _withShareTicket;
@synthesize miniAppType = _miniAppType;
@synthesize extandInfoMap = _extandInfoMap;

- (instancetype)initWithChannel:(PDShareSDKChannel)channel {
    self = [super init];
    if (self) {
        _channel = channel;
    }
    return self;
}

- (PDShareContentType)shareContentType {
    if (self.miniAppID.length > 0 && self.miniAppPath.length > 0) {
        return PDShareContentTypeMiniApp;
    }

    if (self.webPageURL.length > 0) {
        return PDShareContentTypeWebPage;
    }

    if (self.shareImage || self.shareImageFilePath.length > 0 || self.shareImageURL.length > 0) {
        return PDShareContentTypeImage;
    }

    if (self.title.length > 0) {
        return PDShareContentTypeText;
    }
    
    if (self.extandInfoMap.allKeys > 0) {
        return PDShareContentTypeCustom;
    }

    NSAssert(NO, @"Unknown share content Type!");
    return PDShareContentTypeUnknow;
}

@end
