//
//  NSString+XHExtension.m
//  XHKitDemo
//
//  Created by 向洪 on 2019/4/11.
//  Copyright © 2019 向洪. All rights reserved.
//

#import "NSString+XHExtension.h"
#import <UIKit/UIKit.h>

#pragma mark - 字符串转字典

@implementation NSString (XHDictionaryValue)

- (NSDictionary *)xh_JSONObjectDictionaryValue {
    
    NSError *errorJson;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&errorJson];
    if (errorJson != nil) {
        return nil;
    }
    return jsonDict;
}


@end

#pragma mark - 标识符获取

#define key @"xhkit_uuid"

@implementation NSString (XHUUID)

+ (NSString *)xh_UUID {
    
    NSString *uuid = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    if (!uuid) {
        uuid = [[NSUUID UUID] UUIDString];
        [[NSUserDefaults standardUserDefaults] setObject:uuid forKey:key];
    }
    return uuid;
}

+ (NSString *)xh_randomUUID {
    
    return  [[NSUUID UUID] UUIDString];
}

+ (NSString *)xh_UUIDTimestamp {
    
    return  [[NSNumber numberWithLongLong:[[NSDate date] timeIntervalSince1970]*1000] stringValue];
}

@end

#pragma mark - 通过后缀判断文件类型

@implementation NSString (XHFileType)

- (XHFileType)getFileType {
    
    return [NSString getFileTypeWithPath:self];
}

+ (XHFileType)getFileTypeWithPath:(NSString *)path {
    
    NSArray *voiceTypes = @[@"mp3", @"wma", @"wav", @"mod", @"ra", @"cd", @"md", @"asf", @"aac", @"mp3ro", @"vqf", @"flac", @"ape", @"mid", @"ogg", @"m4a", @"aac+", @"aiff" ,@"au", @"vqf"];
    
    NSArray *videoTypes = @[@"avi", @"rmvb", @"rm", @"asf", @"divx", @"mpg", @"mpeg", @"mpe", @"wmv", @"mp4", @"mkv", @"vob", @"mov"];
    
    NSArray *imageTypes = @[@"bmp",@"jpg",@"tiff",@"gif",@"pcx",@"tga",@"exif",@"fpx",@"svg",@"psd",@"cdr",@"pcd",@"dxf",@"ufo",@"eps",@"ai",@"raw",@"wmf", @"png", @"jpeg"];
    NSString *pathExtension = path.pathExtension.lowercaseString;
    
    if ([imageTypes containsObject:pathExtension]) {
        return XHFileTypeImage;
    } else if ([videoTypes containsObject:pathExtension]) {
        return XHFileTypeVideo;
    } else if ([voiceTypes containsObject:pathExtension]) {
        return XHFileTypeVoice;
    } else {
        return XHFileypeUnknow;
    }
}

@end

#pragma mark - 拼音处理

/*
 
 kCFStringTransformStripCombiningMarks;  结合地带商标;(去掉重音和变音符号)
 
 kCFStringTransformToLatin;  拉丁;
 
 kCFStringTransformFullwidthHalfwidth;  全角半宽;
 
 kCFStringTransformLatinKatakana; 拉丁片假名;
 
 kCFStringTransformLatinHiragana; 拉丁平假名;
 
 kCFStringTransformHiraganaKatakana; 平假名片假名;
 
 kCFStringTransformMandarinLatin; 普通话拉丁;(转换成拼音)
 
 kCFStringTransformLatinHangul; 拉丁韩文;
 
 kCFStringTransformLatinArabic; 拉丁阿拉伯语;
 
 kCFStringTransformLatinHebrew; 拉丁希伯来语;
 
 kCFStringTransformLatinThai;拉丁泰国;
 
 kCFStringTransformLatinCyrillic;拉丁西里尔;
 
 kCFStringTransformLatinGreek;拉丁希腊;
 
 kCFStringTransformToXMLHex;XML六角;
 
 kCFStringTransformToUnicodeName;Unicode的名称; (为 Unicode 字符命名)
 
 kCFStringTransformStripDiacritics ;带钢变音符号;
 
 */

