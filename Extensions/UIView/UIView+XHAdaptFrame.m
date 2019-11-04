//
//  UIView+XHAdaptFrame.m
//  环信Chat
//
//  Created by 向洪 on 16/10/24.
//  Copyright © 2016年 向洪. All rights reserved.
//

#import "UIView+XHAdaptFrame.h"

#define COMMON_STATEMENT_WITH_DIFFERENCE(STATEMENT) CGRect frame = self.frame;STATEMENT;self.frame = frame

@implementation UIView (XHAdaptFrame)

@dynamic xh_adapt_frame;
@dynamic xh_adapt_bounds;
@dynamic xh_adapt_vertical_frame;
@dynamic xh_adapt_vertical_bounds;
@dynamic xh_adapt_horizontal_frame;
@dynamic xh_adapt_horizontal_bounds;
@dynamic xh_adapt_center;
@dynamic xh_adapt_ratioX;
@dynamic xh_adapt_ratioY;
@dynamic xh_adapt_x;
@dynamic xh_adapt_y;
@dynamic xh_adapt_width;
@dynamic xh_adapt_height;
@dynamic xh_adapt_centerX;
@dynamic xh_adapt_centerY;

- (void)setXh_adapt_frame:(CGRect)xh_frame {
    COMMON_STATEMENT_WITH_DIFFERENCE(frame = flexibleFrame(xh_frame, 0));
}

- (void)setXh_adapt_bounds:(CGRect)xh_bounds {
    CGSize rectoTool = flexibleSize(xh_bounds.size, 0);
    self.bounds = CGRectMake(0, 0, rectoTool.width, rectoTool.height);
}

- (void)setXh_adapt_vertical_frame:(CGRect)xh_vertical_frame {
    COMMON_STATEMENT_WITH_DIFFERENCE(frame = flexibleFrame(xh_vertical_frame, 1));
}

- (void)setXh_adapt_vertical_bounds:(CGRect)xh_vertical_bounds {
    CGSize rectoTool = flexibleSize(xh_vertical_bounds.size, 1);
    self.bounds = CGRectMake(0, 0, rectoTool.width, rectoTool.height);
}

- (void)setXh_adapt_horizontal_frame:(CGRect)xh_adapt_horizontal_frame {

    COMMON_STATEMENT_WITH_DIFFERENCE(frame = flexibleFrameHeight(xh_adapt_horizontal_frame, 1));
}

- (void)setXh_adapt_horizontal_bounds:(CGRect)xh_adapt_horizontal_bounds {

    CGSize rectoTool = flexibleSizeHeight(xh_adapt_horizontal_bounds.size, 1);
    self.bounds = CGRectMake(0, 0, rectoTool.width, rectoTool.height);
}

- (void)setXh_adapt_center:(CGPoint)xh_center {
    self.center = flexibleCenter(xh_center);
}

- (void)setXh_adapt_x:(CGFloat)xh_adapt_x {
    COMMON_STATEMENT_WITH_DIFFERENCE(frame.origin.x = xh_adapt_x * VerticalRetio());
}

- (void)setXh_adapt_ratioY:(CGFloat)xh_adapt_ratioY {
    COMMON_STATEMENT_WITH_DIFFERENCE(frame.origin.x = xh_adapt_ratioY * HorizontalRetio());
}

- (void)setXh_adapt_width:(CGFloat)xh_adapt_width {
    COMMON_STATEMENT_WITH_DIFFERENCE(frame.size.width = xh_adapt_width * VerticalRetio());
}

- (void)setXh_adapt_height:(CGFloat)xh_adapt_height {
    COMMON_STATEMENT_WITH_DIFFERENCE(frame.size.height = xh_adapt_height * HorizontalRetio());
}

- (void)setXh_adapt_centerX:(CGFloat)xh_adapt_centerX {
    CGPoint center = self.center;
    center.x = xh_adapt_centerX * VerticalRetio();
    self.center = center;
}

- (void)setXh_adapt_centerY:(CGFloat)xh_adapt_centerY {
    CGPoint center = self.center;
    center.x = xh_adapt_centerY * HorizontalRetio();
    self.center = center;
}

- (CGFloat)xh_adapt_ratioX {
    return VerticalRetio();
}

- (CGFloat)xh_adapt_ratioY {
    return HorizontalRetio();
}


@end
