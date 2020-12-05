//
//  pickerView.h
//  Midi file player
//
//  Created by Walter Schurter on 16.05.13.
//  Copyright (c) 2013 Walter Schurter WASElectronic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#define midiFileIndex 0
#import <MessageUI/MessageUI.h>

@interface pickerView : UIViewController

<UIPickerViewDataSource, UIPickerViewDelegate, MFMailComposeViewControllerDelegate>{
    IBOutlet UIPickerView *midiFilesPicker;
    NSMutableArray *midiFilesForPicker;
}
@property (weak, nonatomic) IBOutlet UIButton *buttonCancel;
- (IBAction)buttonCancelPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonEdit;
- (IBAction)buttonEditPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonOK;
- (IBAction)buttonOKpressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonDelete;
- (IBAction)buttonDeletePressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonSearch;
- (IBAction)buttonSearchPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonSearchNext;
- (IBAction)buttonSearchNextPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonUp;
- (IBAction)buttonUpPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonDown;
- (IBAction)buttonDownPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonTopList;
- (IBAction)buttonTopListPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonEndList;
- (IBAction)buttonEndListPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonAddFavorites;
- (IBAction)buttonAddFavoritesPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonGoToFavorites;
- (IBAction)buttonGoToFavoritesPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonRemoveFavorites;
- (IBAction)buttonRemoveFavoritesPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *textFieldEditFileName;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerFiles;

@property (weak, nonatomic) IBOutlet UILabel *labelRenameSearch;

- (IBAction)ReturnKeyButton:(id)sender;

- (IBAction)buttonMailPressed:(id)sender;

@end
