//
//  ViewControllerOptionPad.h
//  AAccompanist
//
//  Created by Walter Schurter on 25.02.16.
//  Copyright © 2016 Walter Schurter. All rights reserved.
//

#import "ViewControllerOptionPad.h"

@interface ViewControllerOptionPad : UIViewController


@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonBack;
- (IBAction)buttonBackPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UISwitch *switchRealTime;
- (IBAction)switchRealTimeChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UISwitch *switchReceiveRealTime;
- (IBAction)switchReceiveRealTimeChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonBluetooth;
@property (weak, nonatomic) IBOutlet UIButton *buttonBluetoothSearch;
- (IBAction)configureCentral:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonCreateMIDIclient;
- (IBAction)configureLocalPeripheral:(id)sender;




@end
