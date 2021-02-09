//
//  PDShareChannelView.m
//  PDShareSDK
//
//  Created by liang on 2021/2/9.
//

#import "PDShareChannelView.h"
#import "PDShareChannelCell.h"
#import "PDShareMacro.h"

@interface PDShareChannelView () <UICollectionViewDelegate, UICollectionViewDataSource> {
    struct {
        unsigned channelsForChannelView : 1;
    } _dataSourceHas;
}

@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation PDShareChannelView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupInitializeConfiguration];
        [self createViewsHierarchy];
        [self layoutContentViews];
    }
    return self;
}

- (void)setupInitializeConfiguration {
    self.backgroundColor = [UIColor whiteColor];
    self.cancelButton.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (void)createViewsHierarchy {
    [self addSubview:self.cancelButton];
    [self addSubview:self.collectionView];
}

- (void)layoutContentViews {
    [NSLayoutConstraint activateConstraints:@[
        [self.cancelButton.topAnchor constraintEqualToAnchor:self.topAnchor constant:15.f],
        [self.cancelButton.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-6.f],
        [self.cancelButton.widthAnchor constraintEqualToConstant:36.f],
        [self.cancelButton.heightAnchor constraintEqualToConstant:36.f],
    ]];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.collectionView.topAnchor constraintEqualToAnchor:self.topAnchor constant:70.f],
        [self.collectionView.leftAnchor constraintEqualToAnchor:self.leftAnchor],
        [self.collectionView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [self.collectionView.rightAnchor constraintEqualToAnchor:self.rightAnchor],
    ]];
}

#pragma mark - Public Methods
- (void)reloadData {
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(channelsForChannelView:)]) {
        return [self.dataSource channelsForChannelView:self].count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PDShareChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PDShareChannelCell class]) forIndexPath:indexPath];
    if (_dataSourceHas.channelsForChannelView) {
        PDShareChannelKey key = [self.dataSource channelsForChannelView:self][indexPath.row];
        cell.channel = [key integerValue];
    } else {
        NSAssert(NO, @"Method `- channelsForChannelView:` from protocol `<PDShareChannelViewDataSource>` must be impl!");
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(channelView:didSelectAtChannel:)]) {
        PDShareChannelKey key = [self.dataSource channelsForChannelView:self][indexPath.row];
        [self.delegate channelView:self didSelectAtChannel:[key integerValue]];
    }
}

#pragma mark - Event Methods
- (void)didClickCancelButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(channelViewDidCancel:)]) {
        [self.delegate channelViewDidCancel:self];
    }
}

#pragma mark - Setter Methods
- (void)setDataSource:(id<PDShareChannelViewDataSource>)dataSource {
    _dataSource = dataSource;
    _dataSourceHas.channelsForChannelView = [_dataSource respondsToSelector:@selector(channelsForChannelView:)];
}

#pragma mark - Getter Methods
- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_cancelButton setImage:PDShareSDKImage(@"nav_icon_close") forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(didClickCancelButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 30.0;
        layout.minimumInteritemSpacing = 1.0;
        layout.itemSize = CGSizeMake(90.0, 81.0);
        layout.sectionInset = UIEdgeInsetsMake(0, 32.0, 0, 32.0);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[PDShareChannelCell class] forCellWithReuseIdentifier:NSStringFromClass([PDShareChannelCell class])];
    }
    return _collectionView;
}

@end
