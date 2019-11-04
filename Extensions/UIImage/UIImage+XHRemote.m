//
//  UIImage+XHRemote.m
//  XHKitDemo
//
//  Created by 向洪 on 2017/6/19.
//  Copyright © 2017年 向洪. All rights reserved.
//

#import "UIImage+XHRemote.h"
#import <AVFoundation/AVFoundation.h>

@implementation UIImage (XHRemote)

+ (void)xh_thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time completionHandler:(void(^)(UIImage *filterImage, NSURL *videoURL))completionHandler {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
        
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
        AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        assetImageGenerator.appliesPreferredTrackTransform = YES;
        assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
        
        CGImageRef thumbnailImageRef = NULL;
        CFTimeInterval thumbnailImageTime = time;
        NSError *thumbnailImageGenerationError = nil;
        thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 1)actualTime:NULL error:&thumbnailImageGenerationError];
        
        if(!thumbnailImageRef) {
            NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
        }
        
        UIImage *thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage: thumbnailImageRef] : nil;
        
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            if (completionHandler) {
                completionHandler(thumbnailImage, videoURL);
            }
        });
        
    });

}

@end
