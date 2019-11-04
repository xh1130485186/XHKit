//
//  UIView+XHAdaptFrame.h
//  环信Chat
//
//  Created by 向洪 on 16/10/24.
//  Copyright © 2016年 向洪. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Header_AdaptScreen.h"

/**
 适配
 */
@interface UIView (XHAdaptFrame)

//以水平和竖直2个的比例分别来适配
@property(nonatomic, assign, readwrite) CGRect xh_adapt_frame;
@property(nonatomic, assign, readwrite) CGRect xh_adapt_bounds;

//竖直的比例来适配高与宽
@property(nonatomic, assign, readwrite) CGRect xh_adapt_vertical_frame;
@property(nonatomic, assign, readwrite) CGRect xh_adapt_vertical_bounds;
@property(nonatomic, assign, readwrite) CGRect xh_adapt_horizontal_frame;
@property(nonatomic, assign, readwrite) CGRect xh_adapt_horizontal_bounds;

@property(nonatomic, assign, readwrite) CGPoint xh_adapt_center;

@property(nonatomic, assign, readwrite) CGFloat xh_adapt_x;
@property(nonatomic, assign, readwrite) CGFloat xh_adapt_y;
@property(nonatomic, assign, readwrite) CGFloat xh_adapt_width;
@property(nonatomic, assign, readwrite) CGFloat xh_adapt_height;
@property(nonatomic, assign, readwrite) CGFloat xh_adapt_centerX;
@property(nonatomic, assign, readwrite) CGFloat xh_adapt_centerY;

//水平比例
@property(nonatomic, assign, readonly) CGFloat xh_adapt_ratioX;
//竖直比例
@property(nonatomic, assign, readonly) CGFloat xh_adapt_ratioY;

@end
