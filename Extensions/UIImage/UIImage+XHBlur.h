//
//  UIImage+XHBlur.h
//  XHKitDemo
//
//  Created by 向洪 on 2017/5/27.
//  Copyright © 2017年 向洪. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 基于vImage的图片模糊效果
 
 这个类基于 vImage 高效的算法运算 api 做图片模糊处理 ,
 参考 UIImage+ImageEffects。
 其他做 高斯模糊 库 的 Core Image、vImage、BlurEffect 。
 第三方 FXBlurView、GPUImage、UIImage+ImageEffects
 
 比较
 coreImage
 该方法实现的模糊效果较好，模糊程度的可调范围很大，可以根据实际的需求随意调试。缺点就是耗时，模拟器上跑需要1-2秒的时间，所有该方法需要放在子线程中执行。
 
 vImage
 该方法效率高，但是模糊效果不如coreImage
 
 BlurEffect 在视图上加一层遮罩，使用简单
 */
@interface UIImage (XHBlur)

- (UIImage *)xh_lightBlurImage;
- (UIImage *)xh_extraLightBlurImage;
- (UIImage *)xh_darkBlurImage;
- (UIImage *)xh_blurImage;
- (UIImage *)xh_tintedBlurImageWithColor:(UIColor *)tintColor;

- (UIImage *)xh_blurredImageWithRadius:(CGFloat)blurRadius;

- (UIImage *)xh_blurredImageWithRadius:(CGFloat)blurRadius
                           tintColor:(UIColor *)tintColor
               saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                           maskImage:(UIImage *)maskImage;


@end
