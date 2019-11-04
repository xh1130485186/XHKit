//
//  NSString+XHExtension.h
//  XHKitDemo
//
//  Created by 向洪 on 2019/4/11.
//  Copyright © 2019 向洪. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 字符串转字典

@interface NSString (XHDictionaryValue)

/**
 JSON字符串转成NSDictionary
 
 @return 字典
 */
- (NSDictionary *)xh_JSONObjectDictionaryValue;

@end

#pragma mark - 标识符获取

@interface NSString (XHUUID)


/**
 获取唯一一个UUID 生成一个uuid然后存储，下次调用读取存储的内容
 
 @return 唯一 UUID
 */
+ (NSString *)xh_UUID;

/**
 获取随机 UUID 例如 E621E1F8-C36C-495A-93FC-0C247A3E6E5F
 
 @return 随机 UUID
 */
+ (NSString *)xh_randomUUID;

/**
 毫秒时间戳 例如 1443066826371
 
 @return 毫秒时间戳
 */
+ (NSString *)xh_UUIDTimestamp;

@end

#pragma mark - 通过后缀判断文件类型

typedef NS_ENUM(NSUInteger, XHFileType) {
    XHFileypeUnknow = 0,
    XHFileTypeImage,
    XHFileTypeVideo,
    XHFileTypeVoice,
};

@interface NSString (XHFileType)

- (XHFileType)getFileType;
+ (XHFileType)getFileTypeWithPath:(NSString *)path;

@end

#pragma mark - 拼音处理

@interface NSString (XHPinYin)

/**
 返回拼音，每个字符以空格隔开
 
 @return 拼音字符
 */
- (NSString *)xh_pinYin;

/**
 返回拼音。带音符
 
 @return 拼音字符
 */
- (NSString *)xh_phoneticSymbolPinYin;

/**
 返回拼音，去除空格的
 
 @return 拼音字符
 */
- (NSString *)xh_outBlankPinYin;

/**
 返回首字符的拼音的第一个大写字母
 
 @return 拼音字符
 */
- (NSString *)xh_uppercaseFirstLetter;

/**
 返回首字符的拼音的第一个小写字母
 
 @return 拼音字符
 */
- (NSString *)xh_lowercaseFirstLetter;

/**
 返回所有字符拼音的第一个小写字母数组
 
 @return 拼音字符数组
 */
- (NSArray *)xh_firstLetterCharacters;

@end

#pragma mark - 字符串清除

@interface NSString (XHTrims)

/**
 清除html标签
 
 @return 清除后的结果
 */
- (NSString *)xh_stringByStrippingHTML;
/**
 清除js脚本
 
 @return 清楚js后的结果
 */
- (NSString *)xh_stringByRemovingScriptsAndStrippingHTML;

/**
 去除空格
 
 @return 去除空格后的字符串
 */
- (NSString *)xh_trimmingWhitespace;

/**
 去除空格与空行
 
 @return 去除空格与空行的字符串
 */
- (NSString *)xh_trimmingWhitespaceAndNewlines;

@end

#pragma mark - emoji表情

@interface NSString (XHEmoji)

/**
 是否包含emoji
 
 @param string 需要判断的字符串
 @return 是否包含
 */
+ (BOOL)xh_stringContainsEmoji:(NSString *)string;

/**
 是否包含emoji
 
 @return 是否包含
 */
- (BOOL)xh_containsEmoji;


/**
 字符串移除emoji
 
 @param string 字符串
 @return 移除后的字符串
 */
+ (NSString*)xh_stringRemoveEmoji:(NSString *)string;

/**
 字符串移除emoji
 
 @return 移除后的字符串
 */
- (NSString*)xh_stringRemoveEmoji;

@end


NS_ASSUME_NONNULL_END
