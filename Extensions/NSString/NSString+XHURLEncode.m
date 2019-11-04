//
//  NSString+XHURLEncode.m
//  GrowthCompass
//
//  Created by 向洪 on 17/4/25.
//  Copyright © 2017年 向洪. All rights reserved.
//



#import "NSString+XHURLEncode.h"

@implementation NSString (XHURLEncode)

- (NSString *)xh_urlEncode {

    return [self xh_urlEncodeUsingEncoding:NSUTF8StringEncoding];
}


/*
 
 URLFragmentAllowedCharacterSet  "#%<>[\]^`{|}
 URLHostAllowedCharacterSet      "#%/<>?@\^`{|}
 URLPasswordAllowedCharacterSet  "#%/:<>?@[\]^`{|}
 URLPathAllowedCharacterSet      "#%;<>?[\]^`{|}
 URLQueryAllowedCharacterSet     "#%<>[\]^`{|}
 URLUserAllowedCharacterSet      "#%/:<>?@[\]^`
 
 */
- (NSString *)xh_urlEncodeUsingEncoding:(NSStringEncoding)encoding {

//    NSString *string = @"!*'\"();:@&=+$,/?%#[]% ";
//    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
//                                                                                 (__bridge CFStringRef)self,NULL,(CFStringRef)string,
//                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding));
    
    if (encoding == NSUTF8StringEncoding) {
        
        return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    } else {
    
        return [self stringByAddingPercentEscapesUsingEncoding:encoding];
    }

//    NSCharacterSet *characterSet = [NSCharacterSet URLQueryAllowedCharacterSet];
//    return [self stringByAddingPercentEncodingWithAllowedCharacters:characterSet];
    
}

- (NSString *)xh_urlDecode {

    return [self xh_urlDecodeUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)xh_urlDecodeUsingEncoding:(NSStringEncoding)encoding {

//    return (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
//                                                                                                 (__bridge CFStringRef)self,CFSTR(""),CFStringConvertNSStringEncodingToEncoding(encoding));
    return [self stringByRemovingPercentEncoding];
}

- (NSDictionary *)xh_dictionaryFromURLParameters {

    NSArray *pairs = [self componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val = [[kv objectAtIndex:1] xh_urlDecodeUsingEncoding:NSUTF8StringEncoding];
        [params setObject:val forKey:[kv objectAtIndex:0]];
    }
    return params;
}

@end
