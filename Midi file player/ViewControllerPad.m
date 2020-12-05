//
//  ViewControllerPad.m
//  Midi file player
//
//  Created by Walter Schurter on 07.12.13.
//  Copyright (c) 2013 Walter Schurter WASElectronic. All rights reserved.
//

#import "ViewControllerPad.h"
#import <CoreMIDI/MIDIServices.h>
#import <CoreMIDI/CoreMIDI.h>
#import "AudioClass.h"
#import "AppDelegate.h"
#include <sys/time.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#include <sys/types.h>
#include <sys/sysctl.h>

@interface ViewControllerPad ()
@end

@implementation ViewControllerPad

@synthesize labelSleep;
@synthesize labelLocalSound1;
@synthesize sliderTempo;
@synthesize sliderSongPosition;
@synthesize labelTempo;
@synthesize labelMIDIfile;
@synthesize labelNowLen;
@synthesize labelTranspose1;
@synthesize textFieldSYSEX;
@synthesize previousMIDIfile;
@synthesize nextMIDIfile;
@synthesize buttonPause;
@synthesize buttonPlay;
@synthesize buttonDelete;
@synthesize buttonStop;
@synthesize buttonRecording;
@synthesize buttonSelect;
@synthesize buttonRefresh;
@synthesize switchMIDIthru;
@synthesize switchLocSnd;
@synthesize switchShowSYSEX;
@synthesize switchFilterSYSEX;
@synthesize switchIsSettings;
@synthesize switchBackgroundPlay;
@synthesize switchAutoNext;
@synthesize switchDrumSet0;
@synthesize buttonTrack0;
@synthesize buttonTrack1;
@synthesize buttonTrack2;
@synthesize buttonTrack3;
@synthesize buttonTrack4;
@synthesize buttonTrack5;
@synthesize buttonTrack6;
@synthesize buttonTrack7;
@synthesize buttonTrack8;
@synthesize buttonTrack9;
@synthesize buttonTrack10;
@synthesize buttonTrack11;
@synthesize buttonTrack12;
@synthesize buttonTrack13;
@synthesize buttonTrack14;
@synthesize buttonTrack15;
@synthesize buttonTransposePlus;
@synthesize buttonTransposeMinus;
@synthesize buttonMinusChord;
@synthesize buttonPlusChord;

@synthesize buttonStartPoint;
@synthesize buttonEndPoint;
@synthesize buttonLoop;

@synthesize textFieldChord;
@synthesize labelChordBig;

@synthesize labelMIDI_0;
@synthesize labelMIDI_1;
@synthesize labelMIDI_2;
@synthesize labelMIDI_3;
@synthesize labelMIDI_4;
@synthesize labelMIDI_5;
@synthesize labelMIDI_6;
@synthesize labelMIDI_7;
@synthesize labelMIDI_8;
@synthesize labelMIDI_9;
@synthesize labelMIDI_10;
@synthesize labelMIDI_11;
@synthesize labelMIDI_12;
@synthesize labelMIDI_13;
@synthesize labelMIDI_14;
@synthesize labelMIDI_15;

@synthesize labelStartPoint;
@synthesize labelEndPoint;

@synthesize slider2;
@synthesize slider4;
@synthesize slider6;
@synthesize slider7;
@synthesize slider8;
@synthesize labelCenter;
@synthesize buttonPlusP;
@synthesize buttonMinusP;
@synthesize buttonTest;
@synthesize labelInstrument;
@synthesize labelInstrNumb;
@synthesize labelChordChannel;

@synthesize slider4text;
@synthesize slider6text;
@synthesize slider7text;

@synthesize buttonChannel0;
@synthesize buttonChannel1;
@synthesize buttonChannel2;
@synthesize buttonChannel3;
@synthesize buttonChannel4;
@synthesize buttonChannel5;
@synthesize buttonChannel6;
@synthesize buttonChannel7;
@synthesize buttonChannel8;
@synthesize buttonChannel9;
@synthesize buttonChannel10;
@synthesize buttonChannel11;
@synthesize buttonChannel12;
@synthesize buttonChannel13;
@synthesize buttonChannel14;
@synthesize buttonChannel15;

@synthesize outDeviceTextField;
@synthesize inDeviceTextField;
@synthesize buttonPrevOut;
@synthesize buttonNextOut;
@synthesize buttonPrevIn;
@synthesize buttonNextIn;

@synthesize buttonMoreMIDIoptions;

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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:NO];
    
    /*
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft] forKey:@"orientation"];
    }
    else {
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInt:UIInterfaceOrientationPortrait] forKey:@"orientation"];
    }
    */
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:NO];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:NO];
    if (backFromOtherView) {
        backFromOtherView = FALSE;
        [self viewDidLoad];
    }
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    
    screenBound = [[UIScreen mainScreen] bounds];
    screenSize = screenBound.size;

    if (!initWasDone) {
        UILabel *line1 = [[UILabel alloc]init];
        line1.backgroundColor = [UIColor colorWithRed:darkGreySlider green:darkGreySlider blue:darkGreySlider alpha:1.0f];
        line1.frame = CGRectMake(0, 429, screenSize.width, 2);
        [self.view addSubview:line1];
        UILabel *line2 = [[UILabel alloc]init];
        line2.backgroundColor = [UIColor colorWithRed:darkGreySlider+0.2 green:darkGreySlider+0.2 blue:darkGreySlider+0.2 alpha:1.0f];
        line2.frame = CGRectMake(0, 431, screenSize.width, 2);
        [self.view addSubview:line2];
        
        UILabel *line3 = [[UILabel alloc]init];
        line3.backgroundColor = [UIColor colorWithRed:darkGreySlider green:darkGreySlider blue:darkGreySlider alpha:1.0f];
        line3.frame = CGRectMake(0, 746, screenSize.width, 2);
        [self.view addSubview:line3];
        UILabel *line4 = [[UILabel alloc]init];
        line4.backgroundColor = [UIColor colorWithRed:darkGreySlider+0.2 green:darkGreySlider+0.2 blue:darkGreySlider+0.2 alpha:1.0f];
        line4.frame = CGRectMake(0, 748, screenSize.width, 2);
        [self.view addSubview:line4];
        
        fileManager = [NSFileManager defaultManager];
        
        if (appDelegate==nil) appDelegate=[[AppDelegate alloc]init];
        
        if (is_IPHONE_5 || iPadA6) {
            timerIntervall = 0.002; // for MIDI input treatment
            counterIntervall = (int)(1 / timerIntervall / 5);
        }
        else {
            timerIntervall = 0.003; // for MIDI input treatment
            counterIntervall = (int)(1 / timerIntervall / 4);
        }
    }
    
    mustParseDir = FALSE;
    lastImportedMIDIfile = @"";
    dataSaved = FALSE;
    
    channelTest = 99;  // nothing
    velocityTest = 0;
    
    if (!initWasDone) {
        switchMIDIthruState = FALSE;
        switchMIDIthru.on = switchMIDIthruState;
        switchLocalSoundState = TRUE;
        switchLocSnd.on = switchLocalSoundState;
        switchShowSYSEXstate = FALSE;
        switchShowSYSEX.on = switchShowSYSEXstate;
        switchFilterSYSEXstate = TRUE;
        switchFilterSYSEX.on = switchFilterSYSEXstate;
        backgroundPlayAllowed = FALSE;
        switchBackgroundPlay.on = backgroundPlayAllowed;
        autoNext = FALSE;
        switchAutoNext.on = autoNext;
        drumSet0 = TRUE;
        switchDrumSet0.on = drumSet0;
        
        previousMIDIfile.clipsToBounds = YES;
        nextMIDIfile.clipsToBounds = YES;
        buttonPause.clipsToBounds = YES;
        buttonPlay.clipsToBounds = YES;
        buttonDelete.clipsToBounds = YES;
        buttonStop.clipsToBounds = YES;
        buttonRecording.clipsToBounds = YES;
        buttonSelect.clipsToBounds = YES;
        buttonRefresh.clipsToBounds = YES;
        buttonTrack0.clipsToBounds = YES;
        buttonTrack1.clipsToBounds = YES;
        buttonTrack2.clipsToBounds = YES;
        buttonTrack3.clipsToBounds = YES;
        buttonTrack4.clipsToBounds = YES;
        buttonTrack5.clipsToBounds = YES;
        buttonTrack6.clipsToBounds = YES;
        buttonTrack7.clipsToBounds = YES;
        buttonTrack8.clipsToBounds = YES;
        buttonTrack9.clipsToBounds = YES;
        buttonTrack10.clipsToBounds = YES;
        buttonTrack11.clipsToBounds = YES;
        buttonTrack12.clipsToBounds = YES;
        buttonTrack13.clipsToBounds = YES;
        buttonTrack14.clipsToBounds = YES;
        buttonTrack15.clipsToBounds = YES;
        buttonTransposePlus.clipsToBounds = YES;
        buttonTransposeMinus.clipsToBounds = YES;
        buttonMinusChord.clipsToBounds = YES;
        buttonPlusChord.clipsToBounds = YES;
        buttonChannel0.clipsToBounds = YES;
        buttonChannel1.clipsToBounds = YES;
        buttonChannel2.clipsToBounds = YES;
        buttonChannel3.clipsToBounds = YES;
        buttonChannel4.clipsToBounds = YES;
        buttonChannel5.clipsToBounds = YES;
        buttonChannel6.clipsToBounds = YES;
        buttonChannel7.clipsToBounds = YES;
        buttonChannel8.clipsToBounds = YES;
        buttonChannel9.clipsToBounds = YES;
        buttonChannel10.clipsToBounds = YES;
        buttonChannel11.clipsToBounds = YES;
        buttonChannel12.clipsToBounds = YES;
        buttonChannel13.clipsToBounds = YES;
        buttonChannel14.clipsToBounds = YES;
        buttonChannel15.clipsToBounds = YES;
        buttonTest.clipsToBounds = YES;
        buttonPlusP.clipsToBounds = YES;
        buttonMinusP.clipsToBounds = YES;
        buttonMoreMIDIoptions.clipsToBounds = YES;
        buttonStartPoint.clipsToBounds = YES;
        buttonEndPoint.clipsToBounds = YES;
        buttonLoop.clipsToBounds = YES;
        
        previousMIDIfile.layer.cornerRadius = 10;
        nextMIDIfile.layer.cornerRadius = 10;
        buttonPause.layer.cornerRadius = 10;
        buttonPlay.layer.cornerRadius = 10;
        buttonDelete.layer.cornerRadius = 10;
        buttonStop.layer.cornerRadius = 10;
        buttonRecording.layer.cornerRadius = 10;
        buttonSelect.layer.cornerRadius = 10;
        buttonRefresh.layer.cornerRadius = 10;
        buttonTrack0.layer.cornerRadius = 7;
        buttonTrack1.layer.cornerRadius = 7;
        buttonTrack2.layer.cornerRadius = 7;
        buttonTrack3.layer.cornerRadius = 7;
        buttonTrack4.layer.cornerRadius = 7;
        buttonTrack5.layer.cornerRadius = 7;
        buttonTrack6.layer.cornerRadius = 7;
        buttonTrack7.layer.cornerRadius = 7;
        buttonTrack8.layer.cornerRadius = 7;
        buttonTrack9.layer.cornerRadius = 18;
        buttonTrack10.layer.cornerRadius = 7;
        buttonTrack11.layer.cornerRadius = 7;
        buttonTrack12.layer.cornerRadius = 7;
        buttonTrack13.layer.cornerRadius = 7;
        buttonTrack14.layer.cornerRadius = 7;
        buttonTrack15.layer.cornerRadius = 7;
        buttonTransposePlus.layer.cornerRadius = 7;
        buttonTransposeMinus.layer.cornerRadius = 7;
        buttonMinusChord.layer.cornerRadius = 7;
        buttonPlusChord.layer.cornerRadius = 7;
        buttonChannel0.layer.cornerRadius = 7;
        buttonChannel1.layer.cornerRadius = 7;
        buttonChannel2.layer.cornerRadius = 7;
        buttonChannel3.layer.cornerRadius = 7;
        buttonChannel4.layer.cornerRadius = 7;
        buttonChannel5.layer.cornerRadius = 7;
        buttonChannel6.layer.cornerRadius = 7;
        buttonChannel7.layer.cornerRadius = 7;
        buttonChannel8.layer.cornerRadius = 7;
        buttonChannel9.layer.cornerRadius = 18;
        buttonChannel10.layer.cornerRadius = 7;
        buttonChannel11.layer.cornerRadius = 7;
        buttonChannel12.layer.cornerRadius = 7;
        buttonChannel13.layer.cornerRadius = 7;
        buttonChannel14.layer.cornerRadius = 7;
        buttonChannel15.layer.cornerRadius = 7;
        buttonTest.layer.cornerRadius = 10;
        buttonPlusP.layer.cornerRadius = 7;
        buttonMinusP.layer.cornerRadius = 7;
        buttonMoreMIDIoptions.layer.cornerRadius = 7;
        buttonStartPoint.layer.cornerRadius = 7;
        buttonEndPoint.layer.cornerRadius = 7;
        buttonLoop.layer.cornerRadius = 7;

    }
    
    [self hideLabels];
    if (!initWasDone) {
        [sliderSongPosition setThumbImage:[UIImage imageNamed:@"sliderGross.png"] forState:UIControlStateNormal];
        [sliderTempo setThumbImage:[UIImage imageNamed:@"sliderGross.png"] forState:UIControlStateNormal];
        [slider2 setThumbImage:[UIImage imageNamed:@"sliderGross.png"] forState:UIControlStateNormal];
        [slider4 setThumbImage:[UIImage imageNamed:@"sliderGross.png"] forState:UIControlStateNormal];
        [slider6 setThumbImage:[UIImage imageNamed:@"sliderGross.png"] forState:UIControlStateNormal];
        [slider7 setThumbImage:[UIImage imageNamed:@"sliderGross.png"] forState:UIControlStateNormal];
        [slider8 setThumbImage:[UIImage imageNamed:@"sliderGross.png"] forState:UIControlStateNormal];

        [sliderTempo setMinimumTrackTintColor:[UIColor blueColor]];
        [sliderTempo setMaximumTrackTintColor:[UIColor blueColor]]; // geht nicht in storyboard
        [slider8 setMaximumTrackTintColor:[UIColor greenColor]]; // geht nicht in storyboard
    }
    
    labelNowLen.text = @"0";
    lastNotifyMessage = @"";
    textFieldSYSEX.text = @"";
    tempSYSEX = @"";
    tempSYSEX2 = @"";
    labelMIDIfile.text = @"";
    labelChordBig.hidden = TRUE;
    labelChordChannel.hidden = TRUE;
    labelChordBig.text = @"";
    counterTimer = 0;
    counterSYSEX = 0;
    counterSYSEX2 = 0;
    countBytes = 0;
    countBytes2 = 0;
    isSYSEX = FALSE;
    isSYSEX2 = FALSE;
    statusSYSEX = FALSE;
    statusSYSEX2 = FALSE;
    midiFilePlaying = FALSE;
    isPause = FALSE;
    isRecording = FALSE;
    
    labelSleep.hidden = TRUE;
    
    [self enableButtons:TRUE];
    
    [self loadPreferences];
    usleep(100);
    
    if (!dataSaved) {
        // copy Test.mid to shared folder (only when App was started the first time)
        NSString *fromPathTestFile = [[NSBundle mainBundle] pathForResource:@"Englishman_In_New_York" ofType:@"mid"];
        NSString *toPathTestFile = [documentsDirectoryPath stringByAppendingPathComponent:@"Englishman_In_New_York.mid"];
        bool errorMove = FALSE;
        if ([fileManager copyItemAtPath:fromPathTestFile toPath:toPathTestFile error: NULL] == NO)
            errorMove = TRUE;
        if (!errorMove) lastImportedMIDIfile = @"Englishman_In_New_York.mid";
        
        [self saveDefaults];
        usleep(100);
        [self savePreferences];
        usleep(100);
    }
    
    [self loadPreferences];
    
    if (track0state == 1) track0state = 0; // muted ?
    if (track1state == 1) track1state = 0;
    if (track2state == 1) track2state = 0;
    if (track3state == 1) track3state = 0;
    if (track4state == 1) track4state = 0;
    if (track5state == 1) track5state = 0;
    if (track6state == 1) track6state = 0;
    if (track7state == 1) track7state = 0;
    if (track8state == 1) track8state = 0;
    if (track9state == 1) track9state = 0;
    if (track10state == 1) track10state = 0;
    if (track11state == 1) track11state = 0;
    if (track12state == 1) track12state = 0;
    if (track13state == 1) track13state = 0;
    if (track14state == 1) track14state = 0;
    if (track15state == 1) track15state = 0;
    
    playBackTempo = 1.0;
    transposeValue = 0;
    
    if (!initWasDone) {
        [self savePreferences];
        
        if (!auInitilisationDone) {
        //if (switchLocalSoundState && !auInitilisationDone) {
            [appDelegate auInitialisations];
        }
        startPoint = 0;
        endPoint = 0;
        isLoop = FALSE;
        buttonLoop.enabled = FALSE;
        buttonStartPoint.enabled = FALSE;
        buttonEndPoint.enabled = FALSE;
        labelStartPoint.hidden = TRUE;
        labelEndPoint.hidden = TRUE;
        [self subStartEndPoints];
        [self subLoopButton];
        
        [self doRestOfLocSndChange];

    }
    
    size_t size = 100;
    char *hw_machine = malloc(size);
    int name[] = {CTL_HW,HW_MACHINE};
    sysctl(name, 2, hw_machine, &size, NULL, 0);
    NSString *hardware = [NSString stringWithUTF8String:hw_machine];
    free(hw_machine);
    
    NSString *testTest = [hardware substringWithRange:NSMakeRange(0, 4)];
    if ([testTest isEqual: @"iPad"]) {
        testTest = [hardware substringWithRange:NSMakeRange(4, 1)];
    }
    if ([testTest intValue] < 5) {
        if (!iPadQuestionAnswered && !initWasDone) {
            iPadAlert = [[UIAlertView alloc]initWithTitle: @"iPad model question"
                                                  message: @"\nTo change the model later, you must remove the App and reinstall it (Attention! You lose all MIDI files and your personal settings).\n\nPress \"A5 or lower\" for \"iPad\" (not \"iPad Air\" or newer models) and \"iPad mini\" (not \"iPad mini Retina\" or newer models).\n\nPress \"A6 or higher\" for \"iPad Air\" and \"iPad mini Retina-Display\" or newer models."
                                                 delegate: self
                                        cancelButtonTitle: @"A5 or lower"
                                        otherButtonTitles: @"A6 or higher",nil];
            [iPadAlert show];
        }
    }
    else if (!iPadQuestionAnswered) {
        iPadA6 = TRUE;
        iPadQuestionAnswered = TRUE;
        userPreferences = [NSUserDefaults standardUserDefaults];
        [userPreferences setBool:iPadA6 forKey:@"iPadA6"];
        [userPreferences setBool:iPadQuestionAnswered forKey:@"iPadQuestionAnswered"];
        [userPreferences synchronize];
    }
    
    labelLocalSound1.hidden = switchLocSnd.isOn;
    
    sliderTempo.value = playBackTempo;
    labelTempo.text = [NSString stringWithFormat:@"Tempo: %.2f", playBackTempo];
    labelTranspose1.text = [NSString stringWithFormat:@"Transpose %d", transposeValue];
    
    [self setTrack0state];
    [self setTrack1state];
    [self setTrack2state];
    [self setTrack3state];
    [self setTrack4state];
    [self setTrack5state];
    [self setTrack6state];
    [self setTrack7state];
    [self setTrack8state];
    [self setTrack9state];
    [self setTrack10state];
    [self setTrack11state];
    [self setTrack12state];
    [self setTrack13state];
    [self setTrack14state];
    [self setTrack15state];
    
    [self loadPreferencesChannel0];
    [self loadPreferencesChannel1];
    [self loadPreferencesChannel2];
    [self loadPreferencesChannel3];
    [self loadPreferencesChannel4];
    [self loadPreferencesChannel5];
    [self loadPreferencesChannel6];
    [self loadPreferencesChannel7];
    [self loadPreferencesChannel8];
    [self loadPreferencesChannel9];
    [self loadPreferencesChannel10];
    [self loadPreferencesChannel11];
    [self loadPreferencesChannel12];
    [self loadPreferencesChannel13];
    [self loadPreferencesChannel14];
    [self loadPreferencesChannel15];
    
    [self resetLastControllers];
    
    if (!initWasDone){
        transposeValue = 0;
        buttonMoreState = FALSE;
        [self initializationMIDI];
    }
    else {
        switchShowSYSEX.on = switchShowSYSEXstate;
        switchFilterSYSEX.on = switchFilterSYSEXstate;
    }
    if (posOutput > ([arrayOutDevices count]-1)) {
        posOutput = (int)[arrayOutDevices count]-1;
    }
    if (posInput > ([arrayInDevices count]-1)) {
        posInput = (int)[arrayInDevices count]-1;
    }
    outDeviceTextField.text = arrayOutDevices[posOutput];
    inDeviceTextField.text = arrayInDevices[posInput];

    
    // Start timer for MIDI notification
    if (notifyTimer != nil) {
        [notifyTimer invalidate];
        notifyTimer = nil;
    }
    notifyTimer =[NSTimer scheduledTimerWithTimeInterval:0.025
                                                  target:self selector:@selector(timerNotifyMethod)userInfo:nil repeats:YES];
    
    notifyMessage = @"";
    
    if (inputTreatTimer != nil) {
        [inputTreatTimer invalidate];
        inputTreatTimer = nil;
    }
    inppoint = 0;
    outpoint = 0;
    inppoint2 = 0;
    outpoint2 = 0;
    // Start timer for MIDI input treatment. See also the counter in inputTreatMethod
    inputTreatTimer =[NSTimer scheduledTimerWithTimeInterval:timerIntervall
                                                      target:self selector:@selector(inputTreatMethod)userInfo:nil repeats:YES];
    
    initWasDone = TRUE;
    
    buttonTest.enabled = TRUE;
    
    [self loadPreferencesSlider];
    
    [self parseDir];
    labelMIDIfile.text = [self getMIDIfileName];
    
    channelSelection = 0;
    [self buttonChannel0pressed:nil];
    
    if (listArrayCount > 0){
        labelMIDIfile.text = listArrayForPicker[selectedIndex];
        midiFilename = listArrayForPicker[selectedIndex];
        // midiFilename =  [midiFilename substringWithRange:NSMakeRange(0, midiFilename.length - 4)];
        midiFilePath = [documentsDirectoryPath stringByAppendingPathComponent:listArrayForPicker[selectedIndex]];
    }
    else {
        labelMIDIfile.text = [NSString stringWithFormat:@"%@", textForNoFiles];
    }

    ignoreLast = TRUE;
    for (int iCh = 0; iCh < 16; iCh++) {
        [self initialMIDIsettings :iCh];
    }
    
    for (int iCh = 0; iCh < 16; iCh++) {
        [self allNotesOffMethod :iCh];
    }
    ignoreLast = FALSE;
    
    [self setTextFieldChord];
    [self subStartEndPoints];
    [self subLoopButton];

}

