//
//  PDSharePanelView.m
//  PDShareSDK
//
//  Created by liang on 2021/2/9.
//

#import "PDSharePanelView.h"
#import "PDShareChannelView.h"
#import "PDShareManager.h"
#import "PDShareUIUtils.h"

@interface PDShareBackgroundView : UIView

@property (nonatomic, copy) void (^hitBlock)(void);

@end

@implementation PDShareBackgroundView

- (instancetype)init {
    self = [super init];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)tap:(UITapGestureRecognizer *)sender {
    !self.hitBlock ?: self.hitBlock();
}

@end

@class PDSharePanelAnimator;

@protocol PDSharePanelAnimatorDelegate <NSObject>

- (CGFloat)contentViewHeightForAnimator:(PDSharePanelAnimator *)animator;

@end

@interface PDSharePanelAnimator : NSObject

@property (nonatomic, weak, readonly) UIView *panelView;
@property (nonatomic, weak, readonly) UIView *backgroundView;
@property (nonatomic, weak, readonly) UIView *contentView;
@property (nonatomic, weak) id<PDSharePanelAnimatorDelegate> delegate;

- (instancetype)initWithPanelView:(UIView *)panelView
                   backgroundView:(UIView *)backgroundView
                      contentView:(UIView *)contentView;

- (void)showWithAnimated:(BOOL)animated inView:(UIView *)inView;
- (void)dismissWithAnimated:(BOOL)animated;

@end

@implementation PDSharePanelAnimator

- (instancetype)initWithPanelView:(UIView *)panelView
                   backgroundView:(UIView *)backgroundView
                      contentView:(UIView *)contentView {
    self = [super init];
    if (self) {
        _panelView = panelView;
        _backgroundView = backgroundView;
        _contentView = contentView;
    }
    return self;
}

- (void)showWithAnimated:(BOOL)animated inView:(UIView *)inView {
    self.panelView.hidden = NO;
    self.panelView.frame = inView.bounds;
    [inView addSubview:self.panelView];
    
    self.backgroundView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5f];
    
    CGFloat contentViewHeight = [self.delegate contentViewHeightForAnimator:self];
    __block CGRect rect = CGRectMake(0,
                                     CGRectGetHeight(inView.frame),
                                     CGRectGetWidth(inView.frame),
                                     contentViewHeight);
    self.contentView.frame = rect;
    
    NSTimeInterval duration = animated ? 0.25f : 0.f;
    [UIView animateWithDuration:duration animations:^{
        rect.origin.y = CGRectGetHeight(inView.frame) - contentViewHeight;
        self.contentView.frame = rect;
    }];
}

- (void)dismissWithAnimated:(BOOL)animated {
    NSTimeInterval duration = animated ? 0.25f : 0.f;
    [UIView animateWithDuration:duration animations:^{
        self.backgroundView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.f];
        
        CGRect rect = self.contentView.frame;
        rect.origin.y = CGRectGetHeight(self.contentView.superview.frame);
        self.contentView.frame = rect;
    } completion:^(BOOL finished) {
        self.panelView.hidden = YES;
        [self.panelView removeFromSuperview];
    }];
}

@end

@interface PDSharePanelView () <PDSharePanelAnimatorDelegate, PDShareChannelViewDelegate, PDShareChannelViewDataSource>

@property (nonatomic, strong) PDShareBackgroundView *backgroundView;
@property (nonatomic, strong) PDShareChannelView *channelView;
@property (nonatomic, strong) PDSharePanelAnimator *animator;
@property (nonatomic, copy) NSArray<PDShareChannelKey> *channels;
@property (nonatomic, copy) void (^shareData)(id<PDShareData>);
@property (nonatomic, copy) void (^onSuccess)(PDShareSDKChannel);
@property (nonatomic, copy) void (^onFailure)(PDShareSDKChannel, NSError *);
@property (nonatomic, copy) void (^onSelected)(PDShareSDKChannel);

@end

@implementation PDSharePanelView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupInitializeConfiguration];
        [self createViewHierarchy];
        [self layoutContentViews];
    }
    return self;
}

- (void)setupInitializeConfiguration {
    self.backgroundColor = [UIColor clearColor];
}

- (void)createViewHierarchy {
    [self addSubview:self.backgroundView];
    [self addSubview:self.channelView];
}

