//
//  UIView+XHRect.m
//  环信Chat
//
//  Created by 向洪 on 16/10/24.
//  Copyright © 2016年 向洪. All rights reserved.
//

#import "UIView+XHRect.h"

#define COMMON_STATEMENT_WITH_DIFFERENCE(STATEMENT) CGRect frame = self.frame;STATEMENT;self.frame = frame

@implementation UIView (XHRect)

- (CGFloat)xh_x {
    return self.frame.origin.x;
}

- (void)setXh_x:(CGFloat)xh_x {
    COMMON_STATEMENT_WITH_DIFFERENCE(frame.origin.x = xh_x);
}

- (CGFloat)xh_y {
    return self.frame.origin.y;
}

- (void)setXh_y:(CGFloat)xh_y {
    COMMON_STATEMENT_WITH_DIFFERENCE(frame.origin.y = xh_y);
}

- (CGFloat)xh_width {
    return self.frame.size.width;
}

- (void)setXh_width:(CGFloat)xh_width {
    COMMON_STATEMENT_WITH_DIFFERENCE(frame.size.width = xh_width);
}

- (CGFloat)xh_height {
    return self.frame.size.height;
}

- (void)setXh_height:(CGFloat)xh_height {
    COMMON_STATEMENT_WITH_DIFFERENCE(frame.size.height = xh_height);
}

- (CGFloat)xh_centerX {
    return self.center.x;
}

- (void)setXh_centerX:(CGFloat)xh_centerX {
    CGPoint center = self.center;
    center.x = xh_centerX;
    self.center = center;
}

- (CGFloat)xh_centerY {
    return self.center.y;
}

- (void)setXh_centerY:(CGFloat)xh_centerY {
    CGPoint center = self.center;
    center.y = xh_centerY;
    self.center = center;
}

- (void)setXh_top:(CGFloat)xh_top {
    COMMON_STATEMENT_WITH_DIFFERENCE(frame.origin.y = xh_top);
}

- (CGFloat)xh_top {
    return self.frame.origin.y;
}

- (void)setXh_bottom:(CGFloat)xh_bottom {
    COMMON_STATEMENT_WITH_DIFFERENCE(frame.origin.y = xh_bottom - frame.size.height);
}

- (CGFloat)xh_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setXh_right:(CGFloat)xh_right {
    COMMON_STATEMENT_WITH_DIFFERENCE(frame.origin.x = xh_right - frame.size.width);
}

- (CGFloat)xh_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setXh_left:(CGFloat)xh_left {
    COMMON_STATEMENT_WITH_DIFFERENCE(frame.origin.x = xh_left);
}

- (CGFloat)xh_left {
    return self.frame.origin.x;
}

- (void)setXh_origin:(CGPoint)xh_origin {
    COMMON_STATEMENT_WITH_DIFFERENCE(frame.origin = xh_origin);
}

- (CGPoint)xh_origin {
    return self.frame.origin;
}

- (void)setXh_size:(CGSize)xh_size {
    COMMON_STATEMENT_WITH_DIFFERENCE(frame.size = xh_size);
}

- (CGSize)xh_size {
    return self.frame.size;
}

@end
