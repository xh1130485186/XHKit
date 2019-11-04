//
//  XHContainer.h
//  BSGrowthViewing
//
//  Created by 向洪 on 2017/8/15.
//  Copyright © 2017年 向洪. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XHContainerStyle) {
    XHContainerCenter,   /* 居中 */
    XHContainerBottom,   /* 底部 */
};

/**
 容器控制视图，提供视图的弹出控制
 */
@interface XHContainerControl : UIView

/**
 初始化 (高度设置最好大于300.0)
 
 @param size 显示视图带大小。XHContainerBottom样式下视图的宽度强制和displayView一致
 @param style 样式
 @return XHContainer
 */
- (instancetype)initWithSize:(CGSize)size style:(XHContainerStyle)style;

// 显示，隐藏
- (void)show;
- (void)show:(UIView *)displayView;
- (void)hide;
@property (nonatomic, copy) void(^hiddenProcessingHandler)(void);

/**
 样式，控制显示的位置
 XHContainerBottom设置的宽度为屏幕的宽度。其他设置宽度会无效
 */
@property (nonatomic, assign) XHContainerStyle style;

/**
 是否隐藏遮罩， 默认为no
 */
@property (nonatomic, assign) BOOL isHideMask;


@property (nonatomic, strong, readonly) UIVisualEffectView *effectView; // 高斯模糊

@end
