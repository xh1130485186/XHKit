//
//  UIImage+XHColor.m
//  XHKitDemo
//
//  Created by 向洪 on 2017/5/27.
//  Copyright © 2017年 向洪. All rights reserved.
//

#import "UIImage+XHColor.h"
#import "UIColor+XHExtension.h"

@implementation UIImage (XHColor)

#pragma mark - 通过颜色创建图片
+ (UIImage *)xh_imageWithColor:(UIColor *)color {

    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    return [self xh_imageWithColor:color size:rect.size];
    
}

+ (UIImage *)xh_imageWithColor:(UIColor *)color size:(CGSize)size {

    
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, 0, [UIScreen mainScreen].scale);;
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}

+ (UIImage *)xh_imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, 0, [UIScreen mainScreen].scale);;
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    if (cornerRadius > 0) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
        [path addClip];
        [path fill];
    } else {
        CGContextFillRect(context, rect);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)xh_imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius roundedCorners:(UIRectCorner)corners {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, 0, [UIScreen mainScreen].scale);;
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    if (cornerRadius > 0) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        [path addClip];
        [path fill];
    } else {
        CGContextFillRect(context, rect);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
#pragma mark - 其他
- (BOOL)xh_opaque {

    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(self.CGImage);
    BOOL opaque = (alphaInfo == kCGImageAlphaNoneSkipLast
    || alphaInfo == kCGImageAlphaNoneSkipFirst
    || alphaInfo == kCGImageAlphaNone);
    return opaque;
}


- (UIColor *)xh_averageColor {
    
    unsigned char rgba[4] = {};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    if (!context) {
        
        CGColorSpaceRelease(colorSpace);
        CGContextRelease(context);
        return nil;
    } else {
    
        CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), self.CGImage);
        CGColorSpaceRelease(colorSpace);
        CGContextRelease(context);
        if(rgba[3] > 0) {
            return [UIColor colorWithRed:((CGFloat)rgba[0] / rgba[3])
                                   green:((CGFloat)rgba[1] / rgba[3])
                                    blue:((CGFloat)rgba[2] / rgba[3])
                                   alpha:((CGFloat)rgba[3] / 255.0)];
        } else {
            return [UIColor colorWithRed:((CGFloat)rgba[0]) / 255.0
                                   green:((CGFloat)rgba[1]) / 255.0
                                    blue:((CGFloat)rgba[2]) / 255.0
                                   alpha:((CGFloat)rgba[3]) / 255.0];
        }
    }
}

- (UIImage *)xh_grayImage {


    // CGBitmapContextCreate 是无倍数的，所以要自己换算成1倍
    NSInteger width = self.size.width * self.scale;
    NSInteger height = self.size.height * self.scale;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, 0, colorSpace, kCGBitmapByteOrderDefault);
    CGColorSpaceRelease(colorSpace);
    if (context == NULL) {
        return nil;
    }
    CGRect imageRect = CGRectMake(0, 0, width, height);
    CGContextDrawImage(context, imageRect, self.CGImage);
    
    UIImage *grayImage = nil;
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    if (self.xh_opaque) {
        grayImage = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    } else {
        CGContextRef alphaContext = CGBitmapContextCreate(NULL, width, height, 8, 0, nil, kCGImageAlphaOnly);
        CGContextDrawImage(alphaContext, imageRect, self.CGImage);
        CGImageRef mask = CGBitmapContextCreateImage(alphaContext);
        CGImageRef maskedGrayImageRef = CGImageCreateWithMask(imageRef, mask);
        grayImage = [UIImage imageWithCGImage:maskedGrayImageRef scale:self.scale orientation:self.imageOrientation];
        CGImageRelease(mask);
        CGImageRelease(maskedGrayImageRef);
        CGContextRelease(alphaContext);
        
        // 用 CGBitmapContextCreateImage 方式创建出来的图片，CGImageAlphaInfo 总是为 CGImageAlphaInfoNone，导致 qmui_opaque 与原图不一致，所以这里再做多一步
        UIGraphicsBeginImageContextWithOptions(grayImage.size, NO, grayImage.scale);
        [grayImage drawInRect:imageRect];
        grayImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    CGContextRelease(context);
    CGImageRelease(imageRef);
    return grayImage;

}

