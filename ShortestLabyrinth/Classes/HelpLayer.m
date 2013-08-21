//
//  HelpLayer.m
//  minosound
//
//  Created by Yuta Mizushima on 2013/08/22.
//  Copyright (c) 2013年 水島 雄太. All rights reserved.
//

#import "HelpLayer.h"

#import "AppDelegate.h"
#import "CCSprite.h"

#import "TilesLayer.h"

@implementation HelpLayer

#pragma mark GameKit delegate
- (void)achievementViewControllerDidFinish:(GKAchievementViewController *)viewController {
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

- (void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController {
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
// Helper class method that creates a Scene with the TilesLayer as the only child.
+ (CCScene *)scene {
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelpLayer *layer = [HelpLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];

	// return the scene
	return scene;
}


- (id)init {
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if((self=[super init])) {
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];

        [CCDirector sharedDirector].displayStats = NO;

        CCMenuItem * item1 = [CCMenuItemImage itemWithNormalImage:@"start.png" selectedImage:@"start_disabled.png" target:self selector:@selector(moveToNextTransision:)];
        item1.tag=31;

        CCMenu * menu  = [CCMenu menuWithItems:item1,nil];
        [menu alignItemsHorizontallyWithPadding:10];
        [menu setPosition:ccp(size.width/2, size.height/2-size.height/3)];
        [self addChild:menu];
	}
	return self;
}

- (void) moveToNextTransision: (id) sender {
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[TilesLayer scene] ]];
}

- (void) onEnter {
	[super onEnter];
}

@end
