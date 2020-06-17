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

// UIColor相关创建器
#define rgba(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define hsla(h, s, b, a) [UIColor colorWithHue:h saturation:s brightness:b alpha:a]
#define colorHex(color) colorHexAlpha(color, 1)
XH_INLINE UIColor *colorHexAlpha(NSString *color, CGFloat alpha) {
    
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    
    if ([cString length] != 6) {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];

    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

