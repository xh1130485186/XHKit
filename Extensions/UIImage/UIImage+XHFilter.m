//
//  UIImage+XHFilter.m
//  XHKitDemo
//
//  Created by 向洪 on 2017/6/1.
//  Copyright © 2017年 向洪. All rights reserved.
//

#import "UIImage+XHFilter.h"
#import "UIImage+XHGenerate.h"
#import "UIImage+XHColor.h"

@implementation UIImage (XHFilter)

#pragma mark - core image 高斯模糊
- (UIImage *)xh_gaussianBlurFilterImage {

    return [self xh_gaussianBlurFilterImageWithRadius:30];
}

- (UIImage *)xh_gaussianBlurFilterImageWithRadius:(CGFloat)radius {

    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *ciImage = [CIImage imageWithCGImage:self.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setDefaults];
    [filter setValue:ciImage forKey:kCIInputImageKey];
    //设置模糊程度
    [filter setValue:@(radius) forKey:kCIInputRadiusKey];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage = [context createCGImage: result fromRect:ciImage.extent];
    UIImage *blurImage = [UIImage imageWithCGImage:outImage];
    CGImageRelease(outImage);
    return blurImage;
}

- (void)xh_gaussianBlurFilterImageWithCompletionHandler:(void(^)(UIImage *filterImage))completionHandler {

 
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
        
        UIImage *image = [self xh_gaussianBlurFilterImage];
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            if (completionHandler) {
                completionHandler(image);
            }
        }); 
        
    });
}

- (void)xh_gaussianBlurFilterImageWithRadius:(CGFloat)radius completionHandler:(void(^)(UIImage *filterImage))completionHandler {

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
        
        UIImage *image = [self xh_gaussianBlurFilterImageWithRadius:radius];
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            if (completionHandler) {
                completionHandler(image);
            }
        });
        
    });
    
}

#pragma mark - 二维码
+ (UIImage *)xh_generateWithQRCodeData:(NSString *)data width:(CGFloat)width {

    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSString *info = data;
    NSData *infoData = [info dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:infoData forKeyPath:@"inputMessage"];
    CIImage *outputImage = [filter outputImage];
    CGFloat scale = outputImage.extent.size.width/outputImage.extent.size.height;
    CGSize size = CGSizeMake(width, width/scale);
    UIImage *image = [UIImage xh_imageWithCIImage:outputImage size:size];
    return image;
}

+ (UIImage *)xh_generateWithLogoQRCodeData:(NSString *)data width:(CGFloat)width logoImageName:(NSString *)logoImageName logoWidth:(CGFloat)logoWidth {

    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSString *info = data;
    NSData *infoData = [info dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:infoData forKeyPath:@"inputMessage"];
    CIImage *outputImage = [filter outputImage];
    
    CGFloat scale = outputImage.extent.size.width/outputImage.extent.size.height;
    CGSize size = CGSizeMake(width, width/scale);
    CGRect extent = outputImage.extent;
    CGFloat scale_x = size.width/CGRectGetWidth(extent);
    CGFloat scale_y = size.height/CGRectGetHeight(extent);
    
    UIImage *logoImage = [UIImage imageNamed:logoImageName];
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef imageRef = [context createCGImage:outputImage fromRect:extent];
    CGContextSetInterpolationQuality(contextRef, kCGInterpolationNone);
    CGContextTranslateCTM(contextRef, 0, size.height);
    CGContextScaleCTM(contextRef, scale_x, -scale_y);
    CGContextSetBlendMode(contextRef, kCGBlendModeNormal);
    CGContextDrawImage(contextRef, extent, imageRef);
    
    CGFloat icon_imageW = logoWidth/scale_x;
    CGFloat icon_imageH = logoWidth/scale_y;
    CGFloat icon_imageX = (size.width/scale_x - icon_imageW) * 0.5;
    CGFloat icon_imageY = (size.height/scale_y - icon_imageH) * 0.5;
    CGContextDrawImage(contextRef, CGRectMake(icon_imageX, icon_imageY, icon_imageW, icon_imageH), logoImage.CGImage);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGImageRelease(imageRef);
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - 条形码
+ (UIImage *)xh_generateWith128BarcodeData:(NSString *)data width:(CGFloat)width {

    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    [filter setDefaults];
    NSString *info = data;
    NSData *infoData = [info dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:infoData forKeyPath:@"inputMessage"];
    // 系统默认为7， 上下左右间距
    [filter setValue:[NSNumber numberWithInteger:7.00] forKey:@"inputQuietSpace"];
    CIImage *outputImage = [filter outputImage];
    
    CGFloat scale = outputImage.extent.size.width/outputImage.extent.size.height;
    UIImage *image = [UIImage xh_imageWithCIImage:outputImage size:CGSizeMake(width, width / scale)];
    return image;
}

//#pragma mark - 玻璃变形
//
//- (UIImage *)xh_glassDistortionFilterImageWithTextureImage:(UIImage *)textureImage {
//
//    if (!textureImage) {
//        textureImage = self;
//    }
//    CIImage *textture = [CIImage imageWithCGImage:textureImage.CGImage];
//
//    CIContext *context = [CIContext contextWithOptions:nil];
//    CIImage *ciImage = [CIImage imageWithCGImage:self.CGImage];
//    CIFilter *filter = [CIFilter filterWithName:@"CIGlassDistortion"];
//    [filter setDefaults];
//    [filter setValue:ciImage forKey:kCIInputImageKey];
//    [filter setValue:textture forKey:@"inputTexture"];
//
//    CIVector *vector = [[CIVector alloc] initWithX:0 Y:0];
//    [filter setValue:vector forKey:@"inputCenter"];
//
//    [filter setValue:@(1000) forKey:@"inputScale"];
//
//    CIImage *result = [filter outputImage];
//    CGImageRef outImage = [context createCGImage:result fromRect:ciImage.extent];
//    UIImage *blurImage = [UIImage imageWithCGImage:outImage];
//    CGImageRelease(outImage);
//    return blurImage;
//}
//
//- (void)xh_glassDistortionFilterImageWithTextureImage:(UIImage *)textureImage completion:(void(^)(UIImage *filterImage))completion {
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        // 处理耗时操作的代码块...
//
//        UIImage *image = [self xh_glassDistortionFilterImageWithTextureImage:textureImage];
//        //通知主线程刷新
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //回调或者说是通知主线程刷新，
//            if (completion) {
//                completion(image);
//            }
//        });
//
//    });
//}
@end
