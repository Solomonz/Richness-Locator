//
//  GenerationHelper.m
//  Richness Locator
//
//  Created by Solomon Zitter on 7/6/14.
//  Copyright (c) 2014 Solomon Zitter. All rights reserved.
//

#import "GenerationHelper.h"
#include <math.h>

@implementation GenerationHelper

- (CLLocation *) GeneratethRichness:(CLLocation *) userlocation atRadius:(double) desiredRadius exact:(BOOL) e
{
    CLLocation * out = [userlocation copy];
    double dLon = 0, dLat = 0;
    
    while([out distanceFromLocation:userlocation] < desiredRadius)
    {
        out = [[CLLocation alloc] initWithLatitude:out.coordinate.latitude longitude:out.coordinate.longitude + 0.000005];
        dLon += 0.000005;
    }
    
    out = [userlocation copy];
    
    while([out distanceFromLocation:userlocation] < desiredRadius)
    {
        out = [[CLLocation alloc] initWithLatitude:out.coordinate.latitude + 0.000005 longitude:out.coordinate.longitude];
        dLat += 0.000005;
    }
    
    double latitudeInMeters = ((double) arc4random_uniform(2 * desiredRadius)) - desiredRadius, latitude = latitudeInMeters * dLat / desiredRadius;
    double longitudeInMeters = sqrt(pow(desiredRadius, 2) - pow(latitudeInMeters, 2));
    if(e)
        longitudeInMeters = longitudeInMeters * (2 * arc4random_uniform(2) - 1.0);
    else
        longitudeInMeters = arc4random_uniform(2 * longitudeInMeters) - longitudeInMeters;
    double longitude = longitudeInMeters * dLon / desiredRadius;
    
    out = [[CLLocation alloc] initWithLatitude:userlocation.coordinate.latitude + latitude longitude:userlocation.coordinate.longitude + longitude];
   return out;
}

@end
