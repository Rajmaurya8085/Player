//
//  AppDelegate.h
//
//  Created by Walter Schurter on 01.05.13.
//  Copyright (c) 2013 Walter Schurter WASElectronic. All rights reserved.
//

@class MailViewController;

#import <UIKit/UIKit.h>
#import <CoreMIDI/MIDIServices.h>
#import <CoreMIDI/CoreMIDI.h>
#import "ViewController.h"
#import "ViewControllerPad.h"

#include "AudioClass.h"

extern NSString *midiFilename;
extern int selectedIndex;
extern NSArray *listArrayForPicker;
extern bool initWasDone;
extern bool switchShowSYSEXstate;
extern bool switchLocalSoundState;
extern bool switchFilterSYSEXstate;
extern Byte channelTest;
extern Byte instrumentTest;
extern Byte velocityTest;
extern bool isSettings;
extern bool isRecording;
extern bool midiFilePlaying;
extern bool isPause;
extern bool switchMIDIthruState;
extern NSString *lastImportedMIDIfile;
extern NSString *lastSelectedMIDIfile;
extern bool mustParseDir;
extern NSString *viewToGetBack;
extern bool viewControllerIsVisible;
extern bool viewControllerSettingsIsVisible;
extern bool viewControllerHelpIsVisible;
extern bool pickerViewIsVisible;
extern NSString *documentsDirectoryPath;

extern Byte tempInitial[16][2];
extern Byte tempAllNoteOff[16];
extern Byte allControllerOff[16];
extern int transposeValue;

extern bool initDone;
extern float songPosition;
extern float songLength;
extern bool buttonMoreState;
extern float playBackTempo;

extern float darkGreySlider;
extern float greyValueSlider;
extern bool okWasPressed;

extern NSMutableArray *arrayOutDevices;
extern NSMutableArray *arrayInDevices;
extern int posOutput;
extern int posInput;
extern bool posWasSaved;

extern Byte lastInstr0back;
extern Byte lastInstr1back;
extern Byte lastInstr2back;
extern Byte lastInstr3back;
extern Byte lastInstr4back;
extern Byte lastInstr5back;
extern Byte lastInstr6back;
extern Byte lastInstr7back;
extern Byte lastInstr8back;
extern Byte lastInstr9back;
extern Byte lastInstr10back;
extern Byte lastInstr11back;
extern Byte lastInstr12back;
extern Byte lastInstr13back;
extern Byte lastInstr14back;
extern Byte lastInstr15back;

extern Byte lastVolume0back;
extern Byte lastVolume1back;
extern Byte lastVolume2back;
extern Byte lastVolume3back;
extern Byte lastVolume4back;
extern Byte lastVolume5back;
extern Byte lastVolume6back;
extern Byte lastVolume7back;
extern Byte lastVolume8back;
extern Byte lastVolume9back;
extern Byte lastVolume10back;
extern Byte lastVolume11back;
extern Byte lastVolume12back;
extern Byte lastVolume13back;
extern Byte lastVolume14back;
extern Byte lastVolume15back;

extern Byte lastReverb0back;
extern Byte lastReverb1back;
extern Byte lastReverb2back;
extern Byte lastReverb3back;
extern Byte lastReverb4back;
extern Byte lastReverb5back;
extern Byte lastReverb6back;
extern Byte lastReverb7back;
extern Byte lastReverb8back;
extern Byte lastReverb9back;
extern Byte lastReverb10back;
extern Byte lastReverb11back;
extern Byte lastReverb12back;
extern Byte lastReverb13back;
extern Byte lastReverb14back;
extern Byte lastReverb15back;

extern Byte lastChorus0back;
extern Byte lastChorus1back;
extern Byte lastChorus2back;
extern Byte lastChorus3back;
extern Byte lastChorus4back;
extern Byte lastChorus5back;
extern Byte lastChorus6back;
extern Byte lastChorus7back;
extern Byte lastChorus8back;
extern Byte lastChorus9back;
extern Byte lastChorus10back;
extern Byte lastChorus11back;
extern Byte lastChorus12back;
extern Byte lastChorus13back;
extern Byte lastChorus14back;
extern Byte lastChorus15back;

