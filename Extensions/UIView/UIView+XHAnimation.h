//
//  UIView+XHAnimation.h
//  BSGrowthViewing
//
//  Created by 向洪 on 2017/8/15.
//  Copyright © 2017年 向洪. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    
    XHOscillatoryAnimationToBigger,
    XHOscillatoryAnimationToSmaller,
} XHOscillatoryAnimationType;

/**
 动画扩展
 */
@interface UIView (XHAnimation)

+ (void)xh_oscillatoryAnimationWithLayer:(CALayer *)layer type:(XHOscillatoryAnimationType)type;

@end
