//
//  TilesLayer.h
//  ShortestLabyrinth
//
//  Created by 水島 雄太 on 2013/04/02.
//  Copyright 水島 雄太 2013年. All rights reserved.
//


#import <GameKit/GameKit.h>
#import "CCTouchDispatcher.h"
#import "Tile.h"

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

#define ROW 10
#define COLUMN 10
#define CELL_WIDTH 25
#define CELL_HEIGHT 25
#define INIT_X 125
#define INIT_Y 50

// TilesLayer
@interface TilesLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    NSMutableArray *tileArray;
    NSMutableArray* tileTable;
}
@property (nonatomic, retain) NSMutableArray *tileArray;
@property (nonatomic, retain) NSMutableArray *tileTable;

// returns a CCScene that contains the TilesLayer as the only child
+(CCScene *) scene;

-(void) addTileWithFileName:(NSString *)fileName Size:(int)x :(int)y;
-(void) initTiles;

-(void) genTile:(Tile *)beforeTile;

-(NSArray*) surroudTile:(Tile *)currentTile;
-(Tile*) choiceTile:(Tile *)currentTile;
-(void) addTileTable:(Tile *)currentTile;

@end