@implementation NSString (XHPinYin)

- (NSString *)xh_phoneticSymbolPinYin {
    
    NSMutableString *pinYin = [NSMutableString stringWithString:self];
    CFStringTransform((__bridge CFMutableStringRef)(pinYin), NULL, kCFStringTransformMandarinLatin, NO);
    return pinYin;
}

- (NSString *)xh_pinYin {
    
    NSMutableString *pinyin = [NSMutableString stringWithString:[self xh_phoneticSymbolPinYin]];
    CFStringTransform((__bridge CFMutableStringRef)(pinyin), NULL, kCFStringTransformStripCombiningMarks, NO);
    return pinyin;
}

- (NSString *)xh_outBlankPinYin {
    
    return [[self xh_pinYin] stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString *)xh_uppercaseFirstLetter {
    
    NSString *string = [[self xh_pinYin] capitalizedString];
    if (string.length > 0) {
        
        return [string substringToIndex:1];
    } else {
        
        return nil;
    }
    
}
- (NSString *)xh_lowercaseFirstLetter {
    
    NSString *string = [self xh_pinYin];
    if (string.length > 0) {
        
        return [string substringToIndex:1];
    } else {
        
        return @"";
    }
}

- (NSArray *)xh_firstLetterCharacters {
    
    NSString *string = [self xh_pinYin];
    NSArray *pinYinList = [string componentsSeparatedByString:@" "];
    NSMutableArray *firstLetterCharacters = [NSMutableArray array];
    [pinYinList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj length] > 0) {
            [firstLetterCharacters addObject:[obj substringToIndex:1]];
        } else {
            [firstLetterCharacters addObject:@""];
        }
    }];
    return firstLetterCharacters;
}

@end

#pragma mark - 字符串清除

@implementation NSString (XHTrims)

/**
 *  @brief  清除html标签
 *
 *  @return 清除后的结果
 */
- (NSString *)xh_stringByStrippingHTML {
    
    NSData *htmlData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *htmlString = [[NSAttributedString alloc] initWithData:htmlData options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:@(NSUTF8StringEncoding)} documentAttributes:nil error:nil];
    NSString *string = [htmlString.string stringByReplacingOccurrencesOfString:@"<[^>]+>" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, htmlString.length)];
    return string;
}
/**
 *  @brief  清除js脚本
 *
 *  @return 清楚js后的结果
 */
- (NSString *)xh_stringByRemovingScriptsAndStrippingHTML {
    NSMutableString *mString = [self mutableCopy];
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<script[^>]*>[\\w\\W]*</script>" options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *matches = [regex matchesInString:mString options:NSMatchingReportProgress range:NSMakeRange(0, [mString length])];
    for (NSTextCheckingResult *match in [matches reverseObjectEnumerator]) {
        [mString replaceCharactersInRange:match.range withString:@""];
    }
    return [mString xh_stringByStrippingHTML];
}
/**
 *  @brief  去除空格
 *
 *  @return 去除空格后的字符串
 */
- (NSString *)xh_trimmingWhitespace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}
/**
 *  @brief  去除空格与空行
 *
 *  @return 去除空格与空行的字符串
 */
- (NSString *)xh_trimmingWhitespaceAndNewlines
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end


#pragma mark - emoji表情

@implementation NSString (XHEmoji)

- (BOOL)xh_containsEmoji {
    
    return [NSString xh_stringContainsEmoji:self];
}

+ (BOOL)xh_stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

+ (NSString*)xh_stringRemoveEmoji:(NSString *)string
{
    __block NSMutableString* buffer = [NSMutableString stringWithCapacity:string.length];
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                if (![NSString xh_stringContainsEmoji:substring]) {
                                    [buffer appendString:substring];
                                }
                            }];
    
    return buffer;
}

- (NSString*)xh_stringRemoveEmoji
{
    return [NSString xh_stringRemoveEmoji:self];
}

@end
