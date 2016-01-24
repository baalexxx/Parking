//
//  CurrentPositionProvider.m
//  Parking
//
//  Created by Alex Baev on 08/01/16.
//  Copyright © 2016 baevsoft. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "CurrentPositionProvider.h"

@interface CurrentPositionProvider()
+(instancetype) alloc __attribute__((unavailable("alloc not available, call sharedInstance instead")));
+(instancetype) allocWithZone __attribute__((unavailable("alloc not available, call sharedInstance instead")));
-(instancetype) init __attribute__((unavailable("init not available, call sharedInstance instead")));
+(instancetype) new __attribute__((unavailable("new not available, call sharedInstance instead")));
-(instancetype) copyWithZone __attribute__((unavailable("init not available, call sharedInstance instead")));
-(instancetype) copy __attribute__((unavailable("init not available, call sharedInstance instead")));

+(instancetype) sharedInstanse;

@end

@implementation CurrentPositionProvider

+ (instancetype) sharedInstanse {
    
    static dispatch_once_t onceToken;
    static CurrentPositionProvider* _provider = nil;
    dispatch_once(&onceToken, ^{
        _provider = [[super alloc] initUniqueInstance];
    });
    
    return _provider;
}

-(instancetype) initUniqueInstance {
    return [super init];
}

+ (CLLocation*) currentPostion {
    
    CurrentPositionProvider* provider = [CurrentPositionProvider sharedInstanse];
    
    CLLocation* loc = [[CLLocation alloc] initWithLatitude:0 longitude:0];
    
    return loc;
}


@end
