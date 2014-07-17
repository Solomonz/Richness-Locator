//
//  GenerationHelper.h
//  Richness Locator
//
//  Created by Solomon Zitter on 7/6/14.
//  Copyright (c) 2014 Solomon Zitter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface GenerationHelper : NSObject

- (CLLocation *) GeneratethRichness:(CLLocation *) userlocation atRadius:(double) maxRadius exact:(BOOL) e;
- (double) dLat:(CLLocation *) userlocation vertDistance:(double) dist;
- (double) dLon:(CLLocation *) userlocation horizDistance:(double) dist;

@end
