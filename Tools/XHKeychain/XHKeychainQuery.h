//
//  XHKeychainQuery.h
//  XHKeychain
//
//  Created by 向洪 on 16/9/19.
//  Copyright © 2016年 向洪. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, XHKeychainQuerySynchronizationMode) {
    XHKeychainQuerySynchronizationModeAny,
    XHKeychainQuerySynchronizationModeNo,
    XHKeychainQuerySynchronizationModeYes
};

@interface XHKeychainQuery : NSObject

/**
 用户名
 */
@property (nonatomic, copy) NSString *account;

/**
 密码
 */
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSData *passwordData;

/**
 kXHKeychainService
 */
@property (nonatomic, copy) NSString *service;

/** kSecAttrLabel */
@property (nonatomic, copy) NSString *label;

/**
 iCloud 备份
 */
@property (nonatomic) XHKeychainQuerySynchronizationMode synchronizationMode;

/**
 公共区名字，与bundle Identifier一致，针对公共区，本公司的产品可以访问
 */
@property (nonatomic, copy) NSString *accessGroup;

/**
 存储

 @param error 错误信息

 @return 存储是否成功
 */
- (BOOL)save:(NSError **)error;

/**
 读取刚条的所以信息

 @param error 错误信息

 @return 数据
 */
- (NSArray<NSDictionary<NSString *, id> *> *)fetchAll:(NSError **)error;

/**
 读取，成功后赋值给passwordData属性

 @param error 错误信息

 @return 读取是否成功
 */
- (BOOL)fetch:(NSError **)error;

/**
 删除

 @param error 错误信息

 @return 删除是否成功
 */
- (BOOL)deleteItem:(NSError **)error;

@end
