//
//  ViewControllerHelp.m
//  Midi file player
//
//  Created by Walter Schurter on 23.05.13.
//  Copyright (c) 2013 Walter Schurter WASElectronic. All rights reserved.
//

#import "ViewControllerHelp.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewControllerHelp ()

@end

@implementation ViewControllerHelp

@synthesize buttonNormal;
@synthesize buttonMute;
@synthesize buttonReceive;

- (BOOL)shouldAutorotate {
    [UIView setAnimationsEnabled:NO];
    return TRUE;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}
-  (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:NO];
    viewControllerHelpIsVisible = TRUE;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:NO];
    viewControllerHelpIsVisible = FALSE;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];

    [scrollview setScrollEnabled:YES];   // This is a must !
    [scrollview setContentSize:CGSizeMake(320, 3100)];  // This is a must ! Storyboard 320 x 720

    viewCont=[[ViewController alloc]init];
    [viewCont buttonStopPressed:nil];
    
    buttonNormal.clipsToBounds = YES;
    buttonMute.clipsToBounds = YES;
    buttonReceive.clipsToBounds = YES;
    buttonNormal.layer.cornerRadius = 7;
    buttonMute.layer.cornerRadius = 7;
    buttonReceive.layer.cornerRadius = 7;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)buttonAboutPressed:(id)sender {
    NSString *messageText = [NSString stringWithFormat:@"%@\n\n%@", @"Copyright ...", @"Some SoundFont instruments are friendly offered by NTONYX\nhttp://www.ntonyx.com/sf.htm"];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"About \"MFP\""
                                                   message: messageText
                                                  delegate: self
                                         cancelButtonTitle: nil
                                         otherButtonTitles:@"OK",nil];
    
    [alert show];
}

- (IBAction)buttonBackPressed:(id)sender {
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    backFromOtherView = TRUE;
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
