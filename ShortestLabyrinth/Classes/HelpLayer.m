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

#import "IntroLayer.h"

@implementation HelpLayer

#pragma mark GameKit delegate
- (void)achievementViewControllerDidFinish:(GKAchievementViewController *)viewController {
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController {
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

+ (CCScene *)scene {
	CCScene *scene = [CCScene node];
	HelpLayer *layer = [HelpLayer node];
	[scene addChild: layer];
	return scene;
}


- (id)init {
	if((self=[super init])) {
		CGSize size = [[CCDirector sharedDirector] winSize];
        [CCDirector sharedDirector].displayStats = NO;
        CCMenuItem * backItem = [CCMenuItemImage itemWithNormalImage:@"back.png" selectedImage:@"back_disabled.png" target:self selector:@selector(moveToIntro:)];
        CCMenu * menu  = [CCMenu menuWithItems:backItem,nil];
        [menu alignItemsHorizontallyWithPadding:10];
        [menu setPosition:ccp(size.width/2, size.height/2-size.height/3)];
        [self addChild:menu];
	}
	return self;
}

- (void) moveToIntro: (id) sender {
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[IntroLayer scene] ]];
}

- (void) onEnter {
	[super onEnter];
}

@end
