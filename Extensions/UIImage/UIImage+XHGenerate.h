//
//  UIImage+XHGenerate.h
//  XHKitDemo
//
//  Created by 向洪 on 2017/6/1.
//  Copyright © 2017年 向洪. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, XHUIImageBorderPosition) {
    XHUIImageBorderPositionAll      = 0,
    XHUIImageBorderPositionTop      = 1 << 0,
    XHUIImageBorderPositionLeft     = 1 << 1,
    XHUIImageBorderPositionBottom   = 1 << 2,
    XHUIImageBorderPositionRight    = 1 << 3,
};


/**
 关于Core Graphics： http://www.cocoachina.com/industry/20140115/7703.html
 关于Core Image http://www.tuicool.com/articles/nEFBru
 */
@interface UIImage (XHGenerate)

#pragma mark - 通过bundle创建图片
/**
 根据main bundle中的文件名读取图片
 
 @param name 图片名
 @return 无缓存的图片
 */
+ (UIImage *)xh_imageWithFileName:(NSString *)name;

/**
 根据指定bundle中的文件名读取图片
 
 @param name 图片名
 @param bundle bundle
 @return 无缓存的图片
 */
+ (UIImage *)xh_imageWithFileName:(NSString *)name inBundle:(NSBundle*)bundle;

#pragma mark - 通过CIImage创建图片
/**
 通过CIImage创建图片（ios自定生产的图片清晰度不够）

 @param ciImage CIImage
 @param size 大小
 @return 根据大小创建的图片
 */
+ (UIImage *)xh_imageWithCIImage:(CIImage *)ciImage size:(CGSize)size;

#pragma mark - GIF

/**
 通过名字创建gif图片

 @param name 名字
 @return gif图片
 */
+ (UIImage *)xh_animatedGIFNamed:(NSString *)name;

/**
 通过数据创建gif图片

 @param data 数据
 @return gif图片
 */
+ (UIImage *)xh_animatedGIFWithData:(NSData *)data;

#pragma mark - 遮罩重叠

/**
 给图片添加遮罩，返回遮罩
 
 @param maskImage 遮罩图片
 @param usingMaskImageMode 设置no，用一个纯CGImage作为mask。这个image必须是单色(例如：黑白色、灰色)、没有alpha通道、不能被其他图片mask。建议一般设置为yes
 @return 添加遮罩的图片
 */
- (UIImage *)xh_imageWithMaskImage:(UIImage *)maskImage usingMaskImageMode:(BOOL)usingMaskImageMode;

/**
 给图片叠加一张图片

 @param superpositionImage 叠加图片
 @param rect 叠加区域根据图片的尺寸来计算
 @return 叠加以后的图片
 */
- (UIImage *)xh_imageWithSuperpositionImage:(UIImage *)superpositionImage drawInRect:(CGRect)rect;

#pragma mark - 字符串图片

/**
 通过一段文字创建图片

 @param attributedString 文字
 @return 文字图片
 */
+ (UIImage *)xh_imageWithAttributedString:(NSAttributedString *)attributedString;

#pragma mark - 截图
/**
 对传进来的 `UIView` 截图，生成一个 `UIImage` 并返回。注意这里使用的是 view.layer 来渲染图片内容。UIView 的 transform 并不会在截图里生效

 @param view 要截图的 `UIView`
 @return 截图
 */
+ (UIImage *)xh_imageWithView:(UIView *)view;

/**
 对传进来的 `UIView` 截图，生成一个 `UIImage` 并返回。注意这里使用的是 iOS 7的系统截图接口。UIView 的 transform 并不会在截图里生效。界面要已经render完，否则截到得图将会是empty

 @param view 要截图的 `UIView`
 @param afterUpdates 是否要在界面更新完成后才截图
 @return 截图
 */
+ (UIImage *)xh_imageWithView:(UIView *)view afterScreenUpdates:(BOOL)afterUpdates;

#pragma mark - 裁剪
/**
 根据图片的分辨率裁剪图片
 
 @param radius 圆角
 @return 裁剪过后的图片
 */
- (UIImage *)xh_cropImageWithCornerRadius:(CGFloat)radius;
/**
 根据图片的分辨率裁剪图片

 @param rect 位置
 @return 裁剪过后的图片
 */
- (UIImage *)xh_cropImageWithLocation:(CGRect)rect;

/**
 根据图片的分辨率裁剪图片,可以设置圆角

 @param rect 位置
 @param radius 圆角
 @return 裁剪过后的图片
 */
- (UIImage *)xh_cropImageWithLocation:(CGRect)rect cornerRadius:(CGFloat)radius;

/**
 根据图片的分辨率裁剪图片,可以设置bezierPath

 @param rect 位置
 @param bezierPath UIBezierPath
 @return 裁剪过后的图片
 */
- (UIImage *)xh_cropImageWithLocation:(CGRect)rect bezierPath:(UIBezierPath *)bezierPath;

/**
 根据显示的像素来裁剪图片

 @param displayFrame 显示的大小
 @param contentMode 显示的模式
 @param rect 裁剪位置
 @return 裁剪过后的图片
 */
- (UIImage *)xh_cropImageWithDisplayFrame:(CGRect)displayFrame contentMode:(UIViewContentMode)contentMode location:(CGRect)rect;

/**
 根据显示的像素来裁剪图片，可以设置圆角

 @param displayFrame 显示的大小
 @param contentMode 显示的模式
 @param rect 裁剪位置
 @param radius 圆角
 @return 裁剪过后的图片
 */
- (UIImage *)xh_cropImageWithDisplayFrame:(CGRect)displayFrame contentMode:(UIViewContentMode)contentMode location:(CGRect)rect cornerRadius:(CGFloat)radius;

#pragma mark - 边框

/**
 根据当前图片创建一个带边框的图片

 @param borderColor 边框颜色
 @param borderWidth 边框宽度（更图片的分辨率有关）
 @return 带边框的图片
 */
- (UIImage *)xh_imageWithBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

/**
 根据当前图片创建一个带边框的图片

 @param borderColor 边框颜色
 @param borderWidth 边框宽度（更图片的分辨率有关）
 @param cornerRadius 边框圆角
 @return 带边框的图片
 */
- (UIImage *)xh_imageWithBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius;

/**
 根据当前图片创建一个带边框的图片

 @param borderColor 边框颜色
 @param borderWidth 边框宽度（更图片的分辨率有关）
 @param borderPosition 边框生成位置
 @return 带边框的图片
 */
- (UIImage *)xh_imageWithBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth borderPosition:(XHUIImageBorderPosition)borderPosition;


@end