extern Byte lastPanorama0back;
extern Byte lastPanorama1back;
extern Byte lastPanorama2back;
extern Byte lastPanorama3back;
extern Byte lastPanorama4back;
extern Byte lastPanorama5back;
extern Byte lastPanorama6back;
extern Byte lastPanorama7back;
extern Byte lastPanorama8back;
extern Byte lastPanorama9back;
extern Byte lastPanorama10back;
extern Byte lastPanorama11back;
extern Byte lastPanorama12back;
extern Byte lastPanorama13back;
extern Byte lastPanorama14back;
extern Byte lastPanorama15back;

extern Byte track0state;
extern Byte track1state;
extern Byte track2state;
extern Byte track3state;
extern Byte track4state;
extern Byte track5state;
extern Byte track6state;
extern Byte track7state;
extern Byte track8state;
extern Byte track9state;
extern Byte track10state;
extern Byte track11state;
extern Byte track12state;
extern Byte track13state;
extern Byte track14state;
extern Byte track15state;

extern Byte lastInstr0;
extern Byte lastInstr1;
extern Byte lastInstr2;
extern Byte lastInstr3;
extern Byte lastInstr4;
extern Byte lastInstr5;
extern Byte lastInstr6;
extern Byte lastInstr7;
extern Byte lastInstr8;
extern Byte lastInstr9;
extern Byte lastInstr10;
extern Byte lastInstr11;
extern Byte lastInstr12;
extern Byte lastInstr13;
extern Byte lastInstr14;
extern Byte lastInstr15;

extern Byte lastVolume0;
extern Byte lastVolume1;
extern Byte lastVolume2;
extern Byte lastVolume3;
extern Byte lastVolume4;
extern Byte lastVolume5;
extern Byte lastVolume6;
extern Byte lastVolume7;
extern Byte lastVolume8;
extern Byte lastVolume9;
extern Byte lastVolume10;
extern Byte lastVolume11;
extern Byte lastVolume12;
extern Byte lastVolume13;
extern Byte lastVolume14;
extern Byte lastVolume15;

extern Byte lastReverb0;
extern Byte lastReverb1;
extern Byte lastReverb2;
extern Byte lastReverb3;
extern Byte lastReverb4;
extern Byte lastReverb5;
extern Byte lastReverb6;
extern Byte lastReverb7;
extern Byte lastReverb8;
extern Byte lastReverb9;
extern Byte lastReverb10;
extern Byte lastReverb11;
extern Byte lastReverb12;
extern Byte lastReverb13;
extern Byte lastReverb14;
extern Byte lastReverb15;

extern Byte lastChorus0;
extern Byte lastChorus1;
extern Byte lastChorus2;
extern Byte lastChorus3;
extern Byte lastChorus4;
extern Byte lastChorus5;
extern Byte lastChorus6;
extern Byte lastChorus7;
extern Byte lastChorus8;
extern Byte lastChorus9;
extern Byte lastChorus10;
extern Byte lastChorus11;
extern Byte lastChorus12;
extern Byte lastChorus13;
extern Byte lastChorus14;
extern Byte lastChorus15;

extern Byte lastPanorama0;
extern Byte lastPanorama1;
extern Byte lastPanorama2;
extern Byte lastPanorama3;
extern Byte lastPanorama4;
extern Byte lastPanorama5;
extern Byte lastPanorama6;
extern Byte lastPanorama7;
extern Byte lastPanorama8;
extern Byte lastPanorama9;
extern Byte lastPanorama10;
extern Byte lastPanorama11;
extern Byte lastPanorama12;
extern Byte lastPanorama13;
extern Byte lastPanorama14;
extern Byte lastPanorama15;

extern Byte lastSlider2value;
extern Byte lastSlider4value;
extern Byte lastSlider6value;
extern Byte lastSlider7value;
extern Byte lastSlider8value;

extern Byte lastSlider2value00;
extern Byte lastSlider4value00;
extern Byte lastSlider6value00;
extern Byte lastSlider7value00;
extern Byte lastSlider8value00;

extern Byte lastSlider2value01;
extern Byte lastSlider4value01;
extern Byte lastSlider6value01;
extern Byte lastSlider7value01;
extern Byte lastSlider8value01;

extern Byte lastSlider2value02;
extern Byte lastSlider4value02;
extern Byte lastSlider6value02;
extern Byte lastSlider7value02;
extern Byte lastSlider8value02;

extern Byte lastSlider2value03;
extern Byte lastSlider4value03;
extern Byte lastSlider6value03;
extern Byte lastSlider7value03;
extern Byte lastSlider8value03;

