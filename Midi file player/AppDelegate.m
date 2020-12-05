//
//  AppDelegate.m
//
//  Created by Walter Schurter on 01.05.13.
//  Copyright (c) 2013 Walter Schurter WASElectronic. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "ViewControllerPad.h"
#import <CoreMIDI/MIDIServices.h>
#import <CoreMIDI/CoreMIDI.h>
#import <AVFoundation/AVFoundation.h>

@implementation AppDelegate

@synthesize window = _window;

NSString *midiFilename = @"";
int selectedIndex = 0;
NSArray *listArrayForPicker;
bool initWasDone = FALSE;
bool switchShowSYSEXstate = FALSE;
bool switchFilterSYSEXstate = FALSE;
bool switchLocalSoundState = FALSE;
Byte channelTest = 0;
Byte instrumentTest = 0;
Byte velocityTest= 0;
bool isSettings = FALSE;
bool isRecording = FALSE;
bool midiFilePlaying = FALSE;
bool isPause = FALSE;
bool switchMIDIthruState = FALSE;
NSString *lastImportedMIDIfile = @"";
NSString *lastSelectedMIDIfile = @"";
bool mustParseDir = FALSE;
NSString *viewToGetBack = @"";
bool viewControllerIsVisible = FALSE;
bool viewControllerSettingsIsVisible = FALSE;
bool viewControllerHelpIsVisible = FALSE;
bool pickerViewIsVisible = FALSE;
NSString *documentsDirectoryPath = @"";

Byte tempInitial[16][2];
Byte tempAllNoteOff[16];
Byte allControllerOff[16];
int transposeValue = 0;

float darkGreySlider = 0.4;
float greyValueSlider = 0.6;
bool okWasPressed = FALSE;

bool initDone = FALSE;
float songPosition = 0;
float songLength = 0;
bool buttonMoreState = FALSE;
float playBackTempo = 0;

NSMutableArray *arrayOutDevices;
NSMutableArray *arrayInDevices;
int posOutput = 99;
int posInput = 99;
bool posWasSaved = FALSE;

Byte lastInstr0back = 0;
Byte lastInstr1back = 0;
Byte lastInstr2back = 0;
Byte lastInstr3back = 0;
Byte lastInstr4back = 0;
Byte lastInstr5back = 0;
Byte lastInstr6back = 0;
Byte lastInstr7back = 0;
Byte lastInstr8back = 0;
Byte lastInstr9back = 0;
Byte lastInstr10back = 0;
Byte lastInstr11back = 0;
Byte lastInstr12back = 0;
Byte lastInstr13back = 0;
Byte lastInstr14back = 0;
Byte lastInstr15back = 0;

Byte lastVolume0back = 0;
Byte lastVolume1back = 0;
Byte lastVolume2back = 0;
Byte lastVolume3back = 0;
Byte lastVolume4back = 0;
Byte lastVolume5back = 0;
Byte lastVolume6back = 0;
Byte lastVolume7back = 0;
Byte lastVolume8back = 0;
Byte lastVolume9back = 0;
Byte lastVolume10back = 0;
Byte lastVolume11back = 0;
Byte lastVolume12back = 0;
Byte lastVolume13back = 0;
Byte lastVolume14back = 0;
Byte lastVolume15back = 0;

Byte lastReverb0back = 0;
Byte lastReverb1back = 0;
Byte lastReverb2back = 0;
Byte lastReverb3back = 0;
Byte lastReverb4back = 0;
Byte lastReverb5back = 0;
Byte lastReverb6back = 0;
Byte lastReverb7back = 0;
Byte lastReverb8back = 0;
Byte lastReverb9back = 0;
Byte lastReverb10back = 0;
Byte lastReverb11back = 0;
Byte lastReverb12back = 0;
Byte lastReverb13back = 0;
Byte lastReverb14back = 0;
Byte lastReverb15back = 0;

Byte lastChorus0back = 0;
Byte lastChorus1back = 0;
Byte lastChorus2back = 0;
Byte lastChorus3back = 0;
Byte lastChorus4back = 0;
Byte lastChorus5back = 0;
Byte lastChorus6back = 0;
Byte lastChorus7back = 0;
Byte lastChorus8back = 0;
Byte lastChorus9back = 0;
Byte lastChorus10back = 0;
Byte lastChorus11back = 0;
Byte lastChorus12back = 0;
Byte lastChorus13back = 0;
Byte lastChorus14back = 0;
Byte lastChorus15back = 0;

Byte lastPanorama0back = 0;
Byte lastPanorama1back = 0;
Byte lastPanorama2back = 0;
Byte lastPanorama3back = 0;
Byte lastPanorama4back = 0;
Byte lastPanorama5back = 0;
Byte lastPanorama6back = 0;
Byte lastPanorama7back = 0;
Byte lastPanorama8back = 0;
Byte lastPanorama9back = 0;
Byte lastPanorama10back = 0;
Byte lastPanorama11back = 0;
Byte lastPanorama12back = 0;
Byte lastPanorama13back = 0;
Byte lastPanorama14back = 0;
Byte lastPanorama15back = 0;

Byte track0state = 0;
Byte track1state = 0;
Byte track2state = 0;
Byte track3state = 0;
Byte track4state = 0;
Byte track5state = 0;
Byte track6state = 0;
Byte track7state = 0;
Byte track8state = 0;
Byte track9state = 0;
Byte track10state = 0;
Byte track11state = 0;
Byte track12state = 0;
Byte track13state = 0;
Byte track14state = 0;
Byte track15state = 0;

Byte lastInstr0 = 255;
Byte lastInstr1 = 255;
Byte lastInstr2 = 255;
Byte lastInstr3 = 255;
Byte lastInstr4 = 255;
Byte lastInstr5 = 255;
Byte lastInstr6 = 255;
Byte lastInstr7 = 255;
Byte lastInstr8 = 255;
Byte lastInstr9 = 255;
Byte lastInstr10 = 255;
Byte lastInstr11 = 255;
Byte lastInstr12 = 255;
Byte lastInstr13 = 255;
Byte lastInstr14 = 255;
Byte lastInstr15 = 255;

Byte lastVolume0 = 255;
Byte lastVolume1 = 255;
Byte lastVolume2 = 255;
Byte lastVolume3 = 255;
Byte lastVolume4 = 255;
Byte lastVolume5 = 255;
Byte lastVolume6 = 255;
Byte lastVolume7 = 255;
Byte lastVolume8 = 255;
Byte lastVolume9 = 255;
Byte lastVolume10 = 255;
Byte lastVolume11 = 255;
Byte lastVolume12 = 255;
Byte lastVolume13 = 255;
Byte lastVolume14 = 255;
Byte lastVolume15 = 255;

