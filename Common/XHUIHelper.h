//
//  XHUIHelper.h
//  XHKitDemo
//
//  Created by 向洪 on 2017/8/11.
//  Copyright © 2017年 向洪. All rights reserved.
//

#import <UIKit/UIKit.h>

// 设备屏幕尺寸
#define IS_65INCH_SCREEN [XHUIHelper is65InchScreen]
#define IS_61INCH_SCREEN [XHUIHelper is65InchScreen]
#define IS_58INCH_SCREEN [XHUIHelper is58InchScreen]
#define IS_55INCH_SCREEN [XHUIHelper is55InchScreen]
#define IS_47INCH_SCREEN [XHUIHelper is47InchScreen]
#define IS_40INCH_SCREEN [XHUIHelper is40InchScreen]


@interface XHUIHelper : NSObject

#pragma mark - 屏幕种类
+ (BOOL)is65InchScreen;
+ (BOOL)is61InchScreen;
+ (BOOL)is58InchScreen;
+ (BOOL)is55InchScreen;
+ (BOOL)is47InchScreen;
+ (BOOL)is40InchScreen;

// iPhone XS Max, iPhone XR, iPhone XS, iPhone X
+ (BOOL)iPhoneXSerial;

// iPhone XS Max
+ (CGSize)screenSizeFor65Inch;
// iPhone XR
+ (CGSize)screenSizeFor61Inch;
// iPhone XS, iPhone X
+ (CGSize)screenSizeFor58Inch;
// iPhone 8(7,6(s)) Plus
+ (CGSize)screenSizeFor55Inch;
// iPhone 8(7,6(s))
+ (CGSize)screenSizeFor47Inch;
// iPhone 5(c,s), iPhone SE
+ (CGSize)screenSizeFor40Inch;



@end
