//
//  XHTimer.h
//  GrowthCompass
//
//  Created by 向洪 on 16/11/11.
//  Copyright © 2016年 向洪. All rights reserved.
//

/*
 
 XHTimer 是对NSTimer的一个简单的封装，使调用更加简单。
 
 */

#import <Foundation/Foundation.h>

@class XHTimer;

typedef void(^TimerInvoke)(void);


@protocol XHTimerDelegate <NSObject>


/**
 调用方法，设置了间隔时间，开始后按照间隔时间来调用

 @param timer XHTimer
 */
- (void)timerInvoke:(XHTimer *)timer;

@end

@interface XHTimer : NSObject

@property (nonatomic, weak) id<XHTimerDelegate> delegate;
@property (nonatomic, strong, readonly) NSTimer *timer;
@property (nonatomic, assign) NSTimeInterval timeInterval;


/**
 初始化，通过设置时间间隔

 @param timeInterval 时间间隔
 @return XHTimer
 */
+ (instancetype)timerWithTimeInterval:(NSTimeInterval)timeInterval;


/**
 回调 调用方法，设置了间隔时间，开始后按照间隔时间来调用

 @param invoke 调用方法
 */
- (void)timerInvoke:(TimerInvoke)invoke;


- (void)start;
- (void)pause;
- (void)stopTimer;


@end
