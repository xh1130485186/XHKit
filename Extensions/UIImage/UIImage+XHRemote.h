//
//  UIImage+XHRemote.h
//  XHKitDemo
//
//  Created by 向洪 on 2017/6/19.
//  Copyright © 2017年 向洪. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 远程网址相关
 */
@interface UIImage (XHRemote)


/**
 通过视频的时间点获取图像

 @param videoURL 视频地址
 @param time 时间
 @param completionHandler 完成回调
 */
+ (void)xh_thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time completionHandler:(void(^)(UIImage *filterImage, NSURL *videoURL))completionHandler;

@end