- (void) timerNotifyMethod {
    
    timerDivisor ++;
    if (timerDivisor == 20) {
        timerDivisor = 0;
        
        [self hideLabels];
        
        if (!midiFilePlaying && !isPause && !isRecording) {
            if (mustEnableDivers) {
                [self enableButtons:TRUE];
                mustEnableDivers = FALSE;
            }
            if (mustParseDir) {
                [self parseDir];
                mustParseDir = FALSE;
            }
            labelMIDIfile.text = [self getMIDIfileName];
        }
        
        if (![notifyMessage isEqual: @""] && initDone){
            if ([notifyMessage isEqual: @"MIDI device added or changed"] || [notifyMessage isEqual: @"MIDI device removed"]){
                textFieldSYSEX.text = [NSString stringWithFormat:@"%@ ", [NSString stringWithFormat:@"%@", notifyMessage]];
                [self scrollToEndOfList];
                [self initializationMIDI];
                notifyMessage = @"";
                initDone = FALSE;
            }
            else if ([notifyMessage isEqual: @"MIDI property changed"]){
                if (lastNotifyMessage != notifyMessage){
                    NSString *tempMessage = @"Please unplug/plug the MIDI device (also required, when MIDI In is not working)!";
                    textFieldSYSEX.text = [NSString stringWithFormat:@"%@ ", [NSString stringWithFormat:@"%@", tempMessage]];
                    [self scrollToEndOfList];
                    lastNotifyMessage = notifyMessage;
                }
            }
        }
        else {
            notifyMessage = @"";
            initDone = TRUE;
        }
        
        toggleColor = !toggleColor;
        
        if (isRecording){
            if (toggleColor) {
                [buttonRecording setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }
            else {
                [buttonRecording setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }
        else {
            [buttonRecording setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        if (midiFilePlaying){
            if (toggleColor) {
                [buttonPlay setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            }
            else {
                [buttonPlay setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }
        else {
            [buttonPlay setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        if (isPause){
            [buttonPlay setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            if (toggleColor) {
                [buttonPause setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
            }
            else {
                [buttonPause setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }
        else {
            [buttonPause setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        if ([[UIDevice currentDevice] batteryState] == UIDeviceBatteryStateUnplugged) {
            [self updateBatteryLevel];
            if (batteryLevel < 0.1) {
                if (labelSleep.hidden) labelSleep.hidden = FALSE;
                else labelSleep.hidden = TRUE;
            }
            else {
                labelSleep.hidden = FALSE;
            }
        }
        else {
            labelSleep.hidden = TRUE;
        }
        
    }
    else {
        while (inppointBut != outpointBut) {
            outpointBut++;
            if (outpointBut >= bufsizeBut){
                outpointBut = 0;
            }
            if (channelForShowChord == 0xFE || channelForShowChord == bufferForChord[outpointBut][0]) {
                if (channelForShowChord == 0xFE) chordChannel = 9; // use drum for "all"
                else chordChannel = channelForShowChord;
                tempChordNote = bufferForChord[outpointBut][1];  // note
                while (tempChordNote > 11) tempChordNote = tempChordNote - 12;
                last12notes[chordChannel][tempChordNote][0] = bufferForChord[outpointBut][1]; // note
                last12notes[chordChannel][tempChordNote][1] = bufferForChord[outpointBut][2]; // velocity
                doChordDetect = TRUE;
            }
        }
        if (doChordDetect) {
            doChordDetect = FALSE;
            [self chordDetection];
        }
    }
}

- (void) updateBatteryLevel {
    batteryLevel = [UIDevice currentDevice].batteryLevel;
    if (batteryLevel < 0.0) {
        // -1.0 means battery state is UIDeviceBatteryStateUnknown
        labelSleep.text = [NSString stringWithFormat:@"Battery: ?"];
    }
    else {
        if (numberFormatter == nil) {
            numberFormatter = [[NSNumberFormatter alloc] init];
            [numberFormatter setNumberStyle:NSNumberFormatterPercentStyle];
            [numberFormatter setMaximumFractionDigits:1];
        }
        NSNumber *levelObj = [NSNumber numberWithFloat:batteryLevel];
        labelSleep.text = [NSString stringWithFormat:@"Battery: %@", [numberFormatter stringFromNumber:levelObj]];
    }
}

- (void) setParseDirPad {
    mustParseDir = TRUE;
}

- (void) parseDir {
    
    listArrayForPicker = NULL;
    listArrayTemp = NULL;
    listArrayCount = 0;
    NSError *error = nil;
    success = 0xFF;
    
    // first look in the "Inbox" folder (files from "open with")
    // extension varies (.mid, .midi)
    
    if (![openURLstring isEqual: @""]) {
        inboxPath = openURLstring;
    }
    else {
        inboxPath = [documentsDirectoryPath stringByAppendingPathComponent:@"/Inbox"];
    }
    openURLstring = @"";
    dirFilesInbox = [fileManager contentsOfDirectoryAtPath:inboxPath error:nil];
    listArrayTemp = [dirFilesInbox filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self ENDSWITH '.midi'"]];
    
    for (int i = 0; i < listArrayTemp.count; i++) {
        tempDirfrom = [NSString stringWithFormat:@"%@/%@", inboxPath, listArrayTemp[i]];
        NSString *tempStr = listArrayTemp[i];
        tempStr = [tempStr stringByReplacingOccurrencesOfString:@".midi" withString:@".mid"];
        tempDirTo = [NSString stringWithFormat:@"%@/%@", [documentsDirectoryPath stringByAppendingPathComponent:@""], tempStr];
        success = [fileManager copyItemAtPath:tempDirfrom toPath:tempDirTo error:&error];
        [fileManager removeItemAtPath:tempDirfrom error:nil];
        lastImportedMIDIfile = tempStr;
        usleep(2000);
    }
    
    dirFilesInbox = [fileManager contentsOfDirectoryAtPath:inboxPath error:nil];
    listArrayTemp = [dirFilesInbox filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self ENDSWITH '.mid'"]];
    for (int i = 0; i < listArrayTemp.count; i++) {
        tempDirfrom = [NSString stringWithFormat:@"%@/%@", inboxPath, listArrayTemp[i]];
        tempDirTo = [NSString stringWithFormat:@"%@/%@", [documentsDirectoryPath stringByAppendingPathComponent:@""], listArrayTemp[i]];
        success = [fileManager copyItemAtPath:tempDirfrom toPath:tempDirTo error:&error];
        [fileManager removeItemAtPath:tempDirfrom error:nil];
        lastImportedMIDIfile = listArrayTemp[i];
        usleep(2000);
    }
    
    dirFilesInbox = [fileManager contentsOfDirectoryAtPath:inboxPath error:nil];
    listArrayTemp = [dirFilesInbox filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self ENDSWITH '.MID'"]];
    for (int i = 0; i < listArrayTemp.count; i++) {
        tempDirfrom = [NSString stringWithFormat:@"%@/%@", inboxPath, listArrayTemp[i]];
        tempDirTo = [NSString stringWithFormat:@"%@/%@", [documentsDirectoryPath stringByAppendingPathComponent:@""], listArrayTemp[i]];
        tempDirTo = [tempDirTo stringByReplacingOccurrencesOfString:@".MID" withString:@".mid"];
        success = [fileManager copyItemAtPath:tempDirfrom toPath:tempDirTo error:&error];
        [fileManager removeItemAtPath:tempDirfrom error:nil];
        lastImportedMIDIfile = [listArrayTemp[i] stringByReplacingOccurrencesOfString:@".MID" withString:@".mid"];
        usleep(2000);
    }
    
    if (success == 0xFF) {
        listArrayTemp = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:inboxPath error:&error];
        for (int i = 0; i < listArrayTemp.count; i++) {
            tempDirfrom = [NSString stringWithFormat:@"%@/%@", inboxPath, listArrayTemp[i]];
            [fileManager removeItemAtPath:tempDirfrom error:nil];
            usleep(2000);
        }
    }
    
    dirFiles = [fileManager contentsOfDirectoryAtPath:documentsDirectoryPath error:nil];
    listArrayForPicker = [dirFiles filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self ENDSWITH '.mid'"]];
    listArrayForPicker = [listArrayForPicker arrayByAddingObjectsFromArray:[dirFiles filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self ENDSWITH '.MID'"]]];
    listArrayForPicker = [listArrayForPicker arrayByAddingObjectsFromArray:[dirFiles filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self ENDSWITH '.Mid'"]]];
    
    listArrayCount = (int)[listArrayForPicker count]; // get array lenght
    sortedArray = [listArrayForPicker sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    listArrayForPicker = sortedArray;
    listArrayCount = (int)[listArrayForPicker count]; // get array lenght
    
    if (![lastImportedMIDIfile isEqual: @""]){
        for (int i = 0; i < listArrayCount; i++) {
            if ([listArrayForPicker[i] isEqual: lastImportedMIDIfile]) {
                selectedIndex = i;
            }
        }
        lastImportedMIDIfile = @"";
    }
    else if (![lastSelectedMIDIfile isEqual: @""]) {
        for (int i = 0; i < listArrayCount; i++) {
            if ([listArrayForPicker[i] isEqual: lastSelectedMIDIfile]) {
                selectedIndex = i;
            }
        }
    }
    else selectedIndex = 0;
    
    if (listArrayCount > 0){
        if (listArrayCount > 0){
            if (selectedIndex >= listArrayCount){
                selectedIndex = 0;
            }
            midiFilename = listArrayForPicker[selectedIndex];
            midiFilePath = [documentsDirectoryPath stringByAppendingPathComponent:listArrayForPicker[selectedIndex]];
            [self saveLastSelectedMIDIfile];
        }
    }
    else {
        midiFilename = [NSString stringWithFormat:@"%@", textForNoFiles];
    }
    
    if (track0state != 2) {
        [appDelegate setDefault0];
    }
    if (track1state != 2) {
        [appDelegate setDefault1];
    }
    if (track2state != 2) {
        [appDelegate setDefault2];
    }
    if (track3state != 2) {
        [appDelegate setDefault3];
    }
    if (track4state != 2) {
        [appDelegate setDefault4];
    }
    if (track5state != 2) {
        [appDelegate setDefault5];
    }
    if (track6state != 2) {
        [appDelegate setDefault6];
    }
    if (track7state != 2) {
        [appDelegate setDefault7];
    }
    if (track8state != 2) {
        [appDelegate setDefault8];
    }
    if (track9state != 2) {
        [appDelegate setDefault9];
    }
    if (track10state != 2) {
        [appDelegate setDefault10];
    }
    if (track11state != 2) {
        [appDelegate setDefault11];
    }
    if (track12state != 2) {
        [appDelegate setDefault12];
    }
    if (track13state != 2) {
        [appDelegate setDefault13];
    }
    if (track14state != 2) {
        [appDelegate setDefault14];
    }
    if (track14state != 2) {
        [appDelegate setDefault15];
    }
    
    [self updateSliderETC];
    isSettings = FALSE;
    switchIsSettings.on = isSettings;
    
}

- (void) scrollToEndOfList {
    
    if ((midiFilePlaying || isRecording) && !isPause) return;
    
    if (textFieldSYSEX.text.length > 1000){
        textFieldSYSEX.text = [textFieldSYSEX.text substringWithRange:NSMakeRange(textFieldSYSEX.text.length -1000, 1000)];
    }
    textFieldSYSEX.frame = CGRectMake(textFieldSYSEX.frame.origin.x, textFieldSYSEX.frame.origin.y, 1, 1); // damit scroll möglich ist !!!!!
    textFieldSYSEX.frame = CGRectMake(textFieldSYSEX.frame.origin.x, textFieldSYSEX.frame.origin.y, 471, 206);
    CGPoint bottomOffset = CGPointMake(0, [textFieldSYSEX contentSize].height - textFieldSYSEX.frame.size.height);
    if (bottomOffset.y > 0){
        [textFieldSYSEX setContentOffset: bottomOffset animated: NO];
    }
}

- (void)timerEndMethodPad {
    // Stop the player and dispose of the objects
    MusicPlayerStop(musicPlayer);
    DisposeMusicSequence(musicSequence);
    DisposeMusicPlayer(musicPlayer);
    midiFilePlaying = FALSE;
    isPause = FALSE;
    labelNowLen.text = @"0";
    timerforAllNotesOff =[NSTimer scheduledTimerWithTimeInterval:0.5
                                                          target:self selector:@selector(timerAllNotesOffMethodPad)userInfo:nil repeats:NO];
    if (!isRecording){
        [self enableButtons:TRUE];
    }
    
    if (autoNext && !isSettings) {
        usleep(1000000);
        [self nextMIDIfilePressed:nil];
        usleep(1000000);
        [self buttonPlayPressed:nil];
    }
    
}

- (void) timerAllNotesOffMethodPad {
    for (int iCh = 0; iCh < 16; iCh++) {
        [self allNotesOffMethod:iCh];
    }
    [appDelegate sendRealTimeByte :0xFC :FALSE]; // Stop
    
    [appDelegate clearDiversBuffers];
    labelChordBig.hidden = TRUE;
    labelChordChannel.hidden = TRUE;
    labelChordBigState = TRUE;
    labelChordBig.text = @"";
}

- (void) allNotesOffMethod :(Byte)channelForNotesOff {
    [self putThreeByteInBuffer :0xB0 + channelForNotesOff :0x7B :0x00];
}

- (void) timerAllNotesOffMethodChannel {
    [self putThreeByteInBuffer :0xB0 + lastTrackTemp :0x7B :0x00];
}


- (void) controllerOff :(int)channelForControllerOff{
    [self putThreeByteInBuffer :0xB0 + channelForControllerOff :0x79 :0x00];
}

// Command   Meaning                 # parameters    param 1         param 2
// 0x80      Note off (not usual)    2               key             velocity
// 0x90      Note on/off             2               key             veolcity
// 0xA0      Aftertouch              2               key             touch
// 0xB0      Controller              2               controller #    controller value
// 0xC0      Program change          1               instrument #
// 0xD0      Channel Pressure        1               pressure
// 0xE0      Pitch bend              2               lsb (7 bits)    msb (7 bits)
// 0xF0      (non-musical commands)
//
// MIDI In messages arrives here
static void	MyMIDIReadProc(const MIDIPacketList *pktlist, void *refCon, void *connRefCon) {
    //printf("\nPackets: %i", pktlist->numPackets);
    for (unsigned int i = 0; i < pktlist->numPackets; i++) {
        if (i == 0) packet2 = pktlist->packet[0];
        nBytes2 = packet2.length;
        //printf("\nPacket length: %i\n", nBytes2);
        iByte2 = 0;
        while (iByte2 < nBytes2) {
            inputByte2 = packet2.data[iByte2];
            inppoint2++;
            if (inppoint2 >= bufsize2){
                inppoint2 = 0;
            }
            inputBuffer2[inppoint2] = inputByte2;
            //printf("\ninputByte2: %02x", inputByte2);
            iByte2 ++;
        }
        packet2 = *MIDIPacketNext(&packet2);
    }
}

// MIDI data from MusicPlayer
static void MyMIDIReadProc2(const MIDIPacketList *pktlist, void *refCon, void *connRefCon) {
    packet = (MIDIPacket *)pktlist->packet;
    for (int i=0; i < pktlist->numPackets; i++) {
        midiStatus = packet->data[0];
        midiCommand = midiStatus >> 4;
        midiChan = midiStatus & 0x0F;
        switch (midiChan) {
            case 0:
                if (track0state == 1) goto nextPa;
                else if (track0state == 2 && isRecording) goto nextPa;
                break;
            case 1:
                if (track1state == 1) goto nextPa;
                else if (track1state == 2 && isRecording) goto nextPa;
                break;
            case 2:
                if (track2state == 1) goto nextPa;
                else if (track2state == 2 && isRecording) goto nextPa;
                break;
            case 3:
                if (track3state == 1) goto nextPa;
                else if (track3state == 2 && isRecording) goto nextPa;
                break;
            case 4:
                if (track4state == 1) goto nextPa;
                else if (track4state == 2 && isRecording) goto nextPa;
                break;
            case 5:
                if (track5state == 1) goto nextPa;
                else if (track5state == 2 && isRecording) goto nextPa;
                break;
            case 6:
                if (track6state == 1) goto nextPa;
                else if (track6state == 2 && isRecording) goto nextPa;
                break;
            case 7:
                if (track7state == 1) goto nextPa;
                else if (track7state == 2 && isRecording) goto nextPa;
                break;
            case 8:
                if (track8state == 1) goto nextPa;
                else if (track8state == 2 && isRecording) goto nextPa;
                break;
            case 9:
                if (track9state == 1) goto nextPa;
                else if (track9state == 2 && isRecording) goto nextPa;
                break;
            case 10:
                if (track10state == 1) goto nextPa;
                else if (track10state == 2 && isRecording) goto nextPa;
                break;
            case 11:
                if (track11state == 1) goto nextPa;
                else if (track11state == 2 && isRecording) goto nextPa;
                break;
            case 12:
                if (track12state == 1) goto nextPa;
                else if (track12state == 2 && isRecording) goto nextPa;
                break;
            case 13:
                if (track13state == 1) goto nextPa;
                else if (track13state == 2 && isRecording) goto nextPa;
                break;
            case 14:
                if (track14state == 1) goto nextPa;
                else if (track14state == 2 && isRecording) goto nextPa;
                break;
            case 15:
                if (track15state == 1) goto nextPa;
                else if (track15state == 2 && isRecording) goto nextPa;
                break;
                
            default:
                break;
        }
        
        if ((midiCommand >= 0x08 && midiCommand < 0x0C) || (midiCommand >= 0x0E && midiCommand < 0x0F)) {
            note2 = packet->data[1] & 0x7F;
            velocity2 = packet->data[2] & 0x7F;
            inppoint++;
            if (inppoint >= bufsize){
                inppoint = 0;
            }
            inputBuffer[inppoint] = midiStatus;
            inppoint++;
            if (inppoint >= bufsize){
                inppoint = 0;
            }
            inputBuffer[inppoint] = note2;
            inppoint++;
            if (inppoint >= bufsize){
                inppoint = 0;
            }
            inputBuffer[inppoint] = velocity2;
            
        }
        else if (midiCommand >= 0x0C && midiCommand < 0x0E){
            inppoint++;
            if (inppoint >= bufsize){
                inppoint = 0;
            }
            inputBuffer[inppoint] = packet->data[0];
            inppoint++;
            if (inppoint >= bufsize){
                inppoint = 0;
            }
            inputBuffer[inppoint] = packet->data[1];
            
        }
        else if (packet->data[0] == 0xF0){
            statusSYSEX = TRUE;
            for (int iP = 0; iP < packet->length; iP++){
                if (!switchFilterSYSEXstate || switchShowSYSEXstate) {
                    inppoint++;
                    if (inppoint >= bufsize){
                        inppoint = 0;
                    }
                    inputBuffer[inppoint] = packet->data[iP];
                }
                if (packet->data[iP] == 0xF7) statusSYSEX = FALSE;
            }
        }
        //        else if (packet->data[0] > 0xF7){  // Real time
        //            inppoint++;
        //            if (inppoint >= bufsize){
        //                inppoint = 0;
        //            }
        //            inputBuffer[inppoint] = packet->data[0];
        //        }
    nextPa:
        packet = MIDIPacketNext(packet);
    }
}

- (void)inputTreatMethod {
    
    // MIDI player data
    
    while ((inppoint != outpoint)){
        outpoint++;
        if (outpoint >= bufsize){
            outpoint = 0;
        }
        
        byteToAnalyze = inputBuffer[outpoint];
        //printf("MIDI Byte: %02x\n", byteToAnalyze);
        
        if (byteToAnalyze <= 0xF0 || byteToAnalyze == 0xF7) {
            if (byteToAnalyze > 0x7F && byteToAnalyze < 0xF0){
                isSYSEX = FALSE;
                counterSYSEX = 0;
                tempSYSEX = @"";
                statusByte = byteToAnalyze;
                countBytes = 0;
                tempBuffer[countBytes] = byteToAnalyze;
            }
            else {
                if (!isSYSEX && byteToAnalyze < 0xF0){
                    countBytes++;
                    tempBuffer[countBytes] = byteToAnalyze;
                }
            }
            
            if (byteToAnalyze == 0xF0){
                isSYSEX = TRUE;
                counterSYSEX = 0;
                if (switchShowSYSEXstate) {
                    if ([textFieldSYSEX.text isEqual: @""]){
                        textFieldSYSEX.text = @"";  // space
                    }
                    else {
                        textFieldSYSEX.text = [NSString stringWithFormat:@"%@\n", textFieldSYSEX.text];
                    }
                }
            }
            else if (byteToAnalyze == 0xF7){
                isSYSEX = FALSE;
                sysexMessages[counterSYSEX] = byteToAnalyze;
                tempSYSEX = [NSString stringWithFormat:@"%@%@ ", tempSYSEX, [NSString stringWithFormat:@"%02x", byteToAnalyze]];
                tempSYSEX = [tempSYSEX uppercaseString];
                if (!switchFilterSYSEXstate) {
                    if (switchShowSYSEXstate) {
                        if (counterSYSEX < 1024 && sysexMessages[0] == 0xF0 && sysexMessages[counterSYSEX] == 0xF7) {
                            textFieldSYSEX.text = [NSString stringWithFormat:@"%@%@ ", textFieldSYSEX.text, [NSString stringWithFormat:@"%@", tempSYSEX]];
                            [self scrollToEndOfList];
                        }
                    }
                    if (counterSYSEX < 1024 && sysexMessages[0] == 0xF0 && sysexMessages[counterSYSEX] == 0xF7) {
                        if (!isSettings) [self sendSYSEX];
                    }
                }
                counterSYSEX = 0;
                tempSYSEX = @"";
            }
            if (isSYSEX){
                sysexMessages[counterSYSEX] = byteToAnalyze;
                counterSYSEX++;
                if (counterSYSEX > 1023) counterSYSEX = 0;  // prevent overflow
                if (byteToAnalyze > 0x7F && byteToAnalyze < 0xF0 ){
                    tempSYSEX = [NSString stringWithFormat:@"%@%@ ", tempSYSEX, [NSString stringWithFormat:@"%02x", 0xF7]];
                    isSYSEX = FALSE;
                }
                else {
                    tempSYSEX = [NSString stringWithFormat:@"%@%@ ", tempSYSEX, [NSString stringWithFormat:@"%02x", byteToAnalyze]];
                }
            }
            
            midiChannelTemp = statusByte & 0x0F;  // logical and to filter chnannel info
            
            if (!isSYSEX && ((statusByte >= 0x80 && statusByte < 0xC0) || (statusByte >= 0xE0 && statusByte < 0xF0)) && countBytes == 2){
                countBytes = 0;
                
                if (statusByte >= 0x80 && statusByte < 0xA0 && midiChannelTemp !=9) { // not for drum channel
                    tempBuffer[1] = tempBuffer[1] + transposeValue;
                    if (tempBuffer[1] > 0x7F) tempBuffer[1] = tempBuffer[1] - 12; // octave down
                    if (tempBuffer[1] < 0x18) tempBuffer[1] = tempBuffer[1] + 12; // octave up
                }
                if (!isSettings || statusByte < 0xB0 || statusByte >= 0xE0) {
                    [self sendMIDIevents :3 :tempBuffer[0] :tempBuffer[1] :tempBuffer[2] :TRUE];
                    [self treatThreeByteMIDI :midiChannelTemp :tempBuffer[0] :tempBuffer[1] :tempBuffer[2]];
                    [self storeLastValues:midiChannelTemp :tempBuffer[0] :tempBuffer[1] :tempBuffer[2]];
                }
                else if (isSettings && statusByte >= 0xB0 && statusByte < 0xC0) {  // Filter volume, reverb, chorus, panorama, reset all controller
                    if (tempBuffer[1] != 0x07 && tempBuffer[1] != 0x5B && tempBuffer[1] != 0x5D && tempBuffer[1] != 0x0A && tempBuffer[1] != 0x79) {
                        //                            NSLog(@"%02x %02x %02x", tempBuffer[0], tempBuffer[1], tempBuffer[2]);
                        [self sendMIDIevents :3 :tempBuffer[0] :tempBuffer[1] :tempBuffer[2] :TRUE];
                        [self treatThreeByteMIDI :midiChannelTemp :tempBuffer[0] :tempBuffer[1] :tempBuffer[2]];
                        [self storeLastValues:midiChannelTemp :tempBuffer[0] :tempBuffer[1] :tempBuffer[2]];
                    }
                }
            }
            else if (!isSYSEX && (statusByte >= 0xC0 && statusByte < 0xD0) && countBytes == 1 && !isSettings){
                countBytes = 0;
                [self sendMIDIevents :2 :tempBuffer[0] :tempBuffer[1] :0 :TRUE]; // program change
                [self treatProgramChange :midiChannelTemp :tempBuffer[1]];
                [self storeLastProgramChange :midiChannelTemp :tempBuffer[1]];
                
                if (midiChannelTemp == 9) {
                    if (drumSet0) tempBuffer[1] = 0; // use only drumset 0
                    instrName = [NSString stringWithFormat:@"Drums (%i)", tempBuffer[1]];
                    if ([textFieldSYSEX.text  isEqual: @""]) {
                        textFieldSYSEX.text = [NSString stringWithFormat:@"%@Chn.%i: %@", textFieldSYSEX.text, midiChannelTemp, instrName];
                    }
                    else {
                        textFieldSYSEX.text = [NSString stringWithFormat:@"%@\nChn.%i: %@", textFieldSYSEX.text, midiChannelTemp, instrName];
                    }
                }
                else {
                    instrName = [NSString stringWithFormat:@"%@", [instruments objectAtIndex:tempBuffer[1]]];
                    if ([textFieldSYSEX.text isEqual: @""]) {
                        textFieldSYSEX.text = [NSString stringWithFormat:@"%@Chn.%i: %@", textFieldSYSEX.text, midiChannelTemp, instrName];
                    }
                    else {
                        textFieldSYSEX.text = [NSString stringWithFormat:@"%@\nChn.%i: %@", textFieldSYSEX.text, midiChannelTemp, instrName];
                    }
                }
                [self scrollToEndOfList];
            }
            else if (!isSYSEX && (statusByte >= 0xD0 && statusByte < 0xE0) && countBytes == 1){
                countBytes = 0;
                [self sendMIDIevents :2 :tempBuffer[0] :tempBuffer[1] :0 :TRUE];
                [self treatTwoByteMIDI :midiChannelTemp :tempBuffer[0] :tempBuffer[1]];
                [self storeLastProgramChange :midiChannelTemp :tempBuffer[1]];
            }
        }
    }
    
    // MIDI in data etc.
    
    while (inppoint2 != outpoint2){
        outpoint2++;
        if (outpoint2 >= bufsize2){
            outpoint2 = 0;
        }
        
    nomau:
        byteToAnalyze2 = inputBuffer2[outpoint2];
        
        if (receiveStartContinueStop) {
            if (byteToAnalyze2 == 0xFA) { // Start
                nextNotSend = TRUE;
                if (isPause) [self subStopButton];
                nextNotSend = TRUE;
                [self subPlayButton];
            }
            else if (byteToAnalyze2 == 0xFB) { // Continue
                nextNotSend = TRUE;
                if (midiFilePlaying && isPause) [self subPauseButton];
            }
            else if (byteToAnalyze2 == 0xFC) { // Stop
                nextNotSend = TRUE;
                if (midiFilePlaying && !isPause) [self subPauseButton];
                else [self subStopButton];
            }
        }
        
        if (byteToAnalyze2 <= 0xF0 || byteToAnalyze2 == 0xF7) {
            if (byteToAnalyze2 > 0x7F && byteToAnalyze2 < 0xF0){
                isSYSEX2 = FALSE;
                counterSYSEX2 = 0;
                tempSYSEX2 = @"";
                statusByte2 = byteToAnalyze2;
                countBytes2 = 0;
                tempBuffer2[countBytes2] = byteToAnalyze2;
            }
            else {
                if (!isSYSEX2 && byteToAnalyze2 < 0xF0){
                    countBytes2++;
                    tempBuffer2[countBytes2] = byteToAnalyze2;
                }
            }
            
            if (byteToAnalyze2 == 0xF0){
                isSYSEX2 = TRUE;
                counterSYSEX2 = 0;
                if (switchShowSYSEXstate) {
                    if ([textFieldSYSEX.text isEqual: @""]){
                        textFieldSYSEX.text = @"";  // space
                    }
                    else {
                        textFieldSYSEX.text = [NSString stringWithFormat:@"%@\n", textFieldSYSEX.text];
                    }
                }
            }
            else if (byteToAnalyze2 == 0xF7){
                isSYSEX2 = FALSE;
                sysexMessages2[counterSYSEX2] = byteToAnalyze2;
                tempSYSEX2 = [NSString stringWithFormat:@"%@%@ ", tempSYSEX2, [NSString stringWithFormat:@"%02x", byteToAnalyze2]];
                tempSYSEX2 = [tempSYSEX2 uppercaseString];
                if (!switchFilterSYSEXstate) {
                    if (switchShowSYSEXstate) {
                        if (counterSYSEX2 < 1024 && sysexMessages2[0] == 0xF0 && sysexMessages2[counterSYSEX2] == 0xF7) {
                            textFieldSYSEX.text = [NSString stringWithFormat:@"%@%@ ", textFieldSYSEX.text, [NSString stringWithFormat:@"%@", tempSYSEX2]];
                            [self scrollToEndOfList];
                        }
                    }
                    if (counterSYSEX2 < 1024 && sysexMessages2[0] == 0xF0 && sysexMessages2[counterSYSEX2] == 0xF7) {
                        [self sendSYSEX2];
                    }
                }
                counterSYSEX2 = 0;
                tempSYSEX2 = @"";
            }
            if (isSYSEX2){
                sysexMessages2[counterSYSEX2] = byteToAnalyze2;
                counterSYSEX2++;
                if (counterSYSEX2 > 1023) counterSYSEX2 = 0;  // prevent overflow
                if (byteToAnalyze2 > 0x7F && byteToAnalyze2 < 0xF0 ){
                    tempSYSEX2 = [NSString stringWithFormat:@"%@%@ ", tempSYSEX2, [NSString stringWithFormat:@"%02x", 0xF7]];
                    isSYSEX2 = FALSE;
                }
                else {
                    tempSYSEX2 = [NSString stringWithFormat:@"%@%@ ", tempSYSEX2, [NSString stringWithFormat:@"%02x", byteToAnalyze2]];
                }
            }
            
            midiChannelTemp2 = statusByte2 & 0x0F;  // logical and to filter chnannel info
            
            if (!isSYSEX2 && ((statusByte2 >= 0x80 && statusByte2 < 0xC0) || (statusByte2 >= 0xE0 && statusByte2 < 0xF0)) && countBytes2 == 2){
                countBytes2 = 0;
                if ([self getSendIt :statusByte2]) {
                    [self sendMIDIevents :3 :tempBuffer2[0] :tempBuffer2[1] :tempBuffer2[2] :switchMIDIthruState];
                    [self treatThreeByteMIDI :midiChannelTemp2 :tempBuffer2[0] :tempBuffer2[1] :tempBuffer2[2]];
                }
            }
            else if (!isSYSEX2 && (statusByte2 >= 0xC0 && statusByte2 < 0xD0) && countBytes2 == 1){
                countBytes2 = 0;
                if ([self getSendIt :statusByte2]) {
                    [self sendMIDIevents :2 :tempBuffer2[0] :tempBuffer2[1] :0 :switchMIDIthruState]; // program change
                    [self treatProgramChange :midiChannelTemp2 :tempBuffer2[1]];
                    [self storeLastProgramChange :midiChannelTemp2 :tempBuffer2[1]];
                    if (midiChannelTemp2 == 9) {
                        if (drumSet0) tempBuffer2[1] = 0; // use only drumset 0
                        instrName = [NSString stringWithFormat:@"Drums (%i)", tempBuffer2[1]];
                        if ([textFieldSYSEX.text  isEqual: @""]) {
                            textFieldSYSEX.text = [NSString stringWithFormat:@"%@Chn.%i: %@", textFieldSYSEX.text, midiChannelTemp2, instrName];
                        }
                        else {
                            textFieldSYSEX.text = [NSString stringWithFormat:@"%@\nChn.%i: %@", textFieldSYSEX.text, midiChannelTemp2, instrName];
                        }
                    }
                    else {
                        instrName = [NSString stringWithFormat:@"%@", [instruments objectAtIndex:tempBuffer2[1]]];
                        if ([textFieldSYSEX.text  isEqual: @""]) {
                            textFieldSYSEX.text = [NSString stringWithFormat:@"%@Chn.%i: %@", textFieldSYSEX.text, midiChannelTemp2, instrName];
                        }
                        else {
                            textFieldSYSEX.text = [NSString stringWithFormat:@"%@\nChn.%i: %@", textFieldSYSEX.text, midiChannelTemp2, instrName];
                        }
                    }
                    [self scrollToEndOfList];
                }
            }
            else if (!isSYSEX2 && (statusByte2 >= 0xD0 && statusByte2 < 0xE0) && countBytes2 == 1){
                countBytes2 = 0;
                if ([self getSendIt :statusByte2]) {
                    [self sendMIDIevents :2 :tempBuffer2[0] :tempBuffer2[1] :0 :switchMIDIthruState];
                    [self treatTwoByteMIDI :midiChannelTemp2 :tempBuffer2[0] :tempBuffer2[1]];
                }
            }
            
        }
    }
    
    // MIDI data from Settings
    
    while ((inppointSettings != outpointSettings)){
        outpointSettings++;
        if (outpointSettings >= bufsizeSettings){
            outpointSettings = 0;
        }
        byteToAnalyze3 = inputBufferSettings[outpointSettings];
        
        if (byteToAnalyze3 > 0xF7) {
            timerForRealTime =[NSTimer scheduledTimerWithTimeInterval:0.02
                                                               target:self selector:@selector(timerRealTimeMethod)userInfo:nil repeats:NO];
        }
        else {
            if (byteToAnalyze3 <= 0xF0 || byteToAnalyze3 == 0xF7) {
                if (byteToAnalyze3 > 0x7F && byteToAnalyze3 < 0xF0){
                    isSYSEX3 = FALSE;
                    counterSYSEX3 = 0;
                    tempSYSEX3 = @"";
                    statusByte3 = byteToAnalyze3;
                    countBytes3 = 0;
                    tempBuffer3[countBytes3] = byteToAnalyze3;
                }
                else {
                    if (!isSYSEX3 && byteToAnalyze3 < 0xF0){
                        countBytes3++;
                        tempBuffer3[countBytes3] = byteToAnalyze3;
                    }
                }
                
                if (byteToAnalyze3 == 0xF0){
                    isSYSEX3 = TRUE;
                    counterSYSEX3 = 0;
                }
                else if (byteToAnalyze3 == 0xF7){
                    counterSYSEX3 = 0;
                    tempSYSEX3 = @"";
                }
                if (isSYSEX3){
                    counterSYSEX3++;
                    if (counterSYSEX3 > 1023) counterSYSEX3 = 0;  // prevent overflow
                    if (byteToAnalyze3 > 0x7F && byteToAnalyze3 < 0xF0 ){
                        isSYSEX3 = FALSE;
                    }
                }
                
                midiChannelTemp3 = statusByte3 & 0x0F;  // logical and to filter chnannel info
                
                if (!isSYSEX3 && ((statusByte3 >= 0x80 && statusByte3 < 0xC0) || (statusByte3 >= 0xE0 && statusByte3 < 0xF0)) && countBytes3 == 2){
                    countBytes3 = 0;
                    [self sendMIDIevents :3 :tempBuffer3[0] :tempBuffer3[1] :tempBuffer3[2] :TRUE];
                    [self treatThreeByteMIDI :midiChannelTemp3 :tempBuffer3[0] :tempBuffer3[1] :tempBuffer3[2]];
                }
                else if (!isSYSEX3 && (statusByte3 >= 0xC0 && statusByte3 < 0xD0) && countBytes3 == 1){
                    countBytes3 = 0;
                    [self sendMIDIevents :2 :tempBuffer3[0] :tempBuffer3[1] :0 :TRUE]; // program change
                    [self treatProgramChange :midiChannelTemp3 :tempBuffer3[1]];
                }
                else if (!isSYSEX3 && (statusByte3 >= 0xD0 && statusByte3 < 0xE0) && countBytes3 == 1){
                    countBytes3 = 0;
                    [self sendMIDIevents :2 :tempBuffer3[0] :tempBuffer3[1] :0 :TRUE];
                    [self treatTwoByteMIDI :midiChannelTemp3 :tempBuffer3[0] :tempBuffer3[1]];
                }
            }
        }
    }
    
    counterTimer++;
    if (counterTimer >= counterIntervall){
        counterTimer = 0;
        if (midiFilePlaying && !isPause){
            MusicTimeStamp now;
            MusicPlayerGetTime (musicPlayer, &now);
            labelNowLen.text = [NSString stringWithFormat:@"%.0f of %.0f", now, len];
            sliderSongPosition.value = now;
            songPosition = now;
            if (now >= len && !isLoop){
                sliderSongPosition.value = 0;
                songPosition = 0;
                timerEnd =[NSTimer scheduledTimerWithTimeInterval:0.1
                                                           target:self selector:@selector(timerEndMethodPad)userInfo:nil repeats:NO];
            }
            else {
                if ((isLoop && endPoint > 0 && endPoint > startPoint) || now >= len) {
                    if (songPosition >= endPoint) {
                        [self buttonPausePressed:nil];
                        songPosition = startPoint;
                        sliderSongPosition.value = songPosition;
                        [self sliderSongPositionChange:nil];
                        usleep(1000000);
                        [self buttonPausePressed:nil];
                    }
                }
            }
        }
    }
}

- (void) timerRealTimeMethod {
    packetList.numPackets = 1;
    firstPacket = &packetList.packet[0];
    firstPacket->timeStamp = 0;	// send immediately
    firstPacket->data[0] = byteToAnalyze3;
    firstPacket->length = 1;
    if (deviceIDdest > -1){
        [appDelegate sendMIDIeventsToPort :outputPort :outputEndpoint :packetList :1];
    }
}

- (void) initializationMIDI {
    
    s = MIDIPortDisconnectSource (outputPortLast, sourceMIDIlast);
    s = MIDIPortDisconnectSource (inputPortLast, destMIDIlast);
    
    s = MIDIPortDispose(outputPortLast);
    s = MIDIPortDispose(inputPortLast);
    
    userPreferences = [NSUserDefaults standardUserDefaults];
    posWasSaved = [userPreferences boolForKey:@"posWasSaved"];
    [userPreferences synchronize];
    
    if (!posWasSaved) {
        posOutput = 99;
        posInput = 99;
    }
    else {
        userPreferences = [NSUserDefaults standardUserDefaults];
        posOutput = (int)[userPreferences integerForKey:@"posOutput"];
        posInput = (int)[userPreferences integerForKey:@"posInput"];
        [userPreferences synchronize];
    }
    
    deviceIDdest = -1;
    deviceIDsource = -1;
    
    countComboBox1 = 0;
    countComboBox2 = 0;
    
    [arrayForComboBox1 removeAllObjects];
    [arrayForComboBox2 removeAllObjects];
    
    arrayForComboBox1 = [[NSMutableArray alloc] init];
    arrayForComboBox2 = [[NSMutableArray alloc] init];
    
    // Create a client
    MIDIClientRef virtualMidi;
    result = MIDIClientCreate(CFSTR("Virtual Client"),
                              MyMIDINotifyProc,
                              NULL,
                              &virtualMidi);
    
    NSAssert( result == noErr, @"MIDIClientCreate failed. Error code: %d '%.4s'", (int) result, (const char *)&result);
    
    // Create an endpoint
    result = MIDIDestinationCreate(virtualMidi, CFSTR("Virtual Destination"), MyMIDIReadProc2, NULL, &virtualEndpoint);
    NSAssert( result == noErr, @"MIDIDestinationCreate failed. Error code: %d '%.4s'", (int) result, (const char *)&result);
    
    // How many MIDI devices do we have?
    ItemCount deviceCount = MIDIGetNumberOfDevices();
    
    // Iterate through all MIDI devices
    for (ItemCount i = 0 ; i < deviceCount ; ++i) {
        
        // Grab a reference to current device
        MIDIDeviceRef device = MIDIGetDevice(i);
        
        // Is this device online? (Currently connected?)
        SInt32 isOffline = 0;
        MIDIObjectGetIntegerProperty(device, kMIDIPropertyOffline, &isOffline);
        
        // How many entities do we have?
        ItemCount entityCount = MIDIDeviceGetNumberOfEntities(device);
        
        // Iterate through this device's entities
        for (ItemCount j = 0 ; j < entityCount ; ++j) {
            
            // Grab a reference to an entity
            MIDIEntityRef entity = MIDIDeviceGetEntity(device, j);
            
            // Iterate through this device's source endpoints (MIDI In)
            ItemCount sourceCount = MIDIEntityGetNumberOfSources(entity);
            for (ItemCount k = 0 ; k < sourceCount ; ++k) {
                
            }
            
            // Iterate through this device's destination endpoints
            ItemCount destCount = MIDIEntityGetNumberOfDestinations(entity);
            for (ItemCount k = 0 ; k < destCount ; ++k) {
                
            }
        }
        
    }
    
    ItemCount destCount = MIDIGetNumberOfDestinations();
    for (ItemCount i = 0 ; i < destCount ; ++i) {
        // Grab a reference to a destination endpoint
        destMIDI = MIDIGetDestination(i);
        if (destMIDI > 0) {
            if (([getDisplayName(destMIDI) rangeOfString:@"Virtual"].location == NSNotFound) && ([getDisplayName(destMIDI)rangeOfString:@"virtual"].location == NSNotFound)){ // do not add Virtual Destinations !!!!!!!!!!!
                [arrayForComboBox2 addObject:getDisplayName(destMIDI)];
                countComboBox2++;
                deviceIDdest = (int)i;
            }
        }
    }
    
    // Virtual sources and destinations don't have entities
    ItemCount sourceCount = MIDIGetNumberOfSources();
    for (ItemCount i = 0 ; i < sourceCount ; ++i) {
        sourceMIDI = MIDIGetSource(i);
        if (sourceMIDI > 0) {
            [arrayForComboBox1 addObject:getDisplayName(sourceMIDI)];
            countComboBox1++;
            deviceIDsource = (int)i;
        }
    }
    
    arrayOutDevices = [[NSMutableArray alloc] init];
    [arrayOutDevices addObject:@"N o n e"];
    if (countComboBox2 > 0) {
        for (int countX = 0; countX < countComboBox2; countX++){
            [arrayOutDevices addObject:arrayForComboBox2[countX]];
        }
    }
    arrayInDevices = [[NSMutableArray alloc] init];
    [arrayInDevices addObject:@"N o n e"];
    if (countComboBox1 > 0) {
        for (int countX = 0; countX < countComboBox1; countX++){
            [arrayInDevices addObject:arrayForComboBox1[countX]];
        }
    }
    
    if (posOutput > ([arrayOutDevices count]-1)) {
        posOutput = (int)[arrayOutDevices count]-1;
    }
    if (posInput > ([arrayInDevices count]-1)) {
        posInput = (int)[arrayInDevices count]-1;
    }
    
    if (![arrayOutDevices[posOutput] isEqual: @"N o n e"]){
        deviceIDdest = posOutput-1;
    }
    else {
        deviceIDdest = -1;
    }
    if (![arrayInDevices[posInput] isEqual: @"N o n e"]){
        deviceIDsource = posInput-1;
    }
    else {
        deviceIDsource = -1;
    }
    
    NSString *deviceNameMIDI = @"";
    
    if (deviceIDsource >= 0){
        s = MIDIPortDisconnectSource (outputPort, sourceMIDI);
    }
    if (deviceIDdest >= 0){
        s = MIDIPortDisconnectSource (inputPort, destMIDI);
    }
    
    if (!client){
        s = MIDIClientCreate((CFStringRef)@"My MIDI Client", MyMIDINotifyProc, (__bridge void *)(self), &client);
    }
    
    if (deviceIDsource >= 0){
        sourceMIDI = MIDIGetSource(deviceIDsource);
        s = MIDIInputPortCreate(client, CFSTR("MIDI Input port"), MyMIDIReadProc, (__bridge void *)(self), &inputPort);
        s = MIDIPortConnectSource(inputPort, sourceMIDI, NULL);
        inputPortLast = inputPort;
    }
    
    if (deviceIDdest >= 0){
        destMIDI = MIDIGetSource(deviceIDdest);
        s = MIDIOutputPortCreate(client, (CFStringRef)@"MIDI Output Port", &outputPort);
        outputEndpoint = MIDIGetDestination(deviceIDdest);
        outputPortLast = outputPort;
        textFieldSYSEX.text = [NSString stringWithFormat:@"%@\nDevice detected. %@If not OK: unplug and plug again", textFieldSYSEX.text, [NSString stringWithFormat:@"%@", deviceNameMIDI]];
        [self scrollToEndOfList];
    }
    
    if (posOutput > ([arrayOutDevices count]-1)) {
        posOutput = (int)[arrayOutDevices count]-1;
    }
    if (posInput > ([arrayInDevices count]-1)) {
        posInput = (int)[arrayInDevices count]-1;
    }
    outDeviceTextField.text = arrayOutDevices[posOutput];
    inDeviceTextField.text = arrayInDevices[posInput];

}

- (BOOL) getSendIt :(Byte)midiStatus2 {
    bool sendIt = FALSE;
    switch (midiStatus2 & 0x0F) {
        case 0:
            if (labelMIDI_0.isHidden) labelMIDI_0.hidden = FALSE;
            if (track0state == 2) sendIt = TRUE;
            break;
        case 1:
            if (labelMIDI_1.isHidden) labelMIDI_1.hidden = FALSE;
            if (track1state == 2) sendIt = TRUE;
            break;
        case 2:
            if (labelMIDI_2.isHidden) labelMIDI_2.hidden = FALSE;
            if (track2state == 2) sendIt = TRUE;
            break;
        case 3:
            if (labelMIDI_3.isHidden) labelMIDI_3.hidden = FALSE;
            if (track3state == 2) sendIt = TRUE;
            break;
        case 4:
            if (labelMIDI_4.isHidden) labelMIDI_4.hidden = FALSE;
            if (track4state == 2) sendIt = TRUE;
            break;
        case 5:
            if (labelMIDI_5.isHidden) labelMIDI_5.hidden = FALSE;
            if (track5state == 2) sendIt = TRUE;
            break;
        case 6:
            if (labelMIDI_6.isHidden) labelMIDI_6.hidden = FALSE;
            if (track6state == 2) sendIt = TRUE;
            break;
        case 7:
            if (labelMIDI_7.isHidden) labelMIDI_7.hidden = FALSE;
            if (track7state == 2) sendIt = TRUE;
            break;
        case 8:
            if (labelMIDI_8.isHidden) labelMIDI_8.hidden = FALSE;
            if (track8state == 2) sendIt = TRUE;
            break;
        case 9:
            if (labelMIDI_9.isHidden) labelMIDI_9.hidden = FALSE;
            if (track9state == 2) sendIt = TRUE;
            break;
        case 10:
            if (labelMIDI_10.isHidden) labelMIDI_10.hidden = FALSE;
            if (track10state == 2) sendIt = TRUE;
            break;
        case 11:
            if (labelMIDI_11.isHidden) labelMIDI_11.hidden = FALSE;
            if (track11state == 2) sendIt = TRUE;
            break;
        case 12:
            if (labelMIDI_12.isHidden) labelMIDI_12.hidden = FALSE;
            if (track12state == 2) sendIt = TRUE;
            break;
        case 13:
            if (labelMIDI_13.isHidden) labelMIDI_13.hidden = FALSE;
            if (track13state == 2) sendIt = TRUE;
            break;
        case 14:
            if (labelMIDI_14.isHidden) labelMIDI_14.hidden = FALSE;
            if (track14state == 2) sendIt = TRUE;
            break;
        case 15:
            if (labelMIDI_15.isHidden) labelMIDI_15.hidden = FALSE;
            if (track15state == 2) sendIt = TRUE;
            break;
            
        default:
            break;
    }
    return sendIt;
}


- (void) treatProgramChange :(Byte)midiChannelTemp :(Byte)tempBuffer1 {
    
    if (midiChannelTemp == 9) {
        instrName = [NSString stringWithFormat:@"Drums (%i)", tempBuffer1];
    }
    else {
        instrName = [NSString stringWithFormat:@"%@", [instruments objectAtIndex:tempBuffer1]];
    }
    
    if (midiChannelTemp == channelSelection) {
        labelInstrument.text = [NSString stringWithFormat:@"%@", instrName];
        labelInstrNumb.text = [NSString stringWithFormat:@"Instrument %i", tempBuffer1];
    }
    
    switch (midiChannelTemp) {
        case 0:
            if (lastInstr0 != tempBuffer1 || lastInstr0 == 0){
                if (switchLocalSoundState) [at0 setInstrument :tempBuffer1 :lastInstr0]; // program change AudioClass
            }
            if (channelSelection == 0 && track0state !=2) {
                slider2.value = tempBuffer1;
            }
            break;
        case 1:
            if (lastInstr1 != tempBuffer1 || lastInstr1 == 0){
                if (switchLocalSoundState) [at1 setInstrument :tempBuffer1 :lastInstr1];
            }
            if (channelSelection == 1 && track1state !=2) {
                slider2.value = tempBuffer1;
            }
            break;
        case 2:
            if (lastInstr2 != tempBuffer1 || lastInstr2 == 0){
                if (switchLocalSoundState) [at2 setInstrument :tempBuffer1 :lastInstr2];
            }
            if (channelSelection == 2 && track2state !=2) {
                slider2.value = tempBuffer1;
            }
            break;
        case 3:
            if (lastInstr3 != tempBuffer1 || lastInstr3 == 0){
                if (switchLocalSoundState) [at3 setInstrument :tempBuffer1 :lastInstr3];
            }
            if (channelSelection == 3 && track3state !=2) {
                slider2.value = tempBuffer1;
            }
            break;
        case 4:
            if (lastInstr4 != tempBuffer1 || lastInstr4 == 0){
                if (switchLocalSoundState) [at4 setInstrument :tempBuffer1 :lastInstr4];
            }
            if (channelSelection == 4 && track4state !=2) {
                slider2.value = tempBuffer1;
            }
            break;
        case 5:
            if (lastInstr5 != tempBuffer1 || lastInstr5 == 0){
                if (switchLocalSoundState) [at5 setInstrument :tempBuffer1 :lastInstr5];
            }
            if (channelSelection == 5 && track5state !=2) {
                slider2.value = tempBuffer1;
            }
            break;
        case 6:
            if (lastInstr6 != tempBuffer1 || lastInstr6 == 0){
                if (switchLocalSoundState) [at6 setInstrument :tempBuffer1 :lastInstr6];
            }
            if (channelSelection == 6 && track6state !=2) {
                slider2.value = tempBuffer1;
            }
            break;
        case 7:
            if (lastInstr7 != tempBuffer1 || lastInstr7 == 0){
                if (switchLocalSoundState) [at7 setInstrument :tempBuffer1 :lastInstr7];
            }
            if (channelSelection == 7 && track7state !=2) {
                slider2.value = tempBuffer1;
            }
            break;
        case 8:
            if (lastInstr8 != tempBuffer1 || lastInstr8 == 0){
                if (switchLocalSoundState) [at8 setInstrument :tempBuffer1 :lastInstr8];
            }
            if (channelSelection == 8 && track8state !=2) {
                slider2.value = tempBuffer1;
            }
            break;
        case 9:  // drums, do not send to AudioClass
            if (channelSelection == 9 && track9state !=2) {
                slider2.value = tempBuffer1;
            }
            break;
        case 10:
            if (lastInstr10 != tempBuffer1 || lastInstr10 == 0){
                if (switchLocalSoundState) [at10 setInstrument :tempBuffer1 :lastInstr10];
            }
            if (channelSelection == 10 && track10state !=2) {
                slider2.value = tempBuffer1;
            }
            break;
        case 11:
            if (lastInstr11 != tempBuffer1 || lastInstr11 == 0){
                if (switchLocalSoundState) [at11 setInstrument :tempBuffer1 :lastInstr11];
            }
            if (channelSelection == 11 && track11state !=2) {
                slider2.value = tempBuffer1;
            }
            break;
        case 12:
            if (lastInstr12 != tempBuffer1 || lastInstr12 == 0){
                if (switchLocalSoundState) [at12 setInstrument :tempBuffer1 :lastInstr12];
            }
            if (channelSelection == 12 && track12state !=2) {
                slider2.value = tempBuffer1;
            }
            break;
        case 13:
            if (lastInstr13 != tempBuffer1 || lastInstr13 == 0){
                if (switchLocalSoundState) [at13 setInstrument :tempBuffer1 :lastInstr13];
            }
            if (channelSelection == 13 && track13state !=2) {
                slider2.value = tempBuffer1;
            }
            break;
        case 14:
            if (lastInstr14 != tempBuffer1 || lastInstr14 == 0){
                if (switchLocalSoundState) [at14 setInstrument :tempBuffer1 :lastInstr14];
            }
            if (channelSelection == 14 && track14state !=2) {
                slider2.value = tempBuffer1;
            }
            break;
        case 15:
            if (lastInstr15 != tempBuffer1 || lastInstr15 == 0){
                if (switchLocalSoundState) [at15 setInstrument :tempBuffer1 :lastInstr15];
            }
            if (channelSelection == 15 && track15state !=2) {
                slider2.value = tempBuffer1;
            }
            break;
            
        default:
            break;
    }
    
}

- (void) treatTwoByteMIDI :(Byte)midiChannelTemp :(Byte)tempBuffer0 :(Byte)tempBuffer1 {
    if (switchLocalSoundState) {
        switch (midiChannelTemp) {
            case 0:
                [at0 midiEvent :tempBuffer0 :tempBuffer1 :0];
                break;
            case 1:
                [at1 midiEvent :tempBuffer0 :tempBuffer1 :0];
                break;
            case 2:
                [at2 midiEvent :tempBuffer0 :tempBuffer1 :0];
                break;
            case 3:
                [at3 midiEvent :tempBuffer0 :tempBuffer1 :0];
                break;
            case 4:
                [at4 midiEvent :tempBuffer0 :tempBuffer1 :0];
                break;
            case 5:
                [at5 midiEvent :tempBuffer0 :tempBuffer1 :0];
                break;
            case 6:
                [at6 midiEvent :tempBuffer0 :tempBuffer1 :0];
                break;
            case 7:
                [at7 midiEvent :tempBuffer0 :tempBuffer1 :0];
                break;
            case 8:
                [at8 midiEvent :tempBuffer0 :tempBuffer1 :0];
                break;
            case 9:  // drums, do not send to AudioClass
                break;
            case 10:
                [at10 midiEvent :tempBuffer0 :tempBuffer1 :0];
                break;
            case 11:
                [at11 midiEvent :tempBuffer0 :tempBuffer1 :0];
                break;
            case 12:
                [at12 midiEvent :tempBuffer0 :tempBuffer1 :0];
                break;
            case 13:
                [at13 midiEvent :tempBuffer0 :tempBuffer1 :0];
                break;
            case 14:
                [at14 midiEvent :tempBuffer0 :tempBuffer1 :0];
                break;
            case 15:
                [at15 midiEvent :tempBuffer0 :tempBuffer1 :0];
                break;
                
            default:
                break;
        }
    }
}

- (void) storeLastProgramChange :(Byte)midiChannelTemp :(Byte)tempBuffer1{
    switch (midiChannelTemp) {
        case 0:
            lastInstr0 = tempBuffer1;
            break;
        case 1:
            lastInstr1 = tempBuffer1;
            break;
        case 2:
            lastInstr2 = tempBuffer1;
            break;
        case 3:
            lastInstr3 = tempBuffer1;
            break;
        case 4:
            lastInstr4 = tempBuffer1;
            break;
        case 5:
            lastInstr5 = tempBuffer1;
            break;
        case 6:
            lastInstr6 = tempBuffer1;
            break;
        case 7:
            lastInstr7 = tempBuffer1;
            break;
        case 8:
            lastInstr8 = tempBuffer1;
            break;
        case 9:
            lastInstr9 = tempBuffer1;
            break;
        case 10:
            lastInstr10 = tempBuffer1;
            break;
        case 11:
            lastInstr11 = tempBuffer1;
            break;
        case 12:
            lastInstr12 = tempBuffer1;
            break;
        case 13:
            lastInstr13 = tempBuffer1;
            break;
        case 14:
            lastInstr14 = tempBuffer1;
            break;
        case 15:
            lastInstr15 = tempBuffer1;
            break;
            
        default:
            break;
    }
    
}

- (void) storeLastValues :(Byte)midiChannelTemp :(Byte)tempBuffer0 :(Byte)tempBuffer1 :(Byte)tempBuffer2{
//    NSLog(@"%02x %02x %02x", tempBuffer0, tempBuffer1, tempBuffer2);
    switch (midiChannelTemp) {
        case 0:
            if ((tempBuffer0 & 0xF0) == 0xB0) {
                if (tempBuffer1 == 0x07) lastVolume0 = tempBuffer2; // volume
                else if (tempBuffer1 == 0x5B) lastReverb0 = tempBuffer2; // reverb
                else if (tempBuffer1 == 0x5D) lastChorus0 = tempBuffer2; // chorus
                else if (tempBuffer1 == 0x0A) lastPanorama0 = tempBuffer2; // panorama
                if (channelSelection == 0 && track0state !=2) {
                    slider4.value = lastVolume0;
                    slider6.value = lastReverb0;
                    slider7.value = lastChorus0;
                    slider8.value = lastPanorama0;
                    slider4text.text = [NSString stringWithFormat:@"%d" , (int)slider4.value];
                    slider6text.text = [NSString stringWithFormat:@"%d" , (int)slider6.value];
                    slider7text.text = [NSString stringWithFormat:@"%d" , (int)slider7.value];
                }
            }
            break;
        case 1:
            if ((tempBuffer0 & 0xF0) == 0xB0) {
                if (tempBuffer1 == 0x07) lastVolume1 = tempBuffer2; // volume
                else if (tempBuffer1 == 0x5B) lastReverb1 = tempBuffer2; // reverb
                else if (tempBuffer1 == 0x5D) lastChorus1 = tempBuffer2; // chorus
                else if (tempBuffer1 == 0x0A) lastPanorama1 = tempBuffer2; // panorama
                if (channelSelection == 1 && track0state !=2) {
                    slider4.value = lastVolume1;
                    slider6.value = lastReverb1;
                    slider7.value = lastChorus1;
                    slider8.value = lastPanorama1;
                    slider4text.text = [NSString stringWithFormat:@"%d" , (int)slider4.value];
                    slider6text.text = [NSString stringWithFormat:@"%d" , (int)slider6.value];
                    slider7text.text = [NSString stringWithFormat:@"%d" , (int)slider7.value];
                }
            }
            break;
        case 2:
            if ((tempBuffer0 & 0xF0) == 0xB0) {
                if (tempBuffer1 == 0x07) lastVolume2 = tempBuffer2; // volume
                else if (tempBuffer1 == 0x5B) lastReverb2 = tempBuffer2; // reverb
                else if (tempBuffer1 == 0x5D) lastChorus2 = tempBuffer2; // chorus
                else if (tempBuffer1 == 0x0A) lastPanorama2 = tempBuffer2; // panorama
                if (channelSelection == 2 && track0state !=2) {
                    slider4.value = lastVolume2;
                    slider6.value = lastReverb2;
                    slider7.value = lastChorus2;
                    slider8.value = lastPanorama2;
                    slider4text.text = [NSString stringWithFormat:@"%d" , (int)slider4.value];
                    slider6text.text = [NSString stringWithFormat:@"%d" , (int)slider6.value];
                    slider7text.text = [NSString stringWithFormat:@"%d" , (int)slider7.value];
                }
            }
            break;
        case 3:
            if ((tempBuffer0 & 0xF0) == 0xB0) {
                if (tempBuffer1 == 0x07) lastVolume3 = tempBuffer2; // volume
                else if (tempBuffer1 == 0x5B) lastReverb3 = tempBuffer2; // reverb
                else if (tempBuffer1 == 0x5D) lastChorus3 = tempBuffer2; // chorus
                else if (tempBuffer1 == 0x0A) lastPanorama3 = tempBuffer2; // panorama
                if (channelSelection == 3 && track0state !=2) {
                    slider4.value = lastVolume3;
                    slider6.value = lastReverb3;
                    slider7.value = lastChorus3;
                    slider8.value = lastPanorama3;
                    slider4text.text = [NSString stringWithFormat:@"%d" , (int)slider4.value];
                    slider6text.text = [NSString stringWithFormat:@"%d" , (int)slider6.value];
                    slider7text.text = [NSString stringWithFormat:@"%d" , (int)slider7.value];
                }
            }
            break;
        case 4:
            if ((tempBuffer0 & 0xF0) == 0xB0) {
                if (tempBuffer1 == 0x07) lastVolume4 = tempBuffer2; // volume
                else if (tempBuffer1 == 0x5B) lastReverb4 = tempBuffer2; // reverb
                else if (tempBuffer1 == 0x5D) lastChorus4 = tempBuffer2; // chorus
                else if (tempBuffer1 == 0x0A) lastPanorama4 = tempBuffer2; // panorama
                if (channelSelection == 4 && track0state !=2) {
                    slider4.value = lastVolume4;
                    slider6.value = lastReverb4;
                    slider7.value = lastChorus4;
                    slider8.value = lastPanorama4;
                    slider4text.text = [NSString stringWithFormat:@"%d" , (int)slider4.value];
                    slider6text.text = [NSString stringWithFormat:@"%d" , (int)slider6.value];
                    slider7text.text = [NSString stringWithFormat:@"%d" , (int)slider7.value];
                }
            }
            break;
        case 5:
            if ((tempBuffer0 & 0xF0) == 0xB0) {
                if (tempBuffer1 == 0x07) lastVolume5 = tempBuffer2; // volume
                else if (tempBuffer1 == 0x5B) lastReverb5 = tempBuffer2; // reverb
                else if (tempBuffer1 == 0x5D) lastChorus5 = tempBuffer2; // chorus
                else if (tempBuffer1 == 0x0A) lastPanorama5 = tempBuffer2; // panorama
                if (channelSelection == 5 && track0state !=2) {
                    slider4.value = lastVolume5;
                    slider6.value = lastReverb5;
                    slider7.value = lastChorus5;
                    slider8.value = lastPanorama5;
                    slider4text.text = [NSString stringWithFormat:@"%d" , (int)slider4.value];
                    slider6text.text = [NSString stringWithFormat:@"%d" , (int)slider6.value];
                    slider7text.text = [NSString stringWithFormat:@"%d" , (int)slider7.value];
                }
            }
            break;
        case 6:
            if ((tempBuffer0 & 0xF0) == 0xB0) {
                if (tempBuffer1 == 0x07) lastVolume6 = tempBuffer2; // volume
                else if (tempBuffer1 == 0x5B) lastReverb6 = tempBuffer2; // reverb
                else if (tempBuffer1 == 0x5D) lastChorus6 = tempBuffer2; // chorus
                else if (tempBuffer1 == 0x0A) lastPanorama6 = tempBuffer2; // panorama
                if (channelSelection == 6 && track0state !=2) {
                    slider4.value = lastVolume6;
                    slider6.value = lastReverb6;
                    slider7.value = lastChorus6;
                    slider8.value = lastPanorama6;
                    slider4text.text = [NSString stringWithFormat:@"%d" , (int)slider4.value];
                    slider6text.text = [NSString stringWithFormat:@"%d" , (int)slider6.value];
                    slider7text.text = [NSString stringWithFormat:@"%d" , (int)slider7.value];
                }
            }
            break;
        case 7:
            if ((tempBuffer0 & 0xF0) == 0xB0) {
                if (tempBuffer1 == 0x07) lastVolume7 = tempBuffer2; // volume
                else if (tempBuffer1 == 0x5B) lastReverb7 = tempBuffer2; // reverb
                else if (tempBuffer1 == 0x5D) lastChorus7 = tempBuffer2; // chorus
                else if (tempBuffer1 == 0x0A) lastPanorama7 = tempBuffer2; // panorama
                if (channelSelection == 7 && track0state !=2) {
                    slider4.value = lastVolume7;
                    slider6.value = lastReverb7;
                    slider7.value = lastChorus7;
                    slider8.value = lastPanorama7;
                    slider4text.text = [NSString stringWithFormat:@"%d" , (int)slider4.value];
                    slider6text.text = [NSString stringWithFormat:@"%d" , (int)slider6.value];
                    slider7text.text = [NSString stringWithFormat:@"%d" , (int)slider7.value];
                }
            }
            break;
        case 8:
            if ((tempBuffer0 & 0xF0) == 0xB0) {
                if (tempBuffer1 == 0x07) lastVolume8 = tempBuffer2; // volume
                else if (tempBuffer1 == 0x5B) lastReverb8 = tempBuffer2; // reverb
                else if (tempBuffer1 == 0x5D) lastChorus8 = tempBuffer2; // chorus
                else if (tempBuffer1 == 0x0A) lastPanorama8 = tempBuffer2; // panorama
                if (channelSelection == 8 && track0state !=2) {
                    slider4.value = lastVolume8;
                    slider6.value = lastReverb8;
                    slider7.value = lastChorus8;
                    slider8.value = lastPanorama8;
                    slider4text.text = [NSString stringWithFormat:@"%d" , (int)slider4.value];
                    slider6text.text = [NSString stringWithFormat:@"%d" , (int)slider6.value];
                    slider7text.text = [NSString stringWithFormat:@"%d" , (int)slider7.value];
                }
            }
            break;
        case 9:
            if ((tempBuffer0 & 0xF0) == 0xB0) {
                if (tempBuffer1 == 0x07) lastVolume9 = tempBuffer2; // volume
                else if (tempBuffer1 == 0x5B) lastReverb9 = tempBuffer2; // reverb
                else if (tempBuffer1 == 0x5D) lastChorus9 = tempBuffer2; // chorus
                else if (tempBuffer1 == 0x0A) lastPanorama9 = tempBuffer2; // panorama
                if (channelSelection == 9 && track0state !=2) {
                    slider4.value = lastVolume9;
                    slider6.value = lastReverb9;
                    slider7.value = lastChorus9;
                    slider8.value = lastPanorama9;
                    slider4text.text = [NSString stringWithFormat:@"%d" , (int)slider4.value];
                    slider6text.text = [NSString stringWithFormat:@"%d" , (int)slider6.value];
                    slider7text.text = [NSString stringWithFormat:@"%d" , (int)slider7.value];
                }
            }
            break;
        case 10:
            if ((tempBuffer0 & 0xF0) == 0xB0) {
                if (tempBuffer1 == 0x07) lastVolume10 = tempBuffer2; // volume
                else if (tempBuffer1 == 0x5B) lastReverb10 = tempBuffer2; // reverb
                else if (tempBuffer1 == 0x5D) lastChorus10 = tempBuffer2; // chorus
                else if (tempBuffer1 == 0x0A) lastPanorama10 = tempBuffer2; // panorama
                if (channelSelection == 10 && track0state !=2) {
                    slider4.value = lastVolume10;
                    slider6.value = lastReverb10;
                    slider7.value = lastChorus10;
                    slider8.value = lastPanorama10;
                    slider4text.text = [NSString stringWithFormat:@"%d" , (int)slider4.value];
                    slider6text.text = [NSString stringWithFormat:@"%d" , (int)slider6.value];
                    slider7text.text = [NSString stringWithFormat:@"%d" , (int)slider7.value];
                }
            }
            break;
        case 11:
            if ((tempBuffer0 & 0xF0) == 0xB0) {
                if (tempBuffer1 == 0x07) lastVolume11 = tempBuffer2; // volume
                else if (tempBuffer1 == 0x5B) lastReverb11 = tempBuffer2; // reverb
                else if (tempBuffer1 == 0x5D) lastChorus11 = tempBuffer2; // chorus
                else if (tempBuffer1 == 0x0A) lastPanorama11 = tempBuffer2; // panorama
                if (channelSelection == 11 && track0state !=2) {
                    slider4.value = lastVolume11;
                    slider6.value = lastReverb11;
                    slider7.value = lastChorus11;
                    slider8.value = lastPanorama11;
                    slider4text.text = [NSString stringWithFormat:@"%d" , (int)slider4.value];
                    slider6text.text = [NSString stringWithFormat:@"%d" , (int)slider6.value];
                    slider7text.text = [NSString stringWithFormat:@"%d" , (int)slider7.value];
                }
            }
            break;
        case 12:
            if ((tempBuffer0 & 0xF0) == 0xB0) {
                if (tempBuffer1 == 0x07) lastVolume12 = tempBuffer2; // volume
                else if (tempBuffer1 == 0x5B) lastReverb12 = tempBuffer2; // reverb
                else if (tempBuffer1 == 0x5D) lastChorus12 = tempBuffer2; // chorus
                else if (tempBuffer1 == 0x0A) lastPanorama12 = tempBuffer2; // panorama
                if (channelSelection == 12 && track0state !=2) {
                    slider4.value = lastVolume12;
                    slider6.value = lastReverb12;
                    slider7.value = lastChorus12;
                    slider8.value = lastPanorama12;
                    slider4text.text = [NSString stringWithFormat:@"%d" , (int)slider4.value];
                    slider6text.text = [NSString stringWithFormat:@"%d" , (int)slider6.value];
                    slider7text.text = [NSString stringWithFormat:@"%d" , (int)slider7.value];
                }
            }
            break;
        case 13:
            if ((tempBuffer0 & 0xF0) == 0xB0) {
                if (tempBuffer1 == 0x07) lastVolume13 = tempBuffer2; // volume
                else if (tempBuffer1 == 0x5B) lastReverb13 = tempBuffer2; // reverb
                else if (tempBuffer1 == 0x5D) lastChorus13 = tempBuffer2; // chorus
                else if (tempBuffer1 == 0x0A) lastPanorama13 = tempBuffer2; // panorama
                if (channelSelection == 13 && track0state !=2) {
                    slider4.value = lastVolume13;
                    slider6.value = lastReverb13;
                    slider7.value = lastChorus13;
                    slider8.value = lastPanorama13;
                    slider4text.text = [NSString stringWithFormat:@"%d" , (int)slider4.value];
                    slider6text.text = [NSString stringWithFormat:@"%d" , (int)slider6.value];
                    slider7text.text = [NSString stringWithFormat:@"%d" , (int)slider7.value];
                }
            }
            break;
        case 14:
            if ((tempBuffer0 & 0xF0) == 0xB0) {
                if (tempBuffer1 == 0x07) lastVolume14 = tempBuffer2; // volume
                else if (tempBuffer1 == 0x5B) lastReverb14 = tempBuffer2; // reverb
                else if (tempBuffer1 == 0x5D) lastChorus14 = tempBuffer2; // chorus
                else if (tempBuffer1 == 0x0A) lastPanorama14 = tempBuffer2; // panorama
                if (channelSelection == 14 && track0state !=2) {
                    slider4.value = lastVolume14;
                    slider6.value = lastReverb14;
                    slider7.value = lastChorus14;
                    slider8.value = lastPanorama14;
                    slider4text.text = [NSString stringWithFormat:@"%d" , (int)slider4.value];
                    slider6text.text = [NSString stringWithFormat:@"%d" , (int)slider6.value];
                    slider7text.text = [NSString stringWithFormat:@"%d" , (int)slider7.value];
                }
            }
            break;
        case 15:
            if ((tempBuffer0 & 0xF0) == 0xB0) {
                if (tempBuffer1 == 0x07) lastVolume15 = tempBuffer2; // volume
                else if (tempBuffer1 == 0x5B) lastReverb15 = tempBuffer2; // reverb
                else if (tempBuffer1 == 0x5D) lastChorus15 = tempBuffer2; // chorus
                else if (tempBuffer1 == 0x0A) lastPanorama15 = tempBuffer2; // panorama
                if (channelSelection == 15 && track0state !=2) {
                    slider4.value = lastVolume15;
                    slider6.value = lastReverb15;
                    slider7.value = lastChorus15;
                    slider8.value = lastPanorama15;
                    slider4text.text = [NSString stringWithFormat:@"%d" , (int)slider4.value];
                    slider6text.text = [NSString stringWithFormat:@"%d" , (int)slider6.value];
                    slider7text.text = [NSString stringWithFormat:@"%d" , (int)slider7.value];
                }
            }
            break;
            
        default:
            break;
    }
    
}

- (void) treatThreeByteMIDI :(Byte)midiChannelTemp :(Byte)tempBuffer0 :(Byte)tempBuffer1 :(Byte)tempBuffer2 {
    // NSLog(@"%02x %02x %02x", tempBuffer0, tempBuffer1, tempBuffer2);
    switch (midiChannelTemp) {
        case 0:
            if (switchLocalSoundState) [at0 midiEvent :tempBuffer0 :tempBuffer1 :tempBuffer2];
            break;
        case 1:
            if (switchLocalSoundState) [at1 midiEvent :tempBuffer0 :tempBuffer1 :tempBuffer2];
            break;
        case 2:
            if (switchLocalSoundState) [at2 midiEvent :tempBuffer0 :tempBuffer1 :tempBuffer2];
            break;
        case 3:
            if (switchLocalSoundState) [at3 midiEvent :tempBuffer0 :tempBuffer1 :tempBuffer2];
            break;
        case 4:
            if (switchLocalSoundState) [at4 midiEvent :tempBuffer0 :tempBuffer1 :tempBuffer2];
            break;
        case 5:
            if (switchLocalSoundState) [at5 midiEvent :tempBuffer0 :tempBuffer1 :tempBuffer2];
            break;
        case 6:
            if (switchLocalSoundState) [at6 midiEvent :tempBuffer0 :tempBuffer1 :tempBuffer2];
            break;
        case 7:
            if (switchLocalSoundState) [at7 midiEvent :tempBuffer0 :tempBuffer1 :tempBuffer2];
            break;
        case 8:
            if (switchLocalSoundState) [at8 midiEvent :tempBuffer0 :tempBuffer1 :tempBuffer2];
            break;
        case 9:
            if (switchLocalSoundState) [at9 midiEvent :tempBuffer0 :tempBuffer1 :tempBuffer2];
            break;
        case 10:
            if (switchLocalSoundState) [at10 midiEvent :tempBuffer0 :tempBuffer1 :tempBuffer2];
            break;
        case 11:
            if (switchLocalSoundState) [at11 midiEvent :tempBuffer0 :tempBuffer1 :tempBuffer2];
            break;
        case 12:
            if (switchLocalSoundState) [at12 midiEvent :tempBuffer0 :tempBuffer1 :tempBuffer2];
            break;
        case 13:
            if (switchLocalSoundState) [at13 midiEvent :tempBuffer0 :tempBuffer1 :tempBuffer2];
            break;
        case 14:
            if (switchLocalSoundState) [at14 midiEvent :tempBuffer0 :tempBuffer1 :tempBuffer2];
            break;
        case 15:
            if (switchLocalSoundState) [at15 midiEvent :tempBuffer0 :tempBuffer1 :tempBuffer2];
            break;
            
        default:
            break;
    }
    if ((tempBuffer0 & 0xF0) == 0x90 || (tempBuffer0 & 0xF0) == 0x80) { // only note on/off
        if ((channelForShowChord != 0xFF) && midiChannelTemp != 9) {
            inppointBut++;
            if (inppointBut >= bufsizeBut){
                inppointBut = 0;
            }
            bufferForChord[inppointBut][0] = midiChannelTemp;
            bufferForChord[inppointBut][1] = tempBuffer1;
            if ((tempBuffer0 & 0xF0) == 0x80) bufferForChord[inppointBut][2] = 0; // Notes Off with velocity > 0
            else bufferForChord[inppointBut][2] = tempBuffer2; // velocity
        }
    }

}

- (void) sendMIDIevents :(int)numberOfEvents :(int)statusInfo :(int)param1 :(int)param2 :(bool)sendThru {
    channelInfoTemp = statusInfo & 0x0F;
    int iP = 0;

    //NSLog(@"%02x %02x %02x", channelInfoTemp, param1, param2);
    
    if (statusInfo > 0x7F && param1 < 0x80 && param2 < 0x80) {
        if (sendThru) {
            
            packetList.numPackets = 1;
            firstPacket = &packetList.packet[0];
            firstPacket->timeStamp = 0;	// send immediately
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
        
        if (isRecording){
            struct timeval time;
            gettimeofday(&time, NULL);
            secTempA = time.tv_sec;
            secTempB = time.tv_usec * 0.000001;
            secTempA = secTempA - secStartA;
            secTempB = secTempB - secStartB;
            timeStamp = (secTempA + secTempB) * 2; // Tempo 120/60 = 2
            
            if ((statusInfo & 0xF0) == 0x90) {  // Note On
                noteMessage.channel = channelInfoTemp;
                noteMessage.note = param1;
                noteMessage.velocity = param2;
                MusicTrackNewMIDINoteEvent(recordTrack, timeStamp, &noteMessage);
                //NSLog(@"%02x %02x %02x", channelInfoTemp, param1, param2);
            }
            else if ((statusInfo & 0xF0) == 0x80) {  // Note Off
                noteMessage.channel = channelInfoTemp;
                noteMessage.note = param1;
                noteMessage.velocity = 0;
                noteMessage.releaseVelocity = param2;
                MusicTrackNewMIDINoteEvent(recordTrack, timeStamp, &noteMessage);
                //NSLog(@"%02x %02x %02x", channelInfoTemp, param1, param2);
            }
            else {
                channelMessage.status = statusInfo;
                channelMessage.data1 = param1;
                channelMessage.data2 = param2;
                MusicTrackNewMIDIChannelEvent(recordTrack, timeStamp, &channelMessage);
                //NSLog(@"%02x %02x %02x", statusInfo, param1, param2);
            }
            
            // Get the length of tracks
            UInt32 szRec = sizeof(MusicTimeStamp);
            lenRec = 0;
            MusicSequenceGetIndTrack(recordSequence, 0, &recordTrack);
            MusicTrackGetProperty(recordTrack, kSequenceTrackProperty_TrackLength, &lenRec, &szRec);
            
            if (lenRec > (120 * 60)){ // > one hour, stop recording
                [self stopRecording];
            }
            
        }
        
        if ((statusInfo & 0xF0) == 0x90 && param2 > 0) {
            switch (channelInfoTemp) {
                case 0:
                    if (labelMIDI_0.isHidden) labelMIDI_0.hidden = FALSE;
                    break;
                case 1:
                    if (labelMIDI_1.isHidden) labelMIDI_1.hidden = FALSE;
                    break;
                case 2:
                    if (labelMIDI_2.isHidden) labelMIDI_2.hidden = FALSE;
                    break;
                case 3:
                    if (labelMIDI_3.isHidden) labelMIDI_3.hidden = FALSE;
                    break;
                case 4:
                    if (labelMIDI_4.isHidden) labelMIDI_4.hidden = FALSE;
                    break;
                case 5:
                    if (labelMIDI_5.isHidden) labelMIDI_5.hidden = FALSE;
                    break;
                case 6:
                    if (labelMIDI_6.isHidden) labelMIDI_6.hidden = FALSE;
                    break;
                case 7:
                    if (labelMIDI_7.isHidden) labelMIDI_7.hidden = FALSE;
                    break;
                case 8:
                    if (labelMIDI_8.isHidden) labelMIDI_8.hidden = FALSE;
                    break;
                case 9:
                    if (labelMIDI_9.isHidden) labelMIDI_9.hidden = FALSE;
                    break;
                case 10:
                    if (labelMIDI_10.isHidden) labelMIDI_10.hidden = FALSE;
                    break;
                case 11:
                    if (labelMIDI_11.isHidden) labelMIDI_11.hidden = FALSE;
                    break;
                case 12:
                    if (labelMIDI_12.isHidden) labelMIDI_12.hidden = FALSE;
                    break;
                case 13:
                    if (labelMIDI_13.isHidden) labelMIDI_13.hidden = FALSE;
                    break;
                case 14:
                    if (labelMIDI_14.isHidden) labelMIDI_14.hidden = FALSE;
                    break;
                case 15:
                    if (labelMIDI_15.isHidden) labelMIDI_15.hidden = FALSE;
                    break;
                    
                default:
                    break;
            }
        }
    }
}

- (void) sendSYSEX {
    packetList.numPackets = 1;
    firstPacket = &packetList.packet[0];
    firstPacket->timeStamp = 0;	// send immediately
    int iP;
    for (iP = 0; iP <= counterSYSEX; iP++){
        firstPacket->data[iP] = sysexMessages[iP];
    }
    firstPacket->length = iP;
    
    if (deviceIDdest > -1){
        s = MIDISend(outputPort, outputEndpoint, &packetList);
    }
    
    if (isRecording){
        struct timeval time;
        gettimeofday(&time, NULL);
        secTempA = time.tv_sec;
        secTempB = time.tv_usec * 0.000001;
        secTempA = secTempA - secStartA;
        secTempB = secTempB - secStartB;
        timeStamp = (secTempA + secTempB) * 2; // Tempo 120/60 = 2
        
        UInt32 theSize = offsetof(MIDIRawData, data[0]) + (sizeof(UInt8) * counterSYSEX+1);
        sysexData = (MIDIRawData *)calloc(1, theSize);
        sysexData->length = counterSYSEX+1;
        
        counterSYSEX = 0;
        
        for (int j = 0; j < sysexData->length; j++) {
            sysexData->data[j] = sysexMessages[j];
        }
        
        int status;
        if ((status = MusicTrackNewMIDIRawDataEvent(recordTrack, timeStamp, sysexData) != noErr)) {
            //NSLog(@"%i", status);
        }
    }
    
}

- (void) sendSYSEX2 {
    if (switchMIDIthruState) {
        packetList.numPackets = 1;
        firstPacket = &packetList.packet[0];
        firstPacket->timeStamp = 0;	// send immediately
        int iP;
        for (iP = 0; iP <= counterSYSEX2; iP++){
            firstPacket->data[iP] = sysexMessages2[iP];
        }
        firstPacket->length = iP;
        
        if (deviceIDdest > -1){
            s = MIDISend(outputPort, outputEndpoint, &packetList);
        }
    }
    if (isRecording){
        struct timeval time;
        gettimeofday(&time, NULL);
        secTempA = time.tv_sec;
        secTempB = time.tv_usec * 0.000001;
        secTempA = secTempA - secStartA;
        secTempB = secTempB - secStartB;
        timeStamp = (secTempA + secTempB) * 2; // Tempo 120/60 = 2
        
        UInt32 theSize = offsetof(MIDIRawData, data[0]) + (sizeof(UInt8) * counterSYSEX2+1);
        sysexData2 = (MIDIRawData *)calloc(1, theSize);
        sysexData2->length = counterSYSEX2+1;
        
        for (int j = 0; j < sysexData2->length; j++) {
            sysexData2->data[j] = sysexMessages2[j];
        }
        counterSYSEX2 = 0;
        
        int status2;
        if ((status2 = MusicTrackNewMIDIRawDataEvent(recordTrack, timeStamp, sysexData2) != noErr)) {
            //NSLog(@"%i", status2);
        }
    }
}


- (void) playMIDIfile {
    
    [appDelegate dummyRead];

    // Initialise the music sequence
    NewMusicSequence(&musicSequence);
    
    //    NSString *midiFilePath = [[NSBundle mainBundle] pathForResource:midiFilename ofType:@"mid"];
    
    // Create a new URL which points to the MIDI file
    NSURL * midiFileURL = [NSURL fileURLWithPath:midiFilePath];
    
    MusicSequenceFileLoad(musicSequence, (__bridge CFURLRef) midiFileURL, 0, 0);
    
    // Initialise the music player, 120 beats-per-minute
    NewMusicPlayer(&musicPlayer);
    
    // Set the endpoint of the sequence to be our virtual endpoint
    MusicSequenceSetMIDIEndpoint(musicSequence, virtualEndpoint);
    
    // Load the sequence into the music player
    MusicPlayerSetSequence(musicPlayer, musicSequence);
    // Called to do some MusicPlayer setup. This just
    // reduces latency when MusicPlayerStart is called
    MusicPlayerPreroll(musicPlayer);
    // Starts the music playing
    MusicPlayerStart(musicPlayer);
    midiFilePlaying = TRUE;
    isPause = FALSE;
    
    MusicPlayerSetPlayRateScalar(musicPlayer, playBackTempo);
    labelTempo.text = [NSString stringWithFormat:@"Tempo: %.2f", playBackTempo];
    
    // Get the length of tracks
    MusicTrack track;
    UInt32 sz = sizeof(MusicTimeStamp);
    len = 0;
    float lenBack = 0;
    for (int trackNr = 0; trackNr < 16; trackNr++){
        MusicSequenceGetIndTrack(musicSequence, trackNr, &track);
        MusicTrackGetProperty(track, kSequenceTrackProperty_TrackLength, &len, &sz);
        if (len > lenBack){
            lenBack = len;
        }
    }
    len = lenBack;
    
    sliderSongPosition.minimumValue = 0;
    songPosition = 0;
    sliderSongPosition.maximumValue = len;
    songLength = len;
    
    if (![lastPlayedMIDIfileName isEqualToString:labelMIDIfile.text]) {
        startPoint = 0;
        endPoint = 0;
        lastPlayedMIDIfileName = labelMIDIfile.text;
    }
    buttonLoop.enabled = TRUE;
    buttonStartPoint.enabled = TRUE;
    buttonEndPoint.enabled = TRUE;
    if (endPoint > startPoint) {
        labelStartPoint.hidden = FALSE;
        labelEndPoint.hidden = FALSE;
    }
}

- (void) startRecording {
    NewMusicSequence(&recordSequence);
    MusicSequenceNewTrack(recordSequence, &recordTrack);
    MusicSequenceSetSequenceType(recordSequence, kMusicSequenceType_Beats);
    
    timeStamp = 0;
    struct timeval time;
    gettimeofday(&time, NULL);
    secStartA = time.tv_sec;
    secStartB = time.tv_usec * 0.000001;
   
    ignoreLast = TRUE;
    if (track0state == 2 || isSettings) [self initialMIDIsettings :0];
    if (track1state == 2 || isSettings) [self initialMIDIsettings :1];
    if (track2state == 2 || isSettings) [self initialMIDIsettings :2];
    if (track3state == 2 || isSettings) [self initialMIDIsettings :3];
    if (track4state == 2 || isSettings) [self initialMIDIsettings :4];
    if (track5state == 2 || isSettings) [self initialMIDIsettings :5];
    if (track6state == 2 || isSettings) [self initialMIDIsettings :6];
    if (track7state == 2 || isSettings) [self initialMIDIsettings :7];
    if (track8state == 2 || isSettings) [self initialMIDIsettings :8];
    if (track9state == 2 || isSettings) [self initialMIDIsettings :9];
    if (track10state == 2 || isSettings) [self initialMIDIsettings :10];
    if (track11state == 2 || isSettings) [self initialMIDIsettings :11];
    if (track12state == 2 || isSettings) [self initialMIDIsettings :12];
    if (track13state == 2 || isSettings) [self initialMIDIsettings :13];
    if (track14state == 2 || isSettings) [self initialMIDIsettings :14];
    if (track15state == 2 || isSettings) [self initialMIDIsettings :15];
    ignoreLast = FALSE;
    
    isRecording = TRUE;

}

- (void) stopRecording {
    isRecording = FALSE;
    [buttonRecording setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    //    CAShow(recordSequence);  // To show all MIDI events !!!
    
    UInt32 sz = sizeof(MusicTimeStamp);
    lenRec = 0;
    MusicSequenceGetIndTrack(recordSequence, 0, &track);
    MusicTrackGetProperty(track, kSequenceTrackProperty_TrackLength, &lenRec, &sz);
    
    if (lenRec > 0.5){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss +zzzz"];
        NSDate *startDate = [NSDate date];
        
        NSTimeZone *zone = [NSTimeZone systemTimeZone];
        NSInteger interval = [zone secondsFromGMTForDate:startDate];
        startDate = [startDate dateByAddingTimeInterval:interval];
        //    NSLog(@"Date: %@", startDate);
        
        NSString *strDate = [[NSString alloc] initWithFormat:@"%@", startDate];
        NSArray *arr = [strDate componentsSeparatedByString:@" "];
        NSString *str;
        str = [arr objectAtIndex:0];
        NSArray *arr_date = [str componentsSeparatedByString:@"-"];
        
        int year = [[arr_date objectAtIndex:0] intValue];
        int month = [[arr_date objectAtIndex:1] intValue];
        int day = [[arr_date objectAtIndex:2] intValue];
        
        str = [arr objectAtIndex:1];
        NSArray *arr_time = [str componentsSeparatedByString:@":"];
        
        int hours = [[arr_time objectAtIndex:0] intValue];
        int minutes = [[arr_time objectAtIndex:1] intValue];
        int seconds = [[arr_time objectAtIndex:2] intValue];
        
        fileNameForSave = [NSString stringWithFormat:@"%@_%04d%02d%02d_%02d%02d%02d%@", @"$Record", year, month, day, hours, minutes, seconds, @".mid"];
        midiFileWritePath = [documentsDirectoryPath stringByAppendingPathComponent:fileNameForSave];
        
        infoStore = [[UIAlertView alloc]initWithTitle: @"Save as MIDI file ?"
                                              message: [NSString stringWithFormat:@"\n%@", fileNameForSave]
                                             delegate: self
                                    cancelButtonTitle: @"YES"
                                    otherButtonTitles: @"NO",nil];
        [infoStore show];  // rest siehe unten !!!!!
    }
    else {
        MusicSequenceDisposeTrack(recordSequence, track);
        DisposeMusicSequence(recordSequence);
    }
    
    if (!midiFilePlaying && !isPause){
        [self enableButtons:TRUE];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(int)buttonIndex {
    // deletion code here
    if (alertView == deleteAlert){
        if (buttonIndex == 0) {
            [fileManager removeItemAtPath:[documentsDirectoryPath stringByAppendingPathComponent:listArrayForPicker[selectedIndex]] error:nil];
            usleep(200);
            [self parseDir];
            if (listArrayCount > 0){
                textFieldSYSEX.text = @"";
                if (listArrayCount > 0){
                    if (selectedIndex >= listArrayCount){
                        selectedIndex = 0;
                    }
                    labelMIDIfile.text = listArrayForPicker[selectedIndex];
                    midiFilename = listArrayForPicker[selectedIndex];
                    midiFilePath = [documentsDirectoryPath stringByAppendingPathComponent:listArrayForPicker[selectedIndex]];
                    [self saveLastSelectedMIDIfile];
                }
                [self resetLastControllers];
            }
            else {
                selectedIndex = 0;
                labelMIDIfile.text = [NSString stringWithFormat:@"%@", textForNoFiles];
                midiFilename = @"";
                midiFilePath = @"";
            }
        }
    }
    
    else if (alertView == iPadAlert){
        if (buttonIndex != 0) {
            iPadA6 = TRUE;
        }
        else {
            iPadA6 = FALSE;
        }
        iPadQuestionAnswered = TRUE;
        userPreferences = [NSUserDefaults standardUserDefaults];
        [userPreferences setBool:iPadA6 forKey:@"iPadA6"];
        [userPreferences setBool:iPadQuestionAnswered forKey:@"iPadQuestionAnswered"];
        [userPreferences synchronize];
    }
    
    else if (alertView == infoStore) {
        if (buttonIndex == 0) {
            NSURL *midiURL = [NSURL fileURLWithPath:midiFileWritePath];
            OSStatus status = 0;
            status = MusicSequenceFileCreate(recordSequence, (__bridge CFURLRef)(midiURL), kMusicSequenceFile_MIDIType, kMusicSequenceFileFlags_EraseFile, 0);
            if (status == noErr) {
                midiFilename = fileNameForSave;
                [self saveLastSelectedMIDIfile];
                [self parseDir];
            }
            else {
                infoStoreError = [[UIAlertView alloc]initWithTitle: @"Information"
                                                           message: [NSString stringWithFormat:@"\nError storing MIDI file in: %@", documentsDirectoryPath]
                                                          delegate: self
                                                 cancelButtonTitle: nil
                                                 otherButtonTitles:@"OK",nil];
                [infoStoreError show];
            }
        }
        MusicSequenceDisposeTrack(recordSequence, track);
        DisposeMusicSequence(recordSequence);
    }
    
}

- (NSString*) getMIDIfileName {
    return midiFilename;
}

- (void) subPlayButton {
    if (listArrayCount > 0){
        if (!midiFilePlaying && listArrayCount > 0){
            textFieldSYSEX.text = @"";
            labelChordBig.hidden = TRUE;
            labelChordChannel.hidden = TRUE;
            labelChordBigState = TRUE;
            labelChordBig.text = @"";
            toggleColor = FALSE;
            if (!isRecording) [appDelegate sendRealTimeByte :0xFA :TRUE]; // Start
            [self playMIDIfile];
            [self enableButtons:FALSE];
        }
        else if (isPause){
            [self buttonPausePressed:nil];
        }
    }
}

- (void) subPauseButton {
    if (midiFilePlaying){
        if (isPause){
            sliderSongPosition.enabled = FALSE;
            isPause = FALSE;
            if (switchLocalSoundState) {
                slider2.enabled = FALSE;
                buttonMinusP.enabled = FALSE;
                buttonPlusP.enabled = FALSE;
            }
            [appDelegate sendRealTimeByte :0xFB :TRUE]; // Continue
            MusicPlayerStart(musicPlayer);
            [textFieldSYSEX setScrollEnabled:FALSE];
            [textFieldSYSEX setTextColor:[UIColor grayColor]];
        }
        else {
            sliderSongPosition.enabled = TRUE;
            isPause = TRUE;
            slider2.enabled = TRUE;
            buttonMinusP.enabled = TRUE;
            buttonPlusP.enabled = TRUE;
            MusicPlayerStop(musicPlayer);
            [textFieldSYSEX setScrollEnabled:TRUE];
            [textFieldSYSEX setTextColor:[UIColor blackColor]];
            [self scrollToEndOfList];
            timerforAllNotesOff =[NSTimer scheduledTimerWithTimeInterval:0.5
                                                                  target:self selector:@selector(timerAllNotesOffMethodPad)userInfo:nil repeats:NO];
        }
    }
}

- (void) subStopButton {
    if (isRecording) {
        // NSLog(@"timeStamp: %f", timeStamp);
        if (timeStamp > 0.2) {
            [self putThreeByteInBuffer :0x90 :0x3C :0];  // dummy damit noten ausklingen
        }
        usleep(100000);
        [self stopRecording];
    }
    else {
        timerforAllNotesOff =[NSTimer scheduledTimerWithTimeInterval:0.01
                                                              target:self selector:@selector(timerAllNotesOffMethodPad)userInfo:nil repeats:NO];
    }
    
    // Stop the player and dispose of the objects
    MusicPlayerStop(musicPlayer);
    DisposeMusicSequence(musicSequence);
    DisposeMusicPlayer(musicPlayer);
    isPause = FALSE;
    midiFilePlaying = FALSE;
    tempSYSEX = @"";
    
    [self enableButtons:TRUE];
    [self scrollToEndOfList];
    
    sliderSongPosition.value = 0;
    labelNowLen.text = @"0";
    songPosition = 0;
    
    buttonLoop.enabled = FALSE;
    buttonStartPoint.enabled =FALSE;
    buttonEndPoint.enabled = FALSE;
    labelStartPoint.hidden = TRUE;
    labelEndPoint.hidden = TRUE;
    [self subStartEndPoints];

}

- (IBAction)buttonPlayPressed:(id)sender {
    nextNotSend = FALSE;
    [self subPlayButton];
}

- (IBAction)buttonStopPressed:(id)sender {
    nextNotSend = FALSE;
    [self subStopButton];
}

- (IBAction)buttonPausePressed:(id)sender {
    nextNotSend = FALSE;
    [self subPauseButton];
}

- (IBAction)buttonRecordingPressed:(id)sender {
    if (isRecording){
        [appDelegate sendRealTimeByte :0xFC :TRUE]; // Stop
        [self stopRecording];
        if (!midiFilePlaying){
            [self enableButtons:TRUE];
        }
    }
    else {
        textFieldSYSEX.text = @"";
        labelChordBig.hidden = TRUE;
        labelChordChannel.hidden = TRUE;
        labelChordBig.text = @"";
        [self enableButtons:FALSE];
        [appDelegate sendRealTimeByte :0xFA :TRUE]; // Start
        [self startRecording];
    }
}

- (IBAction)previousMIDIfilePressed:(id)sender {
    [self buttonStopPressed:nil];
    [self parseDir];
    if (listArrayCount > 0){
        textFieldSYSEX.text = @"";
        labelChordBig.hidden = TRUE;
        labelChordChannel.hidden = TRUE;
        labelChordBig.text = @"";
        if (listArrayCount > 0){
            selectedIndex--;
            if (selectedIndex < 0){
                selectedIndex = listArrayCount-1;
            }
            labelMIDIfile.text = listArrayForPicker[selectedIndex];
            midiFilename = listArrayForPicker[selectedIndex];
            midiFilePath = [documentsDirectoryPath stringByAppendingPathComponent:listArrayForPicker[selectedIndex]];
            [self saveLastSelectedMIDIfile];
        }
        [self resetLastControllers];
    }
    channelSelection = 0;
    [self buttonChannel0pressed:nil];
}


- (IBAction)nextMIDIfilePressed:(id)sender {
    [self buttonStopPressed:nil];
    [self parseDir];
    if (listArrayCount > 0){
        textFieldSYSEX.text = @"";
        labelChordBig.hidden = TRUE;
        labelChordChannel.hidden = TRUE;
        labelChordBig.text = @"";
        if (listArrayCount > 0){
            selectedIndex++;
            if (selectedIndex >= listArrayCount){
                selectedIndex = 0;
            }
            labelMIDIfile.text = listArrayForPicker[selectedIndex];
            midiFilename = listArrayForPicker[selectedIndex];
            midiFilePath = [documentsDirectoryPath stringByAppendingPathComponent:listArrayForPicker[selectedIndex]];
            [self saveLastSelectedMIDIfile];
        }
        [self resetLastControllers];
    }
    channelSelection = 0;
    [self buttonChannel0pressed:nil];
}

- (IBAction)buttonRefreshPressed:(id)sender {
    [self buttonStopPressed:nil];
    [self parseDir];
    if (listArrayCount > 0){
        textFieldSYSEX.text = @"";
        labelChordBig.hidden = TRUE;
        labelChordChannel.hidden = TRUE;
        labelChordBig.text = @"";
        if (listArrayCount > 0){
            if (selectedIndex >= listArrayCount){
                selectedIndex = 0;
            }
            labelMIDIfile.text = listArrayForPicker[selectedIndex];
            midiFilename = listArrayForPicker[selectedIndex];
            midiFilePath = [documentsDirectoryPath stringByAppendingPathComponent:listArrayForPicker[selectedIndex]];
            [self saveLastSelectedMIDIfile];
        }
        [self resetLastControllers];
    }
    
}

- (IBAction)buttonDeletePressed:(id)sender {
    // Delete the file
    if (![labelMIDIfile.text isEqual: textForNoFiles]){
        midiFilename = listArrayForPicker[selectedIndex];
        if ([fileManager fileExistsAtPath:[documentsDirectoryPath stringByAppendingPathComponent:midiFilename]]){
            deleteAlert = [[UIAlertView alloc]initWithTitle: @"MIDI file to delete:"
                                                    message: [NSString stringWithFormat:@"%@\n\n%@", midiFilename, @"Delete this file now ?"]
                                                   delegate: self
                                          cancelButtonTitle: @"YES"
                                          otherButtonTitles: @"NO",nil];
            [deleteAlert show];
            // rest see deletion code below
        }
        else {
            [self parseDir];
            if (listArrayCount > 0){
                textFieldSYSEX.text = @"";
                labelChordBig.hidden = TRUE;
                labelChordChannel.hidden = TRUE;
                labelChordBig.text = @"";
                if (listArrayCount > 0){
                    if (selectedIndex >= listArrayCount){
                        selectedIndex = 0;
                    }
                    labelMIDIfile.text = listArrayForPicker[selectedIndex];
                    midiFilename = listArrayForPicker[selectedIndex];
                    midiFilePath = [documentsDirectoryPath stringByAppendingPathComponent:listArrayForPicker[selectedIndex]];
                    [self saveLastSelectedMIDIfile];
                }
            }
            else {
                selectedIndex = 0;
                labelMIDIfile.text = [NSString stringWithFormat:@"%@", textForNoFiles];
                midiFilename = @"";
                midiFilePath = @"";
            }
        }
    }
    
}


- (IBAction)sliderTempoChanged:(id)sender {
    if (sliderTempo.value < 0.05) sliderTempo.value = 0.05;
    playBackTempo = sliderTempo.value;
    if (midiFilePlaying){
        MusicPlayerSetPlayRateScalar(musicPlayer, playBackTempo);
    }
    labelTempo.text = [NSString stringWithFormat:@"Tempo: %.2f", playBackTempo];
}
- (void) tempoChanged :(float)tempo2 {
    playBackTempo = tempo2;
    MusicPlayerSetPlayRateScalar(musicPlayer, playBackTempo);
    sliderTempo.value = playBackTempo;
    labelTempo.text = [NSString stringWithFormat:@"Tempo: %.2f", playBackTempo];
}

- (float) getTempo {
    return playBackTempo;
}


- (IBAction)sliderSongPositionChange:(id)sender {
    songPosition = sliderSongPosition.value;
    if (midiFilePlaying){
        MusicPlayerStop(musicPlayer);
        MusicPlayerSetTime(musicPlayer, songPosition);
        labelNowLen.text = [NSString stringWithFormat:@"%.0f of %.0f", songPosition, len];
        if (!isPause){
            MusicPlayerStart(musicPlayer);
        }
    }
    else {
        MusicPlayerSetTime(musicPlayer, songPosition);
    }
}

- (void) enableButtons :(bool)enableBut {
    previousMIDIfile.enabled = enableBut;
    nextMIDIfile.enabled = enableBut;
    buttonDelete.enabled = enableBut;
    buttonSelect.enabled = enableBut;
    buttonRefresh.enabled = enableBut;
    switchLocSnd.enabled = enableBut;
    switchMIDIthru.enabled = enableBut;
    sliderSongPosition.enabled = enableBut;
    buttonMoreMIDIoptions.enabled = enableBut;
    
    if (switchLocalSoundState) {
        slider2.enabled = enableBut;
        buttonMinusP.enabled = enableBut;
        buttonPlusP.enabled = enableBut;
    }
    else {
        slider2.enabled = TRUE;
        buttonMinusP.enabled = TRUE;
        buttonPlusP.enabled = TRUE;
    }
    
    [textFieldSYSEX setScrollEnabled:enableBut];
    
    if (enableBut) [textFieldSYSEX setTextColor:[UIColor blackColor]];
    else [textFieldSYSEX setTextColor:[UIColor grayColor]];
    
    if (enableBut){
        [previousMIDIfile setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [nextMIDIfile setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [buttonDelete setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [buttonSelect setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [buttonRefresh setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    else {
        [previousMIDIfile setTitleColor:[UIColor colorWithRed:greyValue green:greyValue blue:greyValue alpha:1.0f] forState:UIControlStateNormal];
        [nextMIDIfile setTitleColor:[UIColor colorWithRed:greyValue green:greyValue blue:greyValue alpha:1.0f] forState:UIControlStateNormal];
        [buttonDelete setTitleColor:[UIColor colorWithRed:greyValue green:greyValue blue:greyValue alpha:1.0f] forState:UIControlStateNormal];
        [buttonSelect setTitleColor:[UIColor colorWithRed:greyValue green:greyValue blue:greyValue alpha:1.0f] forState:UIControlStateNormal];
        [buttonRefresh setTitleColor:[UIColor colorWithRed:greyValue green:greyValue blue:greyValue alpha:1.0f] forState:UIControlStateNormal];
    }
    if (track0state == 2 && !enableBut) buttonTrack0.enabled = FALSE; else buttonTrack0.enabled = TRUE;
    if (track1state == 2 && !enableBut) buttonTrack1.enabled = FALSE; else buttonTrack1.enabled = TRUE;
    if (track2state == 2 && !enableBut) buttonTrack2.enabled = FALSE; else buttonTrack2.enabled = TRUE;
    if (track3state == 2 && !enableBut) buttonTrack3.enabled = FALSE; else buttonTrack3.enabled = TRUE;
    if (track4state == 2 && !enableBut) buttonTrack4.enabled = FALSE; else buttonTrack4.enabled = TRUE;
    if (track5state == 2 && !enableBut) buttonTrack5.enabled = FALSE; else buttonTrack5.enabled = TRUE;
    if (track6state == 2 && !enableBut) buttonTrack6.enabled = FALSE; else buttonTrack6.enabled = TRUE;
    if (track7state == 2 && !enableBut) buttonTrack7.enabled = FALSE; else buttonTrack7.enabled = TRUE;
    if (track8state == 2 && !enableBut) buttonTrack8.enabled = FALSE; else buttonTrack8.enabled = TRUE;
    if (track9state == 2 && !enableBut) buttonTrack9.enabled = FALSE; else buttonTrack9.enabled = TRUE;
    if (track10state == 2 && !enableBut) buttonTrack10.enabled = FALSE; else buttonTrack10.enabled = TRUE;
    if (track11state == 2 && !enableBut) buttonTrack11.enabled = FALSE; else buttonTrack11.enabled = TRUE;
    if (track12state == 2 && !enableBut) buttonTrack12.enabled = FALSE; else buttonTrack12.enabled = TRUE;
    if (track13state == 2 && !enableBut) buttonTrack13.enabled = FALSE; else buttonTrack13.enabled = TRUE;
    if (track14state == 2 && !enableBut) buttonTrack14.enabled = FALSE; else buttonTrack14.enabled = TRUE;
    if (track15state == 2 && !enableBut) buttonTrack15.enabled = FALSE; else buttonTrack15.enabled = TRUE;
    
}

- (IBAction)buttonSelectPressed:(id)sender {
    
    [self buttonStopPressed:nil];
    
    [self parseDir];

    if (listArrayCount == 0) {
        alertP = [[UIAlertView alloc]initWithTitle: @"Information"
                                           message: [NSString stringWithFormat:@"%@", textForNoFiles]
                                          delegate: self
                                 cancelButtonTitle: nil
                                 otherButtonTitles:@"OK",nil];
        [alertP show];
        return;
    }
    
    if (listArrayCount > 0){
        if (selectedIndex >= listArrayCount){
            selectedIndex = 0;
        }
        [self resetLastControllers];
    }
    
}

- (void) stopTimers {
    if (notifyTimer)
    {
        [notifyTimer invalidate];
        notifyTimer = nil;
    }
    
    if(inputTreatTimer)
    {
        [inputTreatTimer invalidate];
        inputTreatTimer = nil;
    }
    
}

- (void) initialMIDIsettings :(int)channelNumber {
    [self initialMIDIsettingsInstrument :channelNumber];
    [self initialMIDIsettingsVolume :channelNumber];
    [self initialMIDIsettingsReverb :channelNumber];
    [self initialMIDIsettingsChorus :channelNumber];
    [self initialMIDIsettingsPanorama :channelNumber];
}

- (void) initialMIDIsettingsInstrument :(int)channelNumber {
    // program change
    if (channelNumber == 0) {
        if (lastInstr0back != lastInstr0 || ignoreLast) {
            lastInstr0back = lastInstr0;
            [self putByteInBuffer:0xC0 + channelNumber]; // program change
            [self putByteInBuffer:lastInstr0];
            if (switchLocalSoundState) {
                [at0 setInstrument :lastInstr0 :255]; // program change AudioClass
            }
        }
    }
    if (channelNumber == 1) {
        if (lastInstr1back != lastInstr1 || ignoreLast) {
            lastInstr1back = lastInstr1;
            [self putByteInBuffer:0xC0 + channelNumber]; // program change
            [self putByteInBuffer:lastInstr1];
            if (switchLocalSoundState) {
                [at1 setInstrument :lastInstr1 :255];
            }
        }
    }
    if (channelNumber == 2) {
        if (lastInstr2back != lastInstr2 || ignoreLast) {
            lastInstr2back = lastInstr2;
            [self putByteInBuffer:0xC0 + channelNumber]; // program change
            [self putByteInBuffer:lastInstr2];
            if (switchLocalSoundState) {
                [at2 setInstrument :lastInstr2 :255];
            }
        }
    }
    if (channelNumber == 3) {
        if (lastInstr3back != lastInstr3 || ignoreLast) {
            lastInstr3back = lastInstr3;
            [self putByteInBuffer:0xC0 + channelNumber]; // program change
            [self putByteInBuffer:lastInstr3];
            if (switchLocalSoundState) {
                [at3 setInstrument :lastInstr3 :255];
            }
        }
    }
    if (channelNumber == 4) {
        if (lastInstr4back != lastInstr4 || ignoreLast) {
            lastInstr4back = lastInstr4;
            [self putByteInBuffer:0xC0 + channelNumber]; // program change
            [self putByteInBuffer:lastInstr4];
            if (switchLocalSoundState) {
                [at4 setInstrument :lastInstr4 :255];
            }
        }
    }
    if (channelNumber == 5) {
        if (lastInstr5back != lastInstr5 || ignoreLast) {
            lastInstr5back = lastInstr5;
            [self putByteInBuffer:0xC0 + channelNumber]; // program change
            [self putByteInBuffer:lastInstr5];
            if (switchLocalSoundState) {
                [at5 setInstrument :lastInstr5 :255];
            }
        }
    }
    if (channelNumber == 6) {
        if (lastInstr6back != lastInstr6 || ignoreLast) {
            lastInstr6back = lastInstr6;
            [self putByteInBuffer:0xC0 + channelNumber]; // program change
            [self putByteInBuffer:lastInstr6];
            if (switchLocalSoundState) {
                [at6 setInstrument :lastInstr6 :255];
            }
        }
    }
    if (channelNumber == 7) {
        if (lastInstr7back != lastInstr7 || ignoreLast) {
            lastInstr7back = lastInstr7;
            [self putByteInBuffer:0xC0 + channelNumber]; // program change
            [self putByteInBuffer:lastInstr7];
            if (switchLocalSoundState) {
                [at7 setInstrument :lastInstr7 :255];
            }
        }
    }
    if (channelNumber == 8) {
        if (lastInstr8back != lastInstr8 || ignoreLast) {
            lastInstr8back = lastInstr8;
            [self putByteInBuffer:0xC0 + channelNumber]; // program change
            [self putByteInBuffer:lastInstr8];
            if (switchLocalSoundState) {
                [at8 setInstrument :lastInstr8 :255];
            }
        }
    }
    if (channelNumber == 9) {
        if (lastInstr9back != lastInstr9 || ignoreLast) {
            lastInstr9back = lastInstr9;
            [self putByteInBuffer:0xC0 + channelNumber]; // program change
            [self putByteInBuffer:lastInstr9];
        }
    }
    
    if (channelNumber == 10) {
        if (lastInstr10back != lastInstr10 || ignoreLast) {
            lastInstr10back = lastInstr10;
            [self putByteInBuffer:0xC0 + channelNumber]; // program change
            [self putByteInBuffer:lastInstr10];
            if (switchLocalSoundState) {
                [at10 setInstrument :lastInstr10 :255];
            }
        }
    }
    if (channelNumber == 11) {
        if (lastInstr11back != lastInstr11 || ignoreLast) {
            lastInstr11back = lastInstr11;
            [self putByteInBuffer:0xC0 + channelNumber]; // program change
            [self putByteInBuffer:lastInstr11];
            if (switchLocalSoundState) {
                [at11 setInstrument :lastInstr11 :255];
            }
        }
    }
    if (channelNumber == 12) {
        if (lastInstr12back != lastInstr12 || ignoreLast) {
            lastInstr12back = lastInstr12;
            [self putByteInBuffer:0xC0 + channelNumber]; // program change
            [self putByteInBuffer:lastInstr12];
            if (switchLocalSoundState) {
                [at12 setInstrument :lastInstr12 :255];
            }
        }
    }
    if (channelNumber == 13) {
        if (lastInstr13back != lastInstr13 || ignoreLast) {
            lastInstr13back = lastInstr13;
            [self putByteInBuffer:0xC0 + channelNumber]; // program change
            [self putByteInBuffer:lastInstr13];
            if (switchLocalSoundState) {
                [at13 setInstrument :lastInstr13 :255];
            }
        }
    }
    if (channelNumber == 14) {
        if (lastInstr14back != lastInstr14 || ignoreLast) {
            lastInstr14back = lastInstr14;
            [self putByteInBuffer:0xC0 + channelNumber]; // program change
            [self putByteInBuffer:lastInstr14];
            if (switchLocalSoundState) {
                [at14 setInstrument :lastInstr14 :255];
            }
        }
    }
    if (channelNumber == 15) {
        if (lastInstr15back != lastInstr15 || ignoreLast) {
            lastInstr15back = lastInstr15;
            [self putByteInBuffer:0xC0 + channelNumber]; // program change
            [self putByteInBuffer:lastInstr15];
            if (switchLocalSoundState) {
                [at15 setInstrument :lastInstr15 :255];
            }
        }
    }
}

- (void) initialMIDIsettingsVolume :(int)channelNumber {
    controllerByte = 0x07; // volume
    if (channelNumber == 0) {
        if (lastVolume0back != lastVolume0 || ignoreLast) {
            lastVolume0back = lastVolume0;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastVolume0];
            if (switchLocalSoundState) [at0 midiEvent :0xB0 :controllerByte :lastVolume0];
        }
    }
    if (channelNumber == 1) {
        if (lastVolume1back != lastVolume1 || ignoreLast) {
            lastVolume1back = lastVolume1;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastVolume1];
            if (switchLocalSoundState) [at1 midiEvent :0xB1 :controllerByte :lastVolume1];
        }
    }
    if (channelNumber == 2) {
        if (lastVolume2back != lastVolume2 || ignoreLast) {
            lastVolume2back = lastVolume2;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastVolume2];
            if (switchLocalSoundState) [at2 midiEvent :0xB2 :controllerByte :lastVolume2];
        }
    }
    if (channelNumber == 3) {
        if (lastVolume3back != lastVolume3 || ignoreLast) {
            lastVolume3back = lastVolume3;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastVolume3];
            if (switchLocalSoundState) [at3 midiEvent :0xB3 :controllerByte :lastVolume3];
        }
    }
    if (channelNumber == 4) {
        if (lastVolume4back != lastVolume4 || ignoreLast) {
            lastVolume4back = lastVolume4;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastVolume4];
            if (switchLocalSoundState) [at4 midiEvent :0xB4 :controllerByte :lastVolume4];
        }
    }
    if (channelNumber == 5) {
        if (lastVolume5back != lastVolume5 || ignoreLast) {
            lastVolume5back = lastVolume5;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastVolume5];
            if (switchLocalSoundState) [at5 midiEvent :0xB5 :controllerByte :lastVolume5];
        }
    }
    if (channelNumber == 6) {
        if (lastVolume6back != lastVolume6 || ignoreLast) {
            lastVolume6back = lastVolume6;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastVolume6];
            if (switchLocalSoundState) [at6 midiEvent :0xB6 :controllerByte :lastVolume6];
        }
    }
    if (channelNumber == 7) {
        if (lastVolume7back != lastVolume7 || ignoreLast) {
            lastVolume7back = lastVolume7;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastVolume7];
            if (switchLocalSoundState) [at7 midiEvent :0xB7 :controllerByte :lastVolume7];
        }
    }
    if (channelNumber == 8) {
        if (lastVolume8back != lastVolume8 || ignoreLast) {
            lastVolume8back = lastVolume8;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastVolume8];
            if (switchLocalSoundState) [at8 midiEvent :0xB8 :controllerByte :lastVolume8];
        }
    }
    if (channelNumber == 9) {
        if (lastVolume9back != lastVolume9 || ignoreLast) {
            lastVolume9back = lastVolume9;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastVolume9];
            if (switchLocalSoundState) [at9 midiEvent :0xB9 :controllerByte :lastVolume9];
        }
    }
    if (channelNumber == 10) {
        if (lastVolume10back != lastVolume10 || ignoreLast) {
            lastVolume10back = lastVolume10;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastVolume10];
            if (switchLocalSoundState) [at10 midiEvent :0xBA :controllerByte :lastVolume10];
        }
    }
    if (channelNumber == 11) {
        if (lastVolume11back != lastVolume11 || ignoreLast) {
            lastVolume11back = lastVolume11;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastVolume11];
            if (switchLocalSoundState) [at11 midiEvent :0xBB :controllerByte :lastVolume11];
        }
    }
    if (channelNumber == 12) {
        if (lastVolume12back != lastVolume12 || ignoreLast) {
            lastVolume12back = lastVolume12;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastVolume12];
            if (switchLocalSoundState) [at12 midiEvent :0xBC :controllerByte :lastVolume12];
        }
    }
    if (channelNumber == 13) {
        if (lastVolume13back != lastVolume13 || ignoreLast) {
            lastVolume13back = lastVolume13;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastVolume13];
            if (switchLocalSoundState) [at13 midiEvent :0xBD :controllerByte :lastVolume13];
        }
    }
    if (channelNumber == 14) {
        if (lastVolume14back != lastVolume14 || ignoreLast) {
            lastVolume14back = lastVolume14;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastVolume14];
            if (switchLocalSoundState) [at14 midiEvent :0xBE :controllerByte :lastVolume14];
        }
    }
    if (channelNumber == 15) {
        if (lastVolume15back != lastVolume15 || ignoreLast) {
            lastVolume15back = lastVolume15;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastVolume15];
            if (switchLocalSoundState) [at15 midiEvent :0xBF :controllerByte :lastVolume15];
        }
    }
    
}

- (void) initialMIDIsettingsReverb :(int)channelNumber {
    controllerByte = 0x5B; // reverb
    if (channelNumber == 0) {
        if (lastReverb0back != lastReverb0 || ignoreLast) {
            lastReverb0back = lastReverb0;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastReverb0];
            if (switchLocalSoundState) [at0 midiEvent :0xB0 :controllerByte :lastReverb0];
        }
    }
    if (channelNumber == 1) {
        if (lastReverb1back != lastReverb1 || ignoreLast) {
            lastReverb1back = lastReverb1;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastReverb1];
            if (switchLocalSoundState) [at1 midiEvent :0xB1 :controllerByte :lastReverb1];
        }
    }
    if (channelNumber == 2) {
        if (lastReverb2back != lastReverb2 || ignoreLast) {
            lastReverb2back = lastReverb2;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastReverb2];
            if (switchLocalSoundState) [at2 midiEvent :0xB2 :controllerByte :lastReverb2];
        }
    }
    if (channelNumber == 3) {
        if (lastReverb3back != lastReverb3 || ignoreLast) {
            lastReverb3back = lastReverb3;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastReverb3];
            if (switchLocalSoundState) [at3 midiEvent :0xB3 :controllerByte :lastReverb3];
        }
    }
    if (channelNumber == 4) {
        if (lastReverb4back != lastReverb4 || ignoreLast) {
            lastReverb4back = lastReverb4;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastReverb4];
            if (switchLocalSoundState) [at4 midiEvent :0xB4 :controllerByte :lastReverb4];
        }
    }
    if (channelNumber == 5) {
        if (lastReverb5back != lastReverb5 || ignoreLast) {
            lastReverb5back = lastReverb5;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastReverb5];
            if (switchLocalSoundState) [at5 midiEvent :0xB5 :controllerByte :lastReverb5];
        }
    }
    if (channelNumber == 6) {
        if (lastReverb6back != lastReverb6 || ignoreLast) {
            lastReverb6back = lastReverb6;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastReverb6];
            if (switchLocalSoundState) [at6 midiEvent :0xB6 :controllerByte :lastReverb6];
        }
    }
    if (channelNumber == 7) {
        if (lastReverb7back != lastReverb7 || ignoreLast) {
            lastReverb7back = lastReverb7;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastReverb7];
            if (switchLocalSoundState) [at7 midiEvent :0xB7 :controllerByte :lastReverb7];
        }
    }
    if (channelNumber == 8) {
        if (lastReverb8back != lastReverb8 || ignoreLast) {
            lastReverb8back = lastReverb8;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastReverb8];
            if (switchLocalSoundState) [at8 midiEvent :0xB8 :controllerByte :lastReverb8];
        }
    }
    if (channelNumber == 9) {
        if (lastReverb9back != lastReverb9 || ignoreLast) {
            lastReverb9back = lastReverb9;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastReverb9];
            if (switchLocalSoundState) [at9 midiEvent :0xB9 :controllerByte :lastReverb9];
        }
    }
    if (channelNumber == 10) {
        if (lastReverb10back != lastReverb10 || ignoreLast) {
            lastReverb10back = lastReverb10;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastReverb10];
            if (switchLocalSoundState) [at10 midiEvent :0xBA :controllerByte :lastReverb10];
        }
    }
    if (channelNumber == 11) {
        if (lastReverb11back != lastReverb11 || ignoreLast) {
            lastReverb11back = lastReverb11;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastReverb11];
            if (switchLocalSoundState) [at11 midiEvent :0xBB :controllerByte :lastReverb11];
        }
    }
    if (channelNumber == 12) {
        if (lastReverb12back != lastReverb12 || ignoreLast) {
            lastReverb12back = lastReverb12;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastReverb12];
            if (switchLocalSoundState) [at12 midiEvent :0xBC :controllerByte :lastReverb12];
        }
    }
    if (channelNumber == 13) {
        if (lastReverb13back != lastReverb13 || ignoreLast) {
            lastReverb13back = lastReverb13;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastReverb13];
            if (switchLocalSoundState) [at13 midiEvent :0xBD :controllerByte :lastReverb13];
        }
    }
    if (channelNumber == 14) {
        if (lastReverb14back != lastReverb14 || ignoreLast) {
            lastReverb14back = lastReverb14;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastReverb14];
            if (switchLocalSoundState) [at14 midiEvent :0xBE :controllerByte :lastReverb14];
        }
    }
    if (channelNumber == 15) {
        if (lastReverb15back != lastReverb15 || ignoreLast) {
            lastReverb15back = lastReverb15;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastReverb15];
            if (switchLocalSoundState) [at15 midiEvent :0xBF :controllerByte :lastReverb15];
        }
    }
    
}

- (void) initialMIDIsettingsChorus :(int)channelNumber {
    controllerByte = 0x5D; // chorus
    if (channelNumber == 0) {
        if (lastChorus0back != lastChorus0 || ignoreLast) {
            lastChorus0back = lastChorus0;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastChorus0];
            if (switchLocalSoundState) [at0 midiEvent :0xB0 :controllerByte :lastChorus0];
        }
    }
    if (channelNumber == 1) {
        if (lastChorus1back != lastChorus1 || ignoreLast) {
            lastChorus1back = lastChorus1;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastChorus1];
            if (switchLocalSoundState) [at1 midiEvent :0xB1 :controllerByte :lastChorus1];
        }
    }
    if (channelNumber == 2) {
        if (lastChorus2back != lastChorus2 || ignoreLast) {
            lastChorus2back = lastChorus2;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastChorus2];
            if (switchLocalSoundState) [at2 midiEvent :0xB2 :controllerByte :lastChorus2];
        }
    }
    if (channelNumber == 3) {
        if (lastChorus3back != lastChorus3 || ignoreLast) {
            lastChorus3back = lastChorus3;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastChorus3];
            if (switchLocalSoundState) [at3 midiEvent :0xB3 :controllerByte :lastChorus3];
        }
    }
    if (channelNumber == 4) {
        if (lastChorus4back != lastChorus4 || ignoreLast) {
            lastChorus4back = lastChorus4;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastChorus4];
            if (switchLocalSoundState) [at4 midiEvent :0xB4 :controllerByte :lastChorus4];
        }
    }
    if (channelNumber == 5) {
        if (lastChorus5back != lastChorus5 || ignoreLast) {
            lastChorus5back = lastChorus5;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastChorus5];
            if (switchLocalSoundState) [at5 midiEvent :0xB5 :controllerByte :lastChorus5];
        }
    }
    if (channelNumber == 6) {
        if (lastChorus6back != lastChorus6 || ignoreLast) {
            lastChorus6back = lastChorus6;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastChorus6];
            if (switchLocalSoundState) [at6 midiEvent :0xB6 :controllerByte :lastChorus6];
        }
    }
    if (channelNumber == 7) {
        if (lastChorus7back != lastChorus7 || ignoreLast) {
            lastChorus7back = lastChorus7;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastChorus7];
            if (switchLocalSoundState) [at7 midiEvent :0xB7 :controllerByte :lastChorus7];
        }
    }
    if (channelNumber == 8) {
        if (lastChorus8back != lastChorus8 || ignoreLast) {
            lastChorus8back = lastChorus8;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastChorus8];
            if (switchLocalSoundState) [at8 midiEvent :0xB8 :controllerByte :lastChorus8];
        }
    }
    if (channelNumber == 9) {
        if (lastChorus9back != lastChorus9 || ignoreLast) {
            lastChorus9back = lastChorus9;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastChorus9];
            if (switchLocalSoundState) [at9 midiEvent :0xB9 :controllerByte :lastChorus9];
        }
    }
    if (channelNumber == 10) {
        if (lastChorus10back != lastChorus10 || ignoreLast) {
            lastChorus10back = lastChorus10;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastChorus10];
            if (switchLocalSoundState) [at10 midiEvent :0xBA :controllerByte :lastChorus10];
        }
    }
    if (channelNumber == 11) {
        if (lastChorus11back != lastChorus11 || ignoreLast) {
            lastChorus11back = lastChorus11;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastChorus11];
            if (switchLocalSoundState) [at11 midiEvent :0xBB :controllerByte :lastChorus11];
        }
    }
    if (channelNumber == 12) {
        if (lastChorus12back != lastChorus12 || ignoreLast) {
            lastChorus12back = lastChorus12;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastChorus12];
            if (switchLocalSoundState) [at12 midiEvent :0xBC :controllerByte :lastChorus12];
        }
    }
    if (channelNumber == 13) {
        if (lastChorus13back != lastChorus13 || ignoreLast) {
            lastChorus13back = lastChorus13;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastChorus13];
            if (switchLocalSoundState) [at13 midiEvent :0xBD :controllerByte :lastChorus13];
        }
    }
    if (channelNumber == 14) {
        if (lastChorus14back != lastChorus14 || ignoreLast) {
            lastChorus14back = lastChorus14;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastChorus14];
            if (switchLocalSoundState) [at14 midiEvent :0xBE :controllerByte :lastChorus14];
        }
    }
    if (channelNumber == 15) {
        if (lastChorus15back != lastChorus15 || ignoreLast) {
            lastChorus15back = lastChorus15;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastChorus15];
            if (switchLocalSoundState) [at15 midiEvent :0xBF :controllerByte :lastChorus15];
        }
    }
    
}

- (void) initialMIDIsettingsPanorama :(int)channelNumber {
    controllerByte = 0x0A;  // panorama
    if (channelNumber == 0) {
        if (lastPanorama0back != lastPanorama0 || ignoreLast) {
            lastPanorama0back = lastPanorama0;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastPanorama0];
            if (switchLocalSoundState) [at0 midiEvent :0xB0 :controllerByte :lastPanorama0];
        }
    }
    if (channelNumber == 1) {
        if (lastPanorama1back != lastPanorama1 || ignoreLast) {
            lastPanorama1back = lastPanorama1;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastPanorama1];
            if (switchLocalSoundState) [at1 midiEvent :0xB1 :controllerByte :lastPanorama1];
        }
    }
    if (channelNumber == 2) {
        if (lastPanorama2back != lastPanorama2 || ignoreLast) {
            lastPanorama2back = lastPanorama2;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastPanorama2];
            if (switchLocalSoundState) [at2 midiEvent :0xB2 :controllerByte :lastPanorama2];
        }
    }
    if (channelNumber == 3) {
        if (lastPanorama3back != lastPanorama3 || ignoreLast) {
            lastPanorama3back = lastPanorama3;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastPanorama3];
            if (switchLocalSoundState) [at3 midiEvent :0xB3 :controllerByte :lastPanorama3];
        }
    }
    if (channelNumber == 4) {
        if (lastPanorama4back != lastPanorama4 || ignoreLast) {
            lastPanorama4back = lastPanorama4;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastPanorama4];
            if (switchLocalSoundState) [at4 midiEvent :0xB4 :controllerByte :lastPanorama4];
        }
    }
    if (channelNumber == 5) {
        if (lastPanorama5back != lastPanorama5 || ignoreLast) {
            lastPanorama5back = lastPanorama5;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastPanorama5];
            if (switchLocalSoundState) [at5 midiEvent :0xB5 :controllerByte :lastPanorama5];
        }
    }
    if (channelNumber == 6) {
        if (lastPanorama6back != lastPanorama6 || ignoreLast) {
            lastPanorama6back = lastPanorama6;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastPanorama6];
            if (switchLocalSoundState) [at6 midiEvent :0xB6 :controllerByte :lastPanorama6];
        }
    }
    if (channelNumber == 7) {
        if (lastPanorama7back != lastPanorama7 || ignoreLast) {
            lastPanorama7back = lastPanorama7;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastPanorama7];
            if (switchLocalSoundState) [at7 midiEvent :0xB7 :controllerByte :lastPanorama7];
        }
    }
    if (channelNumber == 8) {
        if (lastPanorama8back != lastPanorama8 || ignoreLast) {
            lastPanorama8back = lastPanorama8;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastPanorama8];
            if (switchLocalSoundState) [at8 midiEvent :0xB8 :controllerByte :lastPanorama8];
        }
    }
    if (channelNumber == 9) {
        if (lastPanorama9back != lastPanorama9 || ignoreLast) {
            lastPanorama9back = lastPanorama9;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastPanorama9];
            if (switchLocalSoundState) [at9 midiEvent :0xB9 :controllerByte :lastPanorama9];
        }
    }
    if (channelNumber == 10) {
        if (lastPanorama10back != lastPanorama10 || ignoreLast) {
            lastPanorama10back = lastPanorama10;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastPanorama10];
            if (switchLocalSoundState) [at10 midiEvent :0xBA :controllerByte :lastPanorama10];
        }
    }
    if (channelNumber == 11) {
        if (lastPanorama11back != lastPanorama11 || ignoreLast) {
            lastPanorama11back = lastPanorama11;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastPanorama11];
            if (switchLocalSoundState) [at11 midiEvent :0xBB :controllerByte :lastPanorama11];
        }
    }
    if (channelNumber == 12) {
        if (lastPanorama12back != lastPanorama12 || ignoreLast) {
            lastPanorama12back = lastPanorama12;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastPanorama12];
            if (switchLocalSoundState) [at12 midiEvent :0xBC :controllerByte :lastPanorama12];
        }
    }
    if (channelNumber == 13) {
        if (lastPanorama13back != lastPanorama13 || ignoreLast) {
            lastPanorama13back = lastPanorama13;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastPanorama13];
            if (switchLocalSoundState) [at13 midiEvent :0xBD :controllerByte :lastPanorama13];
        }
    }
    if (channelNumber == 14) {
        if (lastPanorama14back != lastPanorama14 || ignoreLast) {
            lastPanorama14back = lastPanorama14;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastPanorama14];
            if (switchLocalSoundState) [at14 midiEvent :0xBE :controllerByte :lastPanorama14];
        }
    }
    if (channelNumber == 15) {
        if (lastPanorama15back != lastPanorama15 || ignoreLast) {
            lastPanorama15back = lastPanorama15;
            [self putThreeByteInBuffer :0xB0 + channelNumber :controllerByte :lastPanorama15];
            if (switchLocalSoundState) [at15 midiEvent :0xBF :controllerByte :lastPanorama15];
        }
    }
    
}

- (void) saveLastSelectedMIDIfile {
    
    if (![lastSelectedMIDIfile isEqual:midiFilename]) {
        
        playBackTempo = 1.0;
        sliderTempo.value = playBackTempo;
        labelTempo.text = [NSString stringWithFormat:@"Tempo: %.2f", playBackTempo];
        
        transposeValue = 0;
        labelTranspose1.text = [NSString stringWithFormat:@"Transpose %d", transposeValue];
        
        if (track0state == 1) track0state = 0; // muted
        if (track1state == 1) track1state = 0;
        if (track2state == 1) track2state = 0;
        if (track3state == 1) track3state = 0;
        if (track4state == 1) track4state = 0;
        if (track5state == 1) track5state = 0;
        if (track6state == 1) track6state = 0;
        if (track7state == 1) track7state = 0;
        if (track8state == 1) track8state = 0;
        if (track9state == 1) track9state = 0;
        if (track10state == 1) track10state = 0;
        if (track11state == 1) track11state = 0;
        if (track12state == 1) track12state = 0;
        if (track13state == 1) track13state = 0;
        if (track14state == 1) track14state = 0;
        if (track15state == 1) track15state = 0;
        
        [self setTrack0state];
        [self setTrack1state];
        [self setTrack2state];
        [self setTrack3state];
        [self setTrack4state];
        [self setTrack5state];
        [self setTrack6state];
        [self setTrack7state];
        [self setTrack8state];
        [self setTrack9state];
        [self setTrack10state];
        [self setTrack11state];
        [self setTrack12state];
        [self setTrack13state];
        [self setTrack14state];
        [self setTrack15state];
        
    }
    
    userPreferences = [NSUserDefaults standardUserDefaults];
    lastSelectedMIDIfile = midiFilename;
    [userPreferences setValue:lastSelectedMIDIfile forKey:@"lastSelectedMIDIfile"];
    [userPreferences synchronize];
}

- (void) loadPreferences {
    userPreferences = [NSUserDefaults standardUserDefaults];
    posOutput = (int)[userPreferences integerForKey:@"posOutput"];
    posInput = (int)[userPreferences integerForKey:@"posInput"];
    posWasSaved = [userPreferences boolForKey:@"posWasSaved"];
    if ([userPreferences boolForKey:@"dataSaved"] == TRUE){
        iPadQuestionAnswered = [userPreferences boolForKey:@"iPadQuestionAnswered"];
        iPadA6 = [userPreferences boolForKey:@"iPadA6"];
        dataSaved = TRUE;
        switchMIDIthruState = [userPreferences boolForKey:@"switchMIDIthruState"];
        switchMIDIthru.on = switchMIDIthruState;
        switchLocalSoundState = [userPreferences boolForKey:@"switchLocalSoundState"];
        switchLocSnd.on = switchLocalSoundState;
        switchFilterSYSEXstate = [userPreferences boolForKey:@"switchFilterSYSEXstate"];
        switchFilterSYSEX.on = switchFilterSYSEXstate;
        switchShowSYSEXstate = [userPreferences boolForKey:@"switchShowSYSEXstate"];
        switchShowSYSEX.on = switchShowSYSEXstate;
        backgroundPlayAllowed = [userPreferences boolForKey:@"backgroundPlayAllowed"];
        switchBackgroundPlay.on = backgroundPlayAllowed;
        autoNext = [userPreferences boolForKey:@"autoNext"];
        switchAutoNext.on = autoNext;
        drumSet0 = [userPreferences boolForKey:@"drumSet0"];
        switchDrumSet0.on = drumSet0;
        
        channelForShowChord = [userPreferences integerForKey:@"channelForShowChord"];
        [self setTextFieldChord];
        track0state = [userPreferences integerForKey:@"track0state"];
        track1state = [userPreferences integerForKey:@"track1state"];
        track2state = [userPreferences integerForKey:@"track2state"];
        track3state = [userPreferences integerForKey:@"track3state"];
        track4state = [userPreferences integerForKey:@"track4state"];
        track5state = [userPreferences integerForKey:@"track5state"];
        track6state = [userPreferences integerForKey:@"track6state"];
        track7state = [userPreferences integerForKey:@"track7state"];
        track8state = [userPreferences integerForKey:@"track8state"];
        track9state = [userPreferences integerForKey:@"track9state"];
        track10state = [userPreferences integerForKey:@"track10state"];
        track11state = [userPreferences integerForKey:@"track11state"];
        track12state = [userPreferences integerForKey:@"track12state"];
        track13state = [userPreferences integerForKey:@"track13state"];
        track14state = [userPreferences integerForKey:@"track14state"];
        track15state = [userPreferences integerForKey:@"track15state"];
        lastSelectedMIDIfile = [userPreferences stringForKey:@"lastSelectedMIDIfile"];
        sendStartContinueStop = [userPreferences boolForKey:@"sendStartContinueStop"];
        receiveStartContinueStop = [userPreferences boolForKey:@"receiveStartContinueStop"];
    }
    [userPreferences synchronize];
}

- (void) savePreferences {
    userPreferences = [NSUserDefaults standardUserDefaults];
    [userPreferences setBool:switchMIDIthruState forKey:@"switchMIDIthruState"];
    [userPreferences setBool:switchLocalSoundState forKey:@"switchLocalSoundState"];
    [userPreferences setBool:switchFilterSYSEXstate forKey:@"switchFilterSYSEXstate"];
    [userPreferences setBool:switchShowSYSEXstate forKey:@"switchShowSYSEXstate"];
    [userPreferences setBool:backgroundPlayAllowed forKey:@"backgroundPlayAllowed"];
    [userPreferences setInteger:channelForShowChord forKey:@"channelForShowChord"];
    [userPreferences setInteger:autoNext forKey:@"autoNext"];
    [userPreferences setInteger:drumSet0 forKey:@"drumSet0"];
    [userPreferences setInteger:track0state forKey:@"track0state"];
    [userPreferences setInteger:track1state forKey:@"track1state"];
    [userPreferences setInteger:track2state forKey:@"track2state"];
    [userPreferences setInteger:track3state forKey:@"track3state"];
    [userPreferences setInteger:track4state forKey:@"track4state"];
    [userPreferences setInteger:track5state forKey:@"track5state"];
    [userPreferences setInteger:track6state forKey:@"track6state"];
    [userPreferences setInteger:track7state forKey:@"track7state"];
    [userPreferences setInteger:track8state forKey:@"track8state"];
    [userPreferences setInteger:track9state forKey:@"track9state"];
    [userPreferences setInteger:track10state forKey:@"track10state"];
    [userPreferences setInteger:track11state forKey:@"track11state"];
    [userPreferences setInteger:track12state forKey:@"track12state"];
    [userPreferences setInteger:track13state forKey:@"track13state"];
    [userPreferences setInteger:track14state forKey:@"track14state"];
    [userPreferences setInteger:track15state forKey:@"track15state"];
    [userPreferences setValue:lastSelectedMIDIfile forKey:@"lastSelectedMIDIfile"];
    [userPreferences setBool:sendStartContinueStop forKey:@"sendStartContinueStop"];
    [userPreferences setBool:receiveStartContinueStop forKey:@"receiveStartContinueStop"];
    [userPreferences setBool:TRUE forKey:@"dataSaved"];
    [userPreferences synchronize];
}

- (void) saveDefaults {
    userPreferences = [NSUserDefaults standardUserDefaults];
    
    [userPreferences setInteger:defaultInstru forKey:@"slider2.value00"];
    [userPreferences setInteger:defaultVolume forKey:@"slider4.value00"];
    [userPreferences setInteger:defaultReverb forKey:@"slider6.value00"];
    [userPreferences setInteger:defaultChorus forKey:@"slider7.value00"];
    [userPreferences setInteger:defaultPanora forKey:@"slider8.value00"];
    
    [userPreferences setInteger:defaultInstru forKey:@"slider2.value01"];
    [userPreferences setInteger:defaultVolume forKey:@"slider4.value01"];
    [userPreferences setInteger:defaultReverb forKey:@"slider6.value01"];
    [userPreferences setInteger:defaultChorus forKey:@"slider7.value01"];
    [userPreferences setInteger:defaultPanora forKey:@"slider8.value01"];
    
    [userPreferences setInteger:defaultInstru forKey:@"slider2.value02"];
    [userPreferences setInteger:defaultVolume forKey:@"slider4.value02"];
    [userPreferences setInteger:defaultReverb forKey:@"slider6.value02"];
    [userPreferences setInteger:defaultChorus forKey:@"slider7.value02"];
    [userPreferences setInteger:defaultPanora forKey:@"slider8.value02"];
    
    [userPreferences setInteger:defaultInstru forKey:@"slider2.value03"];
    [userPreferences setInteger:defaultVolume forKey:@"slider4.value03"];
    [userPreferences setInteger:defaultReverb forKey:@"slider6.value03"];
    [userPreferences setInteger:defaultChorus forKey:@"slider7.value03"];
    [userPreferences setInteger:defaultPanora forKey:@"slider8.value03"];
    
    [userPreferences setInteger:defaultInstru forKey:@"slider2.value04"];
    [userPreferences setInteger:defaultVolume forKey:@"slider4.value04"];
    [userPreferences setInteger:defaultReverb forKey:@"slider6.value04"];
    [userPreferences setInteger:defaultChorus forKey:@"slider7.value04"];
    [userPreferences setInteger:defaultPanora forKey:@"slider8.value04"];
    
    [userPreferences setInteger:defaultInstru forKey:@"slider2.value05"];
    [userPreferences setInteger:defaultVolume forKey:@"slider4.value05"];
    [userPreferences setInteger:defaultReverb forKey:@"slider6.value05"];
    [userPreferences setInteger:defaultChorus forKey:@"slider7.value05"];
    [userPreferences setInteger:defaultPanora forKey:@"slider8.value05"];
    
    [userPreferences setInteger:defaultInstru forKey:@"slider2.value06"];
    [userPreferences setInteger:defaultVolume forKey:@"slider4.value06"];
    [userPreferences setInteger:defaultReverb forKey:@"slider6.value06"];
    [userPreferences setInteger:defaultChorus forKey:@"slider7.value06"];
    [userPreferences setInteger:defaultPanora forKey:@"slider8.value06"];
    
    [userPreferences setInteger:defaultInstru forKey:@"slider2.value07"];
    [userPreferences setInteger:defaultVolume forKey:@"slider4.value07"];
    [userPreferences setInteger:defaultReverb forKey:@"slider6.value07"];
    [userPreferences setInteger:defaultChorus forKey:@"slider7.value07"];
    [userPreferences setInteger:defaultPanora forKey:@"slider8.value07"];
    
    [userPreferences setInteger:defaultInstru forKey:@"slider2.value08"];
    [userPreferences setInteger:defaultVolume forKey:@"slider4.value08"];
    [userPreferences setInteger:defaultReverb forKey:@"slider6.value08"];
    [userPreferences setInteger:defaultChorus forKey:@"slider7.value08"];
    [userPreferences setInteger:defaultPanora forKey:@"slider8.value08"];
    
    [userPreferences setInteger:defaultInstru forKey:@"slider2.value09"];
    [userPreferences setInteger:defaultVolume forKey:@"slider4.value09"];
    [userPreferences setInteger:defaultReverb forKey:@"slider6.value09"];
    [userPreferences setInteger:defaultChorus forKey:@"slider7.value09"];
    [userPreferences setInteger:defaultPanora forKey:@"slider8.value09"];
    
    [userPreferences setInteger:defaultInstru forKey:@"slider2.value10"];
    [userPreferences setInteger:defaultVolume forKey:@"slider4.value10"];
    [userPreferences setInteger:defaultReverb forKey:@"slider6.value10"];
    [userPreferences setInteger:defaultChorus forKey:@"slider7.value10"];
    [userPreferences setInteger:defaultPanora forKey:@"slider8.value10"];
    
    [userPreferences setInteger:defaultInstru forKey:@"slider2.value11"];
    [userPreferences setInteger:defaultVolume forKey:@"slider4.value11"];
    [userPreferences setInteger:defaultReverb forKey:@"slider6.value11"];
    [userPreferences setInteger:defaultChorus forKey:@"slider7.value11"];
    [userPreferences setInteger:defaultPanora forKey:@"slider8.value11"];
    
    [userPreferences setInteger:defaultInstru forKey:@"slider2.value12"];
    [userPreferences setInteger:defaultVolume forKey:@"slider4.value12"];
    [userPreferences setInteger:defaultReverb forKey:@"slider6.value12"];
    [userPreferences setInteger:defaultChorus forKey:@"slider7.value12"];
    [userPreferences setInteger:defaultPanora forKey:@"slider8.value12"];
    
    [userPreferences setInteger:defaultInstru forKey:@"slider2.value13"];
    [userPreferences setInteger:defaultVolume forKey:@"slider4.value13"];
    [userPreferences setInteger:defaultReverb forKey:@"slider6.value13"];
    [userPreferences setInteger:defaultChorus forKey:@"slider7.value13"];
    [userPreferences setInteger:defaultPanora forKey:@"slider8.value13"];
    
    [userPreferences setInteger:defaultInstru forKey:@"slider2.value14"];
    [userPreferences setInteger:defaultVolume forKey:@"slider4.value14"];
    [userPreferences setInteger:defaultReverb forKey:@"slider6.value14"];
    [userPreferences setInteger:defaultChorus forKey:@"slider7.value14"];
    [userPreferences setInteger:defaultPanora forKey:@"slider8.value14"];
    
    [userPreferences setInteger:defaultInstru forKey:@"slider2.value15"];
    [userPreferences setInteger:defaultVolume forKey:@"slider4.value15"];
    [userPreferences setInteger:defaultReverb forKey:@"slider6.value15"];
    [userPreferences setInteger:defaultChorus forKey:@"slider7.value15"];
    [userPreferences setInteger:defaultPanora forKey:@"slider8.value15"];
    
    [userPreferences setInteger:0 forKey:@"track0state"];
    [userPreferences setInteger:0 forKey:@"track1state"];
    [userPreferences setInteger:0 forKey:@"track2state"];
    [userPreferences setInteger:0 forKey:@"track3state"];
    [userPreferences setInteger:0 forKey:@"track4state"];
    [userPreferences setInteger:0 forKey:@"track5state"];
    [userPreferences setInteger:0 forKey:@"track6state"];
    [userPreferences setInteger:0 forKey:@"track7state"];
    [userPreferences setInteger:0 forKey:@"track8state"];
    [userPreferences setInteger:0 forKey:@"track9state"];
    [userPreferences setInteger:0 forKey:@"track10state"];
    [userPreferences setInteger:0 forKey:@"track11state"];
    [userPreferences setInteger:0 forKey:@"track12state"];
    [userPreferences setInteger:0 forKey:@"track13state"];
    [userPreferences setInteger:0 forKey:@"track14state"];
    [userPreferences setInteger:0 forKey:@"track15state"];
    
    [userPreferences synchronize];
}

