//
//  ViewControllerPad.h
//  Midi file player
//
//  Created by Walter Schurter on 07.12.13.
//  Copyright (c) 2013 Walter Schurter WASElectronic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerPad : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *labelSleep;

@property (weak, nonatomic) IBOutlet UILabel *labelLocalSound1;

@property (weak, nonatomic) IBOutlet UIButton *buttonPlay;
- (IBAction)buttonPlayPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonPause;
- (IBAction)buttonPausePressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonStop;
- (IBAction)buttonStopPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonRecording;
- (IBAction)buttonRecordingPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UISlider *sliderTempo;
- (IBAction)sliderTempoChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UISlider *sliderSongPosition;
- (IBAction)sliderSongPositionChange:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *labelTempo;
@property (weak, nonatomic) IBOutlet UILabel *labelMIDIfile;

@property (weak, nonatomic) IBOutlet UIButton *previousMIDIfile;
- (IBAction)previousMIDIfilePressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *nextMIDIfile;
- (IBAction)nextMIDIfilePressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonSelect;
- (IBAction)buttonSelectPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonRefresh;
- (IBAction)buttonRefreshPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonDelete;
- (IBAction)buttonDeletePressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonTransposePlus;
- (IBAction)buttonTransposePlusPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonTransposeMinus;
- (IBAction)buttonTransposeMinusPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *labelTranspose1;

@property (weak, nonatomic) IBOutlet UILabel *labelNowLen;

@property (weak, nonatomic) IBOutlet UITextView *textFieldSYSEX;

@property (weak, nonatomic) IBOutlet UISwitch *switchMIDIthru;
- (IBAction)switchMIDIthruValueChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UISwitch *switchLocSnd;
- (IBAction)switchLocSndValChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UISwitch *switchShowSYSEX;
- (IBAction)switchShowSYSEXvalueChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UISwitch *switchFilterSYSEX;
- (IBAction)switchFilterSYSEXvalueChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UISwitch *switchIsSettings;
- (IBAction)switchIsSettingsValueChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UISwitch *switchAutoNext;
- (IBAction)switchAutoNextPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonTrack0;
- (IBAction)buttonTrack0pressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonTrack1;
- (IBAction)buttonTrack1pressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonTrack2;
- (IBAction)buttonTrack2pressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonTrack3;
- (IBAction)buttonTrack3pressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonTrack4;
- (IBAction)buttonTrack4pressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonTrack5;
- (IBAction)buttonTrack5pressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonTrack6;
- (IBAction)buttonTrack6pressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonTrack7;
- (IBAction)buttonTrack7pressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonTrack8;
- (IBAction)buttonTrack8pressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonTrack9;
- (IBAction)buttonTrack9pressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonTrack10;
- (IBAction)buttonTrack10pressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonTrack11;
- (IBAction)buttonTrack11pressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonTrack12;
- (IBAction)buttonTrack12pressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonTrack13;
- (IBAction)buttonTrack13pressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonTrack14;
- (IBAction)buttonTrack14pressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonTrack15;
- (IBAction)buttonTrack15pressed:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *labelMIDI_0;
@property (weak, nonatomic) IBOutlet UILabel *labelMIDI_1;
@property (weak, nonatomic) IBOutlet UILabel *labelMIDI_2;
@property (weak, nonatomic) IBOutlet UILabel *labelMIDI_3;
@property (weak, nonatomic) IBOutlet UILabel *labelMIDI_4;
@property (weak, nonatomic) IBOutlet UILabel *labelMIDI_5;
@property (weak, nonatomic) IBOutlet UILabel *labelMIDI_6;
@property (weak, nonatomic) IBOutlet UILabel *labelMIDI_7;
@property (weak, nonatomic) IBOutlet UILabel *labelMIDI_8;
@property (weak, nonatomic) IBOutlet UILabel *labelMIDI_9;
@property (weak, nonatomic) IBOutlet UILabel *labelMIDI_10;
@property (weak, nonatomic) IBOutlet UILabel *labelMIDI_11;
@property (weak, nonatomic) IBOutlet UILabel *labelMIDI_12;
@property (weak, nonatomic) IBOutlet UILabel *labelMIDI_13;
@property (weak, nonatomic) IBOutlet UILabel *labelMIDI_14;
@property (weak, nonatomic) IBOutlet UILabel *labelMIDI_15;

@property (weak, nonatomic) IBOutlet UISlider *slider2;
- (IBAction)slider2ValueChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UISlider *slider4;
- (IBAction)slider4ValueChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UISlider *slider6;
- (IBAction)slider6ValueChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UISlider *slider7;
- (IBAction)slider7ValueChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UISlider *slider8;
- (IBAction)slider8ValueChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *slider4text;
@property (weak, nonatomic) IBOutlet UITextField *slider6text;
@property (weak, nonatomic) IBOutlet UITextField *slider7text;
@property (weak, nonatomic) IBOutlet UILabel *labelCenter;

@property (weak, nonatomic) IBOutlet UIButton *buttonMinusP;
- (IBAction)buttonMinusPpressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonPlusP;
- (IBAction)buttonPlusPpressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonTest;
- (IBAction)buttonTestPressed:(id)sender;
- (IBAction)buttonTestReleased:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *labelInstrument;
@property (weak, nonatomic) IBOutlet UILabel *labelInstrNumb;

@property (weak, nonatomic) IBOutlet UIButton *buttonChannel0;
- (IBAction)buttonChannel0pressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonChannel1;
- (IBAction)buttonChannel1pressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonChannel2;
- (IBAction)buttonChannel2pressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonChannel3;
- (IBAction)buttonChannel3pressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonChannel4;
- (IBAction)buttonChannel4pressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonChannel5;
- (IBAction)buttonChannel5pressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonChannel6;
- (IBAction)buttonChannel6pressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonChannel7;
- (IBAction)buttonChannel7pressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonChannel8;
- (IBAction)buttonChannel8pressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonChannel9;
- (IBAction)buttonChannel9pressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonChannel10;
- (IBAction)buttonChannel10pressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonChannel11;
- (IBAction)buttonChannel11pressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonChannel12;
- (IBAction)buttonChannel12pressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonChannel13;
- (IBAction)buttonChannel13pressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonChannel14;
- (IBAction)buttonChannel14pressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonChannel15;
- (IBAction)buttonChannel15pressed:(id)sender;

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

@property (weak, nonatomic) IBOutlet UISwitch *switchBackgroundPlay;
- (IBAction)switchBackgroundPlayPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonMinusChord;
- (IBAction)buttonMinusChordPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonPlusChord;
- (IBAction)buttonPlusChordPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *textFieldChord;

@property (weak, nonatomic) IBOutlet UILabel *labelChordBig;

@property (weak, nonatomic) IBOutlet UILabel *labelChordChannel;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonAbout;
- (IBAction)buttonAboutPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonMoreMIDIoptions;

@property (weak, nonatomic) IBOutlet UISwitch *switchDrumSet0;
- (IBAction)switchDrumSet0valueChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonStartPoint;
- (IBAction)buttonStartPointPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonEndPoint;
- (IBAction)buttonEndPointPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *buttonLoop;
- (IBAction)buttonLoopPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *labelStartPoint;

@property (weak, nonatomic) IBOutlet UILabel *labelEndPoint;

- (void) saveLastSelectedMIDIfile;
- (void) parseDir;
- (void) setParseDirPad;

@end

