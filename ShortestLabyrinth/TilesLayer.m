//
//  TilesLayer.m
//  ShortestLabyrinth
//
//  Created by 水島 雄太 on 2013/04/02.
//  Copyright 水島 雄太 2013年. All rights reserved.
//


// Import the interfaces
#import "TilesLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"
#import "CCSprite.h"

#pragma mark - TilesLayer

// TilesLayer implementation
@implementation TilesLayer
@synthesize tileArray;

// Helper class method that creates a Scene with the TilesLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	TilesLayer *layer = [TilesLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void) initTiles{
    int x = INIT_X;
    int y = INIT_Y;
    for(int y=0;y<COLUMN;y++){
        for(int x=0;x<ROW;x++){
            [self addTileWithFileName:@"tile.png" Size:x*ROW :y*COLUMN IndexX:x Y:y];
        }
    }
}

}



-(NSInteger) searchedTileCount:(NSMutableArray *)tiles{
    NSInteger counter = 0;
    for(Tile* tile in tiles){
        if(tile.isSearched){
            counter++;
        }
    }
    return counter;
}

-(void) genTile:(Tile *)beforeTile{
    Tile* currentTile = [self choiceTile:beforeTile];
    if(currentTile == nil){
        return;
    }else {
        [self addTileTable:currentTile];

        NSLog(@"currentTile:%@",currentTile);

        return [self genTile:[currentTile getBeforeTile:currentTile]];
    }
}

-(NSMutableArray*)surroudTile:(Tile *)currentTile{
    NSMutableArray *array = [NSMutableArray array];

    if([self getIndexByX:currentTile.x Y:currentTile.y-1] != -1 && ![self.tileArray[[self getIndexByX:currentTile.x Y:currentTile.y-1]] isSearched]){
        [array addObject:self.tileArray[[self getIndexByX:currentTile.x Y:currentTile.y-1]]];
    }
    if([self getIndexByX:currentTile.x+1 Y:currentTile.y] != -1 && ![self.tileArray[[self getIndexByX:currentTile.x+1 Y:currentTile.y]] isSearched]){
        [array addObject:self.tileArray[[self getIndexByX:currentTile.x+1 Y:currentTile.y]]];
    }
    if([self getIndexByX:currentTile.x Y:currentTile.y+1] != -1 && ![self.tileArray[[self getIndexByX:currentTile.x Y:currentTile.y+1]] isSearched]){
        [array addObject:self.tileArray[[self getIndexByX:currentTile.x Y:currentTile.y+1]]];
    }
    if([self getIndexByX:currentTile.x-1 Y:currentTile.y] != -1 && ![self.tileArray[[self getIndexByX:currentTile.x-1 Y:currentTile.y]] isSearched]){
        [array addObject:self.tileArray[[self getIndexByX:currentTile.x-1 Y:currentTile.y]]];
    }

    NSLog(@"array:%@",array);

    return array;
}

-(NSInteger) getIndexByX:(NSInteger)x Y:(NSInteger)y{
    if(x<0 || y <0){
        return -1;
    }
    return COLUMN*y + x;
}





-(Tile*)getTileByX:(NSInteger)x Y:(NSInteger)y{
    if(x<0 || y <0 ){
        return nil;
    }
    if(x>= ROW || y >= COLUMN){
        return nil;
    }
    return self.tileArray[y*ROW + x];
}
-(BOOL) checkX:(NSInteger)x Y:(NSInteger)y{
    if(x<0 || y<0){
        return NO;
    }
    if(x>=ROW || y >= COLUMN){
        return NO;
    }
    Tile* tile = [self getTileByX:x Y:y];
    if(tile.isSearched){
        return NO;
    }
    return YES;
}

-(NSMutableArray*)surroundTiles:(Tile *)tile{
    NSMutableArray* mArray = [NSMutableArray array];
    if([self checkX:tile.x Y:tile.y-1]){
        [mArray addObject:[self getTileByX:tile.x Y:tile.y-1]];
    }
    if([self checkX:tile.x+1 Y:tile.y]){
        [mArray addObject:[self getTileByX:tile.x+1 Y:tile.y]];
    }
    if([self checkX:tile.x Y:tile.y+1]){
        [mArray addObject:[self getTileByX:tile.x Y:tile.y+1]];
    }
    if([self checkX:tile.x-1 Y:tile.y]){
        [mArray addObject:[self getTileByX:tile.x-1 Y:tile.y]];
    }
    return mArray;
}

+(NSInteger)random:(NSMutableArray*)array{
    if([array count] == 0){
        return -1;
    }
    return rand() % [array count];

}

-(Tile*)choiceTile:(Tile *)tile{
    NSMutableArray* tiles = [self surroudTile:tile];
    if(tiles){
        choice = self.tileArray[[self random:tiles]];
    }


}
















-(void)addTileTable:(Tile *)currentTile{
    currentTile.isSearched = YES;
}

-(void) addTileWithFileName:(NSString *)fileName Size:(NSInteger)x :(NSInteger)y IndexX:(NSInteger)i_x Y:(NSInteger)i_y{
    if(self.tileArray == nil){
        self.tileArray = [NSMutableArray array];
    }
    Tile *tile = [Tile spriteWithFile: fileName];
    tile.position = ccp(x, y);
    tile.x = i_x;
    tile.y = i_y;
    [self addChild:tile];

    [self.tileArray addObject:tile];
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
    self.isTouchEnabled = YES;

	if( (self=[super init]) ) {
        [self initTiles];
//        [self genTile:nil];
	}
	return self;
}

- (void) nextFrame:(ccTime)dt {
    for(CCSprite* sprite in self.tileArray){
        sprite.position = ccp( sprite.position.x + 100*dt, sprite.position.y );
        if (sprite.position.x > 480+32) {
            sprite.position = ccp( -32, sprite.position.y );
        }
    }
}

-(void) registerWithTouchDispatcher
{
	[[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
	CGPoint location = [self convertTouchToNodeSpace: touch];
    for(CCSprite* sprite in self.tileArray){
        [sprite stopAllActions];
        [sprite runAction: [CCMoveTo actionWithDuration:1 position:location]];
    }
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) visit

{

    [super visit];

    glColor4f(0.0f, 0.0f, 1.0f, 1.0f);

    CGPoint lpt1 = CGPointMake(100, 180);

    CGPoint lpt2 = CGPointMake(200, 120);

    ccDrawLine(lpt1, lpt2);

}

@end
