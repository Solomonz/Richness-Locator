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

@synthesize map, locationManager, alreadyGotUserLocation, alreadyGotDestination, Generateth, Informationeth, usersLocation, prevDist, Destinationeth, GH, UD, time, distance, timer, outOfTime, Revealeth, followLabel, follow;

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
    GH = [[GenerationHelper alloc] init];
    Revealeth.hidden = YES;
    distance = 200;
    time = distance * 1.25;
    follow = YES;
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
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    // Set a movement threshold for new events.
    // locationManager.distanceFilter = 500; // meters
    
    [locationManager startUpdatingLocation];
}

// Delegate method from the CLLocationManagerDelegate protocol.

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation * location = [locations lastObject];
    usersLocation.latitude = location.coordinate.latitude;
    usersLocation.longitude = location.coordinate.longitude;
    
    if(alreadyGotDestination)
    {
        double newDist = ((double) ((int) ([location distanceFromLocation:Destinationeth] * 2))) / 2;
        
        if(newDist == prevDist/*abs(newDist - prevDist) < 0.5*/)
            return;
        
        if(newDist <= sqrt(distance / 4))
        {
            [self ReachedDestination:Informationeth.text.doubleValue];
            alreadyGotDestination = NO;
            return;
        }
        NSString *distanceString = [[NSString alloc] initWithFormat:@"%.1f", newDist];
        
        prevDist = newDist;
        
        [Generateth setTitle:distanceString forState:UIControlStateNormal];
    }
    
    if (!alreadyGotUserLocation && !(map.userLocation.location.coordinate.latitude == 0 && map.userLocation.location.coordinate.longitude == 0))
    {
        MKCoordinateRegion areaToZoom;
        areaToZoom.center = map.userLocation.location.coordinate;
        MKCoordinateSpan areaToSpan;
        areaToSpan.latitudeDelta = 2.1 * [GH dLat:location vertDistance:distance];
        areaToSpan.longitudeDelta = 2.1 * [GH dLon:location horizDistance:distance];
        areaToZoom.span = areaToSpan;
        
        usersLocation = areaToZoom.center;
        
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
    time = distance * 1.25;
    [Revealeth setTitle:[[NSString alloc] initWithFormat:@"%ld", UD.points] forState:UIControlStateNormal];
    [Informationeth setText: [[NSString alloc] initWithFormat:@"Thou hast %d seconds to find thy treasure!", (int) time]];
    
    CLLocation *origin = [[CLLocation alloc] initWithLatitude:usersLocation.latitude longitude:usersLocation.longitude];
    
    Destinationeth = [GH GeneratethRichness:origin atRadius:distance exact:YES];
    
    alreadyGotDestination = YES;
    
    prevDist = ((double) ((int) ([Destinationeth distanceFromLocation:origin] * 2))) / 2;
    [map removeAnnotations:map.annotations];
    
    NSString *distanceString = [[NSString alloc] initWithFormat:@"%.1f", prevDist];
    [Generateth setTitle:distanceString forState:UIControlStateNormal];
    //[self ReachedDestination:0];
    [self Revealeth:nil];
    outOfTime = NO;
    [timer invalidate];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
    Revealeth.hidden = NO;
}

- (IBAction)Revealeth:(id)sender
{
    if(map.annotations.count == 2)
    {
        [map removeAnnotations:map.annotations];
        return;
    }
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = Destinationeth.coordinate;
    point.title = @"THY TREASURE";
    point.subtitle = @"LIËTH HERETH";
    [map addAnnotation:point];
}

- (void) ReachedDestination:(double)timeLeft
{
    [timer invalidate];
    [map removeAnnotations:map.annotations];
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = Destinationeth.coordinate;
    point.title = @"THY TREASURE";
    point.subtitle = @"ITH THINE";
    [map addAnnotation:point];
    UD.points += timeLeft;
    NSString * path = [self getFullDocumentPath:@"UserData.plist"];
    NSMutableArray * a = [[NSMutableArray alloc] initWithObjects:[[NSNumber alloc] initWithLong:0/*UD.points*/], nil];
    [a writeToFile:path atomically:NO];
    NSLog(@"%ld", UD.points);
}

- (IBAction)toSeeOrNotToSee:(UISwitch *)sender forEvent:(UIEvent *)event {
}

- (NSString *)getFullDocumentPath:(NSString *)filename
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	// returns array of strings of the full paths to the documents directories for each user on the device (for accounts)
    NSString *docDir = [paths objectAtIndex:0];
	NSString *fullPath = [docDir stringByAppendingPathComponent:filename];
	return fullPath;
}

- (void) DidntQuiteMakeIt
{
    NSLog(@"you didn't quite make it");
    [map removeAnnotations:map.annotations];
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = Destinationeth.coordinate;
    point.title = @"Thou couldst have been moneyful!";
    point.subtitle = @"But thou werest too slothful";
    [map addAnnotation:point];
}

- (void) updateTimer:(NSTimer *) t
{
    if(time < 0.1 || outOfTime)
    {
        [timer invalidate];
        if(!outOfTime)
            [self DidntQuiteMakeIt];
        outOfTime = YES;
        [Informationeth setText: @"Thou hath run out of time"];
        timer = nil;
        return;
    }
    time -= 0.1;
    if(distance * 1.25 - 3 >= time)
        [Informationeth setText: [[NSString alloc] initWithFormat:@"%.1f", time]];
}

- (IBAction)followSwitch:(UISwitch *)sender
{follow = [sender isOn];}

- (void)zoomToUser:(CLLocation *)location
{
    
}

@end