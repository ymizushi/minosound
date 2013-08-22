//
//  NotificationLayer.m
//  minosound
//
//  Created by Yuta Mizushima on 2013/08/23.
//  Copyright (c) 2013年 水島 雄太. All rights reserved.
//

#import "NotificationLayer.h"

#import "IntroLayer.h"
#import "AppDelegate.h"
#import "CCSprite.h"

@implementation NotificationLayer

#pragma mark GameKit delegate
- (void)achievementViewControllerDidFinish:(GKAchievementViewController *)viewController {
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

- (void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController {
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

- (void) moveToNextTransision: (id) sender {
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[IntroLayer scene] ]];
}

- (void) onEnter {
	[super onEnter];
}

+ (CCScene *)scene {
	CCScene *scene = [CCScene node];
	NotificationLayer *layer = [NotificationLayer node];
	[scene addChild: layer];
	return scene;
}


- (id)init {
	if((self=[super init])) {
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
@end