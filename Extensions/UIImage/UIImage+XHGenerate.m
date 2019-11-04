//
//  UIImage+XHGenerate.m
//  XHKitDemo
//
//  Created by 向洪 on 2017/6/1.
//  Copyright © 2017年 向洪. All rights reserved.
//

#import "UIImage+XHGenerate.h"
#import "UIImage+XHColor.h"

//#import <ImageIO/ImageIO.h>

@implementation UIImage (XHGenerate)

#pragma mark - 通过bundle创建图片

+ (UIImage *)xh_imageWithFileName:(NSString *)name {
    
    return [self xh_imageWithFileName:name inBundle:[NSBundle mainBundle]];
}

+ (UIImage *)xh_imageWithFileName:(NSString *)name inBundle:(NSBundle*)bundle {
    
    NSString *extension = @"png";
    
    NSArray *components = [name componentsSeparatedByString:@"."];
    if ([components count] >= 2) {
        NSUInteger lastIndex = components.count - 1;
        extension = [components objectAtIndex:lastIndex];
        
        name = [name substringToIndex:(name.length-(extension.length+1))];
    }
    
    // 如果为Retina屏幕且存在对应图片，则返回Retina图片，否则查找普通图片
    if ([UIScreen mainScreen].scale == 2.0) {
        name = [name stringByAppendingString:@"@2x"];
        
        NSString *path = [bundle pathForResource:name ofType:extension];
        if (path != nil) {
            return [UIImage imageWithContentsOfFile:path];
        }
    }
    
    if ([UIScreen mainScreen].scale == 3.0) {
        name = [name stringByAppendingString:@"@3x"];
        
        NSString *path = [bundle pathForResource:name ofType:extension];
        if (path != nil) {
            return [UIImage imageWithContentsOfFile:path];
        }
    }
    
    NSString *path = [bundle pathForResource:name ofType:extension];
    if (path) {
        return [UIImage imageWithContentsOfFile:path];
    }
    
    return nil;
}

#pragma mark - 通过CIImage创建图片

+ (UIImage *)xh_imageWithCIImage:(CIImage *)ciImage size:(CGSize)size {

    CGRect extent = ciImage.extent;
    CGFloat scale_x = size.width/CGRectGetWidth(extent);
    CGFloat scale_y = size.height/CGRectGetHeight(extent);

    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef imageRef = [context createCGImage:ciImage fromRect:extent];
    CGContextSetInterpolationQuality(contextRef, kCGInterpolationNone);
    CGContextTranslateCTM(contextRef, 0, size.height);
    CGContextScaleCTM(contextRef, scale_x, -scale_y);
    CGContextSetBlendMode(contextRef, kCGBlendModeNormal);
    CGContextDrawImage(contextRef, extent, imageRef);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGImageRelease(imageRef);
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - GIF

+ (UIImage *)xh_animatedGIFNamed:(NSString *)name {
    
    CGFloat scale = [UIScreen mainScreen].scale;
    
    if (name.pathExtension.length > 0) {
        
        name = [name stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@".%@", name.pathExtension] withString:@""];
    }
    return [self xh_animatedGIFNamed:name scale:scale];
}

+ (UIImage *)xh_animatedGIFNamed:(NSString *)name scale:(CGFloat)scale {

    if (scale < 0) {
        
        return [UIImage imageNamed:name];
    }

    NSString *retinaPath;
    
    if (scale == 0) {
        
        retinaPath = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
    } else {
    
        NSString *scale_str = [NSString stringWithFormat:@"@%gx", scale];
        retinaPath = [[NSBundle mainBundle] pathForResource:[name stringByAppendingString:scale_str] ofType:@"gif"];
    }
    
    NSData *data = [NSData dataWithContentsOfFile:retinaPath];
    
    if (data) {
        
        return [UIImage xh_animatedGIFWithData:data];
    } else {
    
        scale --;
        return [self xh_animatedGIFNamed:name scale:scale];
    }
}

