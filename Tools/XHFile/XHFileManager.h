//
//  XHFileManager.h
//  XHFile
//
//  Created by 向洪 on 16/11/17.
//  Copyright © 2016年 向洪. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    
    XHFileResourceTypeSystem, // 建议存放app或者用户配置，初始化相关的数据
    XHFileResourceTypeFile, // 建议存放文件
    XHFileResourceTypeImage, // 建议存放图片
    XHFileResourceTypeOther
    
} XHFileResourceType;

/**
 用户级别的文件管理
 */
@interface XHFileManager : NSObject

+ (instancetype)fileManager;
- (instancetype)initWithUserKey:(NSString *)key;

// 文件操作基本设置相关，可以设置不同的参数来决定使用不同的目录。
// 自定义路径结构 userKey/resourceType/components
@property (nonatomic) NSSearchPathDirectory directory; // default NSDocumentDirectory.
@property (nonatomic) NSSearchPathDomainMask domainMask; // default NSUserDomainMask.
@property (nonatomic, copy) NSString *userKey; // default xh.
@property (nonatomic) XHFileResourceType resourceType; // default XHFileResourceTypeFile.
@property (nonatomic, copy) NSArray<NSString *> *components; // 自定义目录结构，接在resourceType后, default nil.

// 当前文件管理，指向的路径
@property (nonatomic, copy, readonly) NSString *absoluteString;

// 根据文件流创建文件。 在相同的文件目录下，如果cover为yes，相同的文件名，文件会被覆盖。
- (BOOL)createFileWithContents:(NSData *)contents;
- (BOOL)createFileWithFileName:(NSString *)fileName contents:(NSData *)contents cover:(BOOL)cover;
- (BOOL)createFileWithFileName:(NSString *)fileName contents:(NSData *)contents attributes:(NSDictionary<NSString *, id> *)attr cover:(BOOL)cover;

// 判断当前目录下文件是否存在
- (BOOL)existFileWithFileName:(NSString *)fileName;

// 通过文件名获取文件路径或者文件流。
// 默认会优化从当前目录下获取，如果当前目录下没有文件，会从userkey目下遍历获取。
// 没有获取到，返回nil
- (NSString *)pathWithFileName:(NSString *)fileName;
- (NSData *)dataWithFileName:(NSString *)fileName;

// 获取当前目录下所有的文件路径
- (NSArray<NSString *> *)allFilePath;

// 获取userkey目录下的文件大小
- (NSInteger)getSize;
- (NSInteger)getSizeWithFileType:(XHFileResourceType)resourceType;

// 获取路径下的文件大小，app目录下有效；path可以是目录，也可以是文件。
- (NSInteger)fileSizeWithPath:(NSString *)path;

// 清除某个目录下，某个文件。
// 如果文件不存在，也会返回成功。
- (void)clearWithFileName:(NSString *)fileName completionHandler:(void(^)(BOOL success))completionHandler; // 当前目录指定文件
- (void)clearDiskWithCompletionHandler:(void(^)(BOOL success))completionHandler;  // 当前目录下所有文件
- (void)clearAllDiskWithCompletionHandler:(void(^)(BOOL success))completionHandler; // usekey目录下的所有文件
- (void)clearWithFileType:(XHFileResourceType)resourceType completionHandler:(void(^)(BOOL success))completionHandler; // usekey目录下resourceType下的的所有文件

// 清除路径下的文件，app目录下有效。
// path可以是目录，也可以是文件。
// 如果文件不存在，也会返回成功。
- (void)clearWithPath:(NSString *)path completionHandler:(void(^)(BOOL success))completionHandler;

@end


/*
 文件目录说明
 
 Documents/：保存应用程序的重要数据文件和用户数据文件等。用户数据基本上都放在这个位置(例如从网上下载的图片或音乐文件)，该文件夹在应用程序更新时会自动备份，在连接iTunes时也可以自动同步备份其中的数据。
 
 Library：这个目录下有两个子目录,可创建子文件夹。可以用来放置您希望被备份但不希望被用户看到的数据。该路径下的文件夹，除Caches以外，都会被iTunes备份.
 Library/Caches：保存应用程序使用时产生的支持文件和缓存文件(保存应用程序再次启动过程中需要的信息)，还有日志文件最好也放在这个目录。iTunes 同步时不会备份该目录并且可能被其他工具清理掉其中的数据。
 Library/Preferences：保存应用程序的偏好设置文件。NSUserDefaults类创建的数据和plist文件都放在这里。会被iTunes备份。
 
 tmp/：保存应用运行时所需要的临时数据。不会被iTunes备份。iPhone重启时，会被清空。
 
 
 */
