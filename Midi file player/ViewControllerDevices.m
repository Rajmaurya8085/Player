//
//  ViewController5.m
//  MIDI tools
//
//  Created by Walter Schurter on 09.10.13.
//  Copyright (c) 2013 Walter Schurter. All rights reserved.
//

#import "ViewControllerDevices.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import "CoreAudioKit/CoreAudioKit.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewControllerDevices () <CBCentralManagerDelegate>
@property (nonatomic) CBCentralManager *bluetoothManager;
@end

@interface ViewControllerDevices ()
@end

@implementation ViewControllerDevices

@synthesize outDeviceTextField;
@synthesize inDeviceTextField;
@synthesize buttonOK;
@synthesize buttonMoreMIDIoptions;
@synthesize buttonBack;
@synthesize buttonBluetooth;

bool changesMade = FALSE;
UIImage *imageBTiPhone = NULL;

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

- (void)viewDidLoad {
    
    _bluetoothManager = [[CBCentralManager alloc] initWithDelegate:self
                                                             queue:nil
                                                           options:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0]
                                                                                               forKey:CBCentralManagerOptionShowPowerAlertKey]];

    [super viewDidLoad];
	// Do any additional setup after loading the view.

    buttonOK.clipsToBounds = YES;
    buttonMoreMIDIoptions.clipsToBounds = YES;
    buttonBluetooth.clipsToBounds = YES;
    
    buttonOK.layer.cornerRadius = 10;
    buttonMoreMIDIoptions.layer.cornerRadius = 10;
    buttonBluetooth.layer.cornerRadius = 17;
    
    if (posOutput > ([arrayOutDevices count]-1)) {
        posOutput = (int)[arrayOutDevices count]-1;
    }
    if (posInput > ([arrayInDevices count]-1)) {
        posInput = (int)[arrayInDevices count]-1;
    }
    outDeviceTextField.text = arrayOutDevices[posOutput];
    inDeviceTextField.text = arrayInDevices[posInput];
    
}

- (void) saveDevices {
    userPreferences = [NSUserDefaults standardUserDefaults];
    [userPreferences setInteger:posOutput forKey:@"posOutput"];
    [userPreferences setInteger:posInput forKey:@"posInput"];
    [userPreferences setBool:TRUE forKey:@"posWasSaved"];
    [userPreferences synchronize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPrevOutPressed:(id)sender {
    if (posOutput > 0) {
        posOutput--;
        outDeviceTextField.text = arrayOutDevices[posOutput];        
        [self saveDevices];
        changesMade = TRUE;
    }
}

- (IBAction)buttonNextOutPressed:(id)sender {
    if (posOutput < ([arrayOutDevices count]-1)) {
        posOutput++;
        outDeviceTextField.text = arrayOutDevices[posOutput];
        [self saveDevices];
        changesMade = TRUE;
    }
}

- (IBAction)buttonPrevInPressed:(id)sender {
    if (posInput > 0) {
        posInput--;
        inDeviceTextField.text = arrayInDevices[posInput];
        [self saveDevices];
        changesMade = TRUE;
    }
}

- (IBAction)buttonNextInPressed:(id)sender {
    if (posInput < ([arrayInDevices count]-1)) {
        posInput++;
        inDeviceTextField.text = arrayInDevices[posInput];
        [self saveDevices];
        changesMade = TRUE;
    }
}
- (IBAction)buttonOKpressed:(id)sender {
    if (changesMade) {
        viewCont=[[ViewController alloc]init];
        [viewCont initializationMIDI];
        backFromOtherView = TRUE;
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    else {
        backFromOtherView = TRUE;
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

- (IBAction)buttonBackPressed:(id)sender {
    [self buttonOKpressed:nil];
}

- (void)doneAction:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)configureCentral:(id)sender {
    
    CABTMIDICentralViewController *viewControllerBT = [CABTMIDICentralViewController new];
    
    UINavigationController *navControllerBT = [[UINavigationController alloc] initWithRootViewController:viewControllerBT];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(screenSize.width-60, 40, 60, 40);
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
    [btn setTitle:@"Done" forState:UIControlStateNormal];
    [btn addTarget:self action: @selector(doneAction:) forControlEvents: UIControlEventTouchDown];
    [navControllerBT.view addSubview:btn];

    [self presentViewController:navControllerBT animated:NO completion:nil];
    
}

- (IBAction)configureLocalPeripheral:(UIButton *)sender {
    
    CABTMIDILocalPeripheralViewController *viewControllerBTA = [[CABTMIDILocalPeripheralViewController alloc] init];
    
    UINavigationController *navControllerBTA = [[UINavigationController alloc] initWithRootViewController:viewControllerBTA];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(screenSize.width-60, 40, 60, 40);
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
    [btn setTitle:@"Done" forState:UIControlStateNormal];
    [btn addTarget:self action: @selector(doneAction:) forControlEvents: UIControlEventTouchDown];
    [navControllerBTA.view addSubview:btn];
    
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
            imageBTiPhone = [UIImage imageNamed:@"Bluetooth.png"];
            [buttonBluetooth setImage:imageBTiPhone forState:UIControlStateNormal];
            break;
        case CBCentralManagerStatePoweredOn:
            //stateString = @"Bluetooth is currently powered on and available to use.";
            imageBTiPhone = [UIImage imageNamed:@"BluetoothON.png"];
            [buttonBluetooth setImage:imageBTiPhone forState:UIControlStateNormal];
            break;
        default:
            //stateString = @"State unknown, update imminent.";
            break;
    }
    //NSLog(@"Bluetooth State: %@",stateString);
}

@end
