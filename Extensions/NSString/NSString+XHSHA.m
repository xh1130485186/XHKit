//
//  NSString+XHSHA.m
//  XHKitDemo
//
//  Created by 向洪 on 2017/5/19.
//  Copyright © 2017年 向洪. All rights reserved.
//

#import "NSString+XHSHA.h"

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (XHSHA)

- (NSString *)xh_md5String {

    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, length, bytes);
    return [self xh_stringFromBytes:bytes length:CC_MD5_DIGEST_LENGTH];
}
- (NSString *)xh_sha1String {
    
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(string, length, bytes);
    return [self xh_stringFromBytes:bytes length:CC_SHA1_DIGEST_LENGTH];
}
- (NSString *)xh_sha224String {

    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
    CC_SHA224(string, length, bytes);
    return [self xh_stringFromBytes:bytes length:CC_SHA256_DIGEST_LENGTH];
}
- (NSString *)xh_sha256String {

    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(string, length, bytes);
    return [self xh_stringFromBytes:bytes length:CC_SHA256_DIGEST_LENGTH];
}
- (NSString *)xh_sha384String {

    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
    CC_SHA384(string, length, bytes);
    return [self xh_stringFromBytes:bytes length:CC_SHA256_DIGEST_LENGTH];
}
- (NSString *)xh_sha512String {

    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(string, length, bytes);
    return [self xh_stringFromBytes:bytes length:CC_SHA512_DIGEST_LENGTH];
}

#pragma mark - HMAC

- (NSString *)xh_hmacMD5StringWithKey:(NSString *)key {

    return [self xh_hmacStringUsingAlg:kCCHmacAlgMD5 withKey:key];
}
- (NSString *)xh_hmacSHA1StringWithKey:(NSString *)key {

    return [self xh_hmacStringUsingAlg:kCCHmacAlgSHA1 withKey:key];
}
- (NSString *)xh_hmacSHA224StringWithKey:(NSString *)key {

    return [self xh_hmacStringUsingAlg:kCCHmacAlgSHA224 withKey:key];
}
- (NSString *)xh_hmacSHA256StringWithKey:(NSString *)key {

    return [self xh_hmacStringUsingAlg:kCCHmacAlgSHA256 withKey:key];
}
- (NSString *)xh_hmacSHA384StringWithKey:(NSString *)key {

    return [self xh_hmacStringUsingAlg:kCCHmacAlgSHA384 withKey:key];
}
- (NSString *)xh_hmacSHA512StringWithKey:(NSString *)key {

    return [self xh_hmacStringUsingAlg:kCCHmacAlgSHA512 withKey:key];
}


#pragma mark - private Methods

- (NSString *)xh_hmacStringUsingAlg:(CCHmacAlgorithm)alg withKey:(NSString *)key {
    size_t size;
    switch (alg) {
        case kCCHmacAlgMD5: size = CC_MD5_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA1: size = CC_SHA1_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA224: size = CC_SHA224_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA256: size = CC_SHA256_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA384: size = CC_SHA384_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA512: size = CC_SHA512_DIGEST_LENGTH; break;
        default: return nil;
    }
    
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *messageData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *mutableData = [NSMutableData dataWithLength:size];
    CCHmac(alg, keyData.bytes, keyData.length, messageData.bytes, messageData.length, mutableData.mutableBytes);
    return [self xh_stringFromBytes:(unsigned char *)mutableData.bytes length:(int)mutableData.length];
}

- (NSString *)xh_stringFromBytes:(unsigned char *)bytes length:(int)length
{
    NSMutableString *mutableString = @"".mutableCopy;
    for (int i = 0; i < length; i++)
        [mutableString appendFormat:@"%02x", bytes[i]];
    return [NSString stringWithString:mutableString];
}

@end