+ (UIImage *)xh_animatedGIFWithData:(NSData *)data {
    if (!data) {
        return nil;
    }
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    size_t count = CGImageSourceGetCount(source);
    
    UIImage *animatedImage;
    
    if (count <= 1) {
        animatedImage = [[UIImage alloc] initWithData:data];
    }
    else {
        NSMutableArray *images = [NSMutableArray array];
        
        NSTimeInterval duration = 0.0f;
        
        for (size_t i = 0; i < count; i++) {
            
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            duration += [self xh_frameDurationAtIndex:i source:source];
            
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            
            CGImageRelease(image);
        }
        
        if (!duration) {
            duration = (1.0f / 10.0f) * count;
        }
        
        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
    }
    
    CFRelease(source);
    
    return animatedImage;
}

/**
 获取gif动画每一张的持续时间

 @param index 下标
 @param source 图片资源
 @return 时间
 */
+ (float)xh_frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
    
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp != nil) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    }
    else {
        
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp != nil) {
            frameDuration = [delayTimeProp floatValue];
        }
    }
    
    // Many annoying ads specify a 0 duration to make an image flash as quickly as possible.
    // We follow Firefox's behavior and use a duration of 100 ms for any frames that specify
    // a duration of <= 10 ms. See <rdar://problem/7689300> and <http://webkit.org/b/36082>
    // for more information.
    
    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }
    
    CFRelease(cfFrameProperties);
    return frameDuration;
}

- (UIImage *)xh_imageWithMaskImage:(UIImage *)maskImage usingMaskImageMode:(BOOL)usingMaskImageMode {

    CGImageRef maskRef = [maskImage CGImage];
    CGImageRef mask;
    if (usingMaskImageMode) {
        // 用CGImageMaskCreate创建生成的 image mask。
        // 黑色部分显示，白色部分消失，透明部分显示，其他颜色会按照颜色的灰色度对图片做透明处理。
        
        mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                 CGImageGetHeight(maskRef),
                                 CGImageGetBitsPerComponent(maskRef),
                                 CGImageGetBitsPerPixel(maskRef),
                                 CGImageGetBytesPerRow(maskRef),
                                 CGImageGetDataProvider(maskRef), nil, YES);
    } else {
        // 用一个纯CGImage作为mask。这个image必须是单色(例如：黑白色、灰色)、没有alpha通道、不能被其他图片mask。系统的文档：If `mask' is an image, then it must be in a monochrome color space (e.g. DeviceGray, GenericGray, etc...), may not have alpha, and may not itself be masked by an image mask or a masking color.
        // 白色部分显示，黑色部分消失，透明部分消失，其他灰色度对图片做透明处理。
        mask = maskRef;
    }
    CGImageRef maskedImage = CGImageCreateWithMask(self.CGImage, mask);
    UIImage *returnImage = [UIImage imageWithCGImage:maskedImage scale:self.scale orientation:self.imageOrientation];
    if (usingMaskImageMode) {
        CGImageRelease(mask);
    }
    CGImageRelease(maskedImage);
    return returnImage;
}

