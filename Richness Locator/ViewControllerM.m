//
//  ViewControllerM.m
//  Richness Locator
//
//  Created by Solomon Zitter and Gil Zamfirescu on 6/18/14.
//  Copyright (c) 2014 Solomon Zitter and Gil Zamfirescu. All rights reserved.
//

#import "ViewControllerM.h"

@interface ViewControllerM ()

@end

@implementation ViewControllerM

@synthesize map, locationManager, alreadyGotUserLocation, alreadyGotDestination, Generateth, Informationeth, usersLocation, prevDist, Destinationeth;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        alreadyGotUserLocation = NO;
        alreadyGotDestination = NO;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    Generateth.hidden = YES;
    // Do any additional setup after loading the view.
    [self startStandardUpdates];
    NSLog(@"LOADED");
    //    [self.map.showsUserLocation YES];
    map.showsUserLocation = YES;
    map.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startStandardUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (!locationManager)
    {
        locationManager = [[CLLocationManager alloc] init];
    }
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    
    // Set a movement threshold for new events.
    // locationManager.distanceFilter = 500; // meters
    
    [locationManager startUpdatingLocation];
}

// Delegate method from the CLLocationManagerDelegate protocol.

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    // If it's a relatively recent event, turn off updates to save power.
    
    CLLocation* location = [locations lastObject];
    //    CLLocationDegrees
    usersLocation.latitude = location.coordinate.latitude;
    usersLocation.longitude = location.coordinate.longitude;
    
    if(alreadyGotDestination)
    {
        double newDist = ((double) ((int) ([[[CLLocation alloc] initWithLatitude:usersLocation.latitude longitude:usersLocation.longitude] distanceFromLocation:Destinationeth] * 2))) / 2;
        
        if(abs(newDist - prevDist) < 1)
            return;
        
        if(newDist < prevDist)
            Informationeth.text = @"Thou art WARMERETH";
        else
            Informationeth.text = @"Thou art COLDERETH";
        
        NSString *distanceString = [[NSString alloc] initWithFormat:@"%d", (int) newDist];
        
        prevDist = newDist;
        
        [Generateth setTitle:distanceString forState:UIControlStateNormal];
    }
    
    if (!alreadyGotUserLocation && !(map.userLocation.location.coordinate.latitude == 0 && map.userLocation.location.coordinate.longitude == 0))
    {
        
        MKCoordinateRegion areaToZoom;
        areaToZoom.center = map.userLocation.location.coordinate;
        MKCoordinateSpan areaToSpan;
        areaToSpan.latitudeDelta = 0.005;
        areaToSpan.longitudeDelta = 0.005;
        areaToZoom.span = areaToSpan;
        
        self.usersLocation = areaToZoom.center;
        
        [map setRegion:areaToZoom animated:YES];
        alreadyGotUserLocation = YES;
        Generateth.hidden = NO;
    }
    
    //NSDate* eventDate = location.timestamp;
    //NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)Generateth:(id)sender
{
    Informationeth.text = @"GOETH FORTHETH AND FIND THY FORTUNETH";
    double latitude = (arc4random_uniform(360000) - 180000.0);
    self.Destinationeth = [[CLLocation alloc] initWithLatitude:usersLocation.latitude + latitude / 100000000 longitude:usersLocation.longitude + (arc4random_uniform(2 * sqrt(32400000000 - latitude * latitude)) - sqrt(32400000000 - latitude * latitude)) / 100000000];
    //NSLog(@"Latitude: %+.10f and Longitude: %+.10f", Destinationeth.coordinate.latitude, Destinationeth.coordinate.longitude);
    alreadyGotDestination = YES;
    
    
    
    CLLocation *origin = [[CLLocation alloc] initWithLatitude:usersLocation.latitude longitude:usersLocation.longitude];
    
    self.prevDist = ((double) ((int) ([self.Destinationeth distanceFromLocation:origin] * 2))) / 2;
    [self.map removeAnnotations:self.map.annotations];
    
    NSString *distanceString = [[NSString alloc] initWithFormat:@"%d", (int) prevDist];
    [Generateth setTitle:distanceString forState:UIControlStateNormal];
}

- (IBAction)Revealeth:(id)sender
{
    if(self.map.annotations.count == 2)
        return;
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = Destinationeth.coordinate;
    point.title = @"THY TREASURE";
    point.subtitle = @"LIËTH HERETH";
    [self.map addAnnotation:point];
}

@end