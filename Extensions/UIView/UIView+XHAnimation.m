//
//  UIView+XHAnimation.m
//  BSGrowthViewing
//
//  Created by 向洪 on 2017/8/15.
//  Copyright © 2017年 向洪. All rights reserved.
//

#import "UIView+XHAnimation.h"

@implementation UIView (XHAnimation)

+ (void)xh_oscillatoryAnimationWithLayer:(CALayer *)layer type:(XHOscillatoryAnimationType)type {

    NSNumber *animationScale1 = type == XHOscillatoryAnimationToBigger ? @(1.15) : @(0.5);
    NSNumber *animationScale2 = type == XHOscillatoryAnimationToBigger ? @(0.92) : @(1.15);
    
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
        [layer setValue:animationScale1 forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
            [layer setValue:animationScale2 forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
                [layer setValue:@(1.0) forKeyPath:@"transform.scale"];
            } completion:nil];
        }];
    }];
    
}

@end
