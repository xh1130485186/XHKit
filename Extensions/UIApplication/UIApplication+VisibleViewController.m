//
//  UIApplication+VisibleViewController.m
//  GrowthCompass
//
//  Created by 向洪 on 17/2/10.
//  Copyright © 2017年 向洪. All rights reserved.
//

#import "UIApplication+VisibleViewController.h"

@implementation UIApplication (VisibleViewController)

- (UIViewController *)getVisibleViewControllerFrom:(UIViewController *)vc {

    if ([vc isKindOfClass:[UINavigationController class]]) {

        return [self getVisibleViewControllerFrom:((UINavigationController *) vc).viewControllers.lastObject];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        
        return [self getVisibleViewControllerFrom:[((UITabBarController *) vc) selectedViewController]];
    } else {
        
        if (vc.presentedViewController) {
            
            return [self getVisibleViewControllerFrom:vc.presentedViewController];
        } else {
            
            return vc;
        }
    }
}

- (UIViewController *)visibleViewController {
    
    UIWindow *keyWindow = [[self delegate] window];
    if (keyWindow.windowLevel != UIWindowLevelNormal) {
        
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *window in windows) {
            
            if (window.windowLevel == UIWindowLevelNormal) {
                keyWindow = window;
                break;
            }
        }
    }
    
    UIViewController *rootViewController = keyWindow.rootViewController;
    return [self getVisibleViewControllerFrom:rootViewController];
}


@end
