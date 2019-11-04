//
//  XHTimer.m
//  GrowthCompass
//
//  Created by 向洪 on 16/11/11.
//  Copyright © 2016年 向洪. All rights reserved.
//

#import "XHTimer.h"

@interface XHTimer ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, copy) TimerInvoke invoke;
@property (nonatomic, assign) BOOL stop;

@end

@implementation XHTimer

- (void)dealloc {

    [self stopTimer];
}

- (instancetype)init {

    self = [super init];
    if (self) {
        self.stop = YES;
        _timeInterval = 1.0;
    }
    return self;
}

+ (instancetype)timerWithTimeInterval:(NSTimeInterval)timeInterval {

    XHTimer *timer = [[XHTimer alloc] init];
    timer.timeInterval = timeInterval;
    return timer;
}

- (void)timerInvoke:(TimerInvoke)invoke {

    self.invoke = invoke;
}

- (void)start {
    
    if (_stop) {
        _stop = NO;
        if (!_timer) {
            [self startTimer];
        } else {
        
            [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:_timeInterval]];
        }
    }
}

- (void)pause {
    if (!_stop) {
        _stop = YES;
        [_timer setFireDate:[NSDate distantFuture]];
    }
}

- (void)startTimer {

    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval target:self selector:@selector(timerInvoke) userInfo:nil repeats:YES];
    }
    
}

- (void)stopTimer {
    
    //停止计数器(意味着将timer从运行池中移除)
    [_timer invalidate];
    _stop = YES;
    _timer = nil;
}


- (void)timerInvoke {
    
    if (_invoke) {
        _invoke();
    }
    
    if (self.delegate && [self.delegate conformsToProtocol:@protocol(XHTimerDelegate)] && [self.delegate respondsToSelector:@selector(timerInvoke:)]) {
        [self.delegate timerInvoke:self];
    }
}

#pragma mark - setter

- (void)setTimeInterval:(NSTimeInterval)timeInterval {

    _timeInterval = timeInterval;
    [self stopTimer];
}


@end
