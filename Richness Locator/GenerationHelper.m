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

- (CLLocation *) GeneratethRichness:(CLLocation *) usersLocation atRadius:(double) desiredRadius exact:(BOOL) e
{
    double latitude = arc4random_uniform(desiredRadius * 2000.0) - desiredRadius * 1000.0;
    if(e)
    {
        return [self GeneratethRichnessHelper:usersLocation atRadius:desiredRadius];
    }
    return [[CLLocation alloc] initWithLatitude:usersLocation.coordinate.latitude + latitude / 100000000 longitude:usersLocation.coordinate.longitude + (arc4random_uniform(2 * sqrt(pow(desiredRadius * 1000, 2) - latitude * latitude)) - sqrt(pow(desiredRadius * 1000, 2) - latitude * latitude)) / 100000000];
    //double distance == 6378.137 * 2 * atan2(sqrt(pow(sin((latitude/*l*/ - usersLocation.coordinate.latitude/*ucl*/) * M_PI / 360), 2) + cos(usersLocation.coordinate.latitude/*ucl*/ * M_PI / 180) * cos(latitude/*l*/ * M_PI / 180) * pow(sin((x - usersLocation.coordinate.longitude/*uclo*/) * M_PI / 360), 2)), sqrt(1 - pow(sin((latitude/*l*/ - usersLocation.coordinate.latitude/*ucl*/) * M_PI / 360), 2) + cos(usersLocation.coordinate.latitude/*ucl*/ * M_PI / 180) * cos(latitude/*l*/ * M_PI / 180) * pow(sin((x - usersLocation.coordinate.longitude/*uclo*/) * M_PI / 360), 2))) * 1000;
}

- (CLLocation *) GeneratethRichnessHelper:(CLLocation *)userlocation atRadius:(double)desiredRadius
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
    
    double latitudeInMeters = ((double) arc4random_uniform(2 * desiredRadius)) - desiredRadius, longitudeInMeters = sqrt(pow(desiredRadius, 2) - pow(latitudeInMeters, 2))/* * (arc4random_uniform(2) - 0.5) * 2*/, latitude = latitudeInMeters * dLat / desiredRadius, longitude = longitudeInMeters * dLon / desiredRadius;
    
    out = [[CLLocation alloc] initWithLatitude:userlocation.coordinate.latitude + latitude longitude:userlocation.coordinate.longitude + longitude];
    NSLog(@"%f %f", latitude, longitude);
    
    if((int) [userlocation distanceFromLocation:out] != (int) desiredRadius)
    {
        NSLog(@"whoops");
        return [self GeneratethRichnessHelper:userlocation atRadius:desiredRadius];
    }
    
    /*for(int i = 0; i < 5000; i++)
    {
        self.Destinationeth = [self.GH GeneratethRichness:origin atRadius:300 exact:YES];
        if((int) [self.Destinationeth distanceFromLocation:origin] != 200)
            continue;
        (int) ([out distanceFromLocation:userlocation]);
    }*/
    
    return out;
}

@end
