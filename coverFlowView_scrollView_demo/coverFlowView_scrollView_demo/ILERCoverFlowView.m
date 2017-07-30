//
//  ILERCoverFlowView.m
//  coverFloawView_scrollView_demo
//
//  Created by jianxin.li on 16/4/15.
//  Copyright © 2016年 m6go.com. All rights reserved.
//


#import "ILERCoverFlowView.h"

@interface ILERCoverFlowView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
/** 总页数 */
@property (nonatomic, assign) NSInteger pageCount;
/** 每页的大小 */
@property (nonatomic, assign) CGSize pageSize;
@property (nonatomic, assign) NSRange visibleRange;

@property (nonatomic, strong) NSMutableArray *itemPageViewArray;
@property (nonatomic, strong) NSMutableArray *reusableitemPageViewArray;

@end

@implementation ILERCoverFlowView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self foundationSetup];
        [self sharedInitAndConfig];
    }
    return self;
}

- (void)foundationSetup {
    // 子视图超出时自身边界，子视图超出边界部分会被剪切掉
    self.clipsToBounds   = YES;
    self.backgroundColor = [UIColor lightGrayColor];
    
    // 添加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
}

- (void)sharedInitAndConfig {
    /**
     * 默认设置
     */
    self.needsPagingEnabled       = YES;
    self.currentPageIndex         = 1;
    self.pageSize                 = self.bounds.size;
    self.visibleRange             = NSMakeRange(0, 0);
    self.minimumPageAlpha         = 1.0;
    self.minimumPageScale         = 1.0;
    
    self.scrollView               = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.delegate      = self;
    self.scrollView.pagingEnabled = self.needsPagingEnabled;
    self.scrollView.clipsToBounds = NO;
    self.scrollView.scrollsToTop  = NO;
    self.scrollView.showsVerticalScrollIndicator   = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    UIView *superViewOfScrollView = [[UIView alloc] initWithFrame:self.bounds];
    // view的宽度按照父视图的宽度比例进行缩放并自动调整view的高度，以保证上边距和下边距不变
    [superViewOfScrollView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [superViewOfScrollView setBackgroundColor:[UIColor clearColor]];
    [superViewOfScrollView addSubview:self.scrollView];
    [self addSubview:superViewOfScrollView];
}

/** 点击手势 */
- (void)tap:(UITapGestureRecognizer *)recognizer {
    NSInteger tapIndex = 0;
    // 点击在scrollView中的位置
    CGPoint locationInScrollView = [recognizer locationInView:self.scrollView];
    // 点击的位置是否在scrollView中
    if (CGRectContainsPoint(self.scrollView.bounds, locationInScrollView)) {
        tapIndex = self.currentPageIndex;
        if (self.delegate && [self.delegate respondsToSelector:@selector(coverFlowView:didTapPageAtIndex:)]) {
            [self.delegate coverFlowView:self didTapPageAtIndex:tapIndex];
        }
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfPagesInCoverFlowView:)]) {
        self.pageCount = [self.dataSource numberOfPagesInCoverFlowView:self];
    }
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(sizeForPageInCoverFlowView:)]) {
        _pageSize = [self.dataSource sizeForPageInCoverFlowView:self];
    }
    
    [_reusableitemPageViewArray removeAllObjects];
    self.visibleRange = NSMakeRange(0, 0);
    
    // 从supperView上移除itemPageViewArray
    for (NSInteger i = 0; i < [self.itemPageViewArray count]; i++) {
        [self removeitemPageViewArrayAtIndex:i];
    }
    
    // 添加pageView
    [self.itemPageViewArray removeAllObjects];
    for (NSInteger index = 0; index < _pageCount; index++) {
        [self.itemPageViewArray addObject:[NSNull null]];
    }
    
    // 重置self.scrollView的contentSize
    self.scrollView.frame = CGRectMake(0, 0, _pageSize.width, _pageSize.height);
    self.scrollView.contentSize = CGSizeMake(_pageSize.width * _pageCount, _pageSize.height);
    
    // 当数量大于2个时偏移
    if (self.pageCount > 2) {
        self.scrollView.contentOffset  = CGPointMake(_pageSize.width, 0);
    } else {
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }
    
    [self scrollViewDidEndDecelerating:self.scrollView];
    CGPoint theCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    self.scrollView.center = theCenter;
    
    [self setitemPageViewArrayAtContentOffset:self.scrollView.contentOffset];
    [self refreshVisibleItemViewAppearance];
}

/** 根据当前scrollView的offset设置ItemView */
- (void)setitemPageViewArrayAtContentOffset:(CGPoint)offset {
    if (self.itemPageViewArray.count == 0) return;
    // 计算 self.visibleRange
    CGPoint startPoint = CGPointMake(offset.x - self.scrollView.frame.origin.x, offset.y - self.scrollView.frame.origin.y);
    CGPoint endPoint   = CGPointMake(MAX(0, startPoint.x) + self.bounds.size.width, MAX(0, startPoint.y) + self.bounds.size.height);
    
    NSInteger startIndex = 0;
    for (int i =0; i < self.itemPageViewArray.count; i++) {
        if (_pageSize.width * (i +1) > startPoint.x) {
            startIndex = i;
            break;
        }
    }
    
    NSInteger endIndex = startIndex;
    for (NSInteger i = startIndex; i < self.itemPageViewArray.count; i++) {
        // 如果都不超过则取最后一个
        if ((_pageSize.width * (i + 1) < endPoint.x && _pageSize.width * (i + 2) >= endPoint.x) || i+ 2 == self.itemPageViewArray.count) {
            endIndex = i + 1;
            break;
        }
    }
    
    startIndex = MAX(startIndex - 1, 0);
    endIndex   = MIN(endIndex + 1, self.itemPageViewArray.count - 1);
    
    if (self.visibleRange.location == startIndex && self.visibleRange.length == (endIndex - startIndex + 1)) {
        return;
    }
    
    _visibleRange.location = startIndex;
    _visibleRange.length   = endIndex - startIndex + 1;
    
    for (NSInteger i = startIndex; i <= endIndex; i++) {
        [self setPageViewAtIndex:i];
    }
    
    for (int i = 0; i < startIndex; i ++) {
        [self removeitemPageViewArrayAtIndex:i];
    }
    
    for (NSInteger i = endIndex + 1; i < [self.itemPageViewArray count]; i ++) {
        [self removeitemPageViewArrayAtIndex:i];
    }
    
}

/** 添加并设置itemPageViewArray */
- (void)setPageViewAtIndex:(NSInteger)pageIndex {
    
    NSParameterAssert(pageIndex >= 0 && pageIndex < [self.itemPageViewArray count]);
    
    UIView *itemPageView = [self.itemPageViewArray objectAtIndex:pageIndex];
    
    if ((NSObject *)itemPageView == [NSNull null]) {
        itemPageView = [self.dataSource coverFlowView:self itemViewForPageAtIndex:pageIndex];
        NSAssert(itemPageView!=nil, @"datasource must not return nil");
        [self.itemPageViewArray  replaceObjectAtIndex:pageIndex withObject:itemPageView];
        itemPageView.frame = CGRectMake(_pageSize.width * pageIndex, 0, _pageSize.width, _pageSize.height);
        // 已经添加的替换，未添加的添加
        if (!itemPageView.superview) {
            [self.scrollView addSubview:itemPageView];
        }
    }
}

// 移除itemPageViewArray
- (void)removeitemPageViewArrayAtIndex:(NSInteger)index {
    UIView *itemPageViewArray = [self.itemPageViewArray objectAtIndex:index];
    if ((NSObject *)itemPageViewArray == [NSNull null]) {
        return;
    }
    
    [self queueReusableitemPageViewArray:itemPageViewArray];
    
    if (itemPageViewArray.superview) {
        itemPageViewArray.layer.transform = CATransform3DIdentity;
        [itemPageViewArray removeFromSuperview];
    }
    
    [self.itemPageViewArray replaceObjectAtIndex:index withObject:[NSNull null]];
}

/** 更新各个可见itemView的显示样式 */
- (void)refreshVisibleItemViewAppearance {
    
    if (_minimumPageAlpha == 1.0 && _minimumPageScale == 1.0) {
        return; // 无需更新
    }
    
    CGFloat offset = self.scrollView.contentOffset.x;
    
    for (NSInteger i = self.visibleRange.location; i < self.visibleRange.location + self.visibleRange.length; i++) {
        UIView *itemPageViewArray = [self.itemPageViewArray objectAtIndex:i];
        // 求绝对值
        CGFloat origin = itemPageViewArray.frame.origin.x;
        CGFloat delta = fabs(origin - offset);
        
        [UIView animateWithDuration:0.0 animations:^{
            if (delta < _pageSize.width) {
                itemPageViewArray.alpha = 1 - (delta / _pageSize.width) * (1 - _minimumPageAlpha);
                CGFloat pageScale = 1 - (delta / _pageSize.width) * (1 - _minimumPageScale);
                itemPageViewArray.layer.transform = CATransform3DMakeScale(pageScale, pageScale, 1);
            } else {
                itemPageViewArray.alpha = _minimumPageAlpha;
                itemPageViewArray.layer.transform = CATransform3DMakeScale(_minimumPageScale, _minimumPageScale, 1);
            }
        }];
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if ([self pointInside:point withEvent:event]) {
        CGPoint newPoint = CGPointZero;
        newPoint.x = point.x - self.scrollView.frame.origin.x + self.scrollView.contentOffset.x;
        newPoint.y = point.y - self.scrollView.frame.origin.y + self.scrollView.contentOffset.y;
        if ([self.scrollView pointInside:newPoint withEvent:event]) {
            return [self.scrollView hitTest:newPoint withEvent:event];
        }
        return self.scrollView;
    }
    return nil;
}

- (void)hiddenAllSubViews {
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *view = obj;
        view.hidden = YES;
    }];
}

- (void)showAllSubViews {
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *view = obj;
        view.hidden = NO;
    }];
}

- (void)queueReusableitemPageViewArray:(UIView *)itemPageViewArray {
    [_reusableitemPageViewArray addObject:itemPageViewArray];
}

- (void)dealloc {
    self.scrollView.delegate = nil;
}

#pragma mark - UIScrollVIewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self setitemPageViewArrayAtContentOffset:self.scrollView.contentOffset];
    [self refreshVisibleItemViewAppearance];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        NSInteger pageIndex;
        // 得到当前偏移位置的索引
        pageIndex = floor(scrollView.contentOffset.x / self.pageSize.width);
        if (self.delegate && [self.delegate respondsToSelector:@selector(coverFlowView:didScrollToPageAtIndex:)]) {
            [self.delegate coverFlowView:self didScrollToPageAtIndex:pageIndex];
        }
        self.currentPageIndex = pageIndex;
    }
}


#pragma mark - get

- (NSMutableArray *)itemPageViewArray {
    if (!_itemPageViewArray) {
        _itemPageViewArray = [NSMutableArray array];
    }
    return _itemPageViewArray;
}

- (NSMutableArray *)reusableitemPageViewArrays {
    if (!_reusableitemPageViewArray) {
        _reusableitemPageViewArray = [NSMutableArray array];
    }
    return _reusableitemPageViewArray;
}

@end