- (void) loadPreferencesChannel0 {
    userPreferences = [NSUserDefaults standardUserDefaults];
    if (track0state == 2) {
        lastInstr0 = [userPreferences integerForKey:@"slider2.value00"];
        lastVolume0 = [userPreferences integerForKey:@"slider4.value00"];
        lastReverb0 = [userPreferences integerForKey:@"slider6.value00"];
        lastChorus0 = [userPreferences integerForKey:@"slider7.value00"];
        lastPanorama0 = [userPreferences integerForKey:@"slider8.value00"];
    }
    [userPreferences synchronize];
}
- (void) loadPreferencesChannel1 {
    userPreferences = [NSUserDefaults standardUserDefaults];
    if (track1state == 2) {
        lastInstr1 = [userPreferences integerForKey:@"slider2.value01"];
        lastVolume1 = [userPreferences integerForKey:@"slider4.value01"];
        lastReverb1 = [userPreferences integerForKey:@"slider6.value01"];
        lastChorus1 = [userPreferences integerForKey:@"slider7.value01"];
        lastPanorama1 = [userPreferences integerForKey:@"slider8.value01"];
    }
    [userPreferences synchronize];
}
- (void) loadPreferencesChannel2 {
    userPreferences = [NSUserDefaults standardUserDefaults];
    if (track2state == 2) {
        lastInstr2 = [userPreferences integerForKey:@"slider2.value02"];
        lastVolume2 = [userPreferences integerForKey:@"slider4.value02"];
        lastReverb2 = [userPreferences integerForKey:@"slider6.value02"];
        lastChorus2 = [userPreferences integerForKey:@"slider7.value02"];
        lastPanorama2 = [userPreferences integerForKey:@"slider8.value02"];
    }
    [userPreferences synchronize];
}
- (void) loadPreferencesChannel3 {
    userPreferences = [NSUserDefaults standardUserDefaults];
    if (track3state == 2) {
        lastInstr3 = [userPreferences integerForKey:@"slider2.value03"];
        lastVolume3 = [userPreferences integerForKey:@"slider4.value03"];
        lastReverb3 = [userPreferences integerForKey:@"slider6.value03"];
        lastChorus3 = [userPreferences integerForKey:@"slider7.value03"];
        lastPanorama3 = [userPreferences integerForKey:@"slider8.value03"];
    }
    [userPreferences synchronize];
}
- (void) loadPreferencesChannel4 {
    userPreferences = [NSUserDefaults standardUserDefaults];
    if (track4state == 2) {
        lastInstr4 = [userPreferences integerForKey:@"slider2.value04"];
        lastVolume4 = [userPreferences integerForKey:@"slider4.value04"];
        lastReverb4 = [userPreferences integerForKey:@"slider6.value04"];
        lastChorus4 = [userPreferences integerForKey:@"slider7.value04"];
        lastPanorama4 = [userPreferences integerForKey:@"slider8.value04"];
    }
    [userPreferences synchronize];
}
- (void) loadPreferencesChannel5 {
    userPreferences = [NSUserDefaults standardUserDefaults];
    if (track5state == 2) {
        lastInstr5 = [userPreferences integerForKey:@"slider2.value05"];
        lastVolume5 = [userPreferences integerForKey:@"slider4.value05"];
        lastReverb5 = [userPreferences integerForKey:@"slider6.value05"];
        lastChorus5 = [userPreferences integerForKey:@"slider7.value05"];
        lastPanorama5 = [userPreferences integerForKey:@"slider8.value05"];
    }
    [userPreferences synchronize];
}
- (void) loadPreferencesChannel6 {
    userPreferences = [NSUserDefaults standardUserDefaults];
    if (track6state == 2) {
        lastInstr6 = [userPreferences integerForKey:@"slider2.value06"];
        lastVolume6 = [userPreferences integerForKey:@"slider4.value06"];
        lastReverb6 = [userPreferences integerForKey:@"slider6.value06"];
        lastChorus6 = [userPreferences integerForKey:@"slider7.value06"];
        lastPanorama6 = [userPreferences integerForKey:@"slider8.value06"];
    }
    [userPreferences synchronize];
}
- (void) loadPreferencesChannel7 {
    userPreferences = [NSUserDefaults standardUserDefaults];
    if (track7state == 2) {
        lastInstr7 = [userPreferences integerForKey:@"slider2.value07"];
        lastVolume7 = [userPreferences integerForKey:@"slider4.value07"];
        lastReverb7 = [userPreferences integerForKey:@"slider6.value07"];
        lastChorus7 = [userPreferences integerForKey:@"slider7.value07"];
        lastPanorama7 = [userPreferences integerForKey:@"slider8.value07"];
    }
    [userPreferences synchronize];
}
- (void) loadPreferencesChannel8 {
    userPreferences = [NSUserDefaults standardUserDefaults];
    if (track8state == 2) {
        lastInstr8 = [userPreferences integerForKey:@"slider2.value08"];
        lastVolume8 = [userPreferences integerForKey:@"slider4.value08"];
        lastReverb8 = [userPreferences integerForKey:@"slider6.value08"];
        lastChorus8 = [userPreferences integerForKey:@"slider7.value08"];
        lastPanorama8 = [userPreferences integerForKey:@"slider8.value08"];
    }
    [userPreferences synchronize];
}
- (void) loadPreferencesChannel9 {
    userPreferences = [NSUserDefaults standardUserDefaults];
    if (track9state == 2) {
        lastInstr9 = [userPreferences integerForKey:@"slider2.value09"];
        lastVolume9 = [userPreferences integerForKey:@"slider4.value09"];
        lastReverb9 = [userPreferences integerForKey:@"slider6.value09"];
        lastChorus9 = [userPreferences integerForKey:@"slider7.value09"];
        lastPanorama9 = [userPreferences integerForKey:@"slider8.value09"];
    }
    [userPreferences synchronize];
}
- (void) loadPreferencesChannel10 {
    userPreferences = [NSUserDefaults standardUserDefaults];
    if (track10state == 2) {
        lastInstr10 = [userPreferences integerForKey:@"slider2.value10"];
        lastVolume10 = [userPreferences integerForKey:@"slider4.value10"];
        lastReverb10 = [userPreferences integerForKey:@"slider6.value10"];
        lastChorus10 = [userPreferences integerForKey:@"slider7.value10"];
        lastPanorama10 = [userPreferences integerForKey:@"slider8.value10"];
    }
    [userPreferences synchronize];
}
- (void) loadPreferencesChannel11 {
    userPreferences = [NSUserDefaults standardUserDefaults];
    if (track11state == 2) {
        lastInstr11 = [userPreferences integerForKey:@"slider2.value11"];
        lastVolume11 = [userPreferences integerForKey:@"slider4.value11"];
        lastReverb11 = [userPreferences integerForKey:@"slider6.value11"];
        lastChorus11 = [userPreferences integerForKey:@"slider7.value11"];
        lastPanorama11 = [userPreferences integerForKey:@"slider8.value11"];
    }
    [userPreferences synchronize];
}
- (void) loadPreferencesChannel12 {
    userPreferences = [NSUserDefaults standardUserDefaults];
    if (track12state == 2) {
        lastInstr12 = [userPreferences integerForKey:@"slider2.value12"];
        lastVolume12 = [userPreferences integerForKey:@"slider4.value12"];
        lastReverb12 = [userPreferences integerForKey:@"slider6.value12"];
        lastChorus12 = [userPreferences integerForKey:@"slider7.value12"];
        lastPanorama12 = [userPreferences integerForKey:@"slider8.value12"];
    }
    [userPreferences synchronize];
}
- (void) loadPreferencesChannel13 {
    userPreferences = [NSUserDefaults standardUserDefaults];
    if (track13state == 2) {
        lastInstr13 = [userPreferences integerForKey:@"slider2.value13"];
        lastVolume13 = [userPreferences integerForKey:@"slider4.value13"];
        lastReverb13 = [userPreferences integerForKey:@"slider6.value13"];
        lastChorus13 = [userPreferences integerForKey:@"slider7.value13"];
        lastPanorama13 = [userPreferences integerForKey:@"slider8.value13"];
    }
    [userPreferences synchronize];
}
- (void) loadPreferencesChannel14 {
    userPreferences = [NSUserDefaults standardUserDefaults];
    if (track14state == 2) {
        lastInstr14 = [userPreferences integerForKey:@"slider2.value14"];
        lastVolume14 = [userPreferences integerForKey:@"slider4.value14"];
        lastReverb14 = [userPreferences integerForKey:@"slider6.value14"];
        lastChorus14 = [userPreferences integerForKey:@"slider7.value14"];
        lastPanorama14 = [userPreferences integerForKey:@"slider8.value14"];
    }
    [userPreferences synchronize];
}
- (void) loadPreferencesChannel15 {
    userPreferences = [NSUserDefaults standardUserDefaults];
    if (track15state == 2) {
        lastInstr15 = [userPreferences integerForKey:@"slider2.value15"];
        lastVolume15 = [userPreferences integerForKey:@"slider4.value15"];
        lastReverb15 = [userPreferences integerForKey:@"slider6.value15"];
        lastChorus15 = [userPreferences integerForKey:@"slider7.value15"];
        lastPanorama15 = [userPreferences integerForKey:@"slider8.value15"];
    }
    [userPreferences synchronize];
}

- (void) resetLastControllers {
    if (track0state != 2) {
        lastInstr0 = defaultInstru;
        lastVolume0 = defaultVolume;
        lastReverb0 = defaultReverb;
        lastChorus0 = defaultChorus;
        lastPanorama0 = defaultPanora;
    }
    if (track1state != 2) {
        lastInstr1 = defaultInstru;
        lastVolume1 = defaultVolume;
        lastReverb1 = defaultReverb;
        lastChorus1 = defaultChorus;
        lastPanorama1 = defaultPanora;
    }
    if (track2state != 2) {
        lastInstr2 = defaultInstru;
        lastVolume2 = defaultVolume;
        lastReverb2 = defaultReverb;
        lastChorus2 = defaultChorus;
        lastPanorama2 = defaultPanora;
    }
    if (track3state != 2) {
        lastInstr3 = defaultInstru;
        lastVolume3 = defaultVolume;
        lastReverb3 = defaultReverb;
        lastChorus3 = defaultChorus;
        lastPanorama3 = defaultPanora;
    }
    if (track4state != 2) {
        lastInstr4 = defaultInstru;
        lastVolume4 = defaultVolume;
        lastReverb4 = defaultReverb;
        lastChorus4 = defaultChorus;
        lastPanorama4 = defaultPanora;
    }
    if (track5state != 2) {
        lastInstr5 = defaultInstru;
        lastVolume5 = defaultVolume;
        lastReverb5 = defaultReverb;
        lastChorus5 = defaultChorus;
        lastPanorama5 = defaultPanora;
    }
    if (track6state != 2) {
        lastInstr6 = defaultInstru;
        lastVolume6 = defaultVolume;
        lastReverb6 = defaultReverb;
        lastChorus6 = defaultChorus;
        lastPanorama6 = defaultPanora;
    }
    if (track7state != 2) {
        lastInstr7 = defaultInstru;
        lastVolume7 = defaultVolume;
        lastReverb7 = defaultReverb;
        lastChorus7 = defaultChorus;
        lastPanorama7 = defaultPanora;
    }
    if (track8state != 2) {
        lastInstr8 = defaultInstru;
        lastVolume8 = defaultVolume;
        lastReverb8 = defaultReverb;
        lastChorus8 = defaultChorus;
        lastPanorama8 = defaultPanora;
    }
    if (track9state != 2) {
        lastInstr9 = defaultInstru;
        lastVolume9 = defaultVolume;
        lastReverb9 = defaultReverb;
        lastChorus9 = defaultChorus;
        lastPanorama9 = defaultPanora;
    }
    if (track10state != 2) {
        lastInstr10 = defaultInstru;
        lastVolume10 = defaultVolume;
        lastReverb10 = defaultReverb;
        lastChorus10 = defaultChorus;
        lastPanorama10 = defaultPanora;
    }
    if (track11state != 2) {
        lastInstr11 = defaultInstru;
        lastVolume11 = defaultVolume;
        lastReverb11 = defaultReverb;
        lastChorus11 = defaultChorus;
        lastPanorama11 = defaultPanora;
    }
    if (track12state != 2) {
        lastInstr12 = defaultInstru;
        lastVolume12 = defaultVolume;
        lastReverb12 = defaultReverb;
        lastChorus12 = defaultChorus;
        lastPanorama12 = defaultPanora;
    }
    if (track13state != 2) {
        lastInstr13 = defaultInstru;
        lastVolume13 = defaultVolume;
        lastReverb13 = defaultReverb;
        lastChorus13 = defaultChorus;
        lastPanorama13 = defaultPanora;
    }
    if (track14state != 2) {
        lastInstr14 = defaultInstru;
        lastVolume14 = defaultVolume;
        lastReverb14 = defaultReverb;
        lastChorus14 = defaultChorus;
        lastPanorama14 = defaultPanora;
    }
    if (track15state != 2) {
        lastInstr15 = defaultInstru;
        lastVolume15 = defaultVolume;
        lastReverb15 = defaultReverb;
        lastChorus15 = defaultChorus;
        lastPanorama15 = defaultPanora;
    }
    
}

