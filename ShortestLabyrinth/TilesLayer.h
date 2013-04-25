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

#define ROW 3
#define COLUMN 3
#define CELL_WIDTH 25
#define CELL_HEIGHT 25
#define INIT_X 125
#define INIT_Y 50

// TilesLayer
@interface TilesLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    NSMutableArray *tileArray;
}
@property (nonatomic, retain) NSMutableArray *tileArray;

// returns a CCScene that contains the TilesLayer as the only child
+(CCScene *) scene;

-(void) addTileWithFileName:(NSString *)fileName Size:(NSInteger)x :(NSInteger)y IndexX:(NSInteger)i_x Y:(NSInteger)i_y;
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
-(NSInteger) random:(NSMutableArray *)array;

-(void) scan:(Tile*)tile;

-(void) draw:(NSMutableArray*)tileArray;

-(void) drawTileToTile:(Tile*)beforeTile :(Tile*)tile;


@end
