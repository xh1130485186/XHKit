//
//  UIView+XHRect.h
//  环信Chat
//
//  Created by 向洪 on 16/10/24.
//  Copyright © 2016年 向洪. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 适配
 */
@interface UIView (XHRect)

@property (nonatomic, assign) CGFloat xh_left;
@property (nonatomic, assign) CGFloat xh_top;
@property (nonatomic, assign) CGFloat xh_right;
@property (nonatomic, assign) CGFloat xh_bottom;
@property (nonatomic, assign) CGPoint xh_origin;
@property (nonatomic, assign) CGSize  xh_size;
@property (nonatomic, assign) CGFloat xh_x;
@property (nonatomic, assign) CGFloat xh_y;
@property (nonatomic, assign) CGFloat xh_width;
@property (nonatomic, assign) CGFloat xh_height;
@property (nonatomic, assign) CGFloat xh_centerX;
@property (nonatomic, assign) CGFloat xh_centerY;

@end
