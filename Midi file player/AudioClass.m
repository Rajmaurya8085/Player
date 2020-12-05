//
//  AudioClass.m
//
//  Created by Ben Smiley-Andrews on 22/03/2012.
//  Copyright (c) 2012 Deluge. All rights reserved.
//
//  Expanded and adapted by Walter Schurter on 01.05.13.
//  Copyright (c) 2013 Walter Schurter WASElectronic. All rights reserved.
//

#import "AudioClass.h"
#import <CoreMIDI/MIDIServices.h>
#import <CoreMIDI/CoreMIDI.h>
#import "AppDelegate.h"

@interface AudioClass ()

@property (readwrite) AUGraph   processingGraph;
@property (readwrite) AudioUnit samplerUnit;
@property (readwrite) AudioUnit ioUnit;


@end

@implementation AudioClass

AUSamplerBankPresetData bpdata;

+ audioClass {
    return [[self alloc] initAudioClass];
}


-(id) initAudioClass {
	if((self = [self init] )) {

	}
	return self;
}

- (BOOL) createAUGraph {
    // Each core audio call returns an OSStatus. This means that we
    // Can see if there have been any errors in the setup
	OSStatus result = noErr;
    
    // Create 2 audio units one sampler and one IO
	AUNode samplerNode, ioNode;
    
    // Specify the common portion of an audio unit's identify, used for both audio units
    // in the graph.
    // Setup the manufacturer - in this case Apple
	AudioComponentDescription cd = {};
	cd.componentManufacturer     = kAudioUnitManufacturer_Apple;
    
    // Instantiate an audio processing graph
	result = NewAUGraph (&_processingGraph);
    NSCAssert (result == noErr, @"Unable to create an AUGraph object. Error code: %d '%.4s'", (int) result, (const char *)&result);
    
	//Specify the Sampler unit, to be used as the first node of the graph
	cd.componentType = kAudioUnitType_MusicDevice; // type - music device
	cd.componentSubType = kAudioUnitSubType_Sampler; // sub type - sampler to convert our MIDI
	
    // Add the Sampler unit node to the graph
	result = AUGraphAddNode (self.processingGraph, &cd, &samplerNode);
    NSCAssert (result == noErr, @"Unable to add the Sampler unit to the audio processing graph. Error code: %d '%.4s'", (int) result, (const char *)&result);
    
	// Specify the Output unit, to be used as the second and final node of the graph	
	cd.componentType = kAudioUnitType_Output;  // Output
	cd.componentSubType = kAudioUnitSubType_RemoteIO;  // Output to speakers
    
    // Add the Output unit node to the graph
	result = AUGraphAddNode (self.processingGraph, &cd, &ioNode);
    NSCAssert (result == noErr, @"Unable to add the Output unit to the audio processing graph. Error code: %d '%.4s'", (int) result, (const char *)&result);
    
    // Open the graph
	result = AUGraphOpen (self.processingGraph);
    NSCAssert (result == noErr, @"Unable to open the audio processing graph. Error code: %d '%.4s'", (int) result, (const char *)&result);
    
    // Connect the Sampler unit to the output unit
	result = AUGraphConnectNodeInput (self.processingGraph, samplerNode, 0, ioNode, 0);
    NSCAssert (result == noErr, @"Unable to interconnect the nodes in the audio processing graph. Error code: %d '%.4s'", (int) result, (const char *)&result);
    
	// Obtain a reference to the Sampler unit from its node
	result = AUGraphNodeInfo (self.processingGraph, samplerNode, 0, &_samplerUnit);
    NSCAssert (result == noErr, @"Unable to obtain a reference to the Sampler unit. Error code: %d '%.4s'", (int) result, (const char *)&result);
    
	// Obtain a reference to the I/O unit from its node
	result = AUGraphNodeInfo (self.processingGraph, ioNode, 0, &_ioUnit);
    NSCAssert (result == noErr, @"Unable to obtain a reference to the I/O unit. Error code: %d '%.4s'", (int) result, (const char *)&result);
    
    return YES;
}

