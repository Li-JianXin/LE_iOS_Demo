//
//  ViewController.m
//  coverFloawView_scrollView_demo
//
//  Created by jianxin.li on 16/4/15.
//  Copyright © 2016年 m6go.com. All rights reserved.
//

#import "ViewController.h"
#import "ILERCoverFlowView.h"

@interface ViewController ()<ILERCoverFlowViewDelegate, ILERCoverFlowViewDataSource>

@property (nonatomic, strong) ILERCoverFlowView *coverFlowView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeUI];
}

- (void)initializeUI {
    _coverFlowView = [[ILERCoverFlowView alloc] initWithFrame:CGRectMake(0, 100, ScreenW, 300)];
    _coverFlowView.needsPagingEnabled = YES;
    _coverFlowView.backgroundColor = [UIColor orangeColor];
    _coverFlowView.delegate   = self;
    _coverFlowView.dataSource = self;
    _coverFlowView.minimumPageAlpha = 1.0f;
    _coverFlowView.minimumPageScale = 0.85f;
    [self.view addSubview:_coverFlowView];
}

#pragma mark - ILERCoverFlowViewDelegate

- (void)coverFlowView:(ILERCoverFlowView *)coverFlowView didTapPageAtIndex:(NSInteger)index {
    NSLog(@"点击%ld",index);
}
- (void)coverFlowView:(ILERCoverFlowView *)coverFlowView didScrollToPageAtIndex:(NSInteger)index {
    NSLog(@"滑动%ld",index);
}

#pragma mark - ILERCoverFlowViewDataSource

- (NSInteger)numberOfPagesInCoverFlowView:(ILERCoverFlowView *)coverFlowView {
    return 10;
}

- (UIView *)coverFlowView:(ILERCoverFlowView *)coverFlowView itemViewForPageAtIndex:(NSInteger)index {
    UIImageView *imageView = [UIImageView new];
    imageView = [UIImageView new];
    imageView.layer.cornerRadius  = 50;
    imageView.layer.masksToBounds = YES;
    imageView.backgroundColor = [[self class] RandomColor];
    return imageView;
}

- (CGSize)sizeForPageInCoverFlowView:(ILERCoverFlowView *)coverFlowView {
    return CGSizeMake(230, 200);
}

#pragma mark - private

+ (UIColor *)RandomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

@end
