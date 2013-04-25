//
//  Tile.h
//  ShortestLabyrinth
//
//  Created by 水島 雄太 on 2013/04/02.
//  Copyright (c) 2013年 水島 雄太. All rights reserved.
//

#import "CCSprite.h"

@interface Tile : CCSprite
{
    Tile* beforeTile;
    BOOL isSearched;
    NSInteger x;
    NSInteger y;
    NSInteger display_x;
    NSInteger display_y;
}
@property (nonatomic, retain)Tile* beforeTile;
@property (nonatomic)BOOL isSearched;
@property (nonatomic)NSInteger x;
@property (nonatomic)NSInteger y;
@property (nonatomic)NSInteger display_x;
@property (nonatomic)NSInteger display_y;

-(void)drawToDestTile:(Tile*)tile;

@end