- (void)layoutContentViews {
    [NSLayoutConstraint activateConstraints:@[
        [self.backgroundView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.backgroundView.leftAnchor constraintEqualToAnchor:self.leftAnchor],
        [self.backgroundView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [self.backgroundView.rightAnchor constraintEqualToAnchor:self.rightAnchor],
    ]];
}

#pragma mark - Public Methods
- (void)showWithChannels:(NSArray<PDShareChannelKey> *)channels
                  inView:(UIView *)inView
               shareData:(void (^)(id<PDShareData> _Nonnull))shareData
               onSuccess:(void (^)(PDShareSDKChannel))onSuccess
               onFailure:(void (^)(PDShareSDKChannel, NSError * _Nonnull))onFailure {
    [self showWithChannels:channels
                    inView:inView
                 shareData:shareData
                 onSuccess:onSuccess
                 onFailure:onFailure
                onSelected:nil];
}

- (void)showWithChannels:(NSArray<PDShareChannelKey> *)channels
                  inView:(UIView *)inView
               shareData:(void (^)(id<PDShareData> _Nonnull))shareData
               onSuccess:(void (^)(PDShareSDKChannel))onSuccess
               onFailure:(void (^)(PDShareSDKChannel, NSError * _Nonnull))onFailure
              onSelected:(void (^)(PDShareSDKChannel))onSelected {
    self.channels = [channels copy];
    self.shareData = shareData;
    self.onSuccess = onSuccess;
    self.onFailure = onFailure;
    self.onSelected = onSelected;
    
    [self.channelView reloadData];
    [self.animator showWithAnimated:YES inView:inView ?: PDShareGetKeyWindow()];
}

- (void)dismissWithAnimated:(BOOL)animated {
    self.channels = nil;
    self.shareData = nil;
    self.onSuccess = nil;
    self.onFailure = nil;
    self.onSelected = nil;

    [self.animator dismissWithAnimated:animated];
}

#pragma mark - PDShareChannelViewDelegate, PDShareChannelViewDataSource
- (NSArray<PDShareChannelKey> *)channelsForChannelView:(PDShareChannelView *)channelView {
    return self.channels;
}

- (void)channelView:(PDShareChannelView *)channelView didSelectAtChannel:(PDShareSDKChannel)channel {
    !self.onSelected ?: self.onSelected(channel);
    
    [[PDShareManager defaultManager] shareToChannel:channel
                                          shareData:self.shareData
                                          onSuccess:^(PDShareSDKChannel channel) {
        !self.onSuccess ?: self.onSuccess(channel);
        [self dismissWithAnimated:YES];
    } onFailure:^(PDShareSDKChannel channel, NSError * _Nonnull error) {
        !self.onFailure ?: self.onFailure(channel, error);
        [self dismissWithAnimated:YES];
    }];
}

- (void)channelViewDidCancel:(PDShareChannelView *)channelView {
    [self dismissWithAnimated:YES];
}

#pragma mark - PDSharePanelAnimatorDelegate
- (CGFloat)contentViewHeightForAnimator:(PDSharePanelAnimator *)animator {
    NSInteger line = ceil(self.channels.count / 3.f);
    line = line ?: 0;
    
    CGFloat contentViewHeight = 70.f + 46.f;
    contentViewHeight += line * 81.f; // cell height 81.f
    contentViewHeight += (line - 1) * 30.f; // line space 30.f
    return contentViewHeight;
}

#pragma mark - Gesture Methods
- (void)tap:(UIGestureRecognizer *)sender {
    [self dismissWithAnimated:YES];
}

#pragma mark - Getter Methods
- (PDShareBackgroundView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[PDShareBackgroundView alloc] init];
        _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;

        __weak typeof(self) weakSelf = self;
        _backgroundView.hitBlock = ^{
            [weakSelf dismissWithAnimated:YES];
        };
    }
    return _backgroundView;
}

- (PDShareChannelView *)channelView {
    if (!_channelView) {
        _channelView = [[PDShareChannelView alloc] init];
        _channelView.delegate = self;
        _channelView.dataSource = self;
    }
    return _channelView;
}

- (PDSharePanelAnimator *)animator {
    if (!_animator) {
        _animator = [[PDSharePanelAnimator alloc] initWithPanelView:self
                                                     backgroundView:self.backgroundView
                                                        contentView:self.channelView];
        _animator.delegate = self;
    }
    return _animator;
}

@end
