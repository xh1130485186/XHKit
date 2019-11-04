//
//  NSObject+XHScrollDirection.h
//  XHKitDemo
//
//  Created by 向洪 on 2019/8/27.
//  Copyright © 2019 向洪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    XHScrollDirectionNo,   // 没有滑动
    XHScrollDirectionDown, // 下滑动
    XHScrollDirectionUP,   // 上滑动
} XHScrollDirection;


/**
 对当前类进行扩展，添加支持动态计算滑动方向
 如果需要使用，需要当前类遵守UIScrollViewDelegate。
 这个扩展，默认使用了UIScrollViewDelegate的一些方法，如果在使用的时候，需要在外部使用这些方法，需要另外处理。否则会失效。
 
 目前只支持手动的滑动，以及代码控制带动画的滑动。没有动画的滑动，会使xh_scrollDirection不准确。
 比如使用：
 - (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated;
 - (void)scrollRectToVisible:(CGRect)rect animated:(BOOL)animated;
 animated为no的情况下；
 以及：scrollView.contentOffset = CGPointMake(0, 0);
 
 */
@interface NSObject (XHScrollDirection)

@property (nonatomic, assign) CGFloat xh_oldContentOffsetY; //
@property (nonatomic, assign) XHScrollDirection xh_scrollDirection;  // 当前滑动方向

// 这个扩展，默认使用了UIScrollViewDelegate的一些方法，如果在使用的时候，需要在外部使用这些方法，需要在方法中添加如下：
- (void)xh_scrollViewWillBeginDragging:(UIScrollView *)scrollView;  //  - (void)scrollViewWillBeginDragging:
- (void)xh_scrollViewDidScroll:(UIScrollView *)scrollView;  //  - (void)scrollViewDidScroll:
- (void)xh_scrollViewDidEndDecelerating:(UIScrollView *)scrollView;  //  - (void)scrollViewDidEndDecelerating:
- (void)xh_scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;  //  - (void)scrollViewDidEndDragging:willDecelerate:
- (void)xh_scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;  //  - (void)xh_scrollViewDidEndScrollingAnimation:

@end

NS_ASSUME_NONNULL_END
