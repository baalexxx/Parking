//
//  CurrentPositionProvider.h
//  Parking
//
//  Created by Alex Baev on 08/01/16.
//  Copyright © 2016 baevsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface CurrentPositionProvider : NSObject


+ (CLLocation*) currentPostion;



@end
