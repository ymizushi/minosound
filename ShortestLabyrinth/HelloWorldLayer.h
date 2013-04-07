//
//  HelloWorldLayer.h
//  ShortestLabyrinth
//
//  Created by 水島 雄太 on 2013/04/02.
//  Copyright 水島 雄太 2013年. All rights reserved.
//


#import <GameKit/GameKit.h>
#import "CCTouchDispatcher.h"

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    NSMutableArray *tileArray;
}
@property (nonatomic, retain) NSMutableArray *tileArray;

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

-(void) addTileWithFileName:(NSString *)fileName Size:(int)x :(int)y;

@end
