//
//  XHUICommonDefines.h
//  XHKitDemo
//
//  Created by 向洪 on 2017/8/11.
//  Copyright © 2017年 向洪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHUIHelper.h"
#import "XHCommonDefines.h"

// 操作系统版本号
#define IOS_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])
// 判断操作系统版本号大于等于一个值
#define IOS_DEVICE_VERSION_FLOATVALUE(version_floatValue) [[[UIDevice currentDevice] systemVersion] floatValue] >= version_floatValue

#pragma mark - 布局相关

// 用户界面横屏了才会返回YES
#define IS_LANDSCAPE UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])

// 屏幕宽度，会根据横竖屏的变化而变化
#define SCREEN_WIDTH CGRectGetWidth([[UIScreen mainScreen] bounds])

// 屏幕高度，会根据横竖屏的变化而变化
#define SCREEN_HEIGHT CGRectGetHeight([[UIScreen mainScreen] bounds])

// 屏幕宽度，跟横竖屏无关
#define DEVICE_WIDTH (IS_LANDSCAPE ? SCREEN_HEIGHT : SCREEN_WIDTH)

// 屏幕高度，跟横竖屏无关
#define DEVICE_HEIGHT (IS_LANDSCAPE ? SCREEN_WIDTH : SCREEN_HEIGHT)

// 是否是 iPhoneX 系列屏幕
#define is_iPhoneXSerial [XHUIHelper iPhoneXSerial]

#define UIStatusBarHeightAdapter CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame])
#define UIStatusBarHeight (is_iPhoneXSerial?44:20)

// navigationBar相关frame
#define UINavigationBarHeightAdapter CGRectGetHeight(self.navigationController.navigationBar.frame)
#define UINavTopHeightAdapter CGRectGetMaxY(self.navigationController.navigationBar.frame)
#define UINavTopHeight (is_iPhoneXSerial?88:64) // 一般的竖屏情况下，顶部的高度

// tabbar 相关
#define UITabBarHeightAdapter CGRectGetHeight(self.tabBarController.tabBar.frame)
#define UITabBarHeight (is_iPhoneXSerial?83:49) // 一般的竖屏情况下高度

// UIColor相关创建器
#define rgba(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

// 动画相关
// 底部弹出动画 时间取0.25效果最佳
#define XHUIViewAnimationOptionsCurveIn (7<<16)
#define XHUIViewAnimationOptionsCurveOut (8<<16)

// 图片
#define XHKitImage(name) [UIImage imageWithContentsOfFile:XHBundlePathForResource(@"xhkit", NSClassFromString(@"XHUICommonViewController"), name, @"png", 1)]

XH_INLINE UIWindow *KeyWindow() {
    UIWindow *window;
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                window = windowScene.windows.firstObject;
                break;
            }
        }
    } else{
        window = [UIApplication sharedApplication].keyWindow;
    }
    return window;
}

