//
//  PDShareDataModel.h
//  PDShareSDK
//
//  Created by liang on 2021/2/8.
//

#import <Foundation/Foundation.h>
#import "PDShareData.h"

NS_ASSUME_NONNULL_BEGIN

@interface PDShareDataModel : NSObject <PDShareData>

@property (nonatomic, assign, readonly) PDShareSDKChannel channel;
@property (nonatomic, assign, readonly) PDShareContentType shareContentType;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithChannel:(PDShareSDKChannel)channel;

@end

NS_ASSUME_NONNULL_END