Byte lastReverb0 = 255;
Byte lastReverb1 = 255;
Byte lastReverb2 = 255;
Byte lastReverb3 = 255;
Byte lastReverb4 = 255;
Byte lastReverb5 = 255;
Byte lastReverb6 = 255;
Byte lastReverb7 = 255;
Byte lastReverb8 = 255;
Byte lastReverb9 = 255;
Byte lastReverb10 = 255;
Byte lastReverb11 = 255;
Byte lastReverb12 = 255;
Byte lastReverb13 = 255;
Byte lastReverb14 = 255;
Byte lastReverb15 = 255;

Byte lastChorus0 = 255;
Byte lastChorus1 = 255;
Byte lastChorus2 = 255;
Byte lastChorus3 = 255;
Byte lastChorus4 = 255;
Byte lastChorus5 = 255;
Byte lastChorus6 = 255;
Byte lastChorus7 = 255;
Byte lastChorus8 = 255;
Byte lastChorus9 = 255;
Byte lastChorus10 = 255;
Byte lastChorus11 = 255;
Byte lastChorus12 = 255;
Byte lastChorus13 = 255;
Byte lastChorus14 = 255;
Byte lastChorus15 = 255;

Byte lastPanorama0 = 255;
Byte lastPanorama1 = 255;
Byte lastPanorama2 = 255;
Byte lastPanorama3 = 255;
Byte lastPanorama4 = 255;
Byte lastPanorama5 = 255;
Byte lastPanorama6 = 255;
Byte lastPanorama7 = 255;
Byte lastPanorama8 = 255;
Byte lastPanorama9 = 255;
Byte lastPanorama10 = 255;
Byte lastPanorama11 = 255;
Byte lastPanorama12 = 255;
Byte lastPanorama13 = 255;
Byte lastPanorama14 = 255;
Byte lastPanorama15 = 255;

Byte lastSlider2value = 255;
Byte lastSlider4value = 255;
Byte lastSlider6value = 255;
Byte lastSlider7value = 255;
Byte lastSlider8value = 255;

Byte lastSlider2value00 = 255;
Byte lastSlider4value00 = 255;
Byte lastSlider6value00 = 255;
Byte lastSlider7value00 = 255;
Byte lastSlider8value00 = 255;

Byte lastSlider2value01 = 255;
Byte lastSlider4value01 = 255;
Byte lastSlider6value01 = 255;
Byte lastSlider7value01 = 255;
Byte lastSlider8value01 = 255;

Byte lastSlider2value02 = 255;
Byte lastSlider4value02 = 255;
Byte lastSlider6value02 = 255;
Byte lastSlider7value02 = 255;
Byte lastSlider8value02 = 255;

Byte lastSlider2value03 = 255;
Byte lastSlider4value03 = 255;
Byte lastSlider6value03 = 255;
Byte lastSlider7value03 = 255;
Byte lastSlider8value03 = 255;

Byte lastSlider2value04 = 255;
Byte lastSlider4value04 = 255;
Byte lastSlider6value04 = 255;
Byte lastSlider7value04 = 255;
Byte lastSlider8value04 = 255;

Byte lastSlider2value05 = 255;
Byte lastSlider4value05 = 255;
Byte lastSlider6value05 = 255;
Byte lastSlider7value05 = 255;
Byte lastSlider8value05 = 255;

Byte lastSlider2value06 = 255;
Byte lastSlider4value06 = 255;
Byte lastSlider6value06 = 255;
Byte lastSlider7value06 = 255;
Byte lastSlider8value06 = 255;

Byte lastSlider2value07 = 255;
Byte lastSlider4value07 = 255;
Byte lastSlider6value07 = 255;
Byte lastSlider7value07 = 255;
Byte lastSlider8value07 = 255;

Byte lastSlider2value08 = 255;
Byte lastSlider4value08 = 255;
Byte lastSlider6value08 = 255;
Byte lastSlider7value08 = 255;
Byte lastSlider8value08 = 255;

Byte lastSlider2value09 = 255;
Byte lastSlider4value09 = 255;
Byte lastSlider6value09 = 255;
Byte lastSlider7value09 = 255;
Byte lastSlider8value09 = 255;

Byte lastSlider2value10 = 255;
Byte lastSlider4value10 = 255;
Byte lastSlider6value10 = 255;
Byte lastSlider7value10 = 255;
Byte lastSlider8value10 = 255;

Byte lastSlider2value11 = 255;
Byte lastSlider4value11 = 255;
Byte lastSlider6value11 = 255;
Byte lastSlider7value11 = 255;
Byte lastSlider8value11 = 255;

Byte lastSlider2value12 = 255;
Byte lastSlider4value12 = 255;
Byte lastSlider6value12 = 255;
Byte lastSlider7value12 = 255;
Byte lastSlider8value12 = 255;

Byte lastSlider2value13 = 255;
Byte lastSlider4value13 = 255;
Byte lastSlider6value13 = 255;
Byte lastSlider7value13 = 255;
Byte lastSlider8value13 = 255;

Byte lastSlider2value14 = 255;
Byte lastSlider4value14 = 255;
Byte lastSlider6value14 = 255;
Byte lastSlider7value14 = 255;
Byte lastSlider8value14 = 255;

Byte lastSlider2value15 = 255;
Byte lastSlider4value15 = 255;
Byte lastSlider6value15 = 255;
Byte lastSlider7value15 = 255;
Byte lastSlider8value15 = 255;

bool slider2mustSend = TRUE;
bool slider4mustSend = TRUE;
bool slider6mustSend = TRUE;
bool slider7mustSend = TRUE;
bool slider8mustSend = TRUE;

NSMutableArray *instruments;
NSURL *presetURL0;
NSURL *presetURL1;
NSURL *presetURL2;
bool fileInstruments0Exists = FALSE;
bool fileInstruments1Exists = FALSE;
bool fileInstruments2Exists = FALSE;
NSString *MbGMStereo = @"";

bool switchSoundBankstate = 0;

AudioClass * at0;
AudioClass * at1;
AudioClass * at2;
AudioClass * at3;
AudioClass * at4;
AudioClass * at5;
AudioClass * at6;
AudioClass * at7;
AudioClass * at8;
AudioClass * at9;
AudioClass * at10;
AudioClass * at11;
AudioClass * at12;
AudioClass * at13;
AudioClass * at14;
AudioClass * at15;

bool auInitilisationDone = FALSE;

