#import "HelpLayer.h"

#import "AppDelegate.h"
#import "CCSprite.h"

#import "IntroLayer.h"

@implementation HelpLayer

#pragma mark GameKit delegate
- (void)achievementViewControllerDidFinish:(GKAchievementViewController *)viewController {
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissViewControllerAnimated:YES completion:nil];
}

- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController {
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissViewControllerAnimated:YES completion:nil];
}

+ (CCScene *)scene {
    CGSize size = [[CCDirector sharedDirector] winSize];
	CCScene *scene = [CCScene node];
    CCLayerColor *layer = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 255)];
    CCSprite* sprite;
    sprite = [CCSprite spriteWithFile:@"help_back.png"];
    sprite.position = CGPointMake(size.width/2, size.height/2);

    [scene addChild:layer];
    [scene addChild: sprite];
    
	HelpLayer *helpLayer = [HelpLayer node];
	[scene addChild: helpLayer];
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
