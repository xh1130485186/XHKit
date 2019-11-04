//
//  UIImage+XHCompress.h
//  XHKitDemo
//
//  Created by 向洪 on 2017/5/27.
//  Copyright © 2017年 向洪. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 图片压缩
 */
@interface UIImage (XHCompress)

/**
 压缩图片

 @param maxLength 最大大小
 @return 压缩之后的数据流（JPEG）
 */
- (NSData *)xh_compressImageToMaxLength:(NSInteger)maxLength __attribute__((deprecated("Use -xh_compressWithMaxLength:")));

/**
 压缩图片

 @param maxLength 最大大小
 @param maxWidth 最大宽度
 @return 压缩之后的数据流（JPEG）
 */
- (NSData *)xh_compressImageToMaxLength:(NSInteger)maxLength maxWidth:(NSInteger)maxWidth;

/**
 压缩图片

 @param maxLength 最大值
 @return 压缩之后的数据流（JPEG）
 */
- (NSData *)xh_compressWithMaxLength:(NSUInteger)maxLength;

@end