NSString *sf2_File = @"";
NSString *messageText = @"";
UIAlertView *alert;
UIAlertView *alertAudio;
UIAlertView *loadMapAlert;
UIAlertView *saveMapAlert;
UIAlertView *saveIniAlert;

NSFileManager *fileManager;

MusicSequence musicSequence;
MusicPlayer musicPlayer;

MIDIPacketList packetList;
MIDIPacket *firstPacket;

MIDIPacket *packet;
MIDIPacket packet2;

OSStatus result = noErr;
MIDIEndpointRef virtualEndpoint;

UInt16 nBytes = 0;
UInt16 iByte = 0;
UInt16 nBytes2 = 0;
UInt16 iByte2 = 0;

int inppoint = 0;
int outpoint = 0;
int inppoint2 = 0;
int outpoint2 = 0;

int bufsize = 2048;
Byte inputBuffer[2048];
Byte tempBuffer[256];
Byte sysexMessages[1024];
int bufsize2 = 2048;
Byte inputBuffer2[2048];
Byte tempBuffer2[256];
Byte sysexMessages2[1024];
Byte tempBuffer3[256];

Byte inputByte = 0;
Byte byteToAnalyze = 0;
Byte statusByte = 0;
int countBytes = 0;
Byte inputByte2 = 0;
Byte byteToAnalyze2 = 0;
Byte statusByte2 = 0;
int countBytes2 = 0;
Byte inputByte3 = 0;
Byte byteToAnalyze3 = 0;
Byte statusByte3 = 0;
int countBytes3 = 0;

int counterSYSEX = 0;
bool isSYSEX = FALSE;
NSString *tempSYSEX = @"";
bool statusSYSEX = FALSE;
int counterSYSEX2 = 0;
bool isSYSEX2 = FALSE;
NSString *tempSYSEX2 = @"";
bool statusSYSEX2 = FALSE;
int counterSYSEX3 = 0;
bool isSYSEX3 = FALSE;
NSString *tempSYSEX3 = @"";
bool statusSYSEX3 = FALSE;

Byte midiChannelTemp = 0;
Byte midiStatus = 0;
Byte midiCommand = 0;
Byte midiChan = 0;
Byte note2 = 0;
Byte velocity2 = 0;
Byte midiChannelTemp2 = 0;
Byte midiChannelTemp3 = 0;
Byte channelInfoTemp = 0;

Byte defaultInstru = 0;
Byte defaultVolume = 127;
Byte defaultReverb = 40;
Byte defaultChorus = 0;
Byte defaultPanora = 64;

NSTimer *inputTreatTimer;
NSTimer *timerEnd;
NSTimer *timerforAllNotesOff;
NSTimer *timerforAllNotesOffChannel;
NSTimer *notifyTimer;
NSTimer *buttonStopTimer;
NSTimer *timerforScrollView;
NSTimer *oneShotTimerChordHide;
NSTimer *blinkTimer;
NSTimer *audioUsed;
NSTimer *timerForRealTime;

NSString *tempText = @"";

MusicTimeStamp len;
int counterTimer = 0;

NSString *notifyMessage = @"";

NSString *midiFilePath = @"";
NSString *midiFileWritePath = @"";
NSArray *dirFiles;
NSArray *dirFilesInbox;
NSArray *listArrayTemp;
NSArray *sortedArray;
int listArrayCount = 0;

OSStatus s;
MIDIClientRef client;
MIDIPortRef outputPort = 0;
MIDIPortRef inputPort = 0;
MIDIEndpointRef destMIDI;
MIDIEndpointRef sourceMIDI;
MIDIEndpointRef outputEndpoint;
MIDIThruConnectionRef thruConnectionRef;
MIDIThruConnectionParams thruParams;
CFDataRef data;

int deviceIDdest = -1;
int deviceIDsource = -1;

NSMutableArray *arrayForComboBox1;
NSMutableArray *arrayForComboBox2;

int countComboBox1 = 0;
int countComboBox2 = 0;

Byte track0stateBack = 0;
Byte track1stateBack = 0;
Byte track2stateBack = 0;
Byte track3stateBack = 0;
Byte track4stateBack = 0;
Byte track5stateBack = 0;
Byte track6stateBack = 0;
Byte track7stateBack = 0;
Byte track8stateBack = 0;
Byte track9stateBack = 0;
Byte track10stateBack = 0;
Byte track11stateBack = 0;
Byte track12stateBack = 0;
Byte track13stateBack = 0;
Byte track14stateBack = 0;
Byte track15stateBack = 0;

Byte controllerByte = 0;
Byte tempVariable = 0;

MIDIChannelMessage channelMessage;
MIDINoteMessage noteMessage;
MIDIRawData *sysexData;
MIDIRawData *sysexData2;
MIDIMetaEvent metaDataEvent;
MusicTimeStamp timeStamp = 0;
MusicSequence recordSequence;
MusicTrack recordTrack;
MusicTimeStamp lenRec = 0;

long secTempA = 0;
float secTempB = 0;
long secStartA = 0;
float secStartB = 0;
bool toggleColor = FALSE;
NSString *lastNotifyMessage = @"";
float greyValue = 0.6;

NSUserDefaults *userPreferences;
bool dataSaved;

UIAlertView *deleteAlert;
UIAlertView *iPadAlert;

float timerIntervall = 0;
float counterIntervall = 0;
int textFieldHeight = 0;
NSString *fileNameForSave = @"";

UIAlertView *infoStore;
UIAlertView *infoStoreError;
MusicTrack track;

const NSString *textForNoFiles = @"No MIDI files in shared iTunes folder !";

Byte success = 0xFF;
NSString *tempDirfrom = @"";
NSString *tempDirTo = @"";
NSString *inboxPath = @"";

Byte channelSelection = 0;
bool toggleColorS = FALSE;
bool visible = FALSE;

Byte timerDivisor = 0;
Byte timerDivisorSettings = 0;

bool sliderValuesHaveChanged = FALSE;

int inppointSettings = 0;
int outpointSettings = 0;
int bufsizeSettings = 1024;
Byte inputBufferSettings[1024];

Byte lastTrackTemp = 0;
bool ignoreLast = FALSE;

bool is_IPAD = FALSE;
bool is_IPHONE = TRUE;
bool is_IPHONE_5 = FALSE;

bool iPadA6 = TRUE;
bool iPadQuestionAnswered = FALSE;

bool inBackground = FALSE;
bool backgroundPlayAllowed = FALSE;
bool audioUsedInBackground = FALSE;
bool mustEnableDivers = FALSE;

int maxChordPointerBaseVal = 2632;
NSString *chordTypeBase[2634];  // max chordTypeBase + 2