extern Byte lastSlider2value04;
extern Byte lastSlider4value04;
extern Byte lastSlider6value04;
extern Byte lastSlider7value04;
extern Byte lastSlider8value04;

extern Byte lastSlider2value05;
extern Byte lastSlider4value05;
extern Byte lastSlider6value05;
extern Byte lastSlider7value05;
extern Byte lastSlider8value05;

extern Byte lastSlider2value06;
extern Byte lastSlider4value06;
extern Byte lastSlider6value06;
extern Byte lastSlider7value06;
extern Byte lastSlider8value06;

extern Byte lastSlider2value07;
extern Byte lastSlider4value07;
extern Byte lastSlider6value07;
extern Byte lastSlider7value07;
extern Byte lastSlider8value07;

extern Byte lastSlider2value08;
extern Byte lastSlider4value08;
extern Byte lastSlider6value08;
extern Byte lastSlider7value08;
extern Byte lastSlider8value08;

extern Byte lastSlider2value09;
extern Byte lastSlider4value09;
extern Byte lastSlider6value09;
extern Byte lastSlider7value09;
extern Byte lastSlider8value09;

extern Byte lastSlider2value10;
extern Byte lastSlider4value10;
extern Byte lastSlider6value10;
extern Byte lastSlider7value10;
extern Byte lastSlider8value10;

extern Byte lastSlider2value11;
extern Byte lastSlider4value11;
extern Byte lastSlider6value11;
extern Byte lastSlider7value11;
extern Byte lastSlider8value11;

extern Byte lastSlider2value12;
extern Byte lastSlider4value12;
extern Byte lastSlider6value12;
extern Byte lastSlider7value12;
extern Byte lastSlider8value12;

extern Byte lastSlider2value13;
extern Byte lastSlider4value13;
extern Byte lastSlider6value13;
extern Byte lastSlider7value13;
extern Byte lastSlider8value13;

extern Byte lastSlider2value14;
extern Byte lastSlider4value14;
extern Byte lastSlider6value14;
extern Byte lastSlider7value14;
extern Byte lastSlider8value14;

extern Byte lastSlider2value15;
extern Byte lastSlider4value15;
extern Byte lastSlider6value15;
extern Byte lastSlider7value15;
extern Byte lastSlider8value15;


extern bool slider2mustSend;
extern bool slider4mustSend;
extern bool slider6mustSend;
extern bool slider7mustSend;
extern bool slider8mustSend;

extern NSMutableArray *instruments;
extern NSURL *presetURL0;
extern NSURL *presetURL1;
extern NSURL *presetURL2;
extern bool fileInstruments0Exists;
extern bool fileInstruments1Exists;
extern bool fileInstruments2Exists;
extern NSString *MbGMStereo;

extern bool switchSoundBankstate;

extern AudioClass * at0;
extern AudioClass * at1;
extern AudioClass * at2;
extern AudioClass * at3;
extern AudioClass * at4;
extern AudioClass * at5;
extern AudioClass * at6;
extern AudioClass * at7;
extern AudioClass * at8;
extern AudioClass * at9;
extern AudioClass * at10;
extern AudioClass * at11;
extern AudioClass * at12;
extern AudioClass * at13;
extern AudioClass * at14;
extern AudioClass * at15;

extern bool auInitilisationDone;
extern NSFileManager *fileManager;

extern MusicSequence musicSequence;
extern MusicPlayer musicPlayer;

extern MIDIPacketList packetList;
extern MIDIPacket *firstPacket;

extern MIDIPacket *packet;
extern MIDIPacket packet2;

extern OSStatus result;
extern MIDIEndpointRef virtualEndpoint;

extern UInt16 nBytes;
extern UInt16 iByte;
extern UInt16 nBytes2;
extern UInt16 iByte2;

extern int inppoint;
extern int outpoint;
extern int inppoint2;
extern int outpoint2;

extern int bufsize;
extern Byte inputBuffer[2048];
extern Byte tempBuffer[256];
extern Byte sysexMessages[1024];
extern int bufsize2;
extern Byte inputBuffer2[2048];
extern Byte tempBuffer2[256];
extern Byte sysexMessages2[1024];
extern Byte tempBuffer3[256];

