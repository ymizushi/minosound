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

#define ROW 4
#define COLUMN 4
#define CELL_WIDTH 20
#define CELL_HEIGHT 20

// TilesLayer
@interface TilesLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    NSMutableArray *tileArray;
}
@property (nonatomic, retain) NSMutableArray *tileArray;

// returns a CCScene that contains the TilesLayer as the only child
+(CCScene *) scene;

-(void) initTile:(NSString *)fileName Size:(NSInteger)width :(NSInteger)height X:(NSInteger)x Y:(NSInteger)y;
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


@end
