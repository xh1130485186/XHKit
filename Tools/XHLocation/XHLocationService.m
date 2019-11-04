//
//  XHLocationService.m
//  LocationDemo
//
//  Created by 向洪 on 2017/4/26.
//  Copyright © 2017年 向洪. All rights reserved.
//


#import "XHLocationService.h"

@interface XHLocationService () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation XHLocationService

- (instancetype)init {

    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {

    self.distanceFilter = kCLDistanceFilterNone;
    self.desiredAccuracy = kCLLocationAccuracyBest;
    self.headingFilter = 1;
    self.pausesLocationUpdatesAutomatically = YES;
    self.allowsBackgroundLocationUpdates = NO;
    
}

- (void)startUserLocationService {

    if (_delegate && [_delegate conformsToProtocol:@protocol(XHLocationServiceDelegate)] && [_delegate respondsToSelector:@selector(willStartLocatingUser)]) {
        [_delegate willStartLocatingUser];
    }
    
    [self.locationManager startUpdatingHeading];
    [self.locationManager startUpdatingLocation];
//    
//    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
//        
//        if (_delegate && [_delegate conformsToProtocol:@protocol(XHLocationServiceDelegate)] && [_delegate respondsToSelector:@selector(didFailToLocateUserWithError:)]) {
//            [_delegate didFailToLocateUserWithError:[CLLocationManager authorizationStatus]];
//        }
//        
//    }
}

- (void)stopUserLocationService {

    [self.locationManager stopUpdatingHeading];
    [self.locationManager stopUpdatingLocation];
}


#pragma mark - delegate <CLLocationManagerDelegate>

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(nonnull NSError *)error {

    if (_delegate && [_delegate conformsToProtocol:@protocol(XHLocationServiceDelegate)] && [_delegate respondsToSelector:@selector(didFailToLocateUserWithError:)]) {
        [_delegate didFailToLocateUserWithError:error];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {

    if (_delegate && [_delegate conformsToProtocol:@protocol(XHLocationServiceDelegate)] && [_delegate respondsToSelector:@selector(didUpdateUserHeading:)]) {
        [_delegate didUpdateUserHeading:newHeading];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {

    CLLocation *currLocation = [locations lastObject];
    if (_delegate && [_delegate conformsToProtocol:@protocol(XHLocationServiceDelegate)] && [_delegate respondsToSelector:@selector(didUpdateUserLocation:)]) {
        [_delegate didUpdateUserLocation:currLocation];
    }
    
}

- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager {

    if (_delegate && [_delegate conformsToProtocol:@protocol(XHLocationServiceDelegate)] && [_delegate respondsToSelector:@selector(didStopLocatingUser)]) {
        [_delegate didStopLocatingUser];
    }
}


#pragma mark - setter

- (void)setDistanceFilter:(CLLocationDistance)distanceFilter {

    _distanceFilter = distanceFilter;
    self.locationManager.distanceFilter = distanceFilter;
}

- (void)setDesiredAccuracy:(CLLocationAccuracy)desiredAccuracy {

    _desiredAccuracy = desiredAccuracy;
    self.locationManager.desiredAccuracy = desiredAccuracy;
}

- (void)setHeadingFilter:(CLLocationDegrees)headingFilter {

    _headingFilter = headingFilter;
    self.locationManager.headingFilter = headingFilter;
}

- (void)setPausesLocationUpdatesAutomatically:(BOOL)pausesLocationUpdatesAutomatically {

    _pausesLocationUpdatesAutomatically = pausesLocationUpdatesAutomatically;
    self.locationManager.pausesLocationUpdatesAutomatically = pausesLocationUpdatesAutomatically;
}

- (void)setAllowsBackgroundLocationUpdates:(BOOL)allowsBackgroundLocationUpdates {

    _allowsBackgroundLocationUpdates = allowsBackgroundLocationUpdates;
    if (@available(iOS 9.0, *)) {
        self.locationManager.allowsBackgroundLocationUpdates = allowsBackgroundLocationUpdates;
    } else {
        // Fallback on earlier versions
    }
}

#pragma mark - getter

- (CLLocationManager *)locationManager {

    if (!_locationManager) {

        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
            
            [_locationManager requestAlwaysAuthorization];//如果想让ios8获取当前地址，需要添加此代码
            
        }
        [CLLocationManager locationServicesEnabled];
    }
    return _locationManager;
}

@end
