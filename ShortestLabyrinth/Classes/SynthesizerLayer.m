//
//  SynthesizerLayer.m
//  minosound
//
//  Created by Yuta Mizushima on 2013/09/11.
//  Copyright (c) 2013年 水島 雄太. All rights reserved.
//

#import "SynthesizerLayer.h"

#import "TilesLayer.h"
#import "AppDelegate.h"
#import "CCSprite.h"
@implementation SynthesizerLayer

@synthesize synthesizer;

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
	SynthesizerLayer *layer = [SynthesizerLayer node];
	[scene addChild: layer];
	return scene;
}



- (CGPoint)getTouchEventPoint:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch =[touches anyObject];
    CGPoint location =[touch locationInView:[touch view]];
    return [[CCDirector sharedDirector] convertToGL:location];
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint location = [self getTouchEventPoint:(NSSet *)touches withEvent:(UIEvent *)event];
    [self.synthesizer setCarrierFreq:location.x];
    [self.synthesizer setHarmonicityRatio:8.410+location.y/600.0];
    [self.synthesizer setModulatorIndex:location.x];
    [self.synthesizer play];
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (id)init {
	if((self=[super init])) {
		CGSize size = [[CCDirector sharedDirector] winSize];
        [CCDirector sharedDirector].displayStats = NO;
        self.touchEnabled = YES;
        CCMenuItem * backItem = [CCMenuItemImage itemWithNormalImage:@"back.png" selectedImage:@"back_disabled.png" target:self selector:@selector(moveToIntro:)];
        CCMenu * menu  = [CCMenu menuWithItems:backItem,nil];
        [menu alignItemsHorizontallyWithPadding:10];
        [menu setPosition:ccp(size.width/2, size.height/2-size.height/3)];
        [self addChild:menu];
        
        self.synthesizer = [SimpleFM new];
	}
	return self;
}

- (void) moveToIntro: (id) sender {
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[TilesLayer scene]]];
}

- (void) onEnter {
	[super onEnter];
}

@end