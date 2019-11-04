//
//  XHUICommonViewController.h
//  BSGrowthViewing
//
//  Created by 向洪 on 2017/8/11.
//  Copyright © 2017年 向洪. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XHUICommonDefines.h"
#import "UIScrollView+EmptyDataSet.h"
//#import "QMUIEmptyView.h"

@interface XHUICommonViewController : UIViewController <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

// 基本调用的方法，方便操作
- (void)initializedAppearance;

#pragma mark - 导航栏，左侧按钮返回事件
/**
 导航栏，左侧按钮返回事件，重写这个方法来，自定义返回
 这个方法没有禁止左侧右滑返回，需要在设置interactivePopGestureRecognizerEnabled为no
 
 
 @return 返回no，不会自动pop，返回yes会自动pop
 */
- (BOOL)navigationShouldPopOnBackBarButtonItemEvent;
@property (nonatomic) BOOL interactivePopGestureRecognizerEnabled; // 禁用左侧右滑返回，yes为启动，no为禁用，默认为yes

#pragma mark - 标题左部活动指示器
// 标题左部活动指示器
@property (nonatomic, strong) UIActivityIndicatorView *topActivityIndicatorView;
- (void)topActivityIndicatorStartAnimating;  // 标题左部活动指示器开始动画
- (void)topActivityIndicatorStopAnimating;   // 标题左部活动指示器停止动画

#pragma mark - 空数据
// 空数据，会自动判断通过协议去判断UIScrollView对应的UITableView,UICollectionView的数据是否为空，为nil会显示，不能nil就不会显示。每次刷新的数据时候如果需要显示需要重新调用这个方法。或者这个UIScrollView可以自己设置emptyDataSetSource,emptyDataSetDelegate,然后设置isShowEmptyView为yes，调用reloadEmptyDataSet方法也可以显示。
- (void)showEmptyView:(UIScrollView *)view;
// 如果设置了noDataBtnTitle，重新这个方法可以在按钮点击的时候触发
- (void)noDatabuttonEvent:(UIScrollView *)scrollView;

@end