- (UIImage *)xh_imageWithTintColor:(UIColor *)tintColor {

    UIImage *imageIn = self;
    CGRect rect = CGRectMake(0, 0, imageIn.size.width, imageIn.size.height);
    UIGraphicsBeginImageContextWithOptions(imageIn.size, self.xh_opaque, imageIn.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context) {
     
        CGContextTranslateCTM(context, 0, imageIn.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextSetBlendMode(context, kCGBlendModeNormal);
        CGContextClipToMask(context, rect, imageIn.CGImage);
        CGContextSetFillColorWithColor(context, tintColor.CGColor);
        CGContextFillRect(context, rect);
        UIImage *imageOut = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return imageOut;
    } else {
    
        return imageIn;
    }
}

#pragma mark - 渐变

+ (UIImage *)xh_imageWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint size:(CGSize)size {

    
    UIImage *resultImage = nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpaceRef, (CFArrayRef)@[(id)startColor.CGColor, (id)endColor.CGColor], NULL);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation);
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpaceRef);
    UIGraphicsEndImageContext();
    return resultImage;
}

+ (UIImage *)xh_imageWithColors:(NSArray<UIColor *> *)colors loctions:(NSArray *)loctions startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint size:(CGSize)size {
    
    UIImage *resultImage = nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat components[colors.count * 4];
    for (int i = 0; i < colors.count * 4; i += 4) {
        UIColor *obj = colors[i/4];
        components[i] = obj.xh_red;
        components[i + 1] = obj.xh_green;
        components[i + 2] = obj.xh_blue;
        components[i + 3] = obj.xh_alpha;
    }
    CGFloat locations[loctions.count];
    for (int i = 0; i < loctions.count; i ++) {
        locations[i] = [loctions[i] doubleValue];
    }
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradientRef = CGGradientCreateWithColorComponents(colorSpaceRef,
                                                                    components,
                                                                    locations,
                                                                    colors.count);
    CGContextDrawLinearGradient(context, gradientRef, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation);
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGGradientRelease(gradientRef);
    CGColorSpaceRelease(colorSpaceRef);
    return resultImage;
}

- (UIImage *)xh_imageWithColors:(NSArray<UIColor *> *)colors loctions:(NSArray *)loctions startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    
    UIImage *imageIn = self;
//    CGRect rect = CGRectMake(0, 0, imageIn.size.width, imageIn.size.height);
    UIGraphicsBeginImageContextWithOptions(imageIn.size, self.xh_opaque, imageIn.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, CGRectMake(0, 0, imageIn.size.width, imageIn.size.height), self.CGImage);
    CGFloat components[colors.count * 4];
    for (int i = 0; i < colors.count * 4; i += 4) {
        UIColor *obj = colors[i/4];
        components[i] = obj.xh_red;
        components[i + 1] = obj.xh_green;
        components[i + 2] = obj.xh_blue;
        components[i + 3] = obj.xh_alpha;
    }
    CGFloat locations[loctions.count];
    for (int i = 0; i < loctions.count; i ++) {
        locations[i] = [loctions[i] doubleValue];
    }
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradientRef = CGGradientCreateWithColorComponents(colorSpaceRef,
                                                                    components,
                                                                    locations,
                                                                    colors.count);
    CGContextDrawLinearGradient(context, gradientRef, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation);
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGGradientRelease(gradientRef);
    CGColorSpaceRelease(colorSpaceRef);
    return resultImage;
//    if (context) {
//
//        CGContextTranslateCTM(context, 0, imageIn.size.height);
//        CGContextScaleCTM(context, 1.0, -1.0);
//        CGContextSetBlendMode(context, kCGBlendModeNormal);
//        CGContextClipToMask(context, rect, imageIn.CGImage);
//        CGContextSetFillColorWithColor(context, tintColor.CGColor);
//        CGContextFillRect(context, rect);
//        UIImage *imageOut = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        return imageOut;
//    } else {
//
//        return imageIn;
//    }
}
@end
