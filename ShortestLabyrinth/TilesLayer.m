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
@synthesize pathStack;
@synthesize timerLabel;
@synthesize levelLabel;
@synthesize timer;
@synthesize level;
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

-(void) genTiles{
    self.tileArray = [NSMutableArray array];
    for(int y=0;y<COLUMN;y++){
        for(int x=0;x<ROW;x++){
            [self initTileSize:CELL_WIDTH :CELL_HEIGHT X:x Y:y];
        }
    }
}

-(void) initTiles{
    self.timer = 0.0;
    for(int y=0;y<COLUMN;y++){
        for(int x=0;x<ROW;x++){
            Tile* tile = [self getTileByX:x Y:y];
            tile.beforeTile = nil;
            tile.isSearched = NO;
            tile.isShortcut = NO;
            tile.isMarked = NO;
        }
    }

    Tile* tile = self.tileArray[0];
    tile.beforeTile = nil;
    tile.isSearched = YES;
    tile.isShortcut = YES;
    tile.isMarked = YES;
    [self scan:tile];
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

-(NSInteger)randomGet:(NSMutableArray*)array{
    if(array ==nil || [array count] == 0){
        return -1;
    }
    return arc4random() % [array count];
}

-(Tile*)choiceTile:(Tile *)tile{
    NSMutableArray* tiles = [self surroundTiles:tile];
    if([tiles count] > 0){
        int index = [self randomGet:tiles];
        Tile* choice = tiles[index];
        choice.beforeTile = tile;
        choice.isSearched = YES;
        return choice;
    }
    return [self choiceTile:tile.beforeTile];
}

-(void) scan:(Tile*)tile{
    NSInteger count = 0;
    for(int i=0;i<[self.tileArray count];i++){
        Tile* tile = self.tileArray[i];
        if(tile.isSearched){
            count++;
        }
    }
    if(count >= ROW*COLUMN){
        return;
    }else{
        return [self scan:[self choiceTile:tile]];
    }
}

-(void) initTileSize:(NSInteger)width :(NSInteger)height X:(NSInteger)x Y:(NSInteger)y{
    Tile *tile = [[Tile alloc] init];
    tile.x = x;
    tile.y = y;
    [self.tileArray addObject:tile];
}


// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value

	if( (self=[super init]) ) {
        self.touchEnabled = YES;
        [self genTiles];
        [self initTiles];

        [self setButton1];
        [self gameStart];

        self.timerLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%.01f",10.0f] fontName:@"Marker Felt" fontSize:36];
        self.timerLabel.position = CGPointMake(110, 270);
        [self addChild:self.timerLabel];

        self.levelLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Lavel:%d",1] fontName:@"Marker Felt" fontSize:36];
        self.levelLabel.position = CGPointMake(90, 200);
        [self addChild:self.levelLabel];

	}
	return self;
}

- (void)gameStart{
    // タイマーの初期化
    self.timer = 0.0;
    // ｓタイマーを0.1秒間隔で回す
    [self schedule:@selector(updateTimer) interval:0.1];
}

- (void)updateTimer{
    self.timer += 0.1;
    [self.timerLabel setString:[NSString stringWithFormat:@"%.01f",self.timer]];
}

- (void)stopTimer{
    // タイマーを止める
    [self unschedule:@selector(updateTimer)];
    return;
}

- (void) nextFrame:(ccTime)dt {
    for(CCSprite* sprite in self.tileArray){
        sprite.position = ccp( sprite.position.x + 100*dt, sprite.position.y );
        if (sprite.position.x > 480+32) {
            sprite.position = ccp( -32, sprite.position.y );
        }
    }
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint location = [self getTouchEventPoint:(NSSet *)touches withEvent:(UIEvent *)event];
    int offX = location.x;
    int offY = location.y;
    [self setMarkNearTileX:offX Y:offY];
}

-(CGPoint)getTouchEventPoint:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch =[touches anyObject];
    CGPoint location =[touch locationInView:[touch view]];
    return [[CCDirector sharedDirector] convertToGL:location];
}

-(BOOL)setMarkNearTileX:(NSInteger)x Y:(NSInteger) y {
    for(Tile* tile in self.tileArray){
        float tile_x = (float)tile.x*CELL_WIDTH+OFFSET_X;
        float tile_y = (float)tile.y*CELL_HEIGHT+OFFSET_Y;
        if(tile_x - CELL_WIDTH <= x && x <= tile_x+CELL_WIDTH && tile_y - CELL_HEIGHT <= y && y <= tile_y+CELL_HEIGHT && tile.beforeTile.isMarked){
            tile.isMarked = YES;
            if(tile.x == ROW-1 && tile.y == COLUMN-1){
                [self stopTimer];
                self.pathStack = [NSMutableArray array];
                [self path:self.tileArray[ROW*COLUMN-1] :self.pathStack];
            }
            return YES;
        }
    }
    return NO;
}

//タッチの移動
-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event];
}

//タッチの終了
-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event];
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

-(NSMutableArray*)path:(Tile*)tile :(NSMutableArray*)stack{
    if(tile.beforeTile){
        [stack addObject:tile];
        tile.isShortcut = YES;
        return [self path:tile.beforeTile:stack];
    }else{
        return stack;
    }
}

-(void)draw{
    [super draw];
    if(self.tileArray){
        for(Tile* tile in self.tileArray){
            if(tile){
                CGPoint p1,p2;
                p1=CGPointMake((float)tile.beforeTile.x*CELL_WIDTH+OFFSET_X,(float)tile.beforeTile.y*CELL_HEIGHT+OFFSET_Y);
                p2=CGPointMake((float)tile.x*CELL_WIDTH+OFFSET_X, (float)tile.y*CELL_HEIGHT+OFFSET_Y);
                if(tile.isShortcut){
                    ccDrawColor4F(1.0f, 0.0f, 0.0f, 1.0f);
                }else if(tile.isMarked){
                    ccDrawColor4F(0.0f, 0.0f, 1.0f, 1.0f);
                }else{
                    ccDrawColor4F(0.0f, 1.0f, 0.0f, 1.0f);
                }
                glLineWidth(CELL_WIDTH);
                ccDrawLine(p1, p2);
            }
        }
    }
}

-(void)setButton1{
    CCMenuItem * item1 = [CCMenuItemImage itemWithNormalImage:@"gen_btn.png" selectedImage:@"gen_btn.png" target:self selector:@selector(funcButtonPush:)];
    item1.tag=11;

    CCMenuItem * item2 = [CCMenuItemImage itemWithNormalImage:@"gen_btn.png" selectedImage:@"gen_btn.png" target:self selector:@selector(funcButtonPush2:)];
    item2.tag=21;

    CCMenu * menu  = [CCMenu menuWithItems:item1,item2,nil];
    [menu alignItemsVerticallyWithPadding:10];
    CGSize size = [[CCDirector sharedDirector] winSize];
    [menu setPosition:ccp(size.width/2+size.width/3, size.height/2)];
    [self addChild:menu];
}

-(void) funcButtonPush: (id) sender
{
    [self initTiles];
    [self schedule:@selector(updateTimer) interval:0.1];
}

-(void) funcButtonPush2: (id) sender
{
    [self genTiles];
    [self initTiles];
    self.level += 1;
    NSString *str = [[NSString alloc] initWithFormat:@"Level:%d", self.level];
    [self.levelLabel setString: [NSString stringWithFormat:@"%@",str]];
    [self schedule:@selector(updateTimer) interval:0.1];
}
@end
