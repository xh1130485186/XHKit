//
//  UIImage+XHResize.h
//  XHKitDemo
//
//  Created by 向洪 on 2017/5/27.
//  Copyright © 2017年 向洪. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 图片大小适配调整
 */
@interface UIImage (XHResize)

/**
 改变图片的大小获取一个新的图片

 @param image 原图
 @param newSize 新的大小
 @return 调整大小之后的图片
 */
+ (UIImage *)xh_resizeImage:(UIImage *)image withNewSize:(CGSize)newSize;
- (UIImage *)xh_resizeImageWithNewSize:(CGSize)size;

/**
 通过一个最大宽度获取图片等比大小（图片没有改变）

 @param maxWidth 宽度
 @return 调整后的图片大小
 */
- (CGSize)xh_scaleSizeWithMaxWidth:(CGFloat)maxWidth;

/**
 通过一个最大高度获取图片等比大小（图片没有改变）

 @param maxHeight 高度
 @return 调整后的图片大小
 */
- (CGSize)xh_scaleSizeWithMaxHeight:(CGFloat)maxHeight;

/**
 通过一个最大大小获取图片等比大小（图片没有改变）

 @param maxSize 大小
 @return 调整后的图片大小
 */
- (CGSize)xh_scaleSizeWithMaxSize:(CGSize)maxSize;

@end
