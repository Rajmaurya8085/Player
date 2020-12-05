//
//  ViewControllerDevices.h
//  MIDI tools
//
//  Created by Walter Schurter on 09.10.13.
//  Copyright (c) 2013 Walter Schurter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerDevices : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *outDeviceTextField;

@property (weak, nonatomic) IBOutlet UITextField *inDeviceTextField;

@property (weak, nonatomic) IBOutlet UIButton *buttonPrevOut;
- (IBAction)buttonPrevOutPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonNextOut;
- (IBAction)buttonNextOutPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonPrevIn;
- (IBAction)buttonPrevInPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonNextIn;
- (IBAction)buttonNextInPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonOK;
- (IBAction)buttonOKpressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonMoreMIDIoptions;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonBack;

- (IBAction)buttonBackPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonBluetooth;
@property (weak, nonatomic) IBOutlet UIButton *buttonBluetoothSearch;
- (IBAction)configureCentral:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonCreateMIDIclient;
- (IBAction)configureLocalPeripheral:(id)sender;

@end
