//
//  NotificationLayer.m
//  minosound
//
//  Created by Yuta Mizushima on 2013/08/23.
//  Copyright (c) 2013年 水島 雄太. All rights reserved.
//

#import "NotificationLayer.h"

#import "Config.h"
#import "IntroLayer.h"
#import "AppDelegate.h"
#import "CCSprite.h"

@implementation NotificationLayer
@synthesize notificationView;

#pragma mark GameKit delegate
- (void)achievementViewControllerDidFinish:(GKAchievementViewController *)viewController {
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

- (void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController {
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

- (void) moveToIntro: (id) sender {
    [self.notificationView removeFromSuperview];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[IntroLayer scene] ]];
}

- (void) onEnter {
	[super onEnter];
}

+ (CCScene *)scene {
	CCScene *scene = [CCScene node];
    CCLayerColor *colorLayer = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 255)];
    [scene addChild:colorLayer];
	NotificationLayer *layer = [NotificationLayer node];
	[scene addChild: layer];
	return scene;
}

- (id)init {
	if((self=[super init])) {
		CGSize size = [[CCDirector sharedDirector] winSize];

        [CCDirector sharedDirector].displayStats = NO;

        CCMenuItem * backItem = [CCMenuItemImage itemWithNormalImage:@"back.png" selectedImage:@"back_disabled.png" target:self selector:@selector(moveToIntro:)];

        CCMenu *menu  = [CCMenu menuWithItems:backItem, nil];
        [menu alignItemsHorizontallyWithPadding:10];
        [menu setPosition:ccp(size.width/2, size.height/2-size.height/3)];
        [self addChild:menu];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height-200)];
        UIWebView *webview = [[UIWebView alloc] initWithFrame:view.frame];
        webview.delegate = (id)self;
        NSURL *url = [NSURL URLWithString:[Config getNotificationsUrl]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [webview loadRequest:request];
        webview.scalesPageToFit = YES;
        self.notificationView = webview;
        [view addSubview:self.notificationView];
        [[[CCDirector sharedDirector] view] addSubview:view];
	}
	return self;
}
@end