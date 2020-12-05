//
//  ViewControllerHelpPad.h
//  Midi file player
//
//  Created by Walter Schurter on 09.12.13.
//  Copyright (c) 2013 Walter Schurter WASElectronic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerHelpPad : UIViewController{
    IBOutlet UIScrollView *scrollviewPad;
}

@property (weak, nonatomic) IBOutlet UIButton *buttonNormal;
@property (weak, nonatomic) IBOutlet UIButton *buttonMute;
@property (weak, nonatomic) IBOutlet UIButton *buttonReceive;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonBack;
- (IBAction)buttonBackPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonAbout;
- (IBAction)buttonAboutPressed:(id)sender;

@end