int maxChordPointerVal = 2213;
NSString *chordType[2215];     // maxChordPointerVal + 2

Byte last12notes[16][12][2];
Byte chordChannel = 0;
Byte lowestNoteChord = 0;
Byte tempChordTag = 0;
Byte tempChordTagLast1 = 0;
Byte tempChordTagLast2 = 0;
Byte tempChordNote = 0;
NSString *notesForText[12];
Byte channelForShowChord = 0xFF;
Byte bufferForChord[255][3];
Byte inppointBut = 0;
Byte outpointBut = 0;
Byte bufsizeBut = 255;
int chordPointer = 0;
bool doChordDetect = FALSE;
bool labelChordBigState = FALSE;
NSString *labelChordBigText = @"";
Byte starPointer = 0;

bool backFromOtherView = FALSE;

CGSize screenSize;
CGRect screenBound;

NSString *midiFilenameWithoutExt;
bool nameChanged;
bool searchModeP = FALSE;
int indexOfTheObjectP = -1;
int numberOfIndexesP = 0;
int indexCounterP = 0;

NSArray *resultsearchP;
UIAlertView *alertNotfoundP;
UIAlertView *alertP;
NSString *fileNameSA;

NSNumberFormatter *numberFormatter;
float batteryLevel = 0.0;

bool autoNext = FALSE;
NSString *openURLstring = @"";

int bankSel = 0;
int instSel = 0;
NSString *instrName = @"";
int GMinstr[128];
bool mapGMplayer = FALSE;

int drumSet = 0;
Byte lastPort = 0;
Byte originMIDItemp = 0;
Byte masterVolumeValue = 127;
bool channels32Mode = FALSE;      // "0xF3 ..." is sent for channel switching (0xF5 ... does not work with MIDI interfaces) needs additional hardware

UIAlertView *alertOptions;
UIAlertView *defaultAlert;

MIDIPortRef outputPortLast = 0;
MIDIPortRef inputPortLast = 0;
MIDIEndpointRef destMIDIlast;
MIDIEndpointRef sourceMIDIlast;

bool drumSet0 = TRUE;
NSString *filePathS;
bool mustRefreshOption = FALSE;

bool sendStartContinueStop = FALSE;
bool receiveStartContinueStop = FALSE;
bool nextNotSend = FALSE;

float startPoint = 0;
float endPoint = 0;
bool isLoop = FALSE;
NSString *lastPlayedMIDIfileName = @"";

ViewControllerPad *viewContPad;
ViewController *viewCont;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.

    if ([[UIDevice currentDevice].model hasPrefix:@"iPhone"] || [[UIDevice currentDevice].model hasPrefix:@"iPod"]) {
        is_IPHONE = TRUE;
    }
    if ([[UIDevice currentDevice].model hasPrefix:@"iPad"]) {
        is_IPAD = TRUE;
    }
    
    CGSize displaySize = [[UIScreen mainScreen] bounds].size;
    if (displaySize.height >= 568.0f) {
        is_IPHONE_5 = TRUE;
    }
        
    userPreferences = [NSUserDefaults standardUserDefaults];
    backgroundPlayAllowed = [userPreferences boolForKey:@"backgroundPlayAllowed"];
    [userPreferences synchronize];
    
    if (is_IPHONE) {
        viewCont=[[ViewController alloc]init];
    }
    else {
        viewContPad=[[ViewControllerPad alloc]init];
    }
    
    // Get documents Directory
    // (don't forget the ".plist" entry "Application supports iTunes file sharing YES"
    NSArray *pathDocDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDirectoryPath = [pathDocDir objectAtIndex:0];
    fileInstruments1Exists = FALSE;
    fileInstruments2Exists = FALSE;
    
    [self fillInInstruments];
    [self fillInChords];
    selectedIndex = 0;
    
    [self gmMIDIreset];
    
    if (backgroundPlayAllowed) {
        [self setBackGroundAllowed:TRUE];
    }
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    NSUInteger location = [[url path] rangeOfString:[[url path] lastPathComponent]].location;
    openURLstring = [[url path] substringToIndex:location-1];
    
    if ([[url pathExtension] isEqual: @"midi"] || [[url pathExtension] isEqual: @"MID"] || [[url pathExtension] isEqual: @"mid"]) {
    }
    else {
        alert = [[UIAlertView alloc]initWithTitle: [NSString stringWithFormat:@"Filename not valid\n%@", [[url path] lastPathComponent]]
                                          message: @"\nThis App can only play MIDI files (*.midi, *.MID, *.mid)"
                                         delegate: self
                                cancelButtonTitle: nil
                                otherButtonTitles: @"OK",nil];
        [alert show];
    }
    if (is_IPHONE) {
        [viewCont buttonStopPressed:nil];
        [viewCont setParseDir];
    }
    else {
        [viewContPad buttonStopPressed:nil];
        [viewContPad setParseDirPad];
    }
    return true;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    inBackground = TRUE;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    inBackground = TRUE;
    mustEnableDivers = TRUE;
    if (!backgroundPlayAllowed) {
        if (is_IPHONE) {
            [viewCont buttonStopPressed:nil];
        }
        else {
            [viewContPad buttonStopPressed:nil];
        }
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    if (backgroundPlayAllowed && inBackground && audioUsedInBackground) {
        inBackground = FALSE;
        mustEnableDivers = TRUE;
        if (is_IPHONE) {
            [viewCont buttonStopPressed:nil];
        }
        else {
            [viewContPad buttonStopPressed:nil];
        }
        
        if (switchLocalSoundState) {
            UIAlertView *alertAudio = [[UIAlertView alloc]initWithTitle: @"Warning"
                                                                message: @"Audio was used from an other application! Please close and restart 'MFP' to heare local sounds."
                                                               delegate: self
                                                      cancelButtonTitle: nil
                                                      otherButtonTitles:@"OK",nil];
            [alertAudio show];
        }
    }
    
    else if (viewControllerSettingsIsVisible || viewControllerHelpIsVisible || pickerViewIsVisible) {
        UIAlertView *backAlert = [[UIAlertView alloc]initWithTitle: @"Information:"
                                                           message: [NSString stringWithFormat:@"%@", @"Please go back to the main page (not settings) for correct program functionality."]
                                                          delegate: self
                                                 cancelButtonTitle: @"OK"
                                                 otherButtonTitles: nil, nil];
        [backAlert show];
    }

    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    if (is_IPHONE) {
        [viewCont setParseDir];
    }
    else {
        [viewContPad setParseDirPad];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
}

- (void) setBackGroundAllowed :(bool)isAllowed {
    NSError *sessionError = nil;
    NSError *activationError = nil;
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error:&sessionError];
    [[AVAudioSession sharedInstance] setActive: isAllowed error: &activationError];
}

