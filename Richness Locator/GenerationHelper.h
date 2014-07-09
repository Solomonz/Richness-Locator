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

- (CLLocation *) GeneratethRichness:(CLLocation *) userlocation atRadius:(double) desiredRadius exact:(BOOL) e;
- (CLLocation *) GeneratethRichnessHelper:(CLLocation *) userlocation atRadius:(double) desiredRadius;

@end
