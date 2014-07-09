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
    self.UD = [[UserData alloc] init];
    if([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        NSMutableArray * a = [[NSMutableArray alloc] initWithContentsOfFile:path];
        self.UD.points = [[a objectAtIndex:0] integerValue];
    }
    else
        self.UD.points = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.VCM = [segue destinationViewController];
    self.VCM.UD = self.UD;
}

@end
