//
//  Tile.m
//  ShortestLabyrinth
//
//  Created by 水島 雄太 on 2013/04/02.
//  Copyright (c) 2013年 水島 雄太. All rights reserved.
//

#import "Tile.h"

@implementation Tile
@synthesize beforeTile;

-(Tile*) getBeforeTile:(Tile *)currentTile{
    return self.beforeTile;
}
@end