- (UIImage *)xh_imageWithSuperpositionImage:(UIImage *)superpositionImage drawInRect:(CGRect)rect {
    
    CGRect imageRect = CGRectMake(0, 0, self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(self.size, self.xh_opaque, self.scale);
//    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    [self drawInRect:imageRect];
    [superpositionImage drawInRect:rect];
    UIImage *returnImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return returnImage;
}

#pragma mark - 字符串图片

+ (UIImage *)xh_imageWithAttributedString:(NSAttributedString *)attributedString {
    
    CGSize stringSize = [attributedString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    stringSize = CGSizeMake(ceil(stringSize.width), ceil(stringSize.height));
    UIGraphicsBeginImageContextWithOptions(stringSize, NO, 0);
    [attributedString drawInRect:CGRectMake(0, 0, stringSize.width, stringSize.height)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

#pragma mark - 截图

+ (UIImage *)xh_imageWithView:(UIView *)view {

    UIImage *resultImage = nil;
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

+ (UIImage *)xh_imageWithView:(UIView *)view afterScreenUpdates:(BOOL)afterUpdates {

    UIImage *resultImage = nil;
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    [view drawViewHierarchyInRect:CGRectMake(0, 0, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds)) afterScreenUpdates:afterUpdates];
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

#pragma mark - 裁剪

- (UIImage *)xh_cropImageWithCornerRadius:(CGFloat)radius {
    return [self xh_cropImageWithLocation:CGRectMake(0, 0, self.size.width, self.size.height) cornerRadius:radius];
}

- (UIImage *)xh_cropImageWithLocation:(CGRect)rect {

    return [self xh_cropImageWithLocation:rect cornerRadius:0];
}

- (UIImage *)xh_cropImageWithLocation:(CGRect)rect cornerRadius:(CGFloat)radius {

    
    if (radius == 0) {
        
        rect = CGRectMake((rect.origin.x)*self.scale, (rect.origin.y)*self.scale, (rect.size.width)*self.scale, (rect.size.height)*self.scale);
        CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
        UIImage *croppedImage = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
        CGImageRelease(imageRef);
        return croppedImage;
    } else {
    
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
        return [self xh_cropImageWithLocation:rect bezierPath:bezierPath];
    }
    
}

- (UIImage *)xh_cropImageWithLocation:(CGRect)rect bezierPath:(UIBezierPath *)bezierPath {

    rect = CGRectMake((rect.origin.x), (rect.origin.y), (rect.size.width), (rect.size.height));
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, self.scale);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextAddPath(contextRef, bezierPath.CGPath);
    CGContextClip(contextRef);
    CGContextStrokePath(contextRef);
    [self drawInRect:rect];
    UIImage *croppedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return croppedImage;
}

- (UIImage *)xh_cropImageWithDisplayFrame:(CGRect)displayFrame contentMode:(UIViewContentMode)contentMode location:(CGRect)rect {

    return [self xh_cropImageWithDisplayFrame:displayFrame contentMode:contentMode location:rect cornerRadius:0];
}
                       
- (UIImage *)xh_cropImageWithDisplayFrame:(CGRect)displayFrame contentMode:(UIViewContentMode)contentMode location:(CGRect)rect cornerRadius:(CGFloat)radius {

    CGSize i_size = self.size;
    CGSize d_size = displayFrame.size;
    
    switch (contentMode) {
            
        case UIViewContentModeScaleAspectFit:
        {
            CGFloat scale_x = i_size.width/d_size.width;
            CGFloat scale_y = i_size.height/d_size.height;
            
            CGFloat x = CGRectGetMinX(rect);
            CGFloat y = CGRectGetMinY(rect);
            CGFloat width = CGRectGetWidth(rect);
            CGFloat height = CGRectGetHeight(rect);
            
            CGFloat scale = scale_x>scale_y?scale_x:scale_y;
            CGFloat start_x = 0.0;
            CGFloat start_y = 0.0;
            if (scale_x>scale_y) {
                
                start_y = (d_size.height - i_size.height / scale) * 0.5;
            } else {
            
                start_x = (d_size.width - i_size.width / scale) * 0.5;
                
            }
            return [self xh_cropImageWithLocation:CGRectMake((x - start_x) * scale, (y - start_y) * scale, width * scale, height * scale) cornerRadius:radius * scale];
        }
            break;
        case UIViewContentModeScaleAspectFill:
        {
            CGFloat scale_x = i_size.width/d_size.width;
            CGFloat scale_y = i_size.height/d_size.height;
            
            CGFloat x = CGRectGetMinX(rect);
            CGFloat y = CGRectGetMinY(rect);
            CGFloat width = CGRectGetWidth(rect);
            CGFloat height = CGRectGetHeight(rect);
            
            CGFloat scale = scale_x<scale_y?scale_x:scale_y;
            CGFloat start_x = 0.0;
            CGFloat start_y = 0.0;
            if (scale_x<scale_y) {
                
                start_y = (d_size.height - i_size.height / scale) * 0.5;
            } else {
                
                start_x = (d_size.width - i_size.width / scale) * 0.5;
                
            }
            return [self xh_cropImageWithLocation:CGRectMake((x - start_x) * scale, (y - start_y) * scale, (width - start_x * 2) * scale, (height - start_y * 2) * scale) cornerRadius:radius * scale];
        }
            break;
        case UIViewContentModeCenter:
        {
            CGFloat start_x = (i_size.width - d_size.width) * 0.5;
            CGFloat start_y = (i_size.height - d_size.height) * 0.5;
            rect = CGRectOffset(rect, start_x, start_y);
            return [self xh_cropImageWithLocation:rect cornerRadius:radius];
            
        }
            break;
        case UIViewContentModeTop:
        {
            CGFloat start_x = (i_size.width - d_size.width) * 0.5;
            rect = CGRectOffset(rect, start_x, 0);
            return [self xh_cropImageWithLocation:rect cornerRadius:radius];
            
        }
            break;
        case UIViewContentModeBottom:
        {
            CGFloat start_x = (i_size.width - d_size.width) * 0.5;
            CGFloat start_y = (i_size.height - d_size.height);
            rect = CGRectOffset(rect, start_x, start_y);
            return [self xh_cropImageWithLocation:rect cornerRadius:radius];
        }
            break;
        case UIViewContentModeLeft:
        {
            CGFloat start_y = (i_size.height - d_size.height) * 0.5;
            rect = CGRectOffset(rect, 0, start_y);
            return [self xh_cropImageWithLocation:rect cornerRadius:radius];
        }
            break;
        case UIViewContentModeRight:
        {
         
            CGFloat start_x = (i_size.width - d_size.width);
            CGFloat start_y = (i_size.height - d_size.height) * 0.5;
            rect = CGRectOffset(rect, start_x, start_y);
            return [self xh_cropImageWithLocation:rect cornerRadius:radius];
            
        }
            break;
        case UIViewContentModeTopLeft:
        {
            return [self xh_cropImageWithLocation:rect cornerRadius:radius];
        }
            break;
        case UIViewContentModeTopRight:
        {
            
            CGFloat start_x = (i_size.width - d_size.width);
            rect = CGRectOffset(rect, start_x, 0);
            return [self xh_cropImageWithLocation:rect cornerRadius:radius];
        }
            break;
        case UIViewContentModeBottomLeft:
        {
            CGFloat start_y = (i_size.height - d_size.height);
            rect = CGRectOffset(rect, 0, start_y);
            return [self xh_cropImageWithLocation:rect cornerRadius:radius];
        }
            break;
        case UIViewContentModeBottomRight:
        {
            CGFloat start_x = (i_size.width - d_size.width);
            CGFloat start_y = (i_size.height - d_size.height);
            rect = CGRectOffset(rect, start_x, start_y);
            return [self xh_cropImageWithLocation:rect cornerRadius:radius];
        }
            break;
            
        default:
        {
        
            if (radius == 0) {
            
                CGFloat scale_x = i_size.width/d_size.width;
                CGFloat scale_y = i_size.height/d_size.height;
                
                CGFloat x = CGRectGetMinX(rect);
                CGFloat y = CGRectGetMinY(rect);
                CGFloat width = CGRectGetWidth(rect);
                CGFloat height = CGRectGetHeight(rect);
                
                return [self xh_cropImageWithLocation:CGRectMake(x * scale_x, y * scale_y, width * scale_x, height * scale_y) cornerRadius:0];
                
            } else {
            
                return [self xh_cropImageWithDisplayFrame:displayFrame contentMode:UIViewContentModeScaleAspectFill location:rect cornerRadius:radius];
            }
        }
            break;
    }
    return nil;
}

#pragma mark - 图片添加边框
- (UIImage *)xh_imageWithBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth borderPosition:(XHUIImageBorderPosition)borderPosition {

    if (borderPosition == XHUIImageBorderPositionAll) {
        return [self xh_imageWithBorderColor:borderColor borderWidth:borderWidth cornerRadius:0];
    } else {
        // TODO 使用bezierPathWithRoundedRect:byRoundingCorners:cornerRadii:这个系统接口
        UIBezierPath* path = [UIBezierPath bezierPath];
        if ((XHUIImageBorderPositionBottom & borderPosition) == XHUIImageBorderPositionBottom) {
            [path moveToPoint:CGPointMake(0, self.size.height - borderWidth / 2)];
            [path addLineToPoint:CGPointMake(self.size.width, self.size.height - borderWidth / 2)];
        }
        if ((XHUIImageBorderPositionTop & borderPosition) == XHUIImageBorderPositionTop) {
            [path moveToPoint:CGPointMake(0, borderWidth / 2)];
            [path addLineToPoint:CGPointMake(self.size.width, borderWidth / 2)];
        }
        if ((XHUIImageBorderPositionLeft & borderPosition) == XHUIImageBorderPositionLeft) {
            [path moveToPoint:CGPointMake(borderWidth / 2, 0)];
            [path addLineToPoint:CGPointMake(borderWidth / 2, self.size.height)];
        }
        if ((XHUIImageBorderPositionRight & borderPosition) == XHUIImageBorderPositionRight) {
            [path moveToPoint:CGPointMake(self.size.width - borderWidth / 2, 0)];
            [path addLineToPoint:CGPointMake(self.size.width - borderWidth / 2, self.size.height)];
        }
        [path setLineWidth:borderWidth];
        [path closePath];
        return [self xh_imageWithBorderColor:borderColor path:path];
    }
    return self;
}

- (UIImage *)xh_imageWithBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {

    return [self xh_imageWithBorderColor:borderColor borderWidth:borderWidth cornerRadius:0 dashedLengths:0];
}

- (UIImage *)xh_imageWithBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius {

    return [self xh_imageWithBorderColor:borderColor borderWidth:borderWidth cornerRadius:cornerRadius dashedLengths:0];
}

// 一个CGFloat的数组，例如`CGFloat dashedLengths[] = {2, 4}`。如果不需要虚线，则传0即可
- (UIImage *)xh_imageWithBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius dashedLengths:(const CGFloat *)dashedLengths {
    if (!borderColor || !borderWidth) {
        return self;
    }

    UIBezierPath *path;
    CGRect rect = CGRectInset(CGRectMake(0, 0, self.size.width, self.size.height), borderWidth/2, borderWidth/2);// 调整rect，从而保证绘制描边时像素对齐
    if (cornerRadius > 0) {
        path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    } else {
        path = [UIBezierPath bezierPathWithRect:rect];
    }

    path.lineWidth = borderWidth;
    if (dashedLengths) {
        [path setLineDash:dashedLengths count:2 phase:0];
    }
    return [self xh_imageWithBorderColor:borderColor path:path];
}

- (UIImage *)xh_imageWithBorderColor:(UIColor *)borderColor path:(UIBezierPath *)path {

    if (!borderColor) {
        return self;
    }

    UIImage *oldImage = self;
    UIImage *resultImage;
    CGRect rect = CGRectMake(0, 0, oldImage.size.width, oldImage.size.height);
    UIGraphicsBeginImageContextWithOptions(oldImage.size, self.xh_opaque, oldImage.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [oldImage drawInRect:rect];
    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
    [path stroke];
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}


@end
