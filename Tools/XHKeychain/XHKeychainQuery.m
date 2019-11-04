//
//  XHKeychainQuery.m
//  XHKeychain
//
//  Created by 向洪 on 16/9/19.
//  Copyright © 2016年 向洪. All rights reserved.
//

#import "XHKeychainQuery.h"

@implementation XHKeychainQuery

- (BOOL)save:(NSError **)error {

    if (!_passwordData) {
        if (error) {
            *error = [[self class] errorWithCode:-1001];
        }
        return NO;
    }
    
    if (!_account) {
        if (error) {
            *error = [[self class] errorWithCode:-1002];
        }
        return NO;
    }
    
    if (!_service) {
        if (error) {
            *error = [[self class] errorWithCode:-1003];
        }
        return NO;
    }
    
    NSMutableDictionary *query = nil;
    NSMutableDictionary * searchQuery = [self query];
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)searchQuery, nil);
    
    if (status == errSecSuccess) {//item already exists, update it!
        query = [[NSMutableDictionary alloc]init];
        [query setObject:self.passwordData forKey:(__bridge id)kSecValueData];
        
        status = SecItemUpdate((__bridge CFDictionaryRef)(searchQuery), (__bridge CFDictionaryRef)(query));
    } else if(status == errSecItemNotFound){//item not found, create it!
    
        query = [self query];
        if (self.label) {
            [query setObject:self.label forKey:(__bridge id)kSecAttrLabel];
        }
        [query setObject:self.passwordData forKey:(__bridge id)kSecValueData];
        status = SecItemAdd((__bridge CFDictionaryRef)query, NULL);
    }

    if (status != errSecSuccess && error != NULL) {
   
        *error = [[self class] errorWithCode:status];

    }

    return (status == errSecSuccess);
    
}

- (BOOL)deleteItem:(NSError **)error {

    if (!_account) {
        if (error) {
            *error = [[self class] errorWithCode:-1002];
        }
        return NO;
    }
    
    if (!_service) {
        if (error) {
            *error = [[self class] errorWithCode:-1003];
        }
        return NO;
    }
    NSMutableDictionary *query = [self query];
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)query);
    if (status != errSecSuccess && error != NULL) {
        *error = [[self class] errorWithCode:status];
    }
    return (status == errSecSuccess);
}

- (NSArray *)fetchAll:(NSError *__autoreleasing *)error {
    NSMutableDictionary *query = [self query];
    [query setObject:@YES forKey:(__bridge id)kSecReturnAttributes];
    [query setObject:(__bridge id)kSecMatchLimitAll forKey:(__bridge id)kSecMatchLimit];
    CFTypeRef result = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, &result);
    if (status != errSecSuccess && error != NULL) {
        *error = [[self class] errorWithCode:status];
        return nil;
    }
    return (__bridge_transfer NSArray *)result;
}

- (BOOL)fetch:(NSError *__autoreleasing *)error {
    
    OSStatus status = 0;
    if (!self.service || !self.account) {
        if (error) {
            *error = [[self class] errorWithCode:status];
        }
        return NO;
    }
    
    CFTypeRef result = NULL;
    NSMutableDictionary *query = [self query];
    [query setObject:@YES forKey:(__bridge id)kSecReturnData];
    [query setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    status = SecItemCopyMatching((__bridge CFDictionaryRef)query, &result);
    
    if (status != errSecSuccess) {
        if (error) {
            *error = [[self class] errorWithCode:status];
        }
        return NO;
    }
    
    self.passwordData = (__bridge_transfer NSData *)result;
    return YES;
}

- (NSMutableDictionary *)query {
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    
    if (self.service) {
        [dictionary setObject:self.service forKey:(__bridge id)kSecAttrService];
    }
    
    if (self.account) {
        [dictionary setObject:self.account forKey:(__bridge id)kSecAttrAccount];
    }
    
#if !TARGET_IPHONE_SIMULATOR
    if (self.accessGroup) {
        [dictionary setObject:self.accessGroup forKey:(__bridge id)kSecAttrAccessGroup];
    }
#endif
//    id value;
//    switch (self.synchronizationMode) {
//        case XHKeychainQuerySynchronizationModeNo: {
//            value = @NO;
//            break;
//        }
//        case XHKeychainQuerySynchronizationModeYes: {
//            value = @YES;
//            break;
//        }
//        case XHKeychainQuerySynchronizationModeAny: {
//            value = (__bridge id)(kSecAttrSynchronizableAny);
//            break;
//        }
//    }
    return dictionary;
}


+ (NSError *)errorWithCode:(OSStatus)code {

    NSString *message;
    switch (code) {
        case -1001: {
            message = @"没有密码";
            break;
        }
        case -1002: {
            message = @"没有账号";
            break;
        }
        case -1003: {
            message = @"没有service";
            break;
        }
        default:
            //errSecSuccess ...
            message = @"其他";
            break;
    }
    NSDictionary *userInfo = nil;
    if (message) {
        userInfo = @{NSLocalizedDescriptionKey:message};
    }
    return [NSError errorWithDomain:@"出现错误" code:code userInfo:userInfo];
}

- (void)setPassword:(NSString *)password {

    _passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)password {
    if ([self.passwordData length]) {
        return [[NSString alloc] initWithData:self.passwordData encoding:NSUTF8StringEncoding];
    }
    return nil;
}


@end
