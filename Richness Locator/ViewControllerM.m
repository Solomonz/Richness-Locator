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

@synthesize map, locationManager, alreadyGotUserLocation, alreadyGotDestination, Generateth, Informationeth, usersLocation, prevDist, Destinationeth, GH, UD, time, distance, timer, outOfTime;

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
    map.showsUserLocation = YES;
    map.delegate = self;
    self.GH = [[GenerationHelper alloc] init];
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
    usersLocation.latitude = location.coordinate.latitude;
    usersLocation.longitude = location.coordinate.longitude;
    
    if(alreadyGotDestination)
    {
        double newDist = ((double) ((int) ([[[CLLocation alloc] initWithLatitude:usersLocation.latitude longitude:usersLocation.longitude] distanceFromLocation:Destinationeth] * 2))) / 2;
        
        if(abs(newDist - prevDist) < 1)
            return;
        
        if(newDist <= 5)
        {
            [self ReachedDestination:Informationeth.text.doubleValue];
            alreadyGotDestination = NO;
            return;
        }
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
    self.distance = 10;
    [Informationeth setText: [[NSString alloc] initWithFormat:@"Thou hast %d seconds to find thy treasure!", self.distance]];
    
    CLLocation *origin = [[CLLocation alloc] initWithLatitude:usersLocation.latitude longitude:usersLocation.longitude];
    
    self.Destinationeth = [self.GH GeneratethRichness:origin atRadius:self.distance exact:YES];
    
    alreadyGotDestination = YES;
    
    self.prevDist = ((double) ((int) ([self.Destinationeth distanceFromLocation:origin] * 2))) / 2;
    [self.map removeAnnotations:self.map.annotations];
    
    NSString *distanceString = [[NSString alloc] initWithFormat:@"%d", (int) prevDist];
    [Generateth setTitle:distanceString forState:UIControlStateNormal];
//    [self ReachedDestination:10];
    
    self.time = self.distance;
    self.outOfTime = NO;
    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
}

- (IBAction)Revealeth:(id)sender
{
    if(self.map.annotations.count == 2)
    {
        [self.map removeAnnotations:self.map.annotations];
        return;
    }
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = Destinationeth.coordinate;
    point.title = @"THY TREASURE";
    point.subtitle = @"LIËTH HERETH";
    [self.map addAnnotation:point];
}

- (void) ReachedDestination:(double)timeLeft
{
    [self Revealeth:NULL];
    self.UD.points += timeLeft;
    NSString * path = [self getFullDocumentPath:@"UserData.plist"];
    NSMutableArray * a = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithLong:0], nil];
    [a writeToFile:path atomically:NO];
    NSLog(@"%ld", self.UD.points);
}

- (NSString *)getFullDocumentPath:(NSString * )filename
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	// returns array of strings of the full paths to the documents directories for each user on the device (for accounts)
    NSString *docDir = [paths objectAtIndex:0];
	NSString *fullPath = [docDir stringByAppendingPathComponent:filename];
	return fullPath;
}

- (void) DidntQuiteMakeIt
{
    NSLog(@"hello");
}

- (void) updateTimer:(NSTimer *) t
{
    self.time -= 0.1;
    if(self.time < 0.1 || self.outOfTime)
    {
        [self.timer invalidate];
        if(!self.outOfTime)
            [self DidntQuiteMakeIt];
        self.outOfTime = YES;
        [Informationeth setText: @"Thou hath run out of time"];
        self.timer = nil;
        return;
    }
    if(self.distance - 1.5 >= self.time)
        [Informationeth setText: [[NSString alloc] initWithFormat:@"%.1f", self.time]];
}

@end