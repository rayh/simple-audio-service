//
//  SimpleAudioService.h
//  SimpleAudioService
//
//  Created by Ray Yamamoto Hilton on 2/12/10.
//

#import <Foundation/Foundation.h>


@interface SimpleAudioService : NSObject {
	NSMutableDictionary *sounds;
}

-(void)removeSounds;
-(void)playSound:(NSString *)soundFile;
-(void)loadSound:(NSString *)soundFile;

@end