extern Byte inputByte;
extern Byte byteToAnalyze;
extern Byte statusByte;
extern int countBytes;
extern Byte inputByte2;
extern Byte byteToAnalyze2;
extern Byte statusByte2;
extern int countBytes2;
extern Byte inputByte3;
extern Byte byteToAnalyze3;
extern Byte statusByte3;
extern int countBytes3;

extern int counterSYSEX;
extern bool isSYSEX;
extern NSString *tempSYSEX;
extern bool statusSYSEX;
extern int counterSYSEX2;
extern bool isSYSEX2;
extern NSString *tempSYSEX2;
extern bool statusSYSEX2;
extern int counterSYSEX3;
extern bool isSYSEX3;
extern NSString *tempSYSEX3;
extern bool statusSYSEX3;

extern Byte midiChannelTemp;
extern Byte midiStatus;
extern Byte midiCommand;
extern Byte midiChan;
extern Byte note2;
extern Byte velocity2;
extern Byte midiChannelTemp2;
extern Byte midiChannelTemp3;
extern Byte channelInfoTemp;

extern Byte defaultInstru;
extern Byte defaultVolume;
extern Byte defaultReverb;
extern Byte defaultChorus;
extern Byte defaultPanora;

extern NSTimer *inputTreatTimer;
extern NSTimer *timerEnd;
extern NSTimer *timerforAllNotesOff;
extern NSTimer *timerforAllNotesOffChannel;
extern NSTimer *notifyTimer;
extern NSTimer *buttonStopTimer;
extern NSTimer *timerforScrollView;
extern NSTimer *oneShotTimerChordHide;
extern NSTimer *blinkTimer;
extern NSTimer *audioUsed;
extern NSTimer *timerForRealTime;

extern NSString *tempText;

extern MusicTimeStamp len;
extern int counterTimer;

extern NSString *notifyMessage;

extern NSString *midiFilePath;
extern NSString *midiFileWritePath;
extern NSString *documentsDirectoryPath;
extern NSArray *dirFiles;
extern NSArray *dirFilesInbox;
extern NSArray *listArrayTemp;
extern NSArray *sortedArray;
extern int listArrayCount;

extern OSStatus s;
extern MIDIClientRef client;
extern MIDIPortRef outputPort;
extern MIDIPortRef inputPort;
extern MIDIEndpointRef destMIDI;
extern MIDIEndpointRef sourceMIDI;
extern MIDIEndpointRef outputEndpoint;
extern MIDIThruConnectionRef thruConnectionRef;
extern MIDIThruConnectionParams thruParams;
extern CFDataRef data;

extern int deviceIDdest;
extern int deviceIDsource;

extern NSMutableArray *arrayForComboBox1;
extern NSMutableArray *arrayForComboBox2;

extern int countComboBox1;
extern int countComboBox2;

extern Byte track0stateBack;
extern Byte track1stateBack;
extern Byte track2stateBack;
extern Byte track3stateBack;
extern Byte track4stateBack;
extern Byte track5stateBack;
extern Byte track6stateBack;
extern Byte track7stateBack;
extern Byte track8stateBack;
extern Byte track9stateBack;
extern Byte track10stateBack;
extern Byte track11stateBack;
extern Byte track12stateBack;
extern Byte track13stateBack;
extern Byte track14stateBack;
extern Byte track15stateBack;

extern Byte controllerByte;
extern Byte tempVariable;

extern MIDIChannelMessage channelMessage;
extern MIDINoteMessage noteMessage;
extern MIDIRawData *sysexData;
extern MIDIRawData *sysexData2;
extern MIDIMetaEvent metaDataEvent;
extern MusicTimeStamp timeStamp;
extern MusicSequence recordSequence;
extern MusicTrack recordTrack;
extern MusicTimeStamp lenRec;

extern long secTempA ;
extern float secTempB;
extern long secStartA;
extern float secStartB;
extern bool toggleColor;
extern NSString *lastNotifyMessage;
extern float greyValue;

extern NSUserDefaults *userPreferences;
extern bool dataSaved;

extern UIAlertView *deleteAlert;
extern UIAlertView *iPadAlert;
extern UIAlertView *alertAudio;

extern float timerIntervall;
extern float counterIntervall;
extern int textFieldHeight;
extern NSString *fileNameForSave;

extern UIAlertView *infoStore;
extern UIAlertView *infoStoreError;
extern MusicTrack track;

extern const NSString *textForNoFiles;

extern Byte success;
extern NSString *tempDirfrom;
extern NSString *tempDirTo;
extern NSString *inboxPath;

