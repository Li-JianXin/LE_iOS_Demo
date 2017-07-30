//
//  ILERCoverFlowView.h
//  coverFloawView_scrollView_demo
//
//  Created by jianxin.li on 16/4/15.
//  Copyright © 2016年 m6go.com. All rights reserved.
//


#import <UIKit/UIKit.h>

#define ScreenF [UIScreen mainScreen].bounds
#define ScreenW ScreenF.size.width
#define ScreenH ScreenF.size.height
#define RGBAColor(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:a]
#define RGBColor(r, g, b) MLGRGBAColor(r, g, b, 1)

@class ILERCoverFlowView;

@protocol ILERCoverFlowViewDelegate <NSObject>

@optional
/** 点击 */
- (void)coverFlowView:(ILERCoverFlowView *)coverFlowView didTapPageAtIndex:(NSInteger)index;
/** 滑动 */
- (void)coverFlowView:(ILERCoverFlowView *)coverFlowView didScrollToPageAtIndex:(NSInteger)index;

@end

@protocol ILERCoverFlowViewDataSource <NSObject>

/** 返回itemPage的大小 */
- (CGSize)sizeForPageInCoverFlowView:(ILERCoverFlowView *)coverFlowView;
@required
/** 返回显示View的个数 */
- (NSInteger)numberOfPagesInCoverFlowView:(ILERCoverFlowView *)coverFlowView;
/** 返回具体每一个itemView */
- (UIView *)coverFlowView:(ILERCoverFlowView *)coverFlowView itemViewForPageAtIndex:(NSInteger)index;

@end

@interface ILERCoverFlowView : UIView

@property (nonatomic, weak) id<ILERCoverFlowViewDelegate> delegate;
@property (nonatomic, weak) id<ILERCoverFlowViewDataSource> dataSource;
/** alpha值 默认1 */
@property (nonatomic, assign) CGFloat minimumPageAlpha;
/** page比例 默认1 */
@property (nonatomic, assign) CGFloat minimumPageScale;
/** PagingEnabled开关 */
@property (nonatomic, assign, getter=isNeedsPagingEnabled) BOOL needsPagingEnabled;
/** 当前页数 */
@property (nonatomic, assign) NSInteger currentPageIndex;

@end
