//
//  SimpleAudioService.m
//  SimpleAudioService
//
//  Created by Ray Yamamoto Hilton on 2/12/10.
//

#import "SimpleAudioService.h"
#import <AudioToolbox/AudioToolbox.h>


@implementation SimpleAudioService

- (void)dealloc {
	[self removeSounds];
	[sounds release];
	
    [super dealloc];
}

-(id)init {
	if(self = [super init]) {
		sounds = [[NSMutableDictionary alloc] init];
	}
	return self;
}


-(void)removeSounds {
	for(NSNumber *soundId in [sounds allValues]) {
		AudioServicesDisposeSystemSoundID([soundId unsignedIntValue]);
	}
}

-(void)playSound:(NSString *)soundFile {
	if(![sounds objectForKey:soundFile]) 
		[self loadSound:soundFile];
		
	NSLog(@"Playing sound %@ with id %@", soundFile, [sounds objectForKey:soundFile]);
	AudioServicesPlaySystemSound([[sounds objectForKey:soundFile] unsignedIntValue]);
}

-(void)loadSound:(NSString *)soundFile {
	SystemSoundID soundID;
	NSString *type = @"aif";
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:soundFile ofType:type];
    NSURL *soundUrl = [NSURL fileURLWithPath:soundPath];
    OSStatus error = AudioServicesCreateSystemSoundID((CFURLRef) soundUrl, &soundID);
    if (error == kAudioServicesNoError) { // success
		[sounds setObject:[NSNumber numberWithUnsignedInt:soundID] forKey:soundFile];
		NSLog(@"Loaded sound %@.%@ with id %i", soundFile, type, soundID);
	} else {
		[NSException raise:@"Error loading sound" format:@"Error %d loading sound at path: %@", error, soundPath];
	}
}

@end
