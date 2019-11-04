//
//  NSString+XHAdapter.h
//  GrowthCompass
//
//  Created by 向洪 on 17/4/25.
//  Copyright © 2017年 向洪. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 字体文本适配
 */
@interface NSString (XHUIAdapter)

/**
 适配文本显示需要的矩形大小（width 为屏幕宽度 减 16）
 
 @param font 字体大小
 @return 显示需要的矩形大小
 */
- (CGSize)xh_sizeWithFont:(UIFont *)font;

/**
 适配文本显示需要的矩形大小
 
 @param font 字体大小
 @param width 最大宽度
 @return 显示需要的矩形大小
 */
- (CGSize)xh_sizeWithFont:(UIFont *)font forWidth:(CGFloat)width;

/**
 适配文本显示需要的矩形大小
 
 @param textLabel 显示的label
 @param width 最大宽度
 @return 显示需要的矩形大小
 */
- (CGRect)xh_boundingRectWithTextLabel:(UILabel *)textLabel forWidth:(CGFloat)width ;

/**
 适配文本显示需要的矩形大小
 
 @param size 最大矩形大小
 @param fontSize 系统的文字大小
 @return 显示需要的矩形大小
 */
- (CGRect)xh_boundingRectWithSize:(CGSize)size systemFontOfSize:(CGFloat)fontSize;

/**
 适配文本显示需要的矩形大小
 
 @param size 最大矩形大小
 @param attributes 字体attributes
 @return 显示需要的矩形大小
 */
- (CGRect)xh_boundingRectWithSize:(CGSize)size attributes:(NSDictionary<NSString *, id> *)attributes;

/**
 适配文本显示需要的矩形大小
 
 @param size 最大矩形大小
 @param font 字体
 @return 显示需要的矩形大小
 */
- (CGRect)xh_boundingRectWithSize:(CGSize)size font:(UIFont *)font;

/**
 适配文本显示需要的矩形大小
 
 @param size 最大矩形大小
 @param attributes 字体attributes
 @param context 上下文
 @return 显示需要的矩形大小
 */
- (CGRect)xh_boundingRectWithSize:(CGSize)size attributes:(NSDictionary<NSString *, id> *)attributes context:(NSStringDrawingContext *)context;

@end
