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
#import "UserData.h"

@interface ViewControllerM : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView*map;
@property (strong, nonatomic) CLLocationManager*locationManager;
@property (weak, nonatomic) IBOutlet UIButton*Generateth;
@property (weak, nonatomic) IBOutlet UILabel*Informationeth;
@property (assign, nonatomic) BOOL alreadyGotUserLocation;
@property (assign, nonatomic) BOOL alreadyGotDestination;
@property (assign, nonatomic) CLLocationCoordinate2D usersLocation;
@property (assign, nonatomic) double prevDist;
@property (strong, nonatomic) CLLocation*Destinationeth;
@property (strong, nonatomic) GenerationHelper*GH;
@property (strong, nonatomic) UserData*UD;
@property (assign, nonatomic) double time;
@property (assign, nonatomic) double distance;
@property (strong, nonatomic) NSTimer*timer;
@property (assign, nonatomic) BOOL outOfTime;
@property (weak, nonatomic) IBOutlet UIButton*Revealeth;
@property (weak, nonatomic) IBOutlet UILabel *followLabel;
@property (assign, nonatomic) BOOL follow;


- (IBAction)Generateth:(id)sender;
- (IBAction)Revealeth:(id)sender;
- (void)ReachedDestination:(double)timeLeft;
- (IBAction)followSwitch:(UISwitch *)sender;
- (void)zoomToUser: (CLLocation *) location;



@end