- (void) auInitialisations {
    auInitilisationDone = FALSE;
    fileInstruments0Exists = FALSE;
    fileInstruments1Exists = FALSE;
    fileInstruments2Exists = FALSE;
    MbGMStereo = @"other";
    sf2_File = [documentsDirectoryPath stringByAppendingPathComponent:@"GM_instruments.sf2"]; // if exists, use this
    fileInstruments0Exists = [fileManager fileExistsAtPath:sf2_File];
    
    if (fileInstruments0Exists){
        presetURL0 = [[NSURL alloc] initFileURLWithPath:sf2_File];
        presetURL1 = [[NSURL alloc] initFileURLWithPath:sf2_File];
        presetURL2 = [[NSURL alloc] initFileURLWithPath:sf2_File];
    }
    else {
        @try {
            presetURL1 = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"32MbGMStereo" ofType:@"sf2"]];
            MbGMStereo = @"32MbGMStereo";
            fileInstruments1Exists = TRUE;
        }
        @catch (NSException *exception) {
        }
        
        @try {
            presetURL2 = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Scc1t2" ofType:@"sf2"]];
            fileInstruments2Exists = TRUE;
        }
        @catch (NSException *exception) {
        }
        
        if (!fileInstruments0Exists && !fileInstruments1Exists && !fileInstruments2Exists && !initWasDone){
            messageText = [NSString stringWithFormat:@"%@", @"No sound font file found in the shared iTunes App folder. Please provide a 'General MIDI instruments' sound font (e.g. from the internet at your own responsability: '32MbGMStereo.sf2' or 'fluid_gm.sf2' or 'bennetng_AnotherGS_v2-1.sf2' or 'Scc1t2.sf2') and rename it to 'GM_instruments.sf2'."];
            alert = [[UIAlertView alloc]initWithTitle: @"Info: No local sound available"
                                              message: messageText
                                             delegate: self
                                    cancelButtonTitle: nil
                                    otherButtonTitles:@"OK",nil];
            [alert show];
        }
    }
    
    if ((fileInstruments0Exists || fileInstruments1Exists || fileInstruments2Exists)){
        
        at0 = [AudioClass audioClass];
        [at0 audioInit];
        [at0 setInstrument :0 :-1];
        
        at1 = [AudioClass audioClass];
        [at1 audioInit];
        [at1 setInstrument :0 :-1];
        
        at2 = [AudioClass audioClass];
        [at2 audioInit];
        [at2 setInstrument :0 :-1];
        
        at3 = [AudioClass audioClass];
        [at3 audioInit];
        [at3 setInstrument :0 :-1];
        
        at4 = [AudioClass audioClass];
        [at4 audioInit];
        [at4 setInstrument :0 :-1];
        
        at5 = [AudioClass audioClass];
        [at5 audioInit];
        [at5 setInstrument :0 :-1];
        
        at6 = [AudioClass audioClass];
        [at6 audioInit];
        [at6 setInstrument :0 :-1];
        
        at7 = [AudioClass audioClass];
        [at7 audioInit];
        [at7 setInstrument :0 :-1];
        
        at8 = [AudioClass audioClass];
        [at8 audioInit];
        [at8 setInstrument :0 :-1];
        
        at9 = [AudioClass audioClass]; // drum channel  ! ! !
        [at9 audioInit9];
        
        at10 = [AudioClass audioClass];
        [at10 audioInit];
        [at10 setInstrument :0 :-1];
        
        at11 = [AudioClass audioClass];
        [at11 audioInit];
        [at11 setInstrument :0 :-1];
        
        at12 = [AudioClass audioClass];
        [at12 audioInit];
        [at12 setInstrument :0 :-1];
        
        at13 = [AudioClass audioClass];
        [at13 audioInit];
        [at13 setInstrument :0 :-1];
        
        at14 = [AudioClass audioClass];
        [at14 audioInit];
        [at14 setInstrument :0 :-1];
        
        at15 = [AudioClass audioClass];
        [at15 audioInit];
        [at15 setInstrument :0 :-1];
        
        lastInstr0back = 0;
        lastInstr1back = 0;
        lastInstr2back = 0;
        lastInstr3back = 0;
        lastInstr4back = 0;
        lastInstr5back = 0;
        lastInstr6back = 0;
        lastInstr7back = 0;
        lastInstr8back = 0;
        lastInstr9back = 0;
        lastInstr10back = 0;
        lastInstr11back = 0;
        lastInstr12back = 0;
        lastInstr13back = 0;
        lastInstr14back = 0;
        lastInstr15back = 0;
        
        [viewCont resetLastControllers];
        
        auInitilisationDone = TRUE;
    }
    if (audioUsed) {
        [audioUsed invalidate];
        audioUsed = nil;
    }
    //audioUsed = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(forCheckAudioUsed)userInfo:nil repeats:YES];
}

- (void) forCheckAudioUsed {
    if (backgroundPlayAllowed && inBackground && !audioUsedInBackground) {
        if ([[AVAudioSession sharedInstance] isOtherAudioPlaying]) {
            audioUsedInBackground = TRUE;
            [audioUsed invalidate];
            audioUsed = nil;
        }
    }
}

- (void) auInitialisationsOff {    
    auInitilisationDone = FALSE;
}

//F0 7E 7F 09 01 F7    GM Reset
- (void) gmMIDIreset {
    counterSYSEX = 0;
    sysexMessages[counterSYSEX] = 0xF0;
    counterSYSEX++;
    sysexMessages[counterSYSEX] = 0x7E;
    counterSYSEX++;
    sysexMessages[counterSYSEX] = 0x7F;
    counterSYSEX++;
    sysexMessages[counterSYSEX] = 0x09;
    counterSYSEX++;
    sysexMessages[counterSYSEX] = 0x01;
    counterSYSEX++;
    sysexMessages[counterSYSEX] = 0xF7;
    [self sendSYSEX];
    
}

- (NSString*) getDateTimeString {
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
    
    return [NSString stringWithFormat:@"__%04d_%02d_%02d__%02d_%02d_%02d", year, month, day, hours, minutes, seconds];
}

