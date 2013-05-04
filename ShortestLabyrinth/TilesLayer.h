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
    CCLabelAtlas* gen_label;
}
@property (nonatomic, retain) NSMutableArray *tileArray;
@property (nonatomic, retain) NSMutableArray *pathStack;
@property (nonatomic, retain) CCLabelAtlas* gen_label;

// returns a CCScene that contains the TilesLayer as the only child
+(CCScene *) scene;

-(void) initTileSize:(NSInteger)width :(NSInteger)height X:(NSInteger)x Y:(NSInteger)y;
-(void) initTiles;

-(void) genTile:(Tile *)beforeTile;

-(NSMutableArray*) surroudTiles:(Tile *)currentTile;
-(void) addTileTable:(Tile *)currentTile;

-(NSInteger) getIndexByX:(NSInteger)x Y:(NSInteger)y;

-(NSInteger) searchedTileCount:(NSMutableArray *)tileArray;

-(Tile*) getTileByX:(NSInteger)x Y:(NSInteger)y;
-(BOOL) checkX:(NSInteger)x Y:(NSInteger)y;
-(Tile*) getBeforeTile:(Tile *)currentTile;
-(NSMutableArray*) surroundTiles:(Tile *)currentTile;
-(Tile*) choiceTile:(Tile *)currentTile;
-(NSInteger) randomGet:(NSMutableArray *)array;

-(void) scan:(Tile*)tile;

-(void) draw:(NSMutableArray*)tileArray;

-(void) drawTileToTile:(Tile*)beforeTile :(Tile*)tile;

-(NSMutableArray*)path:(Tile*)tile :(NSMutableArray*)stack;

-(void)setButton1;

@end
