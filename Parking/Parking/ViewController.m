//
//  ViewController.m
//  Parking
//
//  Created by Alex Baev on 24/12/15.
//  Copyright © 2015 baevsoft. All rights reserved.
//

#import "ViewController.h"


@interface ViewController () {
    
    CLLocationManager*locationManager;
    CLLocation* currentLocation;
}



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    
    
   
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
//    if (locationManager == nil)
//        locationManager = [CLLocationManager new];
    
    
    [self CurrentLocationIdentifier]; // call this method
    
    if (status == kCLAuthorizationStatusNotDetermined) {
        [locationManager requestWhenInUseAuthorization];
    }
    
    
    
    
//    locationManager.delegate = self;
//    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
//    locationManager.desiredAccuracy = kCLLocationAccuracyBest; // 100 m
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)fixPositionAction:(id)sender {
    
    //[self CurrentLocationIdentifier];
    //[locationManager startUpdatingLocation];
    
    //[locationManager requestLocation];
    
    [locationManager startUpdatingLocation];
    
}

//------------ Current Location Address-----
-(void)CurrentLocationIdentifier
{
    //---- For getting current gps location
    locationManager = [CLLocationManager new];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager requestLocation];
    
    //------
}


// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    NSString* coorString = [NSString stringWithFormat:@"latitude: %f longitude: %f", location.coordinate.latitude, location.coordinate.longitude];
    
    NSLog(@"******* Bingo!!! *******");
    

    NSLog(coorString, nil);
    
//    NSDate* eventDate = location.timestamp;
//    
//    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
//    
//    if (abs(howRecent) < 15.0) {
//        // If the event is recent, do something with it.
//        NSLog(@"latitude %+.6f, longitude %+.6f\n",
//              location.coordinate.latitude,
//              location.coordinate.longitude);
//    }
    
    [locationManager stopUpdatingLocation];
    

}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    
    NSLog(@"status = %i", (int)status);
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    
    NSLog(error.description, nil);
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
//    if (currentLocation != nil)
//    {
//        
//        label1.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
//        lable2.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
//    }
}


@end
