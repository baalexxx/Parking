//
//  TTLocationManager.h
//
//  Created by Konrad Gadzinowski on 05/01/15.
//  Copyright © 2015 TomTom. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

extern NSString * const kLocationManagerLocationUpdateNotificationKey;
extern NSString * const kLocationManagerChangeAuthorizationNotificationKey;

@interface TTLocationManager : NSObject

@property (strong, readonly, nonatomic) CLLocationManager *locationManager;
@property (assign, readonly, nonatomic) CLLocationCoordinate2D lastLocationCoordinate;
@property (assign, readonly, nonatomic) BOOL serviceStarted;

+ (instancetype)sharedInstance;
- (BOOL)isLocationManagerAvailable;
- (void)startService;
- (void)stopService;
- (CLLocation *)lastUserLocation;

@end