// Starting with instantiated audio processing graph, configure its 
// audio units, initialize it, and start it.
- (void) configureAndStartAudioProcessingGraph: (AUGraph) graph {
    result = noErr;
    if (graph) {
        
        // Initialize the audio processing graph.
        result = AUGraphInitialize (graph);
        NSAssert (result == noErr, @"Unable to initialze AUGraph object. Error code: %d '%.4s'", (int) result, (const char *)&result);
        
        // Start the graph
        result = AUGraphStart (graph);
        NSAssert (result == noErr, @"Unable to start audio processing graph. Error code: %d '%.4s'", (int) result, (const char *)&result);
        
        // Print out the graph to the console
        //CAShow (graph); 
    }
}



// this method assumes the class has a member called mySamplerUnit
// which is an instance of an AUSampler
-(OSStatus) loadFromDLSOrSoundFont: (NSURL *)bankURL withPatch :(int)presetNumber :(int)lastPresetNumber {
    
    @synchronized(self) {
        result = noErr;
        // fill out a bank preset data structure
        bpdata.bankURL  = (__bridge CFURLRef) bankURL;
        bpdata.bankMSB  = kAUSampler_DefaultMelodicBankMSB;
        bpdata.bankLSB  = kAUSampler_DefaultBankLSB;
        
        if (lastPresetNumber < 128){
            bpdata.presetID = (UInt8) lastPresetNumber;
            result = AudioUnitSetProperty(self.samplerUnit,
                                          kAUSamplerProperty_LoadPresetFromBank,
                                          kAudioUnitScope_Global,
                                          0,
                                          NULL,
                                          0);
        }
        
        bpdata.presetID = (UInt8) presetNumber;
        // set the kAUSamplerProperty_LoadPresetFromBank property
        result = AudioUnitSetProperty(self.samplerUnit,
                                      kAUSamplerProperty_LoadPresetFromBank,
                                      kAudioUnitScope_Global,
                                      0,
                                      &bpdata,
                                      sizeof(bpdata));
        // check for errors
        NSCAssert (result == noErr,
                   @"Unable to set the preset property on the Sampler. Error code:%d '%.4s'",
                   (int) result,
                   (const char *)&result);
        return result;
    }
}

-(OSStatus) loadFromDLSOrSoundFontDrum: (NSURL *)bankURL withPatch: (int)presetNumber {
    @synchronized(self) {
        result = noErr;
        // fill out a bank preset data structure
        bpdata.bankURL  = (__bridge CFURLRef) bankURL;
        bpdata.bankMSB  = kAUSampler_DefaultPercussionBankMSB;
        bpdata.bankLSB  = kAUSampler_DefaultBankLSB;
        bpdata.presetID = (UInt8) presetNumber;
        
        // set the kAUSamplerProperty_LoadPresetFromBank property
        result = AudioUnitSetProperty(self.samplerUnit,
                                      kAUSamplerProperty_LoadPresetFromBank,
                                      kAudioUnitScope_Global,
                                      0,
                                      &bpdata,
                                      sizeof(bpdata));
        
        // check for errors
        NSCAssert (result == noErr,
                   @"Unable to set the preset property on the Sampler. Error code:%d '%.4s'",
                   (int) result,
                   (const char *)&result);
        return result;
    }
}


-(void) audioInit {
    [self createAUGraph];
    [self configureAndStartAudioProcessingGraph: self.processingGraph];
}

-(void) audioInit9 {
    [self createAUGraph];
    [self configureAndStartAudioProcessingGraph: self.processingGraph];
    
    // Load the sound font for drums
    @try {
        if (fileInstruments1Exists && fileInstruments2Exists) {
            if (is_IPHONE_5 || iPadA6) {
                [self loadFromDLSOrSoundFontDrum: (NSURL *)presetURL1 withPatch: 0];
            }
            else {
                [self loadFromDLSOrSoundFontDrum: (NSURL *)presetURL2 withPatch: 0];
            }
        }
        else {
            if (fileInstruments0Exists) {
                [self loadFromDLSOrSoundFontDrum: (NSURL *)presetURL0 withPatch: 0];  // user SoundFont
            }
        }
    }
    @catch (NSException *e) {
    }
    @finally {
    }
}


