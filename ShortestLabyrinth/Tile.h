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
    NSInteger x;
    NSInteger y;
    BOOL isSearched;
}
@property (nonatomic, retain)Tile* beforeTile;
@property (nonatomic)NSInteger x;
@property (nonatomic)NSInteger y;
@property (nonatomic)BOOL isSearched;

-(Tile*) getBeforeTile:(Tile *)currentTile;

@end
