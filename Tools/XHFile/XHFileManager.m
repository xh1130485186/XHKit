//
//  XHFileManager.m
//  XHFile
//
//  Created by 向洪 on 16/11/17.
//  Copyright © 2016年 向洪. All rights reserved.
//

#import "XHFileManager.h"
#import <CommonCrypto/CommonDigest.h>

#define Default_UserKey @"xh"
#define Root_Path @"XHFile"
#define System_path @"System"
#define Image_path @"Images"
#define File_path @"Files"
#define Other_path @"Other"

//static XHFileManager *manager;

@interface XHFileManager ()

@property (nonatomic, copy) NSString *absoluteString;

@end

@implementation XHFileManager

#pragma mark - 初始化

+ (instancetype)fileManager {

    XHFileManager *fileManager = [[XHFileManager alloc] init];
    return fileManager;
}

- (instancetype)initWithUserKey:(NSString *)key {

    self = [self init];
    if (self) {
        self.userKey = key;
    }
    return self;
    
}

- (instancetype)init {

    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {

    _directory = NSDocumentDirectory;
    _domainMask = NSUserDomainMask;
    _resourceType = XHFileResourceTypeFile;
    _userKey = Default_UserKey;
    [self generateAbsoluteString];
}

#pragma mark - 生成文件路径

- (void)setDirectory:(NSSearchPathDirectory)directory {
    if (_directory != directory) {
        _directory = directory;
        [self generateAbsoluteString];
    }
}

- (void)setDomainMask:(NSSearchPathDomainMask)domainMask {
    if (_domainMask != domainMask) {
        _domainMask = domainMask;
        [self generateAbsoluteString];
    }
}

- (void)setUserKey:(NSString *)userKey {
    if (userKey.length == 0) {
        _userKey = Default_UserKey;
    } else {
        _userKey = userKey;
    }
    _userKey = userKey;
    [self generateAbsoluteString];
}

- (void)setResourceType:(XHFileResourceType)resourceType {
    _resourceType = resourceType;
    [self generateAbsoluteString];
}

- (void)setComponents:(NSArray<NSString *> *)components {
    _components = [components copy];
    [self generateAbsoluteString];
}

// 生成文件路径
- (void)generateAbsoluteString {
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(_directory, _domainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:Root_Path];
    path = [path stringByAppendingPathComponent:_userKey];
    
    switch (_resourceType) {
            
        case XHFileResourceTypeSystem:
            path = [path stringByAppendingPathComponent:System_path];
            break;
        case XHFileResourceTypeFile:
            path = [path stringByAppendingPathComponent:File_path];
            break;
        case XHFileResourceTypeImage:
            path = [path stringByAppendingPathComponent:Image_path];
            break;
        case XHFileResourceTypeOther:
            path = [path stringByAppendingPathComponent:Other_path];
            break;
        default:
            break;
    }
    
    for (NSString *component in _components) {
        path = [path stringByAppendingPathComponent:component];
    }
    
    _absoluteString = path;
    [self createDirWithPath:path];
}

#pragma mark - 创建文件

// 创建文件夹
- (BOOL)createDirWithPath:(NSString *)path {
    
    BOOL isDir = NO;
    BOOL existed = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir];
    BOOL isCreated = NO;
    if ( !(isDir == YES && existed == YES) )
    {
        isCreated = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if (existed) {
        isCreated = YES;
    }
    return isCreated;
}

// 随机生成UUID
- (NSString *)generatePath {
    return [[NSUUID UUID] UUIDString];
}

// 判断当前文件是否存在
- (BOOL)existFileWithFileName:(NSString *)fileName {
    
    BOOL isDir = NO;
    BOOL existed = [[NSFileManager defaultManager] fileExistsAtPath:[_absoluteString stringByAppendingPathComponent:fileName] isDirectory:&isDir];
    if (!isDir && existed) {
        return YES;
    }
    return NO;
}

// 处理文件名重复问题
- (NSString *)preventRepeatWithFileName:(NSString *)fileName {
    
    if (fileName.length == 0) {
        return [self generatePath];
    }
    
    // 文件存在做文件名处理
    if ([self existFileWithFileName:fileName]) {
        
        NSArray *classArray = [fileName componentsSeparatedByString:@"."];
        NSString *fileClass = [classArray lastObject];
        if (classArray.count == 1) {
            fileClass = @"";
        }
        
        NSString *repeatFileName = [classArray firstObject];
        NSArray *array = [repeatFileName componentsSeparatedByString:@"("];
        if (repeatFileName.length > 3 && [repeatFileName hasSuffix:@")"] && array.count > 1) {
            NSString *string = array.lastObject;
            NSString *numberStr = [string substringToIndex:string.length-1];
            NSInteger index = [numberStr integerValue]+1;
            NSString *path = [NSString stringWithFormat:@"%@(%ld)", array.firstObject, (long)index];
            NSString *filePath = [NSString stringWithFormat:@"%@.%@", path, fileClass];
            return [self preventRepeatWithFileName:filePath];
        } else {
            NSString *filePath = [NSString stringWithFormat:@"%@(1).%@", repeatFileName, fileClass];
            return [self preventRepeatWithFileName:filePath];
        }
    } else {
        return fileName;
    }
}

- (BOOL)createFileWithContents:(NSData *)contents {
    
    return [self createFileWithFileName:nil contents:contents attributes:nil cover:YES];
}

- (BOOL)createFileWithFileName:(NSString *)fileName contents:(NSData *)contents cover:(BOOL)cover {
    
    return [self createFileWithFileName:fileName contents:contents attributes:nil cover:cover];
}

- (BOOL)createFileWithFileName:(NSString *)fileName contents:(NSData *)contents attributes:(NSDictionary<NSString *, id> *)attr cover:(BOOL)cover {
    
    if (cover == NO) {
        fileName = [self preventRepeatWithFileName:fileName];
    }
    if (fileName.length == 0) {
        fileName = [self generatePath];
    }
    NSString *path = [_absoluteString stringByAppendingPathComponent:fileName];
    return [[NSFileManager defaultManager] createFileAtPath:path contents:contents attributes:attr];
}

#pragma mark - 文件获取

- (NSString *)pathWithFileName:(NSString *)fileName {

    if ([self existFileWithFileName:fileName]) {
        NSString *path = [_absoluteString stringByAppendingPathComponent:fileName];
        return path;
    }
    return nil;
}

- (NSData *)dataWithFileName:(NSString *)fileName {

    return [NSData dataWithContentsOfFile:[_absoluteString stringByAppendingPathComponent:fileName]];
}

- (NSArray<NSString *> *)allFilePath {

    return [[NSFileManager defaultManager] contentsOfDirectoryAtPath:_absoluteString error:nil];
}

#pragma mark - 文件大小获取

- (NSInteger)getSize {

    NSString *path = [NSSearchPathForDirectoriesInDomains(_directory, _domainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:Root_Path];
    path = [path stringByAppendingPathComponent:_userKey];
    return [self fileSizeWithPath:path];
    
}

- (NSInteger)getSizeWithFileType:(XHFileResourceType)resourceType {

    NSString *path = [NSSearchPathForDirectoriesInDomains(_directory, _domainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:Root_Path];
    
    switch (resourceType) {
            
        case XHFileResourceTypeSystem:
            path = [path stringByAppendingPathComponent:System_path];
            break;
        case XHFileResourceTypeFile:
            path = [path stringByAppendingPathComponent:File_path];
            break;
        case XHFileResourceTypeImage:
            path = [path stringByAppendingPathComponent:Image_path];
            break;
        case XHFileResourceTypeOther:
            path = [path stringByAppendingPathComponent:Other_path];
            
        default:
            break;
    }
    
    return [self fileSizeWithPath:path];
}

// 自动遍历统计目录下所有的文件
- (NSInteger)fileSizeWithPath:(NSString *)path {
   
    NSFileManager *mgr = [NSFileManager defaultManager];
    //判断字符串是否为文件/文件夹
    BOOL dir = NO;
    BOOL exists = [mgr fileExistsAtPath:path isDirectory:&dir];
    //文件或者文件夹不存在
    if (exists == NO)
        return 0;
    
    if (dir){
        
        // 如果是文件夹
        NSArray *subpaths = [mgr subpathsAtPath:path];
        NSInteger totalByteSize = 0;
        for (NSString *subpath in subpaths){
            NSString *fullSubPath = [path stringByAppendingPathComponent:subpath];
            totalByteSize += [self fileSizeWithPath:fullSubPath];
        }
        
        return totalByteSize;
    } else {
        
        //是文件
        NSDictionary *attr = [mgr attributesOfItemAtPath:path error:nil];
        return [[attr objectForKey:NSFileSize ] integerValue];
    }
}

#pragma mark - 文件清理

- (void)clearWithFileName:(NSString *)fileName completionHandler:(void(^)(BOOL success))completionHandler {
    
    [self clearWithPath:[_absoluteString stringByAppendingPathComponent:fileName] completionHandler:completionHandler];
}

- (void)clearDiskWithCompletionHandler:(void(^)(BOOL success))completionHandler {
    
    [self clearWithPath:_absoluteString completionHandler:completionHandler];
}

- (void)clearAllDiskWithCompletionHandler:(void(^)(BOOL success))completionHandler {
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(_directory, _domainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:Root_Path];
    path = [path stringByAppendingString:_userKey];
    
    [self clearWithPath:path completionHandler:completionHandler];
}

- (void)clearWithFileType:(XHFileResourceType)resourceType completionHandler:(void(^)(BOOL success))completionHandler{
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(_directory, _domainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:Root_Path];
    path = [path stringByAppendingString:_userKey];
    
    switch (resourceType) {
        case XHFileResourceTypeSystem:
            path = [path stringByAppendingPathComponent:System_path];
            break;
        case XHFileResourceTypeFile:
            path = [path stringByAppendingPathComponent:File_path];
            break;
        case XHFileResourceTypeImage:
            path = [path stringByAppendingPathComponent:Image_path];
            break;
        case XHFileResourceTypeOther:
            path = [path stringByAppendingPathComponent:Other_path];
            
        default:
            break;
    }
    
    [self clearWithPath:path completionHandler:completionHandler];
}

- (void)clearWithPath:(NSString *)path completionHandler:(void(^)(BOOL success))completionHandler {

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        BOOL isSucceed = [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        if (completionHandler) {
            completionHandler(isSucceed);
        }
        [self createDirWithPath:path];
    });
}

@end
