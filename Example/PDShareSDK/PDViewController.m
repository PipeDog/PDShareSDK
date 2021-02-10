//
//  PDViewController.m
//  PDShareSDK
//
//  Created by liang on 02/07/2021.
//  Copyright (c) 2021 liang. All rights reserved.
//

#import "PDViewController.h"
#import <PDSharePanelView.h>

@interface PDViewController ()

@property (nonatomic, strong) PDSharePanelView *sharePanelView;

@end

@implementation PDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)didClickButton:(id)sender {
    NSArray<PDShareChannelKey> *channels = @[
        @(PDShareSDKChannelWeChatSession),
        @(PDShareSDKChannelWeChatTimeline),
    ];
    [self.sharePanelView showWithChannels:channels
                                   inView:self.view
                                shareData:^(id<PDShareData>  _Nonnull shareData) {
        shareData.title = @"分享标题";
    } onSuccess:^(PDShareSDKChannel channel) {
        NSLog(@"share success");
    } onFailure:^(PDShareSDKChannel channel, NSError * _Nonnull error) {
        NSLog(@"share failed, error = %@", error);
    }];
}

#pragma mark - Getter Methods
- (PDSharePanelView *)sharePanelView {
    if (!_sharePanelView) {
        _sharePanelView = [[PDSharePanelView alloc] init];
    }
    return _sharePanelView;
}

@end
