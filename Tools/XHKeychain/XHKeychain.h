//
//  XHKeychain.h
//  XHKeychain
//
//  Created by 向洪 on 16/9/19.
//  Copyright © 2016年 向洪. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kXHKeychainService;


/**
 密码的安全存储
 */
@interface XHKeychain : NSObject


/**
 存储密码

 @param password 密码
 @param service  service
 @param account  用户

 @return 操作是否成功
 */
+ (BOOL)savePassword:(NSString *)password forService:(NSString *)service account:(NSString *)account;

/**
 读取密码

 @param service service
 @param account 用户

 @return 密码
 */
+ (NSString *)loadPasswordAtService:(NSString *)service account:(NSString *)account;

/**
 删除service

 @param service service
 @param account 用户

 @return 操作是否成功
 */
+ (BOOL)deletePasswordAtService:(NSString *)service account:(NSString *)account;

@end
