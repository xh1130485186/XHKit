//
//  UIColor+XHExtension.h
//  XHKitDemo
//
//  Created by 向洪 on 2017/5/23.
//  Copyright © 2017年 向洪. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 颜色处理：包括创建，16进制创建，获取当前rgb等的值，随机颜色，去除alpha，获取当前颜色的反色，颜色从一个颜色变化到另一个颜色。
 */
@interface UIColor (XHExtension)

#pragma mark - 颜色创建

// 通过0-255整数构造UIColor
+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha;
+ (UIColor *)colorWithIntRed:(UInt32)red intGreen:(UInt32)green intBlue:(UInt32)blue alpha:(CGFloat)alpha;
+ (UIColor *)colorWithIntRed:(UInt32)red intGreen:(UInt32)green intBlue:(UInt32)blue;

/**
 通过16进制构造UIColor

 @param color color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 @param alpha 通道
 @return UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexString:(NSString *)color;

#pragma mark - 获取颜色属性

- (NSString *)xh_hexString; // 获取16进制颜色字符串值
- (CGFloat)xh_red;          // 红色色值，值范围为0.0-1.0
- (CGFloat)xh_green;        // 绿色色值，
- (CGFloat)xh_blue;         // 蓝色色值
- (CGFloat)xh_alpha;        // 透明通道
- (CGFloat)xh_hue;          // 色相值
- (CGFloat)xh_saturation;   // 饱和度
- (CGFloat)xh_brightness;   // 亮度

#pragma mark - 其他

// 去除Alpha通道
- (UIColor *)xh_colorWithoutAlpha;
// 取当前颜色的反色
- (UIColor *)xh_inverseColor;
// 获取系统颜色值
+ (UIColor *)xh_systemTintColor;
// 获取一个随机颜色
+ (UIColor *)xh_randomColor;

#pragma mark - 颜色变化
/**
 将自身变化到某个目标颜色，可通过参数progress控制变化的程度，最终得到一个纯色
 
 @param toColor 目标颜色
 @param progress 变化程度，取值范围0.0f~1.0f
 @return 计算之后的颜色
 */
- (UIColor *)xh_transitionToColor:(UIColor *)toColor progress:(CGFloat)progress;
// 将颜色A变化到颜色B，可通过progress控制变化的程度
+ (UIColor *)xh_colorFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor progress:(CGFloat)progress;

#pragma mark - 颜色叠加

/**
 计算当前color叠加了alpha之后放在指定颜色的背景上的色值

 @param alpha 通道
 @param backgroundColor 叠加背景颜色
 @return 计算之后的颜色
 */
- (UIColor *)xh_colorWithAlpha:(CGFloat)alpha backgroundColor:(UIColor *)backgroundColor;
// 计算当前color叠加了alpha之后放在白色背景上的色值
- (UIColor *)xh_colorWithAlphaAddedToWhite:(CGFloat)alpha;

/**
 计算两个颜色叠加之后的最终色（注意区分前景色后景色的顺序）

 @param backendColor 后景色
 @param frontColor 前景色
 @return 叠加之后的颜色
 */
+ (UIColor *)xh_colorWithBackendColor:(UIColor *)backendColor frontColor:(UIColor *)frontColor;

#pragma mark - 颜色值

// System Colors
+ (instancetype)infoBlueColor;
+ (instancetype)successColor;
+ (instancetype)warningColor;
+ (instancetype)dangerColor;

// Whites
+ (instancetype)antiqueWhiteColor;
+ (instancetype)oldLaceColor;
+ (instancetype)ivoryColor;
+ (instancetype)seashellColor;
+ (instancetype)ghostWhiteColor;
+ (instancetype)snowColor;
+ (instancetype)linenColor;

// Grays
+ (instancetype)black25PercentColor;
+ (instancetype)black50PercentColor;
+ (instancetype)black75PercentColor;
+ (instancetype)warmGrayColor;
+ (instancetype)coolGrayColor;
+ (instancetype)charcoalColor;

// Blues
+ (instancetype)tealColor;
+ (instancetype)steelBlueColor;
+ (instancetype)robinEggColor;
+ (instancetype)pastelBlueColor;
+ (instancetype)turquoiseColor;
+ (instancetype)skyBlueColor;
+ (instancetype)indigoColor;
+ (instancetype)denimColor;
+ (instancetype)blueberryColor;
+ (instancetype)cornflowerColor;
+ (instancetype)babyBlueColor;
+ (instancetype)midnightBlueColor;
+ (instancetype)fadedBlueColor;
+ (instancetype)icebergColor;
+ (instancetype)waveColor;

// Greens
+ (instancetype)emeraldColor;
+ (instancetype)grassColor;
+ (instancetype)pastelGreenColor;
+ (instancetype)seafoamColor;
+ (instancetype)paleGreenColor;
+ (instancetype)cactusGreenColor;
+ (instancetype)chartreuseColor;
+ (instancetype)hollyGreenColor;
+ (instancetype)oliveColor;
+ (instancetype)oliveDrabColor;
+ (instancetype)moneyGreenColor;
+ (instancetype)honeydewColor;
+ (instancetype)limeColor;
+ (instancetype)cardTableColor;

// Reds
+ (instancetype)salmonColor;
+ (instancetype)brickRedColor;
+ (instancetype)easterPinkColor;
+ (instancetype)grapefruitColor;
+ (instancetype)pinkColor;
+ (instancetype)indianRedColor;
+ (instancetype)strawberryColor;
+ (instancetype)coralColor;
+ (instancetype)maroonColor;
+ (instancetype)watermelonColor;
+ (instancetype)tomatoColor;
+ (instancetype)pinkLipstickColor;
+ (instancetype)paleRoseColor;
+ (instancetype)crimsonColor;

// Purples
+ (instancetype)eggplantColor;
+ (instancetype)pastelPurpleColor;
+ (instancetype)palePurpleColor;
+ (instancetype)coolPurpleColor;
+ (instancetype)violetColor;
+ (instancetype)plumColor;
+ (instancetype)lavenderColor;
+ (instancetype)raspberryColor;
+ (instancetype)fuschiaColor;
+ (instancetype)grapeColor;
+ (instancetype)periwinkleColor;
+ (instancetype)orchidColor;

// Yellows
+ (instancetype)goldenrodColor;
+ (instancetype)yellowGreenColor;
+ (instancetype)bananaColor;
+ (instancetype)mustardColor;
+ (instancetype)buttermilkColor;
+ (instancetype)goldColor;
+ (instancetype)creamColor;
+ (instancetype)lightCreamColor;
+ (instancetype)wheatColor;
+ (instancetype)beigeColor;

// Oranges
+ (instancetype)peachColor;
+ (instancetype)burntOrangeColor;
+ (instancetype)pastelOrangeColor;
+ (instancetype)cantaloupeColor;
+ (instancetype)carrotColor;
+ (instancetype)mandarinColor;

// Browns
+ (instancetype)chiliPowderColor;
+ (instancetype)burntSiennaColor;
+ (instancetype)chocolateColor;
+ (instancetype)coffeeColor;
+ (instancetype)cinnamonColor;
+ (instancetype)almondColor;
+ (instancetype)eggshellColor;
+ (instancetype)sandColor;
+ (instancetype)mudColor;
+ (instancetype)siennaColor;
+ (instancetype)dustColor;


@end
