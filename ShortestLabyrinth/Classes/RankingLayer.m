#import "RankingLayer.h"

#import "TilesLayer.h"
#import "AppDelegate.h"
#import "CCSprite.h"

@implementation RankingLayer

#pragma mark GameKit delegate
- (void)achievementViewControllerDidFinish:(GKAchievementViewController *)viewController {
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissViewControllerAnimated:YES completion:nil];
}

- (void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController {
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissViewControllerAnimated:YES completion:nil];
}

- (void) moveToNextTransision: (id) sender {
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[TilesLayer scene]]];
}

- (void) onEnter {
	[super onEnter];
}

+ (CCScene *)scene {
	CCScene *scene = [CCScene node];
    CCLayerColor *colorLayer = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 255)];
    [scene addChild:colorLayer];
	RankingLayer *layer = [RankingLayer node];
	[scene addChild: layer];
	return scene;
}

- (id)init {
	if((self=[super init])) {
		CGSize size = [[CCDirector sharedDirector] winSize];
        [CCDirector sharedDirector].displayStats = NO;
        CCMenuItem *item1 = [CCMenuItemImage itemWithNormalImage:@"start.png" selectedImage:@"start_disabled.png" target:self selector:@selector(moveToNextTransision:)];
        CCMenu *menu = [CCMenu menuWithItems:item1,nil];
        [menu alignItemsHorizontallyWithPadding:10];
        [menu setPosition:ccp(size.width/2, size.height/2-size.height/3)];
        [self addChild:menu];
	}
	return self;
}
@end