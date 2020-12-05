//
//  ViewControllerOptions.m
//  AAccompanist
//
//  Created by Walter Schurter on 24.02.16.
//  Copyright © 2016 Walter Schurter. All rights reserved.
//

#import "ViewControllerOptions.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewControllerOptions ()
@end

@implementation ViewControllerOptions

@synthesize switchRealTime;
@synthesize switchReceiveRealTime;

UIImage *imageA = NULL;

int countListPhoneA = 9;
Byte partOption = 0;

NSTimer *timerForOption;

AppDelegate *appDelegate;

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

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)ViewControllerSettingsPad;
{
    return 1;
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
    [super viewDidAppear:FALSE];
    //    viewControllerHelpIsVisible = TRUE;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:FALSE];
    //    viewControllerHelpIsVisible = FALSE;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Achtung: in "Accordion-Info.plist" "View controller-based status bar appearance" set "NO"
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:0.65 green:0.65 blue:0.65 alpha:1.0f]];

    switchRealTime.on = sendStartContinueStop;
    switchReceiveRealTime.on = receiveStartContinueStop;
    
    drumSet = 0;
    
    instrumentTest = 0;
    
    mustRefreshOption = TRUE;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)buttonBackPressed:(id)sender {
    if (timerForOption != nil) {
        [timerForOption invalidate];
        timerForOption = nil;
    }
    backFromOtherView = TRUE;
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)buttonDefaultPressed:(id)sender {
    defaultAlert = [[UIAlertView alloc]initWithTitle: @"Set default instrument mapping?"
                                             message: @"\nThe personal settings will be lost.\n\nSet default mapping now?"
                                            delegate: self
                                   cancelButtonTitle: @"YES"
                                   otherButtonTitles: @"NO",nil];
    [defaultAlert show];
}


- (void) sendMIDIevents :(int)numberOfEvents :(int)statusInfo :(int)param1 :(int)param2 {
    if (statusInfo > 0x7F && param1 < 0x80 && param2 < 0x80) {
        packetList.numPackets = 1;
        firstPacket = &packetList.packet[0];
        firstPacket->timeStamp = 0;	// send immediately
        int iP = 0;
        firstPacket->data[iP] = statusInfo;
        iP++;
        if (numberOfEvents > 1){
            firstPacket->data[iP] = param1;
            iP++;
            if (numberOfEvents > 2){
                firstPacket->data[iP] = param2;
                iP++;
            }
        }
        firstPacket->length = iP;
        
        if (deviceIDdest > -1){
            s = MIDISend(outputPort, outputEndpoint, &packetList);
        }
        
    }
}

- (IBAction)switchRealTimeChanged:(id)sender {
    sendStartContinueStop = switchRealTime.isOn;
    userPreferences = [NSUserDefaults standardUserDefaults];
    [userPreferences setBool:sendStartContinueStop forKey:@"sendStartContinueStop"];
    [userPreferences synchronize];
}

- (IBAction)switchReceiveRealTimeChanged:(id)sender {
    receiveStartContinueStop = switchReceiveRealTime.isOn;
    userPreferences = [NSUserDefaults standardUserDefaults];
    [userPreferences setBool:receiveStartContinueStop forKey:@"receiveStartContinueStop"];
    [userPreferences synchronize];
}

@end
