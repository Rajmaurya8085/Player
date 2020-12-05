//
//  AudioClass.h
//
//  Created by Ben Smiley-Andrews on 22/03/2012.
//  Copyright (c) 2012 Deluge. All rights reserved.
//
//  Expanded and adapted by Walter Schurter on 01.05.13.
//  Copyright (c) 2013 Walter Schurter WASElectronic. All rights reserved.
//


#import <AudioToolbox/MusicPlayer.h>

@interface AudioClass : NSObject {

}

+(id) audioClass;

- (void) audioInit;
- (void) audioInit9;
- (void) setInstrument :(Byte)instrNumber :(Byte)lastPresetNumber;
- (void) midiEvent :(Byte)statusInfo :(Byte)param1 :(Byte)param2;
- (void) sendSYSEXevent :(int)sysexLenght;

@end
