//
//  NSObject+XHScrollDirection.m
//  XHKitDemo
//
//  Created by 向洪 on 2019/8/27.
//  Copyright © 2019 向洪. All rights reserved.
//

#import "NSObject+XHScrollDirection.h"
#import <objc/runtime.h>

@implementation NSObject (XHScrollDirection)

#pragma mark - 属性

- (void)setXh_oldContentOffsetY:(CGFloat)xh_oldContentOffsetY {
    objc_setAssociatedObject(self, @"xh_oldContentOffsetY", @(xh_oldContentOffsetY), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)xh_oldContentOffsetY {
    return [objc_getAssociatedObject(self, @"xh_oldContentOffsetY") doubleValue];
}

- (void)setXh_scrollDirection:(XHScrollDirection)xh_scrollDirection {
    objc_setAssociatedObject(self, @"xh_scrollDirection", @(xh_scrollDirection), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (XHScrollDirection)xh_scrollDirection {
    return [objc_getAssociatedObject(self, @"xh_scrollDirection") integerValue];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self xh_scrollViewWillBeginDragging:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self xh_scrollViewDidScroll:scrollView];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self xh_scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self xh_scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self xh_scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark - 计算

- (void)xh_scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.xh_oldContentOffsetY = scrollView.contentOffset.y;
}

- (void)xh_scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.xh_oldContentOffsetY > scrollView.contentOffset.y) {
        self.xh_scrollDirection = XHScrollDirectionUP;
    } else if (self.xh_oldContentOffsetY < scrollView.contentOffset.y) {
        self.xh_scrollDirection = XHScrollDirectionDown;
    } else {
        self.xh_scrollDirection = XHScrollDirectionNo;
    }
    self.xh_scrollDirection = scrollView.contentOffset.y;
}

- (void)xh_scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.xh_scrollDirection = XHScrollDirectionNo;
}

- (void)xh_scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        self.xh_scrollDirection = XHScrollDirectionNo;
    }
}

- (void)xh_scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    self.xh_scrollDirection = XHScrollDirectionNo;
}

@end
