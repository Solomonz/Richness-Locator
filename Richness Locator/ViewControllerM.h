//
//  ViewControllerM.h
//  Richness Locator
//
//  Created by Solomon Zitter and Gil Zamfirescu on 6/18/14.
//  Copyright (c) 2014 Solomon Zitter and Gil Zamfirescu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "GenerationHelper.h"

@interface ViewControllerM : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UIButton *Generateth;
@property (weak, nonatomic) IBOutlet UILabel *Informationeth;
@property (assign, nonatomic) BOOL alreadyGotUserLocation;
@property (assign, nonatomic) BOOL alreadyGotDestination;
@property (assign, nonatomic) CLLocationCoordinate2D usersLocation;
@property (assign, nonatomic) double prevDist;
@property (strong, nonatomic) CLLocation * Destinationeth;
@property (strong, nonatomic) GenerationHelper * GH;

- (IBAction)Generateth:(id)sender;
- (IBAction)Revealeth:(id)sender;

@end
