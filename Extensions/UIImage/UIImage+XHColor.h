//
//  UIImage+XHColor.h
//  XHKitDemo
//
//  Created by 向洪 on 2017/5/27.
//  Copyright © 2017年 向洪. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 图片的颜色相关处理
 */
@interface UIImage (XHColor)

#pragma mark - 通过颜色创建图片
/**
 根据颜色生成纯色图片

 @param color 颜色
 @return 纯色图片
 */
+ (UIImage *)xh_imageWithColor:(UIColor *)color;

/**
 根据颜色和大小生成纯色图片

 @param color 颜色
 @param size 大小
 @return 纯色图片
 */
+ (UIImage *)xh_imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 根据颜色、大小和圆角生成纯色图片

 @param color 颜色
 @param size 大小
 @param cornerRadius 圆角
 @return 纯色图片
 */
+ (UIImage *)xh_imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius;
+ (UIImage *)xh_imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius roundedCorners:(UIRectCorner)corners;

#pragma mark - 其他
/**
 判断一张图是否不存在 alpha 通道，注意 “不存在 alpha 通道” 不等价于 “不透明”。一张不透明的图有可能是存在 alpha 通道但 alpha 值为 1。

 @return yes 表示没有,
 */
- (BOOL)xh_opaque;

/**
 获取图片均色 原理是将图片绘制到1px*1px的矩形内，再从当前区域取色，得到图片的均色。

 @return 代表图片平均颜色的UIColor对象
 */
- (UIColor *)xh_averageColor;

/**
 获取当前图片得到灰色图片

 @return 已经置灰的图片
 */
- (UIImage *)xh_grayImage;

/**
 改变图片主调颜色

 @param tintColor 要用于渲染的新颜色
 @return 与当前图片形状一致但颜色与参数tintColor相同的新图片
 */
- (UIImage *)xh_imageWithTintColor:(UIColor *)tintColor;

#pragma mark - 渐变

/**
 创建渐变

 @param startColor 开始颜色
 @param endColor 结束颜色
 @param startPoint 开始位置
 @param endPoint 结束位置
 @param size 大小
 @return 图片
 */
+ (UIImage *)xh_imageWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint size:(CGSize)size;

/**
 创建渐变

 @param colors 颜色空间
 @param loctions 变换位置
 @param startPoint 开始位置
 @param endPoint 结束位置
 @param size 大小
 @return 图片
 */
+ (UIImage *)xh_imageWithColors:(NSArray<UIColor *> *)colors loctions:(NSArray *)loctions startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint size:(CGSize)size;

- (UIImage *)xh_imageWithColors:(NSArray<UIColor *> *)colors loctions:(NSArray *)loctions startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

@end