-(void) setTrack0state {
    if (track0state == 1) {
        [buttonTrack0 setTitle :[NSString stringWithFormat:@"%@", @"0m"] forState:UIControlStateNormal];
        [buttonTrack0 setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        lastTrackTemp = 0;
        timerforAllNotesOffChannel =[NSTimer scheduledTimerWithTimeInterval:0.2
                                                                     target:self selector:@selector(timerAllNotesOffMethodChannel)userInfo:nil repeats:NO];
    }
    else if (track0state == 2) {
        [buttonTrack0 setTitle :[NSString stringWithFormat:@"%@", @"0r"] forState:UIControlStateNormal];
        [buttonTrack0 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        if (!isRecording && !midiFilePlaying && isPause) [self initialMIDIsettings :0];
    }
    else {
        [buttonTrack0 setTitle :[NSString stringWithFormat:@"%@", @"0"] forState:UIControlStateNormal];
        [buttonTrack0 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

-(void) setTrack1state {
    if (track1state == 1) {
        [buttonTrack1 setTitle :[NSString stringWithFormat:@"%@", @"1m"] forState:UIControlStateNormal];
        [buttonTrack1 setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        lastTrackTemp = 1;
        timerforAllNotesOffChannel =[NSTimer scheduledTimerWithTimeInterval:0.2
                                                                     target:self selector:@selector(timerAllNotesOffMethodChannel)userInfo:nil repeats:NO];
    }
    else if (track1state == 2) {
        [buttonTrack1 setTitle :[NSString stringWithFormat:@"%@", @"1r"] forState:UIControlStateNormal];
        [buttonTrack1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        if (!isRecording && !midiFilePlaying && isPause) [self initialMIDIsettings :1];
    }
    else {
        [buttonTrack1 setTitle :[NSString stringWithFormat:@"%@", @"1"] forState:UIControlStateNormal];
        [buttonTrack1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

-(void) setTrack2state {
    if (track2state == 1) {
        [buttonTrack2 setTitle :[NSString stringWithFormat:@"%@", @"2m"] forState:UIControlStateNormal];
        [buttonTrack2 setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        lastTrackTemp = 2;
        timerforAllNotesOffChannel =[NSTimer scheduledTimerWithTimeInterval:0.2
                                                                     target:self selector:@selector(timerAllNotesOffMethodChannel)userInfo:nil repeats:NO];
    }
    else if (track2state == 2) {
        [buttonTrack2 setTitle :[NSString stringWithFormat:@"%@", @"2r"] forState:UIControlStateNormal];
        [buttonTrack2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        if (!isRecording && !midiFilePlaying && isPause) [self initialMIDIsettings :2];
    }
    else {
        [buttonTrack2 setTitle :[NSString stringWithFormat:@"%@", @"2"] forState:UIControlStateNormal];
        [buttonTrack2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

-(void) setTrack3state {
    if (track3state == 1) {
        [buttonTrack3 setTitle :[NSString stringWithFormat:@"%@", @"3m"] forState:UIControlStateNormal];
        [buttonTrack3 setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        lastTrackTemp = 3;
        timerforAllNotesOffChannel =[NSTimer scheduledTimerWithTimeInterval:0.2
                                                                     target:self selector:@selector(timerAllNotesOffMethodChannel)userInfo:nil repeats:NO];
    }
    else if (track3state == 2) {
        [buttonTrack3 setTitle :[NSString stringWithFormat:@"%@", @"3r"] forState:UIControlStateNormal];
        [buttonTrack3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        if (!isRecording && !midiFilePlaying && isPause) [self initialMIDIsettings :3];
    }
    else {
        [buttonTrack3 setTitle :[NSString stringWithFormat:@"%@", @"3"] forState:UIControlStateNormal];
        [buttonTrack3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

-(void) setTrack4state {
    if (track4state == 1) {
        [buttonTrack4 setTitle :[NSString stringWithFormat:@"%@", @"4m"] forState:UIControlStateNormal];
        [buttonTrack4 setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        lastTrackTemp = 4;
        timerforAllNotesOffChannel =[NSTimer scheduledTimerWithTimeInterval:0.2
                                                                     target:self selector:@selector(timerAllNotesOffMethodChannel)userInfo:nil repeats:NO];
    }
    else if (track4state == 2) {
        [buttonTrack4 setTitle :[NSString stringWithFormat:@"%@", @"4r"] forState:UIControlStateNormal];
        [buttonTrack4 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        if (!isRecording && !midiFilePlaying && isPause) [self initialMIDIsettings :4];
    }
    else {
        [buttonTrack4 setTitle :[NSString stringWithFormat:@"%@", @"4"] forState:UIControlStateNormal];
        [buttonTrack4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

-(void) setTrack5state {
    if (track5state == 1) {
        [buttonTrack5 setTitle :[NSString stringWithFormat:@"%@", @"5m"] forState:UIControlStateNormal];
        [buttonTrack5 setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        lastTrackTemp = 5;
        timerforAllNotesOffChannel =[NSTimer scheduledTimerWithTimeInterval:0.2
                                                                     target:self selector:@selector(timerAllNotesOffMethodChannel)userInfo:nil repeats:NO];
    }
    else if (track5state == 2) {
        [buttonTrack5 setTitle :[NSString stringWithFormat:@"%@", @"5r"] forState:UIControlStateNormal];
        [buttonTrack5 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        if (!isRecording && !midiFilePlaying && isPause) [self initialMIDIsettings :5];
    }
    else {
        [buttonTrack5 setTitle :[NSString stringWithFormat:@"%@", @"5"] forState:UIControlStateNormal];
        [buttonTrack5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

-(void) setTrack6state {
    if (track6state == 1) {
        [buttonTrack6 setTitle :[NSString stringWithFormat:@"%@", @"6m"] forState:UIControlStateNormal];
        [buttonTrack6 setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        lastTrackTemp = 6;
        timerforAllNotesOffChannel =[NSTimer scheduledTimerWithTimeInterval:0.2
                                                                     target:self selector:@selector(timerAllNotesOffMethodChannel)userInfo:nil repeats:NO];
    }
    else if (track6state == 2) {
        [buttonTrack6 setTitle :[NSString stringWithFormat:@"%@", @"6r"] forState:UIControlStateNormal];
        [buttonTrack6 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        if (!isRecording && !midiFilePlaying && isPause) [self initialMIDIsettings :6];
    }
    else {
        [buttonTrack6 setTitle :[NSString stringWithFormat:@"%@", @"6"] forState:UIControlStateNormal];
        [buttonTrack6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

-(void) setTrack7state {
    if (track7state == 1) {
        [buttonTrack7 setTitle :[NSString stringWithFormat:@"%@", @"7m"] forState:UIControlStateNormal];
        [buttonTrack7 setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        lastTrackTemp = 7;
        timerforAllNotesOffChannel =[NSTimer scheduledTimerWithTimeInterval:0.2
                                                                     target:self selector:@selector(timerAllNotesOffMethodChannel)userInfo:nil repeats:NO];
    }
    else if (track7state == 2) {
        [buttonTrack7 setTitle :[NSString stringWithFormat:@"%@", @"7r"] forState:UIControlStateNormal];
        [buttonTrack7 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        if (!isRecording && !midiFilePlaying && isPause) [self initialMIDIsettings :7];
    }
    else {
        [buttonTrack7 setTitle :[NSString stringWithFormat:@"%@", @"7"] forState:UIControlStateNormal];
        [buttonTrack7 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

-(void) setTrack8state {
    if (track8state == 1) {
        [buttonTrack8 setTitle :[NSString stringWithFormat:@"%@", @"8m"] forState:UIControlStateNormal];
        [buttonTrack8 setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        lastTrackTemp = 8;
        timerforAllNotesOffChannel =[NSTimer scheduledTimerWithTimeInterval:0.2
                                                                     target:self selector:@selector(timerAllNotesOffMethodChannel)userInfo:nil repeats:NO];
    }
    else if (track8state == 2) {
        [buttonTrack8 setTitle :[NSString stringWithFormat:@"%@", @"8r"] forState:UIControlStateNormal];
        [buttonTrack8 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        if (!isRecording && !midiFilePlaying && isPause) [self initialMIDIsettings :8];
    }
    else {
        [buttonTrack8 setTitle :[NSString stringWithFormat:@"%@", @"8"] forState:UIControlStateNormal];
        [buttonTrack8 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

-(void) setTrack9state {
    if (track9state == 1){
        [buttonTrack9 setTitle :[NSString stringWithFormat:@"%@", @"9m"] forState:UIControlStateNormal];
        [buttonTrack9 setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        lastTrackTemp = 9;
        timerforAllNotesOffChannel =[NSTimer scheduledTimerWithTimeInterval:0.2
                                                                     target:self selector:@selector(timerAllNotesOffMethodChannel)userInfo:nil repeats:NO];
    }
    else if (track9state == 2) {
        [buttonTrack9 setTitle :[NSString stringWithFormat:@"%@", @"9r"] forState:UIControlStateNormal];
        [buttonTrack9 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        if (!isRecording && !midiFilePlaying && isPause) [self initialMIDIsettings :9];
    }
    else {
        [buttonTrack9 setTitle :[NSString stringWithFormat:@"%@", @"9"] forState:UIControlStateNormal];
        [buttonTrack9 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

-(void) setTrack10state {
    if (track10state == 1) {
        [buttonTrack10 setTitle :[NSString stringWithFormat:@"%@", @"10m"] forState:UIControlStateNormal];
        [buttonTrack10 setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        lastTrackTemp = 10;
        timerforAllNotesOffChannel =[NSTimer scheduledTimerWithTimeInterval:0.2
                                                                     target:self selector:@selector(timerAllNotesOffMethodChannel)userInfo:nil repeats:NO];
    }
    else if (track10state == 2) {
        [buttonTrack10 setTitle :[NSString stringWithFormat:@"%@", @"10r"] forState:UIControlStateNormal];
        [buttonTrack10 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        if (!isRecording && !midiFilePlaying && isPause) [self initialMIDIsettings :10];
    }
    else {
        [buttonTrack10 setTitle :[NSString stringWithFormat:@"%@", @"10"] forState:UIControlStateNormal];
        [buttonTrack10 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}
-(void) setTrack11state {
    if (track11state == 1) {
        [buttonTrack11 setTitle :[NSString stringWithFormat:@"%@", @"11m"] forState:UIControlStateNormal];
        [buttonTrack11 setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        lastTrackTemp = 11;
        timerforAllNotesOffChannel =[NSTimer scheduledTimerWithTimeInterval:0.2
                                                                     target:self selector:@selector(timerAllNotesOffMethodChannel)userInfo:nil repeats:NO];
    }
    else if (track11state == 2) {
        [buttonTrack11 setTitle :[NSString stringWithFormat:@"%@", @"11r"] forState:UIControlStateNormal];
        [buttonTrack11 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        if (!isRecording && !midiFilePlaying && isPause) [self initialMIDIsettings :11];
    }
    else {
        [buttonTrack11 setTitle :[NSString stringWithFormat:@"%@", @"11"] forState:UIControlStateNormal];
        [buttonTrack11 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

-(void) setTrack12state {
    if (track12state == 1) {
        [buttonTrack12 setTitle :[NSString stringWithFormat:@"%@", @"12m"] forState:UIControlStateNormal];
        [buttonTrack12 setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        lastTrackTemp = 12;
        timerforAllNotesOffChannel =[NSTimer scheduledTimerWithTimeInterval:0.2
                                                                     target:self selector:@selector(timerAllNotesOffMethodChannel)userInfo:nil repeats:NO];
    }
    else if (track12state == 2) {
        [buttonTrack12 setTitle :[NSString stringWithFormat:@"%@", @"12r"] forState:UIControlStateNormal];
        [buttonTrack12 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        if (!isRecording && !midiFilePlaying && isPause) [self initialMIDIsettings :12];
    }
    else {
        [buttonTrack12 setTitle :[NSString stringWithFormat:@"%@", @"12"] forState:UIControlStateNormal];
        [buttonTrack12 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

-(void) setTrack13state {
    if (track13state == 1) {
        [buttonTrack13 setTitle :[NSString stringWithFormat:@"%@", @"13m"] forState:UIControlStateNormal];
        [buttonTrack13 setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        lastTrackTemp = 13;
        timerforAllNotesOffChannel =[NSTimer scheduledTimerWithTimeInterval:0.2
                                                                     target:self selector:@selector(timerAllNotesOffMethodChannel)userInfo:nil repeats:NO];
    }
    else if (track13state == 2) {
        [buttonTrack13 setTitle :[NSString stringWithFormat:@"%@", @"13r"] forState:UIControlStateNormal];
        [buttonTrack13 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        if (!isRecording && !midiFilePlaying && isPause) [self initialMIDIsettings :13];
    }
    else {
        [buttonTrack13 setTitle :[NSString stringWithFormat:@"%@", @"13"] forState:UIControlStateNormal];
        [buttonTrack13 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

-(void) setTrack14state {
    if (track14state == 1) {
        [buttonTrack14 setTitle :[NSString stringWithFormat:@"%@", @"14m"] forState:UIControlStateNormal];
        [buttonTrack14 setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        lastTrackTemp = 14;
        timerforAllNotesOffChannel =[NSTimer scheduledTimerWithTimeInterval:0.2
                                                                     target:self selector:@selector(timerAllNotesOffMethodChannel)userInfo:nil repeats:NO];
    }
    else if (track14state == 2) {
        [buttonTrack14 setTitle :[NSString stringWithFormat:@"%@", @"14r"] forState:UIControlStateNormal];
        [buttonTrack14 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        if (!isRecording && !midiFilePlaying && isPause) [self initialMIDIsettings :14];
    }
    else {
        [buttonTrack14 setTitle :[NSString stringWithFormat:@"%@", @"14"] forState:UIControlStateNormal];
        [buttonTrack14 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

-(void) setTrack15state {
    if (track15state == 1) {
        [buttonTrack15 setTitle :[NSString stringWithFormat:@"%@", @"15m"] forState:UIControlStateNormal];
        [buttonTrack15 setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        lastTrackTemp = 15;
        timerforAllNotesOffChannel =[NSTimer scheduledTimerWithTimeInterval:0.2
                                                                     target:self selector:@selector(timerAllNotesOffMethodChannel)userInfo:nil repeats:NO];
    }
    else if (track15state == 2) {
        [buttonTrack15 setTitle :[NSString stringWithFormat:@"%@", @"15r"] forState:UIControlStateNormal];
        [buttonTrack15 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        if (!isRecording && !midiFilePlaying && isPause) [self initialMIDIsettings :15];
    }
    else {
        [buttonTrack15 setTitle :[NSString stringWithFormat:@"%@", @"15"] forState:UIControlStateNormal];
        [buttonTrack15 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

- (IBAction)buttonTrack0pressed:(id)sender {
    track0state++;
    if ((midiFilePlaying || isPause || isRecording) && track0state == 2) track0state = 0;
    if (track0state > 2) track0state = 0;
    [self loadPreferencesChannel0];
    [self setTrack0state];
    [self savePreferences];
}
- (IBAction)buttonTrack1pressed:(id)sender {
    track1state++;
    if ((midiFilePlaying || isPause || isRecording) && track1state == 2) track1state = 0;
    if (track1state > 2) track1state = 0;
    [self loadPreferencesChannel1];
    [self setTrack1state];
    [self savePreferences];
}
- (IBAction)buttonTrack2pressed:(id)sender {
    track2state++;
    if ((midiFilePlaying || isPause || isRecording) && track2state == 2) track2state = 0;
    if (track2state > 2) track2state = 0;
    [self loadPreferencesChannel2];
    [self setTrack2state];
    [self savePreferences];
}
- (IBAction)buttonTrack3pressed:(id)sender {
    track3state++;
    if ((midiFilePlaying || isPause || isRecording) && track3state == 2) track3state = 0;
    if (track3state > 2) track3state = 0;
    [self loadPreferencesChannel3];
    [self setTrack3state];
    [self savePreferences];
}
- (IBAction)buttonTrack4pressed:(id)sender {
    track4state++;
    if ((midiFilePlaying || isPause || isRecording) && track4state == 2) track4state = 0;
    if (track4state > 2) track4state = 0;
    [self loadPreferencesChannel4];
    [self setTrack4state];
    [self savePreferences];
}
- (IBAction)buttonTrack5pressed:(id)sender {
    track5state++;
    if ((midiFilePlaying || isPause || isRecording) && track5state == 2) track5state = 0;
    if (track5state > 2) track5state = 0;
    [self loadPreferencesChannel5];
    [self setTrack5state];
    [self savePreferences];
}
- (IBAction)buttonTrack6pressed:(id)sender {
    track6state++;
    if ((midiFilePlaying || isPause || isRecording) && track6state == 2) track6state = 0;
    if (track6state > 2) track6state = 0;
    [self loadPreferencesChannel6];
    [self setTrack6state];
    [self savePreferences];
}
- (IBAction)buttonTrack7pressed:(id)sender {
    track7state++;
    if ((midiFilePlaying || isPause || isRecording) && track7state == 2) track7state = 0;
    if (track7state > 2) track7state = 0;
    [self loadPreferencesChannel7];
    [self setTrack7state];
    [self savePreferences];
}
- (IBAction)buttonTrack8pressed:(id)sender {
    track8state++;
    if ((midiFilePlaying || isPause || isRecording) && track8state == 2) track8state = 0;
    if (track8state > 2) track8state = 0;
    [self loadPreferencesChannel8];
    [self setTrack8state];
    [self savePreferences];
}
- (IBAction)buttonTrack9pressed:(id)sender {
    track9state++;
    if ((midiFilePlaying || isPause || isRecording) && track9state == 2) track9state = 0;
    if (track9state > 2) track9state = 0;
    [self loadPreferencesChannel9];
    [self setTrack9state];
    [self savePreferences];
}
- (IBAction)buttonTrack10pressed:(id)sender {
    track10state++;
    if ((midiFilePlaying || isPause || isRecording) && track10state == 2) track10state = 0;
    if (track10state >2) track10state = 0;
    [self loadPreferencesChannel10];
    [self setTrack10state];
    [self savePreferences];
}
- (IBAction)buttonTrack11pressed:(id)sender {
    track11state++;
    if ((midiFilePlaying || isPause || isRecording) && track11state == 2) track11state = 0;
    if (track11state > 2) track11state = 0;
    [self loadPreferencesChannel11];
    [self setTrack11state];
    [self savePreferences];
}
- (IBAction)buttonTrack12pressed:(id)sender {
    track12state++;
    if ((midiFilePlaying || isPause || isRecording) && track12state == 2) track12state = 0;
    if (track12state > 2) track12state = 0;
    [self loadPreferencesChannel12];
    [self setTrack12state];
    [self savePreferences];
}
- (IBAction)buttonTrack13pressed:(id)sender {
    track13state++;
    if ((midiFilePlaying || isPause || isRecording) && track13state == 2) track13state = 0;
    if (track13state > 2) track13state = 0;
    [self loadPreferencesChannel13];
    [self setTrack13state];
    [self savePreferences];
}
- (IBAction)buttonTrack14pressed:(id)sender {
    track14state++;
    if ((midiFilePlaying || isPause || isRecording) && track14state == 2) track14state = 0;
    if (track14state > 2) track14state = 0;
    [self loadPreferencesChannel14];
    [self setTrack14state];
    [self savePreferences];
}
- (IBAction)buttonTrack15pressed:(id)sender {
    track15state++;
    if ((midiFilePlaying || isPause || isRecording) && track15state == 2) track15state = 0;
    if (track15state > 2) track15state = 0;
    [self loadPreferencesChannel15];
    [self setTrack15state];
    [self savePreferences];
}

- (IBAction)switchMIDIthruValueChanged:(id)sender {
    switchMIDIthruState = switchMIDIthru.isOn;
    isSettings = FALSE;
    switchIsSettings.on = isSettings;
    [self savePreferences];
}

- (IBAction)switchLocSndValChanged:(id)sender {
    switchLocalSoundState = switchLocSnd.isOn;
    labelLocalSound1.hidden = switchLocSnd.isOn;
    isSettings = FALSE;
    switchIsSettings.on = isSettings;
    [self savePreferences];
    [self doRestOfLocSndChange];
    
    if (switchLocalSoundState) {
        alertAudio = [[UIAlertView alloc]initWithTitle: @"Information"
                                               message: @"If you don't hear local sounds, please close (double click on 'Home' button and sweep out the App) and restart this Application."
                                              delegate: self
                                     cancelButtonTitle: nil
                                     otherButtonTitles:@"OK",nil];
        [alertAudio show];
    }

}

- (void) doRestOfLocSndChange {
    if (switchLocalSoundState && !auInitilisationDone) {
        [appDelegate auInitialisations];
    }
    if (!switchLocalSoundState) {
        for (int iCh = 0; iCh < 16; iCh++) {
            [self allNotesOffMethod :iCh];
        }
    }
    else {
        ignoreLast = TRUE;
        for (int iCh = 0; iCh < 16; iCh++) {
            [self initialMIDIsettings :iCh];
        }
        
        for (int iCh = 0; iCh < 16; iCh++) {
            [self allNotesOffMethod :iCh];
        }
        ignoreLast = FALSE;
    }
}

- (IBAction)switchShowSYSEXvalueChanged:(id)sender {
    switchShowSYSEXstate = switchShowSYSEX.on;
    if (switchShowSYSEXstate) {
        switchFilterSYSEXstate = FALSE;
        switchFilterSYSEX.on = FALSE;
    }
    [self savePreferences];
}
- (IBAction)switchFilterSYSEXvalueChanged:(id)sender {
    switchFilterSYSEXstate = switchFilterSYSEX.on;
    if (switchFilterSYSEXstate) {
        switchShowSYSEXstate = FALSE;
        switchShowSYSEX.on = FALSE;
    }
    [self savePreferences];
}

- (IBAction)switchBackgroundPlayPressed:(id)sender {
    backgroundPlayAllowed = switchBackgroundPlay.isOn;
    [self savePreferences];
    [appDelegate setBackGroundAllowed:backgroundPlayAllowed];
    if (backgroundPlayAllowed) {
        alertAudio = [[UIAlertView alloc]initWithTitle: @"Warning"
                                               message: @"If you play other sounds while 'MFP' is in background, then you must close and restart 'MFP'!\nBackround playing uses a lot of ressources, please try it yourself."
                                              delegate: self
                                     cancelButtonTitle: nil
                                     otherButtonTitles:@"OK",nil];
        [alertAudio show];
    }
}


- (IBAction)buttonTransposePlusPressed:(id)sender {
    transposeValue++;
    if (transposeValue > 6) {
        transposeValue = 6;
    }
    labelTranspose1.text = [NSString stringWithFormat:@"Transpose %d", transposeValue];
    for (int iCh = 0; iCh < 16; iCh++) {
        [self allNotesOffMethod:iCh];
    }
    [appDelegate clearDiversBuffers];
}

- (IBAction)buttonTransposeMinusPressed:(id)sender {
    transposeValue--;
    if (transposeValue < -5) {
        transposeValue = -5;
    }
    labelTranspose1.text = [NSString stringWithFormat:@"Transpose %d", transposeValue];
    for (int iCh = 0; iCh < 16; iCh++) {
        [self allNotesOffMethod:iCh];
    }
    [appDelegate clearDiversBuffers];
}

- (void) hideLabels {
    if (!labelMIDI_0.isHidden) labelMIDI_0.hidden = TRUE;
    if (!labelMIDI_1.isHidden) labelMIDI_1.hidden = TRUE;
    if (!labelMIDI_2.isHidden) labelMIDI_2.hidden = TRUE;
    if (!labelMIDI_3.isHidden) labelMIDI_3.hidden = TRUE;
    if (!labelMIDI_4.isHidden) labelMIDI_4.hidden = TRUE;
    if (!labelMIDI_5.isHidden) labelMIDI_5.hidden = TRUE;
    if (!labelMIDI_6.isHidden) labelMIDI_6.hidden = TRUE;
    if (!labelMIDI_7.isHidden) labelMIDI_7.hidden = TRUE;
    if (!labelMIDI_8.isHidden) labelMIDI_8.hidden = TRUE;
    if (!labelMIDI_9.isHidden) labelMIDI_9.hidden = TRUE;
    if (!labelMIDI_10.isHidden) labelMIDI_10.hidden = TRUE;
    if (!labelMIDI_11.isHidden) labelMIDI_11.hidden = TRUE;
    if (!labelMIDI_12.isHidden) labelMIDI_12.hidden = TRUE;
    if (!labelMIDI_13.isHidden) labelMIDI_13.hidden = TRUE;
    if (!labelMIDI_14.isHidden) labelMIDI_14.hidden = TRUE;
    if (!labelMIDI_15.isHidden) labelMIDI_15.hidden = TRUE;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void) savePreferencesSlider {
    userPreferences = [NSUserDefaults standardUserDefaults];
    switch (channelSelection) {
        case 0:
            if (track0state == 2) {
                [userPreferences setInteger:slider2.value forKey:@"slider2.value00"];
                [userPreferences setInteger:slider4.value forKey:@"slider4.value00"];
                [userPreferences setInteger:slider6.value forKey:@"slider6.value00"];
                [userPreferences setInteger:slider7.value forKey:@"slider7.value00"];
                [userPreferences setInteger:slider8.value forKey:@"slider8.value00"];
            }
            break;
        case 1:
            if (track1state == 2) {
                [userPreferences setInteger:slider2.value forKey:@"slider2.value01"];
                [userPreferences setInteger:slider4.value forKey:@"slider4.value01"];
                [userPreferences setInteger:slider6.value forKey:@"slider6.value01"];
                [userPreferences setInteger:slider7.value forKey:@"slider7.value01"];
                [userPreferences setInteger:slider8.value forKey:@"slider8.value01"];
            }
            break;
        case 2:
            if (track2state == 2) {
                [userPreferences setInteger:slider2.value forKey:@"slider2.value02"];
                [userPreferences setInteger:slider4.value forKey:@"slider4.value02"];
                [userPreferences setInteger:slider6.value forKey:@"slider6.value02"];
                [userPreferences setInteger:slider7.value forKey:@"slider7.value02"];
                [userPreferences setInteger:slider8.value forKey:@"slider8.value02"];
            }
            break;
        case 3:
            if (track3state == 2) {
                [userPreferences setInteger:slider2.value forKey:@"slider2.value03"];
                [userPreferences setInteger:slider4.value forKey:@"slider4.value03"];
                [userPreferences setInteger:slider6.value forKey:@"slider6.value03"];
                [userPreferences setInteger:slider7.value forKey:@"slider7.value03"];
                [userPreferences setInteger:slider8.value forKey:@"slider8.value03"];
            }
            break;
        case 4:
            if (track4state == 2) {
                [userPreferences setInteger:slider2.value forKey:@"slider2.value04"];
                [userPreferences setInteger:slider4.value forKey:@"slider4.value04"];
                [userPreferences setInteger:slider6.value forKey:@"slider6.value04"];
                [userPreferences setInteger:slider7.value forKey:@"slider7.value04"];
                [userPreferences setInteger:slider8.value forKey:@"slider8.value04"];
            }
            break;
        case 5:
            if (track5state == 2) {
                [userPreferences setInteger:slider2.value forKey:@"slider2.value05"];
                [userPreferences setInteger:slider4.value forKey:@"slider4.value05"];
                [userPreferences setInteger:slider6.value forKey:@"slider6.value05"];
                [userPreferences setInteger:slider7.value forKey:@"slider7.value05"];
                [userPreferences setInteger:slider8.value forKey:@"slider8.value05"];
            }
            break;
        case 6:
            if (track6state == 2) {
                [userPreferences setInteger:slider2.value forKey:@"slider2.value06"];
                [userPreferences setInteger:slider4.value forKey:@"slider4.value06"];
                [userPreferences setInteger:slider6.value forKey:@"slider6.value06"];
                [userPreferences setInteger:slider7.value forKey:@"slider7.value06"];
                [userPreferences setInteger:slider8.value forKey:@"slider8.value06"];
            }
            break;
        case 7:
            if (track7state == 2) {
                [userPreferences setInteger:slider2.value forKey:@"slider2.value07"];
                [userPreferences setInteger:slider4.value forKey:@"slider4.value07"];
                [userPreferences setInteger:slider6.value forKey:@"slider6.value07"];
                [userPreferences setInteger:slider7.value forKey:@"slider7.value07"];
                [userPreferences setInteger:slider8.value forKey:@"slider8.value07"];
            }
            break;
        case 8:
            if (track8state == 2) {
                [userPreferences setInteger:slider2.value forKey:@"slider2.value08"];
                [userPreferences setInteger:slider4.value forKey:@"slider4.value08"];
                [userPreferences setInteger:slider6.value forKey:@"slider6.value08"];
                [userPreferences setInteger:slider7.value forKey:@"slider7.value08"];
                [userPreferences setInteger:slider8.value forKey:@"slider8.value08"];
            }
            break;
        case 9:
            if (track9state == 2) {
                [userPreferences setInteger:0 forKey:@"slider2.value09"]; // drums
                [userPreferences setInteger:slider4.value forKey:@"slider4.value09"];
                [userPreferences setInteger:slider6.value forKey:@"slider6.value09"];
                [userPreferences setInteger:slider7.value forKey:@"slider7.value09"];
                [userPreferences setInteger:slider8.value forKey:@"slider8.value09"];
            }
            break;
        case 10:
            if (track10state == 2) {
                [userPreferences setInteger:slider2.value forKey:@"slider2.value10"];
                [userPreferences setInteger:slider4.value forKey:@"slider4.value10"];
                [userPreferences setInteger:slider6.value forKey:@"slider6.value10"];
                [userPreferences setInteger:slider7.value forKey:@"slider7.value10"];
                [userPreferences setInteger:slider8.value forKey:@"slider8.value10"];
            }
            break;
        case 11:
            if (track11state == 2) {
                [userPreferences setInteger:slider2.value forKey:@"slider2.value11"];
                [userPreferences setInteger:slider4.value forKey:@"slider4.value11"];
                [userPreferences setInteger:slider6.value forKey:@"slider6.value11"];
                [userPreferences setInteger:slider7.value forKey:@"slider7.value11"];
                [userPreferences setInteger:slider8.value forKey:@"slider8.value11"];
            }
            break;
        case 12:
            if (track12state == 2) {
                [userPreferences setInteger:slider2.value forKey:@"slider2.value12"];
                [userPreferences setInteger:slider4.value forKey:@"slider4.value12"];
                [userPreferences setInteger:slider6.value forKey:@"slider6.value12"];
                [userPreferences setInteger:slider7.value forKey:@"slider7.value12"];
                [userPreferences setInteger:slider8.value forKey:@"slider8.value12"];
            }
            break;
        case 13:
            if (track13state == 2) {
                [userPreferences setInteger:slider2.value forKey:@"slider2.value13"];
                [userPreferences setInteger:slider4.value forKey:@"slider4.value13"];
                [userPreferences setInteger:slider6.value forKey:@"slider6.value13"];
                [userPreferences setInteger:slider7.value forKey:@"slider7.value13"];
                [userPreferences setInteger:slider8.value forKey:@"slider8.value13"];
            }
            break;
        case 14:
            if (track14state == 2) {
                [userPreferences setInteger:slider2.value forKey:@"slider2.value14"];
                [userPreferences setInteger:slider4.value forKey:@"slider4.value14"];
                [userPreferences setInteger:slider6.value forKey:@"slider6.value14"];
                [userPreferences setInteger:slider7.value forKey:@"slider7.value14"];
                [userPreferences setInteger:slider8.value forKey:@"slider8.value14"];
            }
            break;
        case 15:
            if (track15state == 2) {
                [userPreferences setInteger:slider2.value forKey:@"slider2.value15"];
                [userPreferences setInteger:slider4.value forKey:@"slider4.value15"];
                [userPreferences setInteger:slider6.value forKey:@"slider6.value15"];
                [userPreferences setInteger:slider7.value forKey:@"slider7.value15"];
                [userPreferences setInteger:slider8.value forKey:@"slider8.value15"];
            }
            break;
            
        default:
            break;
    }
    [userPreferences synchronize];
    
    ignoreLast = TRUE;
    [self initialMIDIsettings :channelSelection];
    ignoreLast = FALSE;
    
}

- (void) loadPreferencesSlider {
    userPreferences = [NSUserDefaults standardUserDefaults];
    if (track0state == 2) {
        lastInstr0 = [userPreferences integerForKey:@"slider2.value00"];
        lastVolume0 = [userPreferences integerForKey:@"slider4.value00"];
        lastReverb0 = [userPreferences integerForKey:@"slider6.value00"];
        lastChorus0 = [userPreferences integerForKey:@"slider7.value00"];
        lastPanorama0 = [userPreferences integerForKey:@"slider8.value00"];
    }
    else {
        lastInstr0 = lastInstr0;
        lastVolume0 = lastVolume0;
        lastReverb0 = lastReverb0;
        lastChorus0 = lastChorus0;
        lastPanorama0 = lastPanorama0;
    }
    
    if (track1state == 2) {
        lastInstr1 = [userPreferences integerForKey:@"slider2.value01"];
        lastVolume1 = [userPreferences integerForKey:@"slider4.value01"];
        lastReverb1 = [userPreferences integerForKey:@"slider6.value01"];
        lastChorus1 = [userPreferences integerForKey:@"slider7.value01"];
        lastPanorama1 = [userPreferences integerForKey:@"slider8.value01"];
    }
    else {
        lastInstr1 = lastInstr1;
        lastVolume1 = lastVolume1;
        lastReverb1 = lastReverb1;
        lastChorus1 = lastChorus1;
        lastPanorama1 = lastPanorama1;
    }
    
    if (track2state == 2) {
        lastInstr2 = [userPreferences integerForKey:@"slider2.value02"];
        lastVolume2 = [userPreferences integerForKey:@"slider4.value02"];
        lastReverb2 = [userPreferences integerForKey:@"slider6.value02"];
        lastChorus2 = [userPreferences integerForKey:@"slider7.value02"];
        lastPanorama2 = [userPreferences integerForKey:@"slider8.value02"];
    }
    else {
        lastInstr2 = lastInstr2;
        lastVolume2 = lastVolume2;
        lastReverb2 = lastReverb2;
        lastChorus2 = lastChorus2;
        lastPanorama2 = lastPanorama2;
    }
    
    if (track3state == 2) {
        lastInstr3 = [userPreferences integerForKey:@"slider2.value03"];
        lastVolume3 = [userPreferences integerForKey:@"slider4.value03"];
        lastReverb3 = [userPreferences integerForKey:@"slider6.value03"];
        lastChorus3 = [userPreferences integerForKey:@"slider7.value03"];
        lastPanorama3 = [userPreferences integerForKey:@"slider8.value03"];
    }
    else {
        lastInstr3 = lastInstr3;
        lastVolume3 = lastVolume3;
        lastReverb3 = lastReverb3;
        lastChorus3 = lastChorus3;
        lastPanorama3 = lastPanorama3;
    }
    
    if (track4state == 2) {
        lastInstr4 = [userPreferences integerForKey:@"slider2.value04"];
        lastVolume4 = [userPreferences integerForKey:@"slider4.value04"];
        lastReverb4 = [userPreferences integerForKey:@"slider6.value04"];
        lastChorus4 = [userPreferences integerForKey:@"slider7.value04"];
        lastPanorama4 = [userPreferences integerForKey:@"slider8.value04"];
    }
    else {
        lastInstr4 = lastInstr4;
        lastVolume4 = lastVolume4;
        lastReverb4 = lastReverb4;
        lastChorus4 = lastChorus4;
        lastPanorama4 = lastPanorama4;
    }
    
    if (track5state == 2) {
        lastInstr5 = [userPreferences integerForKey:@"slider2.value05"];
        lastVolume5 = [userPreferences integerForKey:@"slider4.value05"];
        lastReverb5 = [userPreferences integerForKey:@"slider6.value05"];
        lastChorus5 = [userPreferences integerForKey:@"slider7.value05"];
        lastPanorama5 = [userPreferences integerForKey:@"slider8.value05"];
    }
    else {
        lastInstr5 = lastInstr5;
        lastVolume5 = lastVolume5;
        lastReverb5 = lastReverb5;
        lastChorus5 = lastChorus5;
        lastPanorama5 = lastPanorama5;
    }
    
    if (track6state == 2) {
        lastInstr6 = [userPreferences integerForKey:@"slider2.value06"];
        lastVolume6 = [userPreferences integerForKey:@"slider4.value06"];
        lastReverb6 = [userPreferences integerForKey:@"slider6.value06"];
        lastChorus6 = [userPreferences integerForKey:@"slider7.value06"];
        lastPanorama6 = [userPreferences integerForKey:@"slider8.value06"];
    }
    else {
        lastInstr6 = lastInstr6;
        lastVolume6 = lastVolume6;
        lastReverb6 = lastReverb6;
        lastChorus6 = lastChorus6;
        lastPanorama6 = lastPanorama6;
    }
    
    if (track7state == 2) {
        lastInstr7 = [userPreferences integerForKey:@"slider2.value07"];
        lastVolume7 = [userPreferences integerForKey:@"slider4.value07"];
        lastReverb7 = [userPreferences integerForKey:@"slider6.value07"];
        lastChorus7 = [userPreferences integerForKey:@"slider7.value07"];
        lastPanorama7 = [userPreferences integerForKey:@"slider8.value07"];
    }
    else {
        lastInstr7 = lastInstr7;
        lastVolume7 = lastVolume7;
        lastReverb7 = lastReverb7;
        lastChorus7 = lastChorus7;
        lastPanorama7 = lastPanorama7;
    }
    
    if (track8state == 2) {
        lastInstr8 = [userPreferences integerForKey:@"slider2.value08"];
        lastVolume8 = [userPreferences integerForKey:@"slider4.value08"];
        lastReverb8 = [userPreferences integerForKey:@"slider6.value08"];
        lastChorus8 = [userPreferences integerForKey:@"slider7.value08"];
        lastPanorama8 = [userPreferences integerForKey:@"slider8.value08"];
    }
    else {
        lastInstr8 = lastInstr8;
        lastVolume8 = lastVolume8;
        lastReverb8 = lastReverb8;
        lastChorus8 = lastChorus8;
        lastPanorama8 = lastPanorama8;
    }
    
    if (track9state == 2) {
        lastInstr9 = 0; // drums
        lastVolume9 = [userPreferences integerForKey:@"slider4.value09"];
        lastReverb9 = [userPreferences integerForKey:@"slider6.value09"];
        lastChorus9 = [userPreferences integerForKey:@"slider7.value09"];
        lastPanorama9 = [userPreferences integerForKey:@"slider8.value09"];
    }
    else {
        lastInstr9 = lastInstr9;
        lastVolume9 = lastVolume9;
        lastReverb9 = lastReverb9;
        lastChorus9 = lastChorus9;
        lastPanorama9 = lastPanorama9;
    }
    
    if (track10state == 2) {
        lastInstr10 = [userPreferences integerForKey:@"slider2.value10"];
        lastVolume10 = [userPreferences integerForKey:@"slider4.value10"];
        lastReverb10 = [userPreferences integerForKey:@"slider6.value10"];
        lastChorus10 = [userPreferences integerForKey:@"slider7.value10"];
        lastPanorama10 = [userPreferences integerForKey:@"slider8.value10"];
    }
    else {
        lastInstr10 = lastInstr10;
        lastVolume10 = lastVolume10;
        lastReverb10 = lastReverb10;
        lastChorus10 = lastChorus10;
        lastPanorama10 = lastPanorama10;
    }
    
    if (track11state == 2) {
        lastInstr11 = [userPreferences integerForKey:@"slider2.value11"];
        lastVolume11 = [userPreferences integerForKey:@"slider4.value11"];
        lastReverb11 = [userPreferences integerForKey:@"slider6.value11"];
        lastChorus11 = [userPreferences integerForKey:@"slider7.value11"];
        lastPanorama11 = [userPreferences integerForKey:@"slider8.value11"];
    }
    else {
        lastInstr11 = lastInstr11;
        lastVolume11 = lastVolume11;
        lastReverb11 = lastReverb11;
        lastChorus11 = lastChorus11;
        lastPanorama11 = lastPanorama11;
    }
    
    if (track12state == 2) {
        lastInstr12 = [userPreferences integerForKey:@"slider2.value12"];
        lastVolume12 = [userPreferences integerForKey:@"slider4.value12"];
        lastReverb12 = [userPreferences integerForKey:@"slider6.value12"];
        lastChorus12 = [userPreferences integerForKey:@"slider7.value12"];
        lastPanorama12 = [userPreferences integerForKey:@"slider8.value12"];
    }
    else {
        lastInstr12 = lastInstr12;
        lastVolume12 = lastVolume12;
        lastReverb12 = lastReverb12;
        lastChorus12 = lastChorus12;
        lastPanorama12 = lastPanorama12;
    }
    
    if (track13state == 2) {
        lastInstr13 = [userPreferences integerForKey:@"slider2.value13"];
        lastVolume13 = [userPreferences integerForKey:@"slider4.value13"];
        lastReverb13 = [userPreferences integerForKey:@"slider6.value13"];
        lastChorus13 = [userPreferences integerForKey:@"slider7.value13"];
        lastPanorama13 = [userPreferences integerForKey:@"slider8.value13"];
    }
    else {
        lastInstr13 = lastInstr13;
        lastVolume13 = lastVolume13;
        lastReverb13 = lastReverb13;
        lastChorus13 = lastChorus13;
        lastPanorama13 = lastPanorama13;
    }
    
    if (track14state == 2) {
        lastInstr14 = [userPreferences integerForKey:@"slider2.value14"];
        lastVolume14 = [userPreferences integerForKey:@"slider4.value14"];
        lastReverb14 = [userPreferences integerForKey:@"slider6.value14"];
        lastChorus14 = [userPreferences integerForKey:@"slider7.value14"];
        lastPanorama14 = [userPreferences integerForKey:@"slider8.value14"];
    }
    else {
        lastInstr14 = lastInstr14;
        lastVolume14 = lastVolume14;
        lastReverb14 = lastReverb14;
        lastChorus14 = lastChorus14;
        lastPanorama14 = lastPanorama14;
    }
    
    if (track15state == 2) {
        lastInstr15 = [userPreferences integerForKey:@"slider2.value15"];
        lastVolume15 = [userPreferences integerForKey:@"slider4.value15"];
        lastReverb15 = [userPreferences integerForKey:@"slider6.value15"];
        lastChorus15 = [userPreferences integerForKey:@"slider7.value15"];
        lastPanorama15 = [userPreferences integerForKey:@"slider8.value15"];
    }
    else {
        lastInstr15 = lastInstr15;
        lastVolume15 = lastVolume15;
        lastReverb15 = lastReverb15;
        lastChorus15 = lastChorus15;
        lastPanorama15 = lastPanorama15;
    }
    
    switch (channelSelection) {
        case 0:
            slider2.value = lastInstr0;
            slider4.value = lastVolume0;
            slider6.value = lastReverb0;
            slider7.value = lastChorus0;
            slider8.value = lastPanorama0;
            break;
            
        case 1:
            slider2.value = lastInstr1;
            slider4.value = lastVolume1;
            slider6.value = lastReverb1;
            slider7.value = lastChorus1;
            slider8.value = lastPanorama1;
            break;
        case 2:
            slider2.value = lastInstr2;
            slider4.value = lastVolume2;
            slider6.value = lastReverb2;
            slider7.value = lastChorus2;
            slider8.value = lastPanorama2;
            break;
        case 3:
            slider2.value = lastInstr3;
            slider4.value = lastVolume3;
            slider6.value = lastReverb3;
            slider7.value = lastChorus3;
            slider8.value = lastPanorama3;
            break;
        case 4:
            slider2.value = lastInstr4;
            slider4.value = lastVolume4;
            slider6.value = lastReverb4;
            slider7.value = lastChorus4;
            slider8.value = lastPanorama4;
            break;
        case 5:
            slider2.value = lastInstr5;
            slider4.value = lastVolume5;
            slider6.value = lastReverb5;
            slider7.value = lastChorus5;
            slider8.value = lastPanorama5;
            break;
        case 6:
            slider2.value = lastInstr6;
            slider4.value = lastVolume6;
            slider6.value = lastReverb6;
            slider7.value = lastChorus6;
            slider8.value = lastPanorama6;
            break;
        case 7:
            slider2.value = lastInstr7;
            slider4.value = lastVolume7;
            slider6.value = lastReverb7;
            slider7.value = lastChorus7;
            slider8.value = lastPanorama7;
            break;
        case 8:
            slider2.value = lastInstr8;
            slider4.value = lastVolume8;
            slider6.value = lastReverb8;
            slider7.value = lastChorus8;
            slider8.value = lastPanorama8;
            break;
        case 9:
            slider2.value = lastInstr9;
            slider4.value = lastVolume9;
            slider6.value = lastReverb9;
            slider7.value = lastChorus9;
            slider8.value = lastPanorama9;
            break;
        case 10:
            slider2.value = lastInstr10;
            slider4.value = lastVolume10;
            slider6.value = lastReverb10;
            slider7.value = lastChorus10;
            slider8.value = lastPanorama10;
            break;
        case 11:
            slider2.value = lastInstr11;
            slider4.value = lastVolume11;
            slider6.value = lastReverb11;
            slider7.value = lastChorus11;
            slider8.value = lastPanorama11;
            break;
        case 12:
            slider2.value = lastInstr12;
            slider4.value = lastVolume12;
            slider6.value = lastReverb12;
            slider7.value = lastChorus12;
            slider8.value = lastPanorama12;
            break;
        case 13:
            slider2.value = lastInstr13;
            slider4.value = lastVolume13;
            slider6.value = lastReverb13;
            slider7.value = lastChorus13;
            slider8.value = lastPanorama13;
            break;
        case 14:
            slider2.value = lastInstr14;
            slider4.value = lastVolume14;
            slider6.value = lastReverb14;
            slider7.value = lastChorus14;
            slider8.value = lastPanorama14;
            break;
        case 15:
            slider2.value = lastInstr15;
            slider4.value = lastVolume15;
            slider6.value = lastReverb15;
            slider7.value = lastChorus15;
            slider8.value = lastPanorama15;
            break;
            
        default:
            break;
    }
    
    [userPreferences synchronize];
    
    if (slider2.value == 0  && slider4.value == 0 && slider6.value == 0 && slider7.value == 0 && slider8.value == 0){
        slider2.value = 0;
        slider4.value = 127;
        slider6.value = 40;
        slider7.value = 0;
        slider8.value = 64;  // Center
        [self savePreferencesSlider];
    }
    
    Byte tempSlider2 = (int)slider2.value;
    if (channelSelection == 9) {
        instrName = [NSString stringWithFormat:@"Drums (%i)", tempSlider2];
    }
    else {
        instrName = [NSString stringWithFormat:@"%@", [instruments objectAtIndex:tempSlider2]];
    }
    labelInstrument.text = [NSString stringWithFormat:@"%@", instrName];
    labelInstrNumb.text = [NSString stringWithFormat:@"Instrument %i", tempSlider2];

    slider4text.text = [NSString stringWithFormat:@"%d" , (int)slider4.value];
    slider6text.text = [NSString stringWithFormat:@"%d" , (int)slider6.value];
    slider7text.text = [NSString stringWithFormat:@"%d" , (int)slider7.value];
    
}

- (void) updateSliderETC {
    switch (channelSelection) {
        case 0:
            slider2.value = lastInstr0;
            slider4.value = lastVolume0;
            slider6.value = lastReverb0;
            slider7.value = lastChorus0;
            slider8.value = lastPanorama0;
            break;
        case 1:
            slider2.value = lastInstr1;
            slider4.value = lastVolume1;
            slider6.value = lastReverb1;
            slider7.value = lastChorus1;
            slider8.value = lastPanorama1;
            break;
        case 2:
            slider2.value = lastInstr2;
            slider4.value = lastVolume2;
            slider6.value = lastReverb2;
            slider7.value = lastChorus2;
            slider8.value = lastPanorama2;
            break;
        case 3:
            slider2.value = lastInstr3;
            slider4.value = lastVolume3;
            slider6.value = lastReverb3;
            slider7.value = lastChorus3;
            slider8.value = lastPanorama3;
            break;
        case 4:
            slider2.value = lastInstr4;
            slider4.value = lastVolume4;
            slider6.value = lastReverb4;
            slider7.value = lastChorus4;
            slider8.value = lastPanorama4;
            break;
        case 5:
            slider2.value = lastInstr5;
            slider4.value = lastVolume5;
            slider6.value = lastReverb5;
            slider7.value = lastChorus5;
            slider8.value = lastPanorama5;
            break;
        case 6:
            slider2.value = lastInstr6;
            slider4.value = lastVolume6;
            slider6.value = lastReverb6;
            slider7.value = lastChorus6;
            slider8.value = lastPanorama6;
            break;
        case 7:
            slider2.value = lastInstr7;
            slider4.value = lastVolume7;
            slider6.value = lastReverb7;
            slider7.value = lastChorus7;
            slider8.value = lastPanorama7;
            break;
        case 8:
            slider2.value = lastInstr8;
            slider4.value = lastVolume8;
            slider6.value = lastReverb8;
            slider7.value = lastChorus8;
            slider8.value = lastPanorama8;
            break;
        case 9:
            slider2.value = lastInstr9;
            slider4.value = lastVolume9;
            slider6.value = lastReverb9;
            slider7.value = lastChorus9;
            slider8.value = lastPanorama9;
            break;
        case 10:
            slider2.value = lastInstr10;
            slider4.value = lastVolume10;
            slider6.value = lastReverb10;
            slider7.value = lastChorus10;
            slider8.value = lastPanorama10;
            break;
        case 11:
            slider2.value = lastInstr11;
            slider4.value = lastVolume11;
            slider6.value = lastReverb11;
            slider7.value = lastChorus11;
            slider8.value = lastPanorama11;
            break;
        case 12:
            slider2.value = lastInstr12;
            slider4.value = lastVolume12;
            slider6.value = lastReverb12;
            slider7.value = lastChorus12;
            slider8.value = lastPanorama12;
            break;
        case 13:
            slider2.value = lastInstr13;
            slider4.value = lastVolume13;
            slider6.value = lastReverb13;
            slider7.value = lastChorus13;
            slider8.value = lastPanorama13;
            break;
        case 14:
            slider2.value = lastInstr14;
            slider4.value = lastVolume14;
            slider6.value = lastReverb14;
            slider7.value = lastChorus14;
            slider8.value = lastPanorama14;
            break;
        case 15:
            slider2.value = lastInstr15;
            slider4.value = lastVolume15;
            slider6.value = lastReverb15;
            slider7.value = lastChorus15;
            slider8.value = lastPanorama15;
            break;
            
        default:
            break;
    }
    Byte tempSlider2 = (int)slider2.value;
    if (channelSelection == 9) {
        instrName = [NSString stringWithFormat:@"Drums (%i)", tempSlider2];
    }
    else {
        instrName = [NSString stringWithFormat:@"%@", [instruments objectAtIndex:tempSlider2]];
    }
    labelInstrument.text = [NSString stringWithFormat:@"%@", instrName];
    labelInstrNumb.text = [NSString stringWithFormat:@"Instrument %i", tempSlider2];
    
    slider4text.text = [NSString stringWithFormat:@"%d" , (int)slider4.value];
    slider6text.text = [NSString stringWithFormat:@"%d" , (int)slider6.value];
    slider7text.text = [NSString stringWithFormat:@"%d" , (int)slider7.value];
    
    lastSlider2value = 255;
    lastSlider4value = 255;
    lastSlider6value = 255;
    lastSlider7value = 255;
    lastSlider8value = 255;
}

- (IBAction)slider2ValueChanged:(id)sender {
    
    Byte tempInstr = slider2.value;
    //slider2.value = tempInstr;  // snap to integer value
    
    isSettings = TRUE;
    switchIsSettings.on = isSettings;

    if (channelSelection == 9) {
        instrName = [NSString stringWithFormat:@"Drums (%i)", tempInstr];
    }
    else {
        instrName = [NSString stringWithFormat:@"%@", [instruments objectAtIndex:tempInstr]];
    }
    labelInstrument.text = [NSString stringWithFormat:@"%@", instrName];
    labelInstrNumb.text = [NSString stringWithFormat:@"Instrument %i", tempInstr];
    
    switch (channelSelection) {
        case 0:
            lastInstr0 = tempInstr;
            break;
        case 1:
            lastInstr1 = tempInstr;
            break;
        case 2:
            lastInstr2 = tempInstr;
            break;
        case 3:
            lastInstr3 = tempInstr;
            break;
        case 4:
            lastInstr4 = tempInstr;
            break;
        case 5:
            lastInstr5 = tempInstr;
            break;
        case 6:
            lastInstr6 = tempInstr;
            break;
        case 7:
            lastInstr7 = tempInstr;
            break;
        case 8:
            lastInstr8 = tempInstr;
            break;
        case 9:
            lastInstr9 = tempInstr;
            break;
        case 10:
            lastInstr10 = tempInstr;
            break;
        case 11:
            lastInstr11 = tempInstr;
            break;
        case 12:
            lastInstr12 = tempInstr;
            break;
        case 13:
            lastInstr13 = tempInstr;
            break;
        case 14:
            lastInstr14 = tempInstr;
            break;
        case 15:
            lastInstr15 = tempInstr;
            break;
            
        default:
            break;
    }
    [self initialMIDIsettings :channelSelection];
    //[self initialMIDIsettingsInstrument :channelSelection];
}

- (IBAction)slider4ValueChanged:(id)sender {
    Byte tempVol = slider4.value;
    //slider4.value = tempVol;
    isSettings = TRUE;
    switchIsSettings.on = isSettings;

    slider4text.text = [NSString stringWithFormat:@"%d", tempVol];
    switch (channelSelection) {
        case 0:
            lastVolume0 = tempVol;
            break;
        case 1:
            lastVolume1 = tempVol;
            break;
        case 2:
            lastVolume2 = tempVol;
            break;
        case 3:
            lastVolume3 = tempVol;
            break;
        case 4:
            lastVolume4 = tempVol;
            break;
        case 5:
            lastVolume5 = tempVol;
            break;
        case 6:
            lastVolume6 = tempVol;
            break;
        case 7:
            lastVolume7 = tempVol;
            break;
        case 8:
            lastVolume8 = tempVol;
            break;
        case 9:
            lastVolume9 = tempVol;
            break;
        case 10:
            lastVolume10 = tempVol;
            break;
        case 11:
            lastVolume11 = tempVol;
            break;
        case 12:
            lastVolume12 = tempVol;
            break;
        case 13:
            lastVolume13 = tempVol;
            break;
        case 14:
            lastVolume14 = tempVol;
            break;
        case 15:
            lastVolume15 = tempVol;
            break;
        default:
            break;
    }
    [self initialMIDIsettingsVolume :channelSelection];
}

- (IBAction)slider6ValueChanged:(id)sender {
    Byte tempReverb = slider6.value;
    //slider6.value = tempReverb;
    isSettings = TRUE;
    switchIsSettings.on = isSettings;

    slider6text.text = [NSString stringWithFormat:@"%d", tempReverb];
    switch (channelSelection) {
        case 0:
            lastReverb0 = tempReverb;
            break;
        case 1:
            lastReverb1 = tempReverb;
            break;
        case 2:
            lastReverb2 = tempReverb;
            break;
        case 3:
            lastReverb3 = tempReverb;
            break;
        case 4:
            lastReverb4 = tempReverb;
            break;
        case 5:
            lastReverb5 = tempReverb;
            break;
        case 6:
            lastReverb6 = tempReverb;
            break;
        case 7:
            lastReverb7 = tempReverb;
            break;
        case 8:
            lastReverb8 = tempReverb;
            break;
        case 9:
            lastReverb9 = tempReverb;
            break;
        case 10:
            lastReverb10 = tempReverb;
            break;
        case 11:
            lastReverb11 = tempReverb;
            break;
        case 12:
            lastReverb12 = tempReverb;
            break;
        case 13:
            lastReverb13 = tempReverb;
            break;
        case 14:
            lastReverb14 = tempReverb;
            break;
        case 15:
            lastReverb15 = tempReverb;
            break;
        default:
            break;
    }
    [self initialMIDIsettingsReverb :channelSelection];
}

- (IBAction)slider7ValueChanged:(id)sender {
    Byte tempChorus = slider7.value;
    //slider7.value = tempChorus;
    isSettings = TRUE;
    switchIsSettings.on = isSettings;

    slider7text.text = [NSString stringWithFormat:@"%d", tempChorus];
    switch (channelSelection) {
        case 0:
            lastChorus0 = tempChorus;
            break;
        case 1:
            lastChorus1 = tempChorus;
            break;
        case 2:
            lastChorus2 = tempChorus;
            break;
        case 3:
            lastChorus3 = tempChorus;
            break;
        case 4:
            lastChorus4 = tempChorus;
            break;
        case 5:
            lastChorus5 = tempChorus;
            break;
        case 6:
            lastChorus6 = tempChorus;
            break;
        case 7:
            lastChorus7 = tempChorus;
            break;
        case 8:
            lastChorus8 = tempChorus;
            break;
        case 9:
            lastChorus9 = tempChorus;
            break;
        case 10:
            lastChorus10 = tempChorus;
            break;
        case 11:
            lastChorus11 = tempChorus;
            break;
        case 12:
            lastChorus12 = tempChorus;
            break;
        case 13:
            lastChorus13 = tempChorus;
            break;
        case 14:
            lastChorus14 = tempChorus;
            break;
        case 15:
            lastChorus15 = tempChorus;
            break;
        default:
            break;
    }
    [self initialMIDIsettingsChorus :channelSelection];
}

- (IBAction)slider8ValueChanged:(id)sender {
    Byte tempPanorma = slider8.value;
    slider8.value = tempPanorma;
    isSettings = TRUE;
    switchIsSettings.on = isSettings;

    switch (channelSelection) {
        case 0:
            lastPanorama0 = tempPanorma;
            break;
        case 1:
            lastPanorama1 = tempPanorma;
            break;
        case 2:
            lastPanorama2 = tempPanorma;
            break;
        case 3:
            lastPanorama3 = tempPanorma;
            break;
        case 4:
            lastPanorama4 = tempPanorma;
            break;
        case 5:
            lastPanorama5 = tempPanorma;
            break;
        case 6:
            lastPanorama6 = tempPanorma;
            break;
        case 7:
            lastPanorama7 = tempPanorma;
            break;
        case 8:
            lastPanorama8 = tempPanorma;
            break;
        case 9:
            lastPanorama9 = tempPanorma;
            break;
        case 10:
            lastPanorama10 = tempPanorma;
            break;
        case 11:
            lastPanorama11 = tempPanorma;
            break;
        case 12:
            lastPanorama12 = tempPanorma;
            break;
        case 13:
            lastPanorama13 = tempPanorma;
            break;
        case 14:
            lastPanorama14 = tempPanorma;
            break;
        case 15:
            lastPanorama15 = tempPanorma;
            break;
        default:
            break;
    }
    [self initialMIDIsettingsPanorama :channelSelection];
}

- (IBAction)buttonMinusPpressed:(id)sender {
    if (slider2.value > 0){
        slider2.value--;
        [self slider2ValueChanged:nil];
    }
}
- (IBAction)buttonPlusPpressed:(id)sender {
    if (slider2.value < 127){
        slider2.value++;
        [self slider2ValueChanged:nil];
    }
}

- (IBAction)buttonTestPressed:(id)sender {
    [self putThreeByteInBuffer :0x90 + channelSelection :0x3C :0x7F];
}

- (IBAction)buttonTestReleased:(id)sender {
    [self putThreeByteInBuffer :0x90 + channelSelection :0x3C :0x00];
}

- (void) putByteInBuffer :(Byte)byteToPut{
    inppointSettings++;
    if (inppointSettings >= bufsizeSettings) inppointSettings = 0;
    inputBufferSettings[inppointSettings] = byteToPut;
}

- (void) putThreeByteInBuffer :(Byte)byteToPut1 :(Byte)byteToPut2 :(Byte)byteToPut3 {
    inppointSettings++;
    if (inppointSettings >= bufsizeSettings) inppointSettings = 0;
    inputBufferSettings[inppointSettings] = byteToPut1;
    inppointSettings++;
    if (inppointSettings >= bufsizeSettings) inppointSettings = 0;
    inputBufferSettings[inppointSettings] = byteToPut2;
    inppointSettings++;
    if (inppointSettings >= bufsizeSettings) inppointSettings = 0;
    inputBufferSettings[inppointSettings] = byteToPut3;
}

- (void) channelChange {
    [self setSmallFont];
    [self updateSliderETC];
//    [self initialMIDIsettings :channelSelection];
}

- (void) setSmallFont {
    [buttonChannel0.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [buttonChannel1.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [buttonChannel2.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [buttonChannel3.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [buttonChannel4.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [buttonChannel5.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [buttonChannel6.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [buttonChannel7.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [buttonChannel8.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [buttonChannel9.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [buttonChannel10.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [buttonChannel11.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [buttonChannel12.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [buttonChannel13.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [buttonChannel14.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [buttonChannel15.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [buttonChannel0 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [buttonChannel1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [buttonChannel2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [buttonChannel3 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [buttonChannel4 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [buttonChannel5 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [buttonChannel6 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [buttonChannel7 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [buttonChannel8 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [buttonChannel9 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [buttonChannel10 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [buttonChannel11 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [buttonChannel12 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [buttonChannel13 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [buttonChannel14 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [buttonChannel15 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
}

- (IBAction)buttonChannel0pressed:(id)sender {
    channelSelection = 0;
    [self channelChange];
    [buttonChannel0.titleLabel setFont:[UIFont boldSystemFontOfSize:27]];
}
- (IBAction)buttonChannel1pressed:(id)sender {
    channelSelection = 1;
    [self channelChange];
    [buttonChannel1.titleLabel setFont:[UIFont boldSystemFontOfSize:27]];
}
- (IBAction)buttonChannel2pressed:(id)sender {
    channelSelection = 2;
    [self channelChange];
    [buttonChannel2.titleLabel setFont:[UIFont boldSystemFontOfSize:27]];
}
- (IBAction)buttonChannel3pressed:(id)sender {
    channelSelection = 3;
    [self channelChange];
    [buttonChannel3.titleLabel setFont:[UIFont boldSystemFontOfSize:27]];
}
- (IBAction)buttonChannel4pressed:(id)sender {
    channelSelection = 4;
    [self channelChange];
    [buttonChannel4.titleLabel setFont:[UIFont boldSystemFontOfSize:27]];
}
- (IBAction)buttonChannel5pressed:(id)sender {
    channelSelection = 5;
    [self channelChange];
    [buttonChannel5.titleLabel setFont:[UIFont boldSystemFontOfSize:27]];
}
- (IBAction)buttonChannel6pressed:(id)sender {
    channelSelection = 6;
    [self channelChange];
    [buttonChannel6.titleLabel setFont:[UIFont boldSystemFontOfSize:27]];
}
- (IBAction)buttonChannel7pressed:(id)sender {
    channelSelection = 7;
    [self channelChange];
    [buttonChannel7.titleLabel setFont:[UIFont boldSystemFontOfSize:27]];
}
- (IBAction)buttonChannel8pressed:(id)sender {
    channelSelection = 8;
    [self channelChange];
    [buttonChannel8.titleLabel setFont:[UIFont boldSystemFontOfSize:27]];
}
- (IBAction)buttonChannel9pressed:(id)sender {
    channelSelection = 9;
    [self channelChange];
    [buttonChannel9.titleLabel setFont:[UIFont boldSystemFontOfSize:27]];
}
- (IBAction)buttonChannel10pressed:(id)sender {
    channelSelection = 10;
    [self channelChange];
    [buttonChannel10.titleLabel setFont:[UIFont boldSystemFontOfSize:27]];
}
- (IBAction)buttonChannel11pressed:(id)sender {
    channelSelection = 11;
    [self channelChange];
    [buttonChannel11.titleLabel setFont:[UIFont boldSystemFontOfSize:27]];
}
- (IBAction)buttonChannel12pressed:(id)sender {
    channelSelection = 12;
    [self channelChange];
    [buttonChannel12.titleLabel setFont:[UIFont boldSystemFontOfSize:27]];
}
- (IBAction)buttonChannel13pressed:(id)sender {
    channelSelection = 13;
    [self channelChange];
    [buttonChannel13.titleLabel setFont:[UIFont boldSystemFontOfSize:27]];
}
- (IBAction)buttonChannel14pressed:(id)sender {
    channelSelection = 14;
    [self channelChange];
    [buttonChannel14.titleLabel setFont:[UIFont boldSystemFontOfSize:27]];
}
- (IBAction)buttonChannel15pressed:(id)sender {
    channelSelection = 15;
    [self channelChange];
    [buttonChannel15.titleLabel setFont:[UIFont boldSystemFontOfSize:27]];
}


- (void) saveDevices {
    userPreferences = [NSUserDefaults standardUserDefaults];
    [userPreferences setInteger:posOutput forKey:@"posOutput"];
    [userPreferences setInteger:posInput forKey:@"posInput"];
    [userPreferences setBool:TRUE forKey:@"posWasSaved"];
    [userPreferences synchronize];
}

- (IBAction)buttonPrevOutPressed:(id)sender {
    if (posOutput > 0) {
        posOutput--;
        outDeviceTextField.text = arrayOutDevices[posOutput];
        [self saveDevices];
        [self initializationMIDI];
    }
}

- (IBAction)buttonNextOutPressed:(id)sender {
    if (posOutput < ([arrayOutDevices count]-1)) {
        posOutput++;
        outDeviceTextField.text = arrayOutDevices[posOutput];
        [self saveDevices];
        [self initializationMIDI];
    }
}

- (IBAction)buttonPrevInPressed:(id)sender {
    if (posInput > 0) {
        posInput--;
        inDeviceTextField.text = arrayInDevices[posInput];
        [self saveDevices];
        [self initializationMIDI];
    }
}

- (IBAction)buttonNextInPressed:(id)sender {
    if (posInput < ([arrayInDevices count]-1)) {
        posInput++;
        inDeviceTextField.text = arrayInDevices[posInput];
        [self saveDevices];
        [self initializationMIDI];
    }
}

- (IBAction)buttonMinusChordPressed:(id)sender {
    if (channelForShowChord == 0xFF) channelForShowChord = 0xFE;
    else if (channelForShowChord == 0xFE) channelForShowChord = 15;
    else if (channelForShowChord > 0) channelForShowChord--;
    else if (channelForShowChord == 0) channelForShowChord = 0xFF;
    if (channelForShowChord == 9) channelForShowChord = 8;
    [self setTextFieldChord];
    [self savePreferences];
}

- (IBAction)buttonPlusChordPressed:(id)sender {
    if (channelForShowChord == 0xFF) channelForShowChord = 0;
    else if (channelForShowChord == 0xFE) channelForShowChord = 0xFF;
    else if (channelForShowChord < 15) channelForShowChord++;
    else if (channelForShowChord == 15) channelForShowChord = 0xFE;
    if (channelForShowChord == 9) channelForShowChord = 10;
    [self setTextFieldChord];
    [self savePreferences];
}

- (void) setTextFieldChord {
    if (channelForShowChord == 0xFF) textFieldChord.text = @"none";
    else if (channelForShowChord == 0xFE) textFieldChord.text = @"all";
    else textFieldChord.text = [NSString stringWithFormat:@"%d", channelForShowChord];
    labelChordBig.hidden = TRUE;
    labelChordChannel.hidden = TRUE;
    labelChordBig.text = @"";
}

- (IBAction)switchIsSettingsValueChanged:(id)sender {
    isSettings = switchIsSettings.isOn;
}

- (void) chordDetection {
    lowestNoteChord = 0x7F;
    for (int cc = 0; cc < 12; cc++) {
        if (last12notes[chordChannel][cc][1] > 0) { // velocity
            if (last12notes[chordChannel][cc][0] < lowestNoteChord) lowestNoteChord = last12notes[chordChannel][cc][0]; // note value
        }
    }
    if (lowestNoteChord == 0x7F) lowestNoteChord = 0;
    else while (lowestNoteChord > 11) lowestNoteChord = lowestNoteChord - 12;
    chordPointer = 0;
    switch (lowestNoteChord) {
        case 0:
            if (last12notes[chordChannel][0][1] > 0) chordPointer = chordPointer + 1; // velocity > 0
            if (last12notes[chordChannel][1][1] > 0) chordPointer = chordPointer + 2;
            if (last12notes[chordChannel][2][1] > 0) chordPointer = chordPointer + 4;
            if (last12notes[chordChannel][3][1] > 0) chordPointer = chordPointer + 8;
            if (last12notes[chordChannel][4][1] > 0) chordPointer = chordPointer + 16;
            if (last12notes[chordChannel][5][1] > 0) chordPointer = chordPointer + 32;
            if (last12notes[chordChannel][6][1] > 0) chordPointer = chordPointer + 64;
            if (last12notes[chordChannel][7][1] > 0) chordPointer = chordPointer + 128;
            if (last12notes[chordChannel][8][1] > 0) chordPointer = chordPointer + 256;
            if (last12notes[chordChannel][9][1] > 0) chordPointer = chordPointer + 512;
            if (last12notes[chordChannel][10][1] > 0) chordPointer = chordPointer + 1024;
            if (last12notes[chordChannel][11][1] > 0) chordPointer = chordPointer + 2048;
            break;
        case 1:
            if (last12notes[chordChannel][1][1] > 0) chordPointer = chordPointer + 1;
            if (last12notes[chordChannel][2][1] > 0) chordPointer = chordPointer + 2;
            if (last12notes[chordChannel][3][1] > 0) chordPointer = chordPointer + 4;
            if (last12notes[chordChannel][4][1] > 0) chordPointer = chordPointer + 8;
            if (last12notes[chordChannel][5][1] > 0) chordPointer = chordPointer + 16;
            if (last12notes[chordChannel][6][1] > 0) chordPointer = chordPointer + 32;
            if (last12notes[chordChannel][7][1] > 0) chordPointer = chordPointer + 64;
            if (last12notes[chordChannel][8][1] > 0) chordPointer = chordPointer + 128;
            if (last12notes[chordChannel][9][1] > 0) chordPointer = chordPointer + 256;
            if (last12notes[chordChannel][10][1] > 0) chordPointer = chordPointer + 512;
            if (last12notes[chordChannel][11][1] > 0) chordPointer = chordPointer + 1024;
            if (last12notes[chordChannel][0][1] > 0) chordPointer = chordPointer + 2048;
            break;
        case 2:
            if (last12notes[chordChannel][2][1] > 0) chordPointer = chordPointer + 1;
            if (last12notes[chordChannel][3][1] > 0) chordPointer = chordPointer + 2;
            if (last12notes[chordChannel][4][1] > 0) chordPointer = chordPointer + 4;
            if (last12notes[chordChannel][5][1] > 0) chordPointer = chordPointer + 8;
            if (last12notes[chordChannel][6][1] > 0) chordPointer = chordPointer + 16;
            if (last12notes[chordChannel][7][1] > 0) chordPointer = chordPointer + 32;
            if (last12notes[chordChannel][8][1] > 0) chordPointer = chordPointer + 64;
            if (last12notes[chordChannel][9][1] > 0) chordPointer = chordPointer + 128;
            if (last12notes[chordChannel][10][1] > 0) chordPointer = chordPointer + 256;
            if (last12notes[chordChannel][11][1] > 0) chordPointer = chordPointer + 512;
            if (last12notes[chordChannel][0][1] > 0) chordPointer = chordPointer + 1024;
            if (last12notes[chordChannel][1][1] > 0) chordPointer = chordPointer + 2048;
            break;
        case 3:
            if (last12notes[chordChannel][3][1] > 0) chordPointer = chordPointer + 1;
            if (last12notes[chordChannel][4][1] > 0) chordPointer = chordPointer + 2;
            if (last12notes[chordChannel][5][1] > 0) chordPointer = chordPointer + 4;
            if (last12notes[chordChannel][6][1] > 0) chordPointer = chordPointer + 8;
            if (last12notes[chordChannel][7][1] > 0) chordPointer = chordPointer + 16;
            if (last12notes[chordChannel][8][1] > 0) chordPointer = chordPointer + 32;
            if (last12notes[chordChannel][9][1] > 0) chordPointer = chordPointer + 64;
            if (last12notes[chordChannel][10][1] > 0) chordPointer = chordPointer + 128;
            if (last12notes[chordChannel][11][1] > 0) chordPointer = chordPointer + 256;
            if (last12notes[chordChannel][0][1] > 0) chordPointer = chordPointer + 512;
            if (last12notes[chordChannel][1][1] > 0) chordPointer = chordPointer + 1024;
            if (last12notes[chordChannel][2][1] > 0) chordPointer = chordPointer + 2048;
            break;
        case 4:
            if (last12notes[chordChannel][4][1] > 0) chordPointer = chordPointer + 1;
            if (last12notes[chordChannel][5][1] > 0) chordPointer = chordPointer + 2;
            if (last12notes[chordChannel][6][1] > 0) chordPointer = chordPointer + 4;
            if (last12notes[chordChannel][7][1] > 0) chordPointer = chordPointer + 8;
            if (last12notes[chordChannel][8][1] > 0) chordPointer = chordPointer + 16;
            if (last12notes[chordChannel][9][1] > 0) chordPointer = chordPointer + 32;
            if (last12notes[chordChannel][10][1] > 0) chordPointer = chordPointer + 64;
            if (last12notes[chordChannel][11][1] > 0) chordPointer = chordPointer + 128;
            if (last12notes[chordChannel][0][1] > 0) chordPointer = chordPointer + 256;
            if (last12notes[chordChannel][1][1] > 0) chordPointer = chordPointer + 512;
            if (last12notes[chordChannel][2][1] > 0) chordPointer = chordPointer + 1024;
            if (last12notes[chordChannel][3][1] > 0) chordPointer = chordPointer + 2048;
            break;
        case 5:
            if (last12notes[chordChannel][5][1] > 0) chordPointer = chordPointer + 1;
            if (last12notes[chordChannel][6][1] > 0) chordPointer = chordPointer + 2;
            if (last12notes[chordChannel][7][1] > 0) chordPointer = chordPointer + 4;
            if (last12notes[chordChannel][8][1] > 0) chordPointer = chordPointer + 8;
            if (last12notes[chordChannel][9][1] > 0) chordPointer = chordPointer + 16;
            if (last12notes[chordChannel][10][1] > 0) chordPointer = chordPointer + 32;
            if (last12notes[chordChannel][11][1] > 0) chordPointer = chordPointer + 64;
            if (last12notes[chordChannel][0][1] > 0) chordPointer = chordPointer + 128;
            if (last12notes[chordChannel][1][1] > 0) chordPointer = chordPointer + 256;
            if (last12notes[chordChannel][2][1] > 0) chordPointer = chordPointer + 512;
            if (last12notes[chordChannel][3][1] > 0) chordPointer = chordPointer + 1024;
            if (last12notes[chordChannel][4][1] > 0) chordPointer = chordPointer + 2048;
            break;
        case 6:
            if (last12notes[chordChannel][6][1] > 0) chordPointer = chordPointer + 1;
            if (last12notes[chordChannel][7][1] > 0) chordPointer = chordPointer + 2;
            if (last12notes[chordChannel][8][1] > 0) chordPointer = chordPointer + 4;
            if (last12notes[chordChannel][9][1] > 0) chordPointer = chordPointer + 8;
            if (last12notes[chordChannel][10][1] > 0) chordPointer = chordPointer + 16;
            if (last12notes[chordChannel][11][1] > 0) chordPointer = chordPointer + 32;
            if (last12notes[chordChannel][0][1] > 0) chordPointer = chordPointer + 64;
            if (last12notes[chordChannel][1][1] > 0) chordPointer = chordPointer + 128;
            if (last12notes[chordChannel][2][1] > 0) chordPointer = chordPointer + 256;
            if (last12notes[chordChannel][3][1] > 0) chordPointer = chordPointer + 512;
            if (last12notes[chordChannel][4][1] > 0) chordPointer = chordPointer + 1024;
            if (last12notes[chordChannel][5][1] > 0) chordPointer = chordPointer + 2048;
            break;
        case 7:
            if (last12notes[chordChannel][7][1] > 0) chordPointer = chordPointer + 1;
            if (last12notes[chordChannel][8][1] > 0) chordPointer = chordPointer + 2;
            if (last12notes[chordChannel][9][1] > 0) chordPointer = chordPointer + 4;
            if (last12notes[chordChannel][10][1] > 0) chordPointer = chordPointer + 8;
            if (last12notes[chordChannel][11][1] > 0) chordPointer = chordPointer + 16;
            if (last12notes[chordChannel][0][1] > 0) chordPointer = chordPointer + 32;
            if (last12notes[chordChannel][1][1] > 0) chordPointer = chordPointer + 64;
            if (last12notes[chordChannel][2][1] > 0) chordPointer = chordPointer + 128;
            if (last12notes[chordChannel][3][1] > 0) chordPointer = chordPointer + 256;
            if (last12notes[chordChannel][4][1] > 0) chordPointer = chordPointer + 512;
            if (last12notes[chordChannel][5][1] > 0) chordPointer = chordPointer + 1024;
            if (last12notes[chordChannel][6][1] > 0) chordPointer = chordPointer + 2048;
            break;
        case 8:
            if (last12notes[chordChannel][8][1] > 0) chordPointer = chordPointer + 1;
            if (last12notes[chordChannel][9][1] > 0) chordPointer = chordPointer + 2;
            if (last12notes[chordChannel][10][1] > 0) chordPointer = chordPointer + 4;
            if (last12notes[chordChannel][11][1] > 0) chordPointer = chordPointer + 8;
            if (last12notes[chordChannel][0][1] > 0) chordPointer = chordPointer + 16;
            if (last12notes[chordChannel][1][1] > 0) chordPointer = chordPointer + 32;
            if (last12notes[chordChannel][2][1] > 0) chordPointer = chordPointer + 64;
            if (last12notes[chordChannel][3][1] > 0) chordPointer = chordPointer + 128;
            if (last12notes[chordChannel][4][1] > 0) chordPointer = chordPointer + 256;
            if (last12notes[chordChannel][5][1] > 0) chordPointer = chordPointer + 512;
            if (last12notes[chordChannel][6][1] > 0) chordPointer = chordPointer + 1024;
            if (last12notes[chordChannel][7][1] > 0) chordPointer = chordPointer + 2048;
            break;
        case 9:
            if (last12notes[chordChannel][9][1] > 0) chordPointer = chordPointer + 1;
            if (last12notes[chordChannel][10][1] > 0) chordPointer = chordPointer + 2;
            if (last12notes[chordChannel][11][1] > 0) chordPointer = chordPointer + 4;
            if (last12notes[chordChannel][0][1] > 0) chordPointer = chordPointer + 8;
            if (last12notes[chordChannel][1][1] > 0) chordPointer = chordPointer + 16;
            if (last12notes[chordChannel][2][1] > 0) chordPointer = chordPointer + 32;
            if (last12notes[chordChannel][3][1] > 0) chordPointer = chordPointer + 64;
            if (last12notes[chordChannel][4][1] > 0) chordPointer = chordPointer + 128;
            if (last12notes[chordChannel][5][1] > 0) chordPointer = chordPointer + 256;
            if (last12notes[chordChannel][6][1] > 0) chordPointer = chordPointer + 512;
            if (last12notes[chordChannel][7][1] > 0) chordPointer = chordPointer + 1024;
            if (last12notes[chordChannel][8][1] > 0) chordPointer = chordPointer + 2048;
            break;
        case 10:
            if (last12notes[chordChannel][10][1] > 0) chordPointer = chordPointer + 1;
            if (last12notes[chordChannel][11][1] > 0) chordPointer = chordPointer + 2;
            if (last12notes[chordChannel][0][1] > 0) chordPointer = chordPointer + 4;
            if (last12notes[chordChannel][1][1] > 0) chordPointer = chordPointer + 8;
            if (last12notes[chordChannel][2][1] > 0) chordPointer = chordPointer + 16;
            if (last12notes[chordChannel][3][1] > 0) chordPointer = chordPointer + 32;
            if (last12notes[chordChannel][4][1] > 0) chordPointer = chordPointer + 64;
            if (last12notes[chordChannel][5][1] > 0) chordPointer = chordPointer + 128;
            if (last12notes[chordChannel][6][1] > 0) chordPointer = chordPointer + 256;
            if (last12notes[chordChannel][7][1] > 0) chordPointer = chordPointer + 512;
            if (last12notes[chordChannel][8][1] > 0) chordPointer = chordPointer + 1024;
            if (last12notes[chordChannel][9][1] > 0) chordPointer = chordPointer + 2048;
            break;
        case 11:
            if (last12notes[chordChannel][11][1] > 0) chordPointer = chordPointer + 1;
            if (last12notes[chordChannel][0][1] > 0) chordPointer = chordPointer + 2;
            if (last12notes[chordChannel][1][1] > 0) chordPointer = chordPointer + 4;
            if (last12notes[chordChannel][2][1] > 0) chordPointer = chordPointer + 8;
            if (last12notes[chordChannel][3][1] > 0) chordPointer = chordPointer + 16;
            if (last12notes[chordChannel][4][1] > 0) chordPointer = chordPointer + 32;
            if (last12notes[chordChannel][5][1] > 0) chordPointer = chordPointer + 64;
            if (last12notes[chordChannel][6][1] > 0) chordPointer = chordPointer + 128;
            if (last12notes[chordChannel][7][1] > 0) chordPointer = chordPointer + 256;
            if (last12notes[chordChannel][8][1] > 0) chordPointer = chordPointer + 512;
            if (last12notes[chordChannel][9][1] > 0) chordPointer = chordPointer + 1024;
            if (last12notes[chordChannel][10][1] > 0) chordPointer = chordPointer + 2048;
            break;
            
        default:
            if (last12notes[chordChannel][0][1] > 0) chordPointer = chordPointer + 1;
            if (last12notes[chordChannel][1][1] > 0) chordPointer = chordPointer + 2;
            if (last12notes[chordChannel][2][1] > 0) chordPointer = chordPointer + 4;
            if (last12notes[chordChannel][3][1] > 0) chordPointer = chordPointer + 8;
            if (last12notes[chordChannel][4][1] > 0) chordPointer = chordPointer + 16;
            if (last12notes[chordChannel][5][1] > 0) chordPointer = chordPointer + 32;
            if (last12notes[chordChannel][6][1] > 0) chordPointer = chordPointer + 64;
            if (last12notes[chordChannel][7][1] > 0) chordPointer = chordPointer + 128;
            if (last12notes[chordChannel][8][1] > 0) chordPointer = chordPointer + 256;
            if (last12notes[chordChannel][9][1] > 0) chordPointer = chordPointer + 512;
            if (last12notes[chordChannel][10][1] > 0) chordPointer = chordPointer + 1024;
            if (last12notes[chordChannel][11][1] > 0) chordPointer = chordPointer + 2048;
            break;
    }
    if (chordPointer > maxChordPointerVal) {
        chordPointer = maxChordPointerVal+1;
    }
    if (chordType[chordPointer] != nil) {
        labelChordBig.text = [NSString stringWithFormat:@"%@%@", notesForText[lowestNoteChord], chordType[chordPointer]];
        labelChordChannel.frame = CGRectMake(31 + (bufferForChord[outpointBut][0]*46), 411, 16, 29);
        labelChordBig.hidden = FALSE;
        labelChordChannel.hidden = FALSE;
    }
    else {
        chordPointer = 0;
        if (last12notes[chordChannel][0][1] > 0) chordPointer = chordPointer + 1;
        if (last12notes[chordChannel][1][1] > 0) chordPointer = chordPointer + 2;
        if (last12notes[chordChannel][2][1] > 0) chordPointer = chordPointer + 4;
        if (last12notes[chordChannel][3][1] > 0) chordPointer = chordPointer + 8;
        if (last12notes[chordChannel][4][1] > 0) chordPointer = chordPointer + 16;
        if (last12notes[chordChannel][5][1] > 0) chordPointer = chordPointer + 32;
        if (last12notes[chordChannel][6][1] > 0) chordPointer = chordPointer + 64;
        if (last12notes[chordChannel][7][1] > 0) chordPointer = chordPointer + 128;
        if (last12notes[chordChannel][8][1] > 0) chordPointer = chordPointer + 256;
        if (last12notes[chordChannel][9][1] > 0) chordPointer = chordPointer + 512;
        if (last12notes[chordChannel][10][1] > 0) chordPointer = chordPointer + 1024;
        if (last12notes[chordChannel][11][1] > 0) chordPointer = chordPointer + 2048;
        
        if (chordPointer > maxChordPointerBaseVal) {
            chordPointer = maxChordPointerBaseVal+1;
        }
        if (chordTypeBase[chordPointer] != nil) {
            labelChordBig.text = [NSString stringWithFormat:@"%@", chordTypeBase[chordPointer]];
            labelChordChannel.frame = CGRectMake(31 + (bufferForChord[outpointBut][0]*46), 411, 16, 29);
            labelChordBig.hidden = FALSE;
            labelChordChannel.hidden = FALSE;
        }
    }
    
    if (chordTypeBase[chordPointer] == nil && chordType[chordPointer] == nil) {
        if (!oneShotTimerChordHide) {
            oneShotTimerChordHide = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                                     target:self selector:@selector(forOneShotTimerChordHide)userInfo:nil repeats:NO];
        }
    }
    else {
        if (oneShotTimerChordHide) {
            [oneShotTimerChordHide invalidate];
            oneShotTimerChordHide = nil;
        }
    }
}

- (void) forOneShotTimerChordHide {
    labelChordBig.hidden = TRUE;
    labelChordChannel.hidden = TRUE;
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

- (IBAction)switchAutoNextPressed:(id)sender {
    autoNext = switchAutoNext.isOn;
    [self savePreferences];
}

- (IBAction)switchDrumSet0valueChanged:(id)sender {
    drumSet0 = switchDrumSet0.isOn;
    [self savePreferences];
}

- (IBAction)buttonStartPointPressed:(id)sender {
    startPoint = songPosition;
    if (startPoint > endPoint) {
        endPoint = sliderSongPosition.maximumValue;
    }
    labelStartPoint.hidden = FALSE;
    [self subStartEndPoints];
}

- (IBAction)buttonEndPointPressed:(id)sender {
    endPoint = songPosition;
    if (endPoint < startPoint) {
        startPoint = 0;
    }
    labelStartPoint.hidden = FALSE;
    labelEndPoint.hidden = FALSE;
    [self subStartEndPoints];
}

- (void) subStartEndPoints {
    labelStartPoint.frame = CGRectMake((sliderSongPosition.frame.origin.x-4) + (((sliderSongPosition.frame.size.width-10) * startPoint / sliderSongPosition.maximumValue)), labelStartPoint.frame.origin.y, labelStartPoint.frame.size.width, labelStartPoint.frame.size.height);
    labelEndPoint.frame = CGRectMake((sliderSongPosition.frame.origin.x-4) + (((sliderSongPosition.frame.size.width-10) * endPoint / sliderSongPosition.maximumValue)), labelEndPoint.frame.origin.y, labelEndPoint.frame.size.width, labelEndPoint.frame.size.height);
}

- (IBAction)buttonLoopPressed:(id)sender {
    if (isLoop) isLoop = FALSE;
    else isLoop = TRUE;
    [self subLoopButton];
}

- (void) subLoopButton {
    if (isLoop) [buttonLoop setTitle :[NSString stringWithFormat:@"%@", @"Loop is ON"] forState:UIControlStateNormal];
    else [buttonLoop setTitle :[NSString stringWithFormat:@"%@", @"Loop is OFF"] forState:UIControlStateNormal];
}

@end