- (void) setInstrument :(Byte)instrNumber :(Byte)lastPresetNumber
{
    @synchronized(self) {
        
        if (self == at0) {
            [self midiEvent :0xB0 :0x7B :0x00];
        }
        else if (self == at1) {
            [self midiEvent :0xB1 :0x7B :0x00];
        }
        else if (self == at2) {
            [self midiEvent :0xB2 :0x7B :0x00];
        }
        else if (self == at3) {
            [self midiEvent :0xB3 :0x7B :0x00];
        }
        else if (self == at4) {
            [self midiEvent :0xB4 :0x7B :0x00];
        }
        else if (self == at5) {
            [self midiEvent :0xB5 :0x7B :0x00];
        }
        else if (self == at6) {
            [self midiEvent :0xB6 :0x7B :0x00];
        }
        else if (self == at7) {
            [self midiEvent :0xB7 :0x7B :0x00];
        }
        else if (self == at8) {
            [self midiEvent :0xB8 :0x7B :0x00];
        }
        else if (self == at9) {
            [self midiEvent :0xB9 :0x7B :0x00];
        }
        else if (self == at10) {
            [self midiEvent :0xBA :0x7B :0x00];
        }
        else if (self == at11) {
            [self midiEvent :0xBB :0x7B :0x00];
        }
        else if (self == at12) {
            [self midiEvent :0xBC :0x7B :0x00];
        }
        else if (self == at13) {
            [self midiEvent :0xBD :0x7B :0x00];
        }
        else if (self == at14) {
            [self midiEvent :0xBE :0x7B :0x00];
        }
        else if (self == at15) {
            [self midiEvent :0xBF :0x7B :0x00];
        }
        
        if (instrNumber < 128) {
            // Load the sound font for GM instruments
            @try {
                if (fileInstruments1Exists && fileInstruments2Exists) {
                    if (is_IPHONE_5 || iPadA6) {
                        // Bagpipe is wrong on Scc1t2
                        if ((instrNumber < 2 || instrNumber == 33 || instrNumber == 25 || instrNumber > 75) && instrNumber != 109 && [MbGMStereo isEqual: @"32MbGMStereo"]) { // replace bad pianos etc. in 32MbGMStereo !!  instrument 33 is not OK
                            [self loadFromDLSOrSoundFont: (NSURL *)presetURL2 withPatch :instrNumber :lastPresetNumber];
                        }
                        else {
                            [self loadFromDLSOrSoundFont: (NSURL *)presetURL1 withPatch :instrNumber :lastPresetNumber];
                        }
                    }
                    else {
                        [self loadFromDLSOrSoundFont: (NSURL *)presetURL2 withPatch :instrNumber :lastPresetNumber];
                    }
                }
                else {
                    if (fileInstruments0Exists) {
                        [self loadFromDLSOrSoundFont: (NSURL *)presetURL0 withPatch :instrNumber :lastPresetNumber]; // user SoundFont
                    }
                }
            }
            @catch (NSException *e) {
            }
            @finally {
            }
        }
    }
}


- (void) midiEvent :(Byte)statusInfo :(Byte)param1 :(Byte)param2 {
    @synchronized(self) {
        if (statusInfo > 0x7F && param1 < 0x80 && param2 < 0x80) {
            @try {
                MusicDeviceMIDIEvent (self.samplerUnit, statusInfo, param1, param2, 0);
            }
            @catch (NSException * e) {
                NSLog(@"Exception: %@", e);
            }
            @finally {
                //NSLog(@"finally");
            }
        }
    }
}

- (void) sendSYSEXevent :(int)sysexLenght{
    if (switchLocalSoundState) {
        @synchronized(self) {
            MusicDeviceSysEx(self.samplerUnit, sysexMessages, sysexLenght);
        }
    }
}


@end
