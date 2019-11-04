//
//  XHKeychain.m
//  XHKeychain
//
//  Created by 向洪 on 16/9/19.
//  Copyright © 2016年 向洪. All rights reserved.
//

#import "XHKeychain.h"
#import "XHKeychainQuery.h"


NSString *const kXHKeychainService = @"xhUserService";

@implementation XHKeychain

+ (BOOL)savePassword:(NSString *)password forService:(NSString *)service account:(NSString *)account {

    XHKeychainQuery *query = [[XHKeychainQuery alloc] init];
    query.service = service;
    query.password = password;
    query.account = account;

    NSError *error = nil;
    if ([query save:&error]) {
        return YES;
    } else {
        if (error) {
            NSLog(@"%@", error);
        }
        return NO;
    }
}

+ (NSString *)loadPasswordAtService:(NSString *)service account:(NSString *)account {

    XHKeychainQuery *query = [[XHKeychainQuery alloc] init];
    query.service = service;
    query.account = account;
    NSError *error = nil;
    [query fetch:&error];
    if (error) {
        NSLog(@"%@", error);
    }
    return query.password;
}

+ (BOOL)deletePasswordAtService:(NSString *)service account:(NSString *)account {

    XHKeychainQuery *query = [[XHKeychainQuery alloc] init];
    query.service = service;
    query.account = account;
    NSError *error = nil;
    if ([query deleteItem:&error]) {
        return YES;
    } else {
        if (error) {
         
            NSLog(@"%@", error);
        }
        return NO;
    }
}

@end
