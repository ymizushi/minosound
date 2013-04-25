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
@synthesize x;
@synthesize y;
@synthesize display_x;
@synthesize display_y;
@synthesize isSearched;

-(void)draw{
    if(self.beforeTile){
        glColor4f(1.0, 0.0, 0.0, 1.0);
        glLineWidth(10.0f);
        CGPoint p1,p2;
        p1=CGPointMake((float)self.beforeTile.x*50,(float)self.beforeTile.y*50);
        p2=CGPointMake((float)self.x*50,(float)self.y*50);
        ccDrawLine(p1, p2);
    }
}

@end
