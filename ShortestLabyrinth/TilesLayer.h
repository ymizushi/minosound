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

#import "SimpleFM.h"

#define ROW 14
#define COLUMN 14
#define CELL_WIDTH 20
#define CELL_HEIGHT 20
#define OFFSET_X  160
#define OFFSET_Y  30

// TilesLayer
@interface TilesLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    NSMutableArray *tileArray;
    NSMutableArray *pathStack;
    CCLabelTTF *timerLabel;
    CCLabelTTF *levelLabel;
    float timer;
    NSInteger level;

    SimpleFM* simpleFM;
}
@property (nonatomic, retain) NSMutableArray *tileArray;
@property (nonatomic, retain) NSMutableArray *pathStack;
@property (nonatomic, retain) CCLabelTTF *timerLabel;
@property (nonatomic, retain) CCLabelTTF *levelLabel;
@property (nonatomic) float timer;
@property (nonatomic) NSInteger level;
@property (nonatomic, retain) SimpleFM *simpleFM;

+(CCScene *) scene;
-(void) initTileSize:(NSInteger)width :(NSInteger)height X:(NSInteger)x Y:(NSInteger)y;
-(void) initTiles;
-(void) genTiles;
-(Tile*) getTileByX:(NSInteger)x Y:(NSInteger)y;
-(BOOL) checkX:(NSInteger)x Y:(NSInteger)y;
-(NSMutableArray*) surroundTiles:(Tile *)currentTile;
-(Tile*) choiceTile:(Tile *)currentTile;
-(NSInteger) randomGet:(NSMutableArray *)array;
-(void) scan:(Tile*)tile;
-(void) draw:(NSMutableArray*)tileArray;
-(void) drawTileToTile:(Tile*)beforeTile :(Tile*)tile;
-(NSMutableArray*)path:(Tile*)tile :(NSMutableArray*)stack;
-(void)setButton1;
@end