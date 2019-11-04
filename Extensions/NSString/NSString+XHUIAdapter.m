//
//  NSString+XHAdapter.m
//  GrowthCompass
//
//  Created by 向洪 on 17/4/25.
//  Copyright © 2017年 向洪. All rights reserved.
//

#import "NSString+XHUIAdapter.h"

/*  
    NSStringDrawingTruncatesLastVisibleLine如果文本内容超出指定的矩形限制，文本将被截去并在最后一个字符后加上省略号。 如果指定了NSStringDrawingUsesLineFragmentOrigin选项，则该选项被忽略
    NSStringDrawingUsesLineFragmentOrigin：绘制文本时使用 line fragement origin 而不是 baseline origin。
    NSStringDrawingUsesFontLeading计算行高时使用行间距。（译者注：字体大小+行间距=行高）
    NSStringDrawingUsesDeviceMetrics：计算布局时使用图元字形（而不是印刷字体）。
 */

@implementation NSString (XHUIAdapter)

- (CGSize)xh_sizeWithFont:(UIFont *)font {
    
    return [self xh_boundingRectWithSize:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds) - 16, 10000) font:font].size;
}

- (CGSize)xh_sizeWithFont:(UIFont *)font forWidth:(CGFloat)width {
    
    return [self xh_boundingRectWithSize:CGSizeMake(width, 10000) font:font].size;
}

- (CGRect)xh_boundingRectWithTextLabel:(UILabel *)textLabel forWidth:(CGFloat)width {
    
    return [self xh_boundingRectWithSize:CGSizeMake(width, 10000) font:textLabel.font];
}

- (CGRect)xh_boundingRectWithSize:(CGSize)size systemFontOfSize:(CGFloat)fontSize {
    
    return [self xh_boundingRectWithSize:size font:[UIFont systemFontOfSize:fontSize]];
}

- (CGRect)xh_boundingRectWithSize:(CGSize)size attributes:(NSDictionary<NSString *, id> *)attributes {
    
    return [self xh_boundingRectWithSize:size attributes:attributes context:nil];
}

- (CGRect)xh_boundingRectWithSize:(CGSize)size font:(UIFont *)font {
    
    CGRect return_rect = CGRectZero;
    if (font) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName: font,
                                     NSParagraphStyleAttributeName: paragraph};
        return_rect = [self xh_boundingRectWithSize:size attributes:attributes];
    }
    return return_rect;
}

- (CGRect)xh_boundingRectWithSize:(CGSize)size attributes:(NSDictionary<NSString *, id> *)attributes context:(NSStringDrawingContext *)context {
    
    CGRect return_rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributes context:nil];
    return CGRectMake(0, 0, ceil(return_rect.size.width), ceil(return_rect.size.height));
}

@end
