//
//  ViewControllerOptions.h
//  AAccompanist
//
//  Created by Walter Schurter on 24.02.16.
//  Copyright © 2016 Walter Schurter. All rights reserved.
//

#import "ViewController.h"

@interface ViewControllerOptions : ViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonBack;
- (IBAction)buttonBackPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UISwitch *switchRealTime;
- (IBAction)switchRealTimeChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UISwitch *switchReceiveRealTime;
- (IBAction)switchReceiveRealTimeChanged:(id)sender;

@end
