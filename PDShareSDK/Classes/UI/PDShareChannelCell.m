//
//  PDShareChannelCell.m
//  PDShareSDK
//
//  Created by liang on 2021/2/9.
//

#import "PDShareChannelCell.h"
#import "PDShareSDKUIConfiguration.h"

@interface PDShareChannelCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation PDShareChannelCell

@synthesize imageView = _imageView;
@synthesize textLabel = _textLabel;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupInitializeConfiguration];
        [self createViewHierarchy];
        [self layoutContentViews];
    }
    return self;
}

- (void)setupInitializeConfiguration {
    self.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)createViewHierarchy {
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.textLabel];
}

- (void)layoutContentViews {
    [NSLayoutConstraint activateConstraints:@[
        [self.imageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
        [self.imageView.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor],
        [self.imageView.widthAnchor constraintEqualToConstant:50.f],
        [self.imageView.heightAnchor constraintEqualToConstant:50.f],
    ]];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.textLabel.topAnchor constraintEqualToAnchor:self.imageView.bottomAnchor constant:10.f],
        [self.textLabel.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor],
        [self.textLabel.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor],
        [self.textLabel.heightAnchor constraintEqualToConstant:21.f],
    ]];
}

#pragma mark - Setter Methods
- (void)setChannel:(PDShareSDKChannel)channel {
    _channel = channel;
    
    id<PDShareChannelStyle> style = PDShareSDKGetStyle(channel);
    self.imageView.image = style.image;
    self.textLabel.text = style.title;
    
    self.imageView.backgroundColor = self.textLabel.backgroundColor = [UIColor lightGrayColor];
}

#pragma mark - Getter Methods
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        _imageView.contentMode = UIViewContentModeCenter;
    }
    return _imageView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _textLabel.font = [UIFont systemFontOfSize:15.f];
        _textLabel.textColor = [UIColor colorWithRed:(102 % 255) / 255.f
                                               green:(102 % 255) / 255.f
                                                blue:(102 % 255) / 255.f
                                               alpha:1.f];
    }
    return _textLabel;
}

@end
