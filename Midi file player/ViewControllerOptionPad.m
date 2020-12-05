//
//  ViewControllerOptionPad.m
//  AAccompanist
//
//  Created by Walter Schurter on 25.02.16.
//  Copyright © 2016 Walter Schurter. All rights reserved.
//

#import "ViewControllerOptionPad.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "CoreAudioKit/CoreAudioKit.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewControllerOptionPad () <CBCentralManagerDelegate>

@property (nonatomic) CBCentralManager *bluetoothManager;

@end

@implementation ViewControllerOptionPad

@synthesize switchRealTime;
@synthesize switchReceiveRealTime;
@synthesize buttonBluetooth;

UIImage *image = NULL;
UIImage *imageBT = NULL;

int countListPad = 9;
Byte partOptionPad = 0;

NSTimer *timerForOptionPad;

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

- (void)viewDidLoad {
    
    _bluetoothManager = [[CBCentralManager alloc] initWithDelegate:self
                                                             queue:nil
                                                           options:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0]
                                                                                               forKey:CBCentralManagerOptionShowPowerAlertKey]];

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Achtung: in "Accordion-Info.plist" "View controller-based status bar appearance" set "NO"
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:0.65 green:0.65 blue:0.65 alpha:1.0f]];
    
    buttonBluetooth.clipsToBounds = YES;
    
    buttonBluetooth.layer.cornerRadius = 24;

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
    if (timerForOptionPad != nil) {
        [timerForOptionPad invalidate];
        timerForOptionPad = nil;
    }
    backFromOtherView = TRUE;
    [self dismissViewControllerAnimated:NO completion:nil];    
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

- (void)doneAction:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)configureCentral:(id)sender {
    
    CABTMIDICentralViewController *viewControllerBT = [CABTMIDICentralViewController new];
    
    UINavigationController *navControllerBT = [[UINavigationController alloc] initWithRootViewController:viewControllerBT];

    navControllerBT.modalPresentationStyle = UIModalPresentationPopover;
    
    UIPopoverPresentationController *popC = navControllerBT.popoverPresentationController;
    popC.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popC.sourceRect = [sender frame];
    
    UIButton *button = (UIButton *)sender;
    popC.sourceView = button.superview;
    
    [self presentViewController:navControllerBT animated:NO completion:nil];
    
}

- (IBAction)configureLocalPeripheral:(UIButton *)sender {
    
    CABTMIDILocalPeripheralViewController *viewControllerBTA = [[CABTMIDILocalPeripheralViewController alloc] init];
   
    UINavigationController *navControllerBTA = [[UINavigationController alloc] initWithRootViewController:viewControllerBTA];
    
    navControllerBTA.modalPresentationStyle = UIModalPresentationPopover;
    
    UIPopoverPresentationController *popC = navControllerBTA.popoverPresentationController;
    popC.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popC.sourceRect = [sender frame];
    
    UIButton *button = (UIButton *)sender;
    popC.sourceView = button.superview;
    
    [self presentViewController:navControllerBTA animated:NO completion:nil];

}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    // This delegate method will monitor for any changes in bluetooth state and respond accordingly
    //NSString *stateString = nil;
    switch(_bluetoothManager.state) {
        case CBCentralManagerStateResetting:
            //stateString = @"The connection with the system service was momentarily lost, update imminent.";
            break;
        case CBCentralManagerStateUnsupported:
            //stateString = @"The platform doesn't support Bluetooth Low Energy.";
            break;
        case CBCentralManagerStateUnauthorized:
            //stateString = @"The app is not authorized to use Bluetooth Low Energy.";
            break;
        case CBCentralManagerStatePoweredOff:
            //stateString = @"Bluetooth is currently powered off.";
            imageBT = [UIImage imageNamed:@"Bluetooth.png"];
            [buttonBluetooth setImage:imageBT forState:UIControlStateNormal];
            break;
        case CBCentralManagerStatePoweredOn:
            //stateString = @"Bluetooth is currently powered on and available to use.";
            imageBT = [UIImage imageNamed:@"BluetoothON.png"];
            [buttonBluetooth setImage:imageBT forState:UIControlStateNormal];
            break;
        default:
            //stateString = @"State unknown, update imminent.";
            break;
    }
    
}

@end
