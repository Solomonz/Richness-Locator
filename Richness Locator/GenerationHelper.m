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

- (CLLocation *) GeneratethRichness:(CLLocation *) usersLocation atRadius:(double) desiredRadius
{
    double latitude = arc4random_uniform(desiredRadius * 2000) - desiredRadius * 1000;
    
    //double distance == 6378.137 * 2 * atan2(sqrt(pow(sin((latitude/*l*/ - usersLocation.coordinate.latitude/*ucl*/) * M_PI / 360), 2) + cos(usersLocation.coordinate.latitude/*ucl*/ * M_PI / 180) * cos(latitude/*l*/ * M_PI / 180) * pow(sin((x - usersLocation.coordinate.longitude/*uclo*/) * M_PI / 360), 2)), sqrt(1 - pow(sin((latitude/*l*/ - usersLocation.coordinate.latitude/*ucl*/) * M_PI / 360), 2) + cos(usersLocation.coordinate.latitude/*ucl*/ * M_PI / 180) * cos(latitude/*l*/ * M_PI / 180) * pow(sin((x - usersLocation.coordinate.longitude/*uclo*/) * M_PI / 360), 2))) * 1000;
    
    return [[CLLocation alloc] initWithLatitude:usersLocation.coordinate.latitude + latitude / 100000000 longitude:usersLocation.coordinate.longitude + (arc4random_uniform(2 * sqrt(pow(desiredRadius * 1000, 2) - latitude * latitude)) - sqrt(pow(desiredRadius * 1000, 2) - latitude * latitude)) / 100000000];
}

@end
