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
@synthesize isShortcut;

-(void)draw{
    [super draw];
    if(self.beforeTile){
        CGPoint p1,p2;
        p1=CGPointMake((float)self.beforeTile.x*WIDTH+OFFSET_X,(float)self.beforeTile.y*HEIGHT+OFFSET_Y);
        p2=CGPointMake((float)self.x*WIDTH+OFFSET_X,(float)self.y*HEIGHT+OFFSET_Y);
        if(self.isShortcut){
            ;
        }else{
            ;
        }
        ccDrawColor4F(1.0f, 0.0f, 0.0f, 1.0f);
        glLineWidth(10.0f);
        ccDrawLine(p1, p2);
    }
}

@end