- (void) fillInInstruments {
    
    instruments = [[NSMutableArray alloc] init];
    
    [instruments addObject:@"0  Acoustic Grand Piano"];
    [instruments addObject:@"1  Bright Acoustic Piano"];
    [instruments addObject:@"2  Electric Grand Piano"];
    [instruments addObject:@"3  Honky-tonk Piano"];
    [instruments addObject:@"4  Electric Piano 1"];
    [instruments addObject:@"5  Electric Piano 2"];
    [instruments addObject:@"6  Harpsichord"];
    [instruments addObject:@"7  Clavi"];
    [instruments addObject:@"8  Celesta"];
    [instruments addObject:@"9  Glockenspiel"];
    [instruments addObject:@"10  Music Box"];
    [instruments addObject:@"11  Vibraphone"];
    [instruments addObject:@"12  Marimba"];
    [instruments addObject:@"13  Xylophone"];
    [instruments addObject:@"14  Tubular Bells"];
    [instruments addObject:@"15  Dulcimer"];
    [instruments addObject:@"16  Drawbar Organ"];
    [instruments addObject:@"17  Percussive Organ"];
    [instruments addObject:@"18  Rock Organ"];
    [instruments addObject:@"19  Church Organ"];
    [instruments addObject:@"20  Reed Organ"];
    [instruments addObject:@"21  Accordion"];
    [instruments addObject:@"22  Harmonica"];
    [instruments addObject:@"23  Tango Accordion"];
    [instruments addObject:@"24  Acoustic Guitar (nylon)"];
    [instruments addObject:@"25  Acoustic Guitar (steel)"];
    [instruments addObject:@"26  Electric Guitar (jazz)"];
    [instruments addObject:@"27  Electric Guitar (clean)"];
    [instruments addObject:@"28  Electric Guitar (muted)"];
    [instruments addObject:@"29  Overdriven Guitar"];
    [instruments addObject:@"30  Distortion Guitar"];
    [instruments addObject:@"31  Guitar harmonics"];
    [instruments addObject:@"32  Acoustic Bass"];
    [instruments addObject:@"33  Electric Bass (finger)"];
    [instruments addObject:@"34  Electric Bass (pick)"];
    [instruments addObject:@"35  Fretless Bass"];
    [instruments addObject:@"36  Slap Bass 1"];
    [instruments addObject:@"37  Slap Bass 2"];
    [instruments addObject:@"38  Synth Bass 1"];
    [instruments addObject:@"39  Synth Bass 2"];
    [instruments addObject:@"40  Violin"];
    [instruments addObject:@"41  Viola"];
    [instruments addObject:@"42  Cello"];
    [instruments addObject:@"43  Contrabass"];
    [instruments addObject:@"44  Tremolo Strings"];
    [instruments addObject:@"45  Pizzicato Strings"];
    [instruments addObject:@"46  Orchestral Harp"];
    [instruments addObject:@"47  Timpani"];
    [instruments addObject:@"48  String Ensemble 1"];
    [instruments addObject:@"49  String Ensemble 2"];
    [instruments addObject:@"50  Synth Strings 1"];
    [instruments addObject:@"51  Synth Strings 2"];
    [instruments addObject:@"52  Voice Aahs"];
    [instruments addObject:@"53  Voice Oohs"];
    [instruments addObject:@"54  Synth Voice"];
    [instruments addObject:@"55  Orchestra Hit"];
    [instruments addObject:@"56  Trumpet"];
    [instruments addObject:@"57  Trombone"];
    [instruments addObject:@"58  Tuba"];
    [instruments addObject:@"59  Muted Trumpet"];
    [instruments addObject:@"60  French Horn"];
    [instruments addObject:@"61  Brass Section"];
    [instruments addObject:@"62  Synth Brass 1"];
    [instruments addObject:@"63  Synth Brass 2"];
    [instruments addObject:@"64  Soprano Sax"];
    [instruments addObject:@"65  Alto Sax"];
    [instruments addObject:@"66  Tenor Sax"];
    [instruments addObject:@"67  Baritone Sax"];
    [instruments addObject:@"68  Oboe"];
    [instruments addObject:@"69  English Horn"];
    [instruments addObject:@"70  Bassoon"];
    [instruments addObject:@"71  Clarinet"];
    [instruments addObject:@"72  Piccolo"];
    [instruments addObject:@"73  Flute"];
    [instruments addObject:@"74  Recorder"];
    [instruments addObject:@"75  Pan Flute"];
    [instruments addObject:@"76  Blown Bottle"];
    [instruments addObject:@"77  Shakuhachi"];
    [instruments addObject:@"78  Whistle"];
    [instruments addObject:@"79  Ocarina"];
    [instruments addObject:@"80  Lead 1 (square)"];
    [instruments addObject:@"81  Lead 2 (sawtooth)"];
    [instruments addObject:@"82  Lead 3 (calliope)"];
    [instruments addObject:@"83  Lead 4 (chiff)"];
    [instruments addObject:@"84  Lead 5 (charang)"];
    [instruments addObject:@"85  Lead 6 (voice)"];
    [instruments addObject:@"86  Lead 7 (fifths)"];
    [instruments addObject:@"87  Lead 8 (bass+lead)"];
    [instruments addObject:@"88  Pad 1 (new age)"];
    [instruments addObject:@"89  Pad 2 (warm)"];
    [instruments addObject:@"90  Pad 3 (polysynth)"];
    [instruments addObject:@"91  Pad 4 (choir)"];
    [instruments addObject:@"92  Pad 5 (bowed)"];
    [instruments addObject:@"93  Pad 6 (metallic)"];
    [instruments addObject:@"94  Pad 7 (halo)"];
    [instruments addObject:@"95  Pad 8 (sweep)"];
    [instruments addObject:@"96  FX 1 (rain)"];
    [instruments addObject:@"97  FX 2 (soundtrack)"];
    [instruments addObject:@"98  FX 3 (crystal)"];
    [instruments addObject:@"99  FX 4 (atmosphere)"];
    [instruments addObject:@"100  FX 5 (brightness)"];
    [instruments addObject:@"101  FX 6 (goblins)"];
    [instruments addObject:@"102  FX 7 (echoes)"];
    [instruments addObject:@"103  FX 8 (sci-fi)"];
    [instruments addObject:@"104  Sitar"];
    [instruments addObject:@"105  Banjo"];
    [instruments addObject:@"106  Shamisen"];
    [instruments addObject:@"107  Koto"];
    [instruments addObject:@"108  Kalimba"];
    [instruments addObject:@"109  Bagpipe"];
    [instruments addObject:@"110  Fiddle"];
    [instruments addObject:@"111  Shanai"];
    [instruments addObject:@"112  Tinkle Bell"];
    [instruments addObject:@"113  Agogo Bells"];
    [instruments addObject:@"114  Steel Drums"];
    [instruments addObject:@"115  Woodblock"];
    [instruments addObject:@"116  Taiko Drum"];
    [instruments addObject:@"117  Melodic Tom"];
    [instruments addObject:@"118  Synth Drum"];
    [instruments addObject:@"119  Reverse Cymbal"];
    [instruments addObject:@"120  Guitar Fret Noise"];
    [instruments addObject:@"121  Breath Noise"];
    [instruments addObject:@"122  Seashore"];
    [instruments addObject:@"123  Bird Tweet"];
    [instruments addObject:@"124  Telephone Ring"];
    [instruments addObject:@"125  Helicopter"];
    [instruments addObject:@"126  Applause"];
    [instruments addObject:@"127  Gunshot"];
    
}

