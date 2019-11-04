//
//  NSString+XHURLEncode.h
//  GrowthCompass
//
//  Created by 向洪 on 17/4/25.
//  Copyright © 2017年 向洪. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 路径编码
 */
@interface NSString (XHURLEncode)

/**
 对路径进行编码，解决路径带特殊符号问题（中文路径）

 @return 编码后的字符串
 */
- (NSString *)xh_urlEncode;

/**
 对路径进行编码，解决路径带特殊符号问题（中文路径）

 @param encoding 编码格式
 @return 编码后的字符串
 */
- (NSString *)xh_urlEncodeUsingEncoding:(NSStringEncoding)encoding;

/**
 对编码的路径进行解码

 @return 解码后的字符串
 */
- (NSString *)xh_urlDecode;

/**
 对编码的路径进行解码

 @param encoding 解码格式
 @return 解码后的字符串
 */
- (NSString *)xh_urlDecodeUsingEncoding:(NSStringEncoding)encoding;

/**
 返回路径中传入的参数

 @return NSDictionary
 */
- (NSDictionary *)xh_dictionaryFromURLParameters;

@end