extern Byte channelSelection;
extern bool toggleColorS;
extern bool visible;

extern Byte timerDivisor;
extern Byte timerDivisorSettings;

extern bool sliderValuesHaveChanged;

extern int inppointSettings;
extern int outpointSettings;
extern int bufsizeSettings;
extern Byte inputBufferSettings[1024];

extern Byte lastTrackTemp;
extern bool ignoreLast;

extern bool is_IPAD;
extern bool is_IPHONE;
extern bool is_IPHONE_5;
extern bool iPadA6;
extern bool iPadQuestionAnswered;

extern bool inBackground;
extern bool backgroundPlayAllowed;
extern bool audioUsedInBackground;
extern bool mustEnableDivers;

extern int maxChordPointerVal;

extern int maxChordPointerBaseVal;
extern NSString *chordTypeBase[2634];  // max chordTypeBase + 2

extern int maxChordPointerVal;
extern NSString *chordType[2215];     // maxChordPointerVal + 2

extern Byte last12notes[16][12][2];
extern Byte chordChannel;
extern Byte lowestNoteChord;
extern Byte tempChordTag;
extern Byte tempChordTagLast1;
extern Byte tempChordTagLast2;
extern Byte tempChordNote;
extern NSString *notesForText[12];
extern Byte channelForShowChord;
extern Byte bufferForChord[255][3];
extern Byte inppointBut;
extern Byte outpointBut;
extern Byte bufsizeBut;
extern int chordPointer;
extern bool doChordDetect;
extern bool labelChordBigState;
extern NSString *labelChordBigText;
extern Byte starPointer;

extern NSString *midiFilenameWithoutExt;
extern bool nameChanged;
extern bool searchModeP;
extern int indexOfTheObjectP;
extern int numberOfIndexesP;
extern int indexCounterP;

extern NSArray *resultsearchP;
extern UIAlertView *alertNotfoundP;
extern UIAlertView *alertP;

extern bool backFromOtherView;

extern CGSize screenSize;
extern CGRect screenBound;

extern NSNumberFormatter *numberFormatter;
extern float batteryLevel;

extern bool autoNext;

void MyMIDINotifyProc (const MIDINotification  *message, void *refCon);
NSString *getDisplayName(MIDIObjectRef object);

extern int bankSel;
extern int instSel;
extern NSString *instrName;
extern int GMinstr[];
extern int drumSet;
extern Byte originMIDItemp;
extern bool mapGMplayer;
extern Byte masterVolumeValue;
extern bool channels32Mode;

extern UIAlertView *alertOptions;
extern UIAlertView *defaultAlert;

extern MIDIPortRef outputPortLast;
extern MIDIPortRef inputPortLast;
extern MIDIEndpointRef destMIDIlast;
extern MIDIEndpointRef sourceMIDIlast;

extern bool drumSet0;
extern bool mustRefreshOption;

extern bool sendStartContinueStop;
extern bool receiveStartContinueStop;
extern bool nextNotSend;

extern float startPoint;
extern float endPoint;
extern bool isLoop;
extern NSString *lastPlayedMIDIfileName;

extern NSString *openURLstring;

extern ViewController *viewCont;
extern ViewControllerPad *viewContPad;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
extern AppDelegate *appDelegate;

@property (strong, nonatomic) UIWindow *window;

- (void) auInitialisations;
- (void) setDefault0;
- (void) setDefault1;
- (void) setDefault2;
- (void) setDefault3;
- (void) setDefault4;
- (void) setDefault5;
- (void) setDefault6;
- (void) setDefault7;
- (void) setDefault8;
- (void) setDefault9;
- (void) setDefault10;
- (void) setDefault11;
- (void) setDefault12;
- (void) setDefault13;
- (void) setDefault14;
- (void) setDefault15;
- (void) setBackGroundAllowed :(bool)isAllowed;
- (void) clearDiversBuffers;
- (void) getBankInstrumentName :(int)tablePointer;
- (void) sendMIDIeventsToPort :(MIDIPortRef)outputPortA :(MIDIEndpointRef)outputEndpointA :(MIDIPacketList)packetListA :(int)iPA ;
- (void) setDefaultMapping;
- (void) gmMIDIreset;
- (NSString*) getDateTimeString;
- (void) dummyRead;
- (void) sendRealTimeByte :(Byte)realTimeByte :(BOOL)immediate;
@end
