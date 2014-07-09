//
//  ViewController.h
//  Richness Locator
//
//  Created by Solomon Zitter on 6/17/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ViewControllerM.h"
#import "UserData.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) UserData * UD;
@property (strong, nonatomic) ViewControllerM * VCM;

@end
