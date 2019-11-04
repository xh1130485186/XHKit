//
//  XHLocationService.h
//  LocationDemo
//
//  Created by 向洪 on 2017/4/26.
//  Copyright © 2017年 向洪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

/*
 一、第一个枚举值：kCLAuthorizationStatusNotDetermined的意思是：定位服务授权状态是用户没有决定是否使用定位服务。
 二、第二个枚举值：kCLAuthorizationStatusRestricted的意思是：定位服务授权状态是受限制的。可能是由于活动限制定位服务，用户不能改变。这个状态可能不是用户拒绝的定位服务。
 三、第三个枚举值：kCLAuthorizationStatusDenied的意思是：定位服务授权状态已经被用户明确禁止，或者在设置里的定位服务中关闭。
 四、第四个枚举值：kCLAuthorizationStatusAuthorizedAlways的意思是：定位服务授权状态已经被用户允许在任何状态下获取位置信息。包括监测区域、访问区域、或者在有显著的位置变化的时候。
 五、第五个枚举值：kCLAuthorizationStatusAuthorizedWhenInUse的意思是：定位服务授权状态仅被允许在使用应用程序的时候。
 六、第六个枚举值：kCLAuthorizationStatusAuthorized的意思是：这个枚举值已经被废弃了。他相当于
 kCLAuthorizationStatusAuthorizedAlways这个值。
 */


@class CLLocation;
/// 定位服务Delegate,调用startUserLocationService定位成功后，用此Delegate来获取定位数据
@protocol XHLocationServiceDelegate <NSObject>
@optional
/**
 *在将要启动定位时，会调用此函数
 */
- (void)willStartLocatingUser;

/**
 *在停止定位后，会调用此函数
 */
- (void)didStopLocatingUser;

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(CLHeading *)userLocation;

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserLocation:(CLLocation *)userLocation;

/**
 *定位失败后，会调用此函数
 *@param error 错误枚举
 */
- (void)didFailToLocateUserWithError:(NSError *)error;

@end


@interface XHLocationService : NSObject

/// 当前用户位置，返回坐标类型为当前设置的坐标类型
//@property (nonatomic, readonly) BMKUserLocation *userLocation;

/// 定位服务Delegate,调用startUserLocationService定位成功后，用此Delegate来获取定位数据
@property (nonatomic, weak) id<XHLocationServiceDelegate> delegate;

/**
 *打开定位服务
 *需要在info.plist文件中添加(以下二选一，两个都添加默认使用NSLocationWhenInUseUsageDescription)：
 *NSLocationWhenInUseUsageDescription 允许在前台使用时获取BS的描述
 *NSLocationAlwaysUsageDescription 允许永远可获取BS的描述
 */
- (void)startUserLocationService;
/**
 *关闭定位服务
 */
- (void)stopUserLocationService;

#pragma mark - 定位参数，具体含义可参考CLLocationManager相关属性的注释

/// 设定定位的最小更新距离。默认为kCLDistanceFilterNone
@property(nonatomic, assign) CLLocationDistance distanceFilter;

/// 设定定位精度。默认为kCLLocationAccuracyBest。
@property(nonatomic, assign) CLLocationAccuracy desiredAccuracy;

/// 设定最小更新角度。默认为1度，设定为kCLHeadingFilterNone会提示任何角度改变。
@property(nonatomic, assign) CLLocationDegrees headingFilter;

/// 指定定位是否会被系统自动暂停。默认为YES。只在iOS 6.0之后起作用。
@property(nonatomic, assign) BOOL pausesLocationUpdatesAutomatically;

///指定定位：是否允许后台定位更新。默认为NO。只在iOS 9.0之后起作用。设为YES时，Info.plist中 UIBackgroundModes 必须包含 "location"
@property(nonatomic, assign) BOOL allowsBackgroundLocationUpdates;

@end