void MyMIDINotifyProc (const MIDINotification  *message, void *refCon) {
    //    printf("MIDI Notify, messageId=%ld,", message->messageID);
    if (message->messageID == kMIDIMsgObjectAdded) {
        notifyMessage = @"MIDI device added or changed";
    }
    else if (message->messageID == kMIDIMsgObjectRemoved) {
        notifyMessage = @"MIDI device removed";
    }
    else if (message->messageID == kMIDIMsgPropertyChanged) {
        notifyMessage = @"MIDI property changed";
    }
    else if (message->messageID == kMIDIMsgThruConnectionsChanged) {
        notifyMessage = @"MIDI Thru connections changed";
    }
    else if (message->messageID == kMIDIMsgSerialPortOwnerChanged) {
        notifyMessage = @"MIDI Serial Port owner changed";
    }
}

NSString *getDisplayName(MIDIObjectRef object) {
    // Returns the display name of a given MIDIObjectRef as an NSString
    CFStringRef name = nil;
    if (noErr != MIDIObjectGetStringProperty(object, kMIDIPropertyDisplayName, &name))
        return nil;
    return (__bridge NSString *)name;
}

- (void) setDefault0 {
    lastInstr0 = 0;
    lastVolume0 = 127;
    lastReverb0 = 40;
    lastChorus0 = 0;
    lastPanorama0 = 64;
}
- (void) setDefault1 {
    lastInstr1 = 0;
    lastVolume1 = 127;
    lastReverb1 = 40;
    lastChorus1 = 0;
    lastPanorama1 = 64;
}
- (void) setDefault2 {
    lastInstr2 = 0;
    lastVolume2 = 127;
    lastReverb2 = 40;
    lastChorus2 = 0;
    lastPanorama2 = 64;
}
- (void) setDefault3 {
    lastInstr3 = 0;
    lastVolume3 = 127;
    lastReverb3 = 40;
    lastChorus3 = 0;
    lastPanorama3 = 64;
}
- (void) setDefault4 {
    lastInstr4 = 0;
    lastVolume4 = 127;
    lastReverb4 = 40;
    lastChorus4 = 0;
    lastPanorama4 = 64;
}
- (void) setDefault5 {
    lastInstr5 = 0;
    lastVolume5 = 127;
    lastReverb5 = 40;
    lastChorus5 = 0;
    lastPanorama5 = 64;
}
- (void) setDefault6 {
    lastInstr6 = 0;
    lastVolume6 = 127;
    lastReverb6 = 40;
    lastChorus6 = 0;
    lastPanorama6 = 64;
}
- (void) setDefault7 {
    lastInstr7 = 0;
    lastVolume7 = 127;
    lastReverb7 = 40;
    lastChorus7 = 0;
    lastPanorama7 = 64;
}
- (void) setDefault8 {
    lastInstr8 = 0;
    lastVolume8 = 127;
    lastReverb8 = 40;
    lastChorus8 = 0;
    lastPanorama8 = 64;
}
- (void) setDefault9 {
    lastInstr9 = 0;
    lastVolume9 = 127;
    lastReverb9 = 40;
    lastChorus9 = 0;
    lastPanorama9 = 64;
}
- (void) setDefault10 {
    lastInstr10 = 0;
    lastVolume10 = 127;
    lastReverb10 = 40;
    lastChorus10 = 0;
    lastPanorama10 = 64;
}
- (void) setDefault11 {
    lastInstr11 = 0;
    lastVolume11 = 127;
    lastReverb11 = 40;
    lastChorus11 = 0;
    lastPanorama11 = 64;
}
- (void) setDefault12 {
    lastInstr12 = 0;
    lastVolume12 = 127;
    lastReverb12 = 40;
    lastChorus12 = 0;
    lastPanorama12 = 64;
}
- (void) setDefault13 {
    lastInstr13 = 0;
    lastVolume13 = 127;
    lastReverb13 = 40;
    lastChorus13 = 0;
    lastPanorama13 = 64;
}
- (void) setDefault14 {
    lastInstr14 = 0;
    lastVolume14 = 127;
    lastReverb14 = 40;
    lastChorus14 = 0;
    lastPanorama14 = 64;
}
- (void) setDefault15 {
    lastInstr15 = 0;
    lastVolume15 = 127;
    lastReverb15 = 40;
    lastChorus15 = 0;
    lastPanorama15 = 64;
}

- (void) clearDiversBuffers {
    for (int iB = 0; iB < 256; iB++) {
        bufferForChord[iB][0] = 0;
        bufferForChord[iB][1] = 0;
        bufferForChord[iB][2] = 0;
    }
    inppointBut = 0;
    outpointBut = 0;
    
    for (int ccc = 0; ccc < 16; ccc++) {
        for (int cc = 0; cc < 12; cc++) {
            last12notes[ccc][cc][0] = 0;
            last12notes[ccc][cc][1] = 0;
        }
    }
    for (int iCh = 0; iCh < 16; iCh++) {
        tempAllNoteOff[iCh]= 1;
    }
    labelChordBigState = TRUE;
    labelChordBigText = @"";
}

