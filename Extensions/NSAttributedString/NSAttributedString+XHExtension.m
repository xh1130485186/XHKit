//
//  NSAttributedString+XHExtension.m
//  BSGrowthViewing
//
//  Created by 向洪 on 2017/11/10.
//  Copyright © 2017年 向洪. All rights reserved.
//

#import "NSAttributedString+XHExtension.h"

@implementation NSAttributedString (XHExtension)

+ (instancetype)xh_attributedStringWithImage:(UIImage *)image {
    return [self xh_attributedStringWithImage:image baselineOffset:0 leftMargin:0 rightMargin:0];
}

+ (instancetype)xh_attributedStringWithImage:(UIImage *)image baselineOffset:(CGFloat)offset leftMargin:(CGFloat)leftMargin rightMargin:(CGFloat)rightMargin {
    if (!image) {
        return nil;
    }
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = image;
    attachment.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    NSMutableAttributedString *string = [[NSAttributedString attributedStringWithAttachment:attachment] mutableCopy];
    [string addAttribute:NSBaselineOffsetAttributeName value:@(offset) range:NSMakeRange(0, string.length)];
    if (leftMargin > 0) {
        [string insertAttributedString:[self xh_attributedStringWithFixedSpace:leftMargin] atIndex:0];
    }
    if (rightMargin > 0) {
        [string appendAttributedString:[self xh_attributedStringWithFixedSpace:rightMargin]];
    }
    return string;
}

+ (instancetype)xh_attributedStringWithFixedSpace:(CGFloat)width {
    UIGraphicsBeginImageContext(CGSizeMake(width, 1));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [self xh_attributedStringWithImage:image];
}

@end
