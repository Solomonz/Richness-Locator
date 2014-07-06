//
//  CustomAnnotation.m
//  Richness Locator
//
//  Created by Gil Zamfirescu-Pereira on 6/18/14.
//  Copyright (c) 2014 Gil Zamfirescu-Pereira. All rights reserved.
//

#import "CustomAnnotation.h"
#import <MapKit/MapKit.h>

@interface CustomAnnotation <MKAnnotation> {
    CLLocationCoordinate2D coordinate;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
- (id)initWithLocation:(CLLocationCoordinate2D)coord;


@end
