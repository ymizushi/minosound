//
//  IntroLayer.m
//  ShortestLabyrinth
//
//  Created by 水島 雄太 on 2013/04/02.
//  Copyright 水島 雄太 2013年. All rights reserved.
//


#import "IntroLayer.h"
#import "TilesLayer.h"
#import "NotificationLayer.h"
#import "HelpLayer.h"
#import "SimpleAudioEngine.h"

#pragma mark - IntroLayer
@implementation IntroLayer

// Helper class method that creates a Scene with the TilesLayer as the only child.
+ (CCScene *) scene {
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	IntroLayer *layer = [IntroLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

@synthesize enabledSound;

- (id) init {
	if( (self=[super init])) {
		CGSize size = [[CCDirector sharedDirector] winSize];
		CCSprite *background;
		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
			background = [CCSprite spriteWithFile:@"Default.png"];
		} else {
			background = [CCSprite spriteWithFile:@"Default-Landscape~ipad.png"];
		}
		background.position = ccp(size.width/2, size.height/2);
		[self addChild: background];

        [CCDirector sharedDirector].displayStats = NO;
        
        CCMenuItem * startItem = [CCMenuItemImage itemWithNormalImage:@"start.png" selectedImage:@"start_disabled.png" target:self selector:@selector(moveToGame:)];
        CCMenuItem * notificationItem = [CCMenuItemImage itemWithNormalImage:@"help.png" selectedImage:@"help_disabled.png" target:self selector:@selector(moveTonNotification:)];
        CCMenuItem * helpItem = [CCMenuItemImage itemWithNormalImage:@"help.png" selectedImage:@"help_disabled.png" target:self selector:@selector(moveToHelp:)];
        CCMenu * menu  = [CCMenu menuWithItems:startItem,notificationItem,helpItem,nil];
        [menu alignItemsVerticallyWithPadding:10];
        [menu setPosition:ccp(size.width/2, size.height/2-size.height/3)];
        [self addChild:menu];
	}
	return self;
}

- (void) moveToGame:(id)sender {
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[TilesLayer scene] ]];
}

- (void) moveTonNotification:(id)sender {
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.0 scene:[NotificationLayer scene] ]];
}

- (void) moveToHelp:(id)sender {
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[HelpLayer scene] ]];
}

- (void) onEnter {
	[super onEnter];
}

@end