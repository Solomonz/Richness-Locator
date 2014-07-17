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
    double dLon = [self dLon:userlocation horizDistance:desiredRadius], dLat = [self dLat:userlocation vertDistance:desiredRadius];
    
    double latitudeInMeters = ((double) arc4random_uniform(2 * desiredRadius)) - desiredRadius, latitude = latitudeInMeters * dLat / desiredRadius;
    double longitudeInMeters = sqrt(pow(desiredRadius, 2) - pow(latitudeInMeters, 2));
    if(e)
        longitudeInMeters = longitudeInMeters * (2 * arc4random_uniform(2) - 1.0);
    else
        longitudeInMeters = arc4random_uniform(2 * longitudeInMeters) - longitudeInMeters;
    double longitude = longitudeInMeters * dLon / desiredRadius;
    
    out = [[CLLocation alloc] initWithLatitude:userlocation.coordinate.latitude + latitude longitude:userlocation.coordinate.longitude + longitude];
    //if(e && (abs([out distanceFromLocation:userlocation] - desiredRadius) >= 0.1))
        //return [self GeneratethRichness:userlocation atRadius:desiredRadius exact:YES];
    return out;
}

- (double) dLat:(CLLocation *)userlocation vertDistance:(double)dist
{
    CLLocation * c = [userlocation copy];
    double out = 0;
    while([c distanceFromLocation:userlocation] < dist)
    {
        c = [[CLLocation alloc] initWithLatitude:c.coordinate.latitude + 0.000001 longitude:c.coordinate.longitude];
        out += 0.000001;
    }
    return out;
}

- (double) dLon:(CLLocation *)userlocation horizDistance:(double)dist
{
    CLLocation * c = [userlocation copy];
    double out = 0;
    while([c distanceFromLocation:userlocation] < dist)
    {
        c = [[CLLocation alloc] initWithLatitude:c.coordinate.latitude longitude:c.coordinate.longitude + 0.000001];
        out += 0.000001;
    }
    return out;
}

@end
