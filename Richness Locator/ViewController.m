//
//  ViewController.m
//  Richness Locator
//
//  Created by Solomon Zitter on 6/17/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize UD, VCM;

- (NSString *)getFullDocumentPath:(NSString * )filename
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	// returns array of strings of the full paths to the documents directories for each user on the device (for accounts)
    NSString *docDir = [paths objectAtIndex:0];
	NSString *fullPath = [docDir stringByAppendingPathComponent:filename];
	return fullPath;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *path = [self getFullDocumentPath:@"UserData.plist"];
    UD = [[UserData alloc] init];
    if([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        NSMutableArray * a = [[NSMutableArray alloc] initWithContentsOfFile:path];
        UD.points = [[a objectAtIndex:0] integerValue];
    }
    else
        UD.points = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if(segue.class != [[ViewControllerM alloc] init])
        return;
    VCM = [segue destinationViewController];
    VCM.UD = UD;
}

@end
