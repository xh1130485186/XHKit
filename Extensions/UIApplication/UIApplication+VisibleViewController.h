//
//  UIApplication+VisibleViewController.h
//  GrowthCompass
//
//  Created by 向洪 on 17/2/10.
//  Copyright © 2017年 向洪. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 获取当前的显示的视图控制器
 */
@interface UIApplication (VisibleViewController)

- (UIViewController *)visibleViewController;

@end
