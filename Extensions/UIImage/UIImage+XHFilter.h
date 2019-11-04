//
//  UIImage+XHFilter.h
//  XHKitDemo
//
//  Created by 向洪 on 2017/6/1.
//  Copyright © 2017年 向洪. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 目前实现了高斯模糊，条形码和二维码条形码的获取。
 */
@interface UIImage (XHFilter)

#pragma mark - core image 高斯模糊
/**
 https://developer.apple.com/library/content/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/uid/TP30000136-SW29
 高斯模糊 CICategoryBlur CIGaussianBlur
 
 @param completionHandler 返回处理后的图片
 */
- (void)xh_gaussianBlurFilterImageWithCompletionHandler:(void(^)(UIImage *filterImage))completionHandler;

/**
 高斯模糊 CICategoryBlur CIGaussianBlur

 @param radius 模糊值
 @param completionHandler 返回处理后的图片
 */
- (void)xh_gaussianBlurFilterImageWithRadius:(CGFloat)radius completionHandler:(void(^)(UIImage *filterImage))completionHandler;

#pragma mark - 二维码
/**
 CICategoryGenerator CIQRCodeGenerator

 @param data 字符串数据
 @param width 图片宽度
 @return 二维码图片
 */
+ (UIImage *)xh_generateWithQRCodeData:(NSString *)data width:(CGFloat)width;

/**
 生成一张带有logo的二维码

 @param data 字符串数据
 @param width 二维码图片宽度
 @param logoImageName logo图片名字
 @param logoWidth logo显示宽度
 @return 二维码图片
 */
+ (UIImage *)xh_generateWithLogoQRCodeData:(NSString *)data width:(CGFloat)width logoImageName:(NSString *)logoImageName logoWidth:(CGFloat)logoWidth;

#pragma mark - 条形码
/**
 条形码创建

 @param data 数据
 @param width 长
 @return 条形码图片
 */
+ (UIImage *)xh_generateWith128BarcodeData:(NSString *)data width:(CGFloat)width;

#pragma mark - 玻璃变形
//
///**
// 玻璃变形效果 CIGlassDistortion
//
// @param textureImage 纹理输入图片,传nil时根据自己的纹理生成
// @param completion 变形之后的效果
// */
//- (void)xh_glassDistortionFilterImageWithTextureImage:(UIImage *)textureImage completion:(void(^)(UIImage *filterImage))completion;

@end
