//
//  TTLocationManager.m
//
//  Created by Konrad Gadzinowski on 05/01/15.
//  Copyright © 2015 TomTom. All rights reserved.
//

#import "TTLocationManager.h"

NSString * const kLocationManagerLocationUpdateNotificationKey = @"LocationManagerLocationUpdateNotificationKey";
NSString * const kLocationManagerChangeAuthorizationNotificationKey = @"LocationManagerChangeAuthorizationNotificationKey";
NSString * const kKeyLastLocationCoordinate = @"UserLastLocation";

@interface TTLocationManager () <CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;
}

@property (assign, readwrite, nonatomic) CLLocationCoordinate2D lastLocationCoordinate;
@property (assign, readwrite, nonatomic) CLAuthorizationStatus locationAuthorizationStatus;
@property (assign, readwrite, nonatomic) BOOL serviceStarted;

@end

@implementation TTLocationManager

- (void)startService
{
    if (!self.serviceStarted) {
        
        NSNumber *latitude;
        NSNumber *longitude;
        
        // Fetch last stored location from UserDefaults
        CLLocation *loc = [self lastUserLocation];
        if (loc){
            latitude = @(loc.coordinate.latitude);
            longitude = @(loc.coordinate.longitude);
        } else {
            // Center the map on Amsterdam
            latitude = @52.37316;
            longitude = @4.89065;
        }
        
        self.locationManager.delegate = self;
        self.lastLocationCoordinate = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
        self.locationManager.distanceFilter = 40;

        if ([self authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
            // Check for iOS 8.
            if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [self.locationManager requestAlwaysAuthorization];
            }
        }

        [self.locationManager startUpdatingLocation];
        
        self.serviceStarted = YES;
    }
}

- (void)stopService
{
    if (self.serviceStarted) {
        [self.locationManager stopUpdatingLocation];
        self.locationManager.delegate = nil;
        self.serviceStarted = NO;
    }
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return _locationManager;
}

- (BOOL)isLocationManagerAvailable
{
    if (![self areLocationServiceEnabled]) {
        return NO;
    }
    
    BOOL isAvailable = NO;
    switch ([self authorizationStatus]) {
        case kCLAuthorizationStatusNotDetermined:
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied:
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            isAvailable = YES;
            break;
    }
    
    return isAvailable;
}

#pragma mark - Store location

- (CLLocation *)lastUserLocation {
    id loc = [[NSUserDefaults standardUserDefaults] objectForKey:kKeyLastLocationCoordinate];
    if ([loc isKindOfClass:[NSArray class]]) {
        return [[CLLocation alloc] initWithLatitude:[loc[0] doubleValue] longitude:[loc[1] doubleValue]];
    }
    return nil;
}

- (void)setLastUserLocation:(CLLocation *)lastLocation {
    [[NSUserDefaults standardUserDefaults] setObject:@[@(lastLocation.coordinate.latitude), @(lastLocation.coordinate.longitude)]  forKey:kKeyLastLocationCoordinate];
}

- (void)clearLastUserLocation {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kKeyLastLocationCoordinate];
}

#pragma mark - CLLocationManager data

- (BOOL) areLocationServiceEnabled {
    return CLLocationManager.locationServicesEnabled;
}

- (CLAuthorizationStatus) authorizationStatus {
    return CLLocationManager.authorizationStatus;
}

#pragma mark - CLLocationManager delegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"Location manager did change authorization status: %d", status);
    [[NSNotificationCenter defaultCenter] postNotificationName:kLocationManagerChangeAuthorizationNotificationKey object:self];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation *location = [locations lastObject];
    NSDate *eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (fabs(howRecent) < 15.0) {
        // If the event is recent, do something with it.
        NSLog(@"latitude %+.6f, longitude %+.6f",location.coordinate.latitude, location.coordinate.longitude);
    }
    
    self.lastLocationCoordinate = location.coordinate;

    //Store in UserDefaults
    [self setLastUserLocation:location];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kLocationManagerLocationUpdateNotificationKey object:self];
}

@end
