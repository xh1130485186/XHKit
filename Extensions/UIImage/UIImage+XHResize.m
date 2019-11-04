//
//  UIImage+XHResize.m
//  XHKitDemo
//
//  Created by 向洪 on 2017/5/27.
//  Copyright © 2017年 向洪. All rights reserved.
//

#import "UIImage+XHResize.h"

@implementation UIImage (XHResize)

+ (UIImage *)xh_resizeImage:(UIImage *)image withNewSize:(CGSize)newSize {

    UIGraphicsBeginImageContextWithOptions(newSize, NO, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)xh_resizeImageWithNewSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (CGSize)xh_scaleSizeWithMaxWidth:(CGFloat)maxWidth {
    
    CGFloat proportion = self.size.width / self.size.height;
    return [self xh_scaleSizeWithMaxSize:CGSizeMake(maxWidth, maxWidth / proportion)];
}

- (CGSize)xh_scaleSizeWithMaxHeight:(CGFloat)maxHeight {

    CGFloat proportion = self.size.width / self.size.height;
    return [self xh_scaleSizeWithMaxSize:CGSizeMake(maxHeight * proportion, maxHeight)];
}

- (CGSize)xh_scaleSizeWithMaxSize:(CGSize)maxSize {
    
    if (CGSizeEqualToSize(maxSize, CGSizeZero) || CGSizeEqualToSize(self.size, CGSizeZero)) {
        return CGSizeZero;
    }
    
    CGSize imageSize = self.size;
    CGFloat proportion = imageSize.width / imageSize.height;

    if (imageSize.width > maxSize.width) {
        
        imageSize.width = maxSize.width;
    }
    
    imageSize.height = floor(imageSize.width / proportion);
    
    if (imageSize.height > maxSize.height) {
        
        imageSize.height = maxSize.height;
        imageSize.width = floor(imageSize.height * proportion);
    }
    
    return imageSize;
    
}
@end
