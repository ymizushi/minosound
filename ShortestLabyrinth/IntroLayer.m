//
//  IntroLayer.m
//  ShortestLabyrinth
//
//  Created by 水島 雄太 on 2013/04/02.
//  Copyright 水島 雄太 2013年. All rights reserved.
//


// Import the interfaces
#import "IntroLayer.h"
#import "TilesLayer.h"
#import "SimpleAudioEngine.h"

#pragma mark - IntroLayer

// TilesLayer implementation
@implementation IntroLayer

// Helper class method that creates a Scene with the TilesLayer as the only child.
+(CCScene *) scene
{
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

// 
-(id) init
{
	if( (self=[super init])) {

		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];

		CCSprite *background;
		
		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
			background = [CCSprite spriteWithFile:@"Default.png"];
			background.rotation = 90;
		} else {
			background = [CCSprite spriteWithFile:@"Default-Landscape~ipad.png"];
		}
		background.position = ccp(size.width/2, size.height/2);

		// add the label as a child to this Layer
		[self addChild: background];

        CCMenuItem * item1 = [CCMenuItemImage itemWithNormalImage:@"gen_btn.png" selectedImage:@"gen_btn.png" target:self selector:@selector(moveToNextTransision:)];
        item1.tag=31;

        CCMenuItem * item2 = [CCMenuItemImage itemWithNormalImage:@"gen_btn.png" selectedImage:@"gen_btn.png" target:self selector:@selector(moveToSystemConfig:)];
        item2.tag=41;

        CCMenu * menu  = [CCMenu menuWithItems:item1,item2,nil];
        [menu alignItemsVerticallyWithPadding:10];
        [menu setPosition:ccp(size.width/2+size.width/3, size.height/2)];
        [self addChild:menu];
	}
	
	return self;
}

-(void) moveToNextTransision: (id) sender
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[TilesLayer scene] ]];
}

-(void) moveToSystemConfig: (id) sender
{
    self.enabledSound = !self.enabledSound;
    SimpleAudioEngine* ae = [SimpleAudioEngine sharedEngine];
    if(self.enabledSound){
        [ae playBackgroundMusic:@"music.mp3" loop:YES];
    }else{
        [ae stopBackgroundMusic];
    }
}

-(void) onEnter
{
	[super onEnter];
}

@end
