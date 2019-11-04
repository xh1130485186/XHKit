//
//  UIImage+XHCompress.m
//  XHKitDemo
//
//  Created by 向洪 on 2017/5/27.
//  Copyright © 2017年 向洪. All rights reserved.
//

#import "UIImage+XHCompress.h"
#import "UIImage+XHResize.h"

@implementation UIImage (XHCompress)

- (NSData *)xh_compressImageToMaxLength:(NSInteger)maxLength {

    return [self xh_compressImageToMaxLength:maxLength maxWidth:self.size.width];

}

- (NSData *)xh_compressImageToMaxLength:(NSInteger)maxLength maxWidth:(NSInteger)maxWidth {

    CGSize newSize = [self xh_scaleSizeWithMaxWidth:maxWidth];
    UIImage *newImage = [UIImage xh_resizeImage:self withNewSize:newSize];
    
    return [newImage xh_compressWithMaxLength:maxLength];
    
}


- (NSData *)xh_compressWithMaxLength:(NSUInteger)maxLength {
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    //NSLog(@"Before compressing quality, image size = %ld KB",data.length/1024);
    if (data.length < maxLength) return data;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
        //NSLog(@"Compression = %.1f", compression);
        //NSLog(@"In compressing quality loop, image size = %ld KB", data.length / 1024);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    //NSLog(@"After compressing quality, image size = %ld KB", data.length / 1024);
    if (data.length < maxLength) return data;
    UIImage *resultImage = [UIImage imageWithData:data];
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        //NSLog(@"Ratio = %.1f", ratio);
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
        //NSLog(@"In compressing size loop, image size = %ld KB", data.length / 1024);
    }
    //NSLog(@"After compressing size loop, image size = %ld KB", data.length / 1024);
    return data;
}


@end