- (void) fillInChords {
    notesForText[0]  = @"C ";
    notesForText[1]  = @"C#(Db) ";
    notesForText[2]  = @"D ";
    notesForText[3]  = @"D#(Eb) ";
    notesForText[4]  = @"E ";
    notesForText[5]  = @"F ";
    notesForText[6]  = @"F#(Gb) ";
    notesForText[7]  = @"G ";
    notesForText[8]  = @"G#(Ab) ";
    notesForText[9]  = @"A ";
    notesForText[10] = @"A#(Bb) ";
    notesForText[11] = @"B ";
    
    chordType[145]   = @"maj";
    chordType[137]   = @"min";
    chordType[1169]  = @"7";
    chordType[1041]  = @"7";
    chordType[585]   = @"7dim";
    chordType[2193]  = @"maj7";
    chordType[1161]  = @"min7";
    chordType[2185]  = @"minmaj7";
    chordType[161]   = @"sus4";
    chordType[657]   = @"6";
    chordType[1173]  = @"9";
    chordType[1165]  = @"min9";
    chordType[2197]  = @"maj9";
    chordType[2189]  = @"minmaj9";
    chordType[1197]  = @"min11";
    chordType[1573]  = @"13";
    chordType[149]   = @"add9";
    chordType[141]   = @"minadd9";
    chordType[661]   = @"6add9";
    chordType[653]   = @"min6add9";
    chordType[1193]  = @"min7add11";
    chordType[1681]  = @"dom7add13";
    chordType[1105]  = @"7b5";
    chordType[1297]  = @"7#5";
    chordType[1171]  = @"7b9";
    chordType[1177]  = @"7#9";
    chordType[1305]  = @"7#5b9";
    chordType[1097]  = @"min7b5";
    chordType[1237]  = @"9#11";
    chordType[1425]  = @"9b13";
    chordType[1185]  = @"7sus4";
    chordType[1189]  = @"9sus4";
    chordType[2213]  = @"maj9sus4"; // maxChordPointerVal !!!
    
    chordTypeBase[145]   = @"C maj";
    chordTypeBase[137]   = @"C min";
    chordTypeBase[1041]  = @"C 7";
    chordTypeBase[1169]  = @"C 7";
    chordTypeBase[1153]  = @"C 7";
    
    chordTypeBase[290]   = @"C#(Db) maj";
    chordTypeBase[274]   = @"C#(Db) min";
    chordTypeBase[2082]  = @"C#(Db) 7";
    chordTypeBase[2338]  = @"C#(Db) 7";
    chordTypeBase[2306]  = @"C#(Db) 7";
    
    chordTypeBase[580]   = @"D maj";
    chordTypeBase[548]   = @"D min";
    chordTypeBase[69]    = @"D 7";
    chordTypeBase[581]   = @"D 7";
    chordTypeBase[517]   = @"D 7";
    
    chordTypeBase[1160]  = @"D#(Eb) maj";
    chordTypeBase[1096]  = @"D#(Eb) min";
    chordTypeBase[138]   = @"D#(Eb) 7";
    chordTypeBase[1162]  = @"D#(Eb) 7";
    chordTypeBase[1034]  = @"D#(Eb) 7";
    
    chordTypeBase[2320]  = @"E maj";
    chordTypeBase[2192]  = @"E min";
    chordTypeBase[276]   = @"E 7";
    chordTypeBase[2324]  = @"E 7";
    chordTypeBase[2068]  = @"E 7";
    
    chordTypeBase[545]   = @"F maj";
    chordTypeBase[289]   = @"F min";
    chordTypeBase[552]   = @"F 7";
    chordTypeBase[553]   = @"F 7";
    chordTypeBase[41]    = @"F 7";
    
    chordTypeBase[1090]  = @"F#(Gb) maj";
    chordTypeBase[578]   = @"F#(Gb) min";
    chordTypeBase[1104]  = @"F#(Gb) 7";
    chordTypeBase[1106]  = @"F#(Gb) 7";
    chordTypeBase[82]    = @"F#(Gb) 7";
    
    chordTypeBase[2180]  = @"G maj";
    chordTypeBase[1156]  = @"G min";
    chordTypeBase[2208]  = @"G 7";
    chordTypeBase[2212]  = @"G 7";
    chordTypeBase[164]   = @"G 7";
    
    chordTypeBase[265]   = @"G#(Ab) maj";
    chordTypeBase[2312]  = @"G#(Ab) min";
    chordTypeBase[321]   = @"G#(Ab) 7";
    chordTypeBase[329]   = @"G#(Ab) 7";
    chordTypeBase[328]   = @"G#(Ab) 7";
    
    chordTypeBase[530]   = @"A maj";
    chordTypeBase[529]   = @"A min";
    chordTypeBase[642]   = @"A 7";
    chordTypeBase[658]   = @"A 7";
    chordTypeBase[656]   = @"A 7";
    
    chordTypeBase[1060]  = @"A#(Bb) maj";
    chordTypeBase[1058]  = @"A#(Bb) min";
    chordTypeBase[1284]  = @"A#(Bb) 7";
    chordTypeBase[1316]  = @"A#(Bb) 7";
    chordTypeBase[1312]  = @"A#(Bb) 7";
    
    chordTypeBase[2120]  = @"B maj";
    chordTypeBase[2116]  = @"B min";
    chordTypeBase[2568]  = @"B 7";
    chordTypeBase[2632]  = @"B 7";
    chordTypeBase[2624]  = @"B 7";
    
}

- (void) getBankInstrumentName :(int)tablePointer {
    bankSel = 0;
    instSel = 0;
    instrName = @"";
}


- (void) sendMIDIeventsToPort :(MIDIPortRef)outputPortA :(MIDIEndpointRef)outputEndpointA :(MIDIPacketList)packetListA :(int)iPA {
    firstPacket->length = iPA;
    s = MIDISend(outputPortA, outputEndpointA, &packetListA);
}


- (void) setDefaultMapping {
    int instrNr = 0;
    userPreferences = [NSUserDefaults standardUserDefaults];
    for (instrNr = 0; instrNr < 128; instrNr++) {
        [userPreferences setInteger:GMinstr[instrNr] forKey:[NSString stringWithFormat: @"%@%i", @"GMmap", instrNr]];
    }
    
    drumSet = 0;
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
        [self sendMIDIeventsToPort :outputPort :outputEndpoint :packetList :iP];
    }
}

- (void) sendRealTimeByte :(Byte)realTimeByte :(BOOL)immediate {
    if (nextNotSend) {
        nextNotSend = FALSE;
        return;
    }
    if (sendStartContinueStop) {
        if (immediate) {
            packetList.numPackets = 1;
            firstPacket = &packetList.packet[0];
            firstPacket->timeStamp = 0;	// send immediately
            firstPacket->data[0] = realTimeByte;
            firstPacket->length = 1;
            if (deviceIDdest > -1){
                [self sendMIDIeventsToPort :outputPort :outputEndpoint :packetList :1];
            }
        }
        else {
            inppointSettings++;
            if (inppointSettings >= bufsizeSettings) inppointSettings = 0;
            inputBufferSettings[inppointSettings] = realTimeByte;
        }
    }
}


- (void) dummyRead {
    // Dummy read, wegen unloesbarem Problem beim Lesen
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSArray *listArray = [[NSFileManager defaultManager] subpathsAtPath:documentsDirectoryPath];
    NSString *filePath = [documentsDirectoryPath stringByAppendingPathComponent:listArray[0]];
    NSString *textTest = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    textTest = @"";
}
@end
