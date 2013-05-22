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
#import "math.h"
#import "SimpleAudioEngine.h"

#pragma mark - TilesLayer

// TilesLayer implementation
@implementation TilesLayer
@synthesize tileArray;
@synthesize pathStack;
@synthesize timerLabel;
@synthesize levelLabel;
@synthesize timer;
@synthesize level;
@synthesize color;
@synthesize enableSound;
@synthesize playPathIndex;

// Helper class method that creates a Scene with the TilesLayer as the only child.
+ (CCScene *)scene
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

- (id)init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
    
	if( (self=[super init]) ) {
        self.scaleMap = @{
                          @"A2"  :[NSNumber numberWithDouble:440.0f],
                          //                          @"AS2" :[NSNumber numberWithDouble:466.163762f],
                          @"B2"  :[NSNumber numberWithDouble:493.883301f],
                          @"C2"  :[NSNumber numberWithDouble:523.251131f],
                          //                          @"CS2" :[NSNumber numberWithDouble:554.365262f],
                          @"D2"  :[NSNumber numberWithDouble:587.329536f],
                          //                          @"DS2" :[NSNumber numberWithDouble:622.253967f],
                          @"E2"  :[NSNumber numberWithDouble:659.255114f],
                          @"F2"  :[NSNumber numberWithDouble:698.456463f],
                          //                          @"FS2" :[NSNumber numberWithDouble:739.988845f],
                          @"G2"  :[NSNumber numberWithDouble:783.990872f],
                          //                          @"GS2" :[NSNumber numberWithDouble:830.609395f],
                          };
        self.touchEnabled = YES;
        [self genTiles];
        
        [self initTiles];
        
        [self setButton1];
        [self gameStart];
        
        self.timerLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%.01f",10.0f]
                                             fontName:@"Marker Felt"
                                             fontSize:36];
        self.timerLabel.position = CGPointMake(110, 270);
        [self addChild:self.timerLabel];
        
        //        self.levelLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Lavel:%d",1] fontName:@"Marker Felt" fontSize:36];
        //        self.levelLabel.position = CGPointMake(90, 200);
        //        [self addChild:self.levelLabel];
        
        self.simpleFM = [[SimpleFM alloc]init];
        self.diff = 0.01;
        
	}
	return self;
}

#pragma mark - init

- (void)genTiles
{
    self.tileArray = [NSMutableArray array];
    for(int y=0;y<COLUMN;y++){
        for(int x=0;x<ROW;x++){
            [self initTileSize:CELL_WIDTH
                        height:CELL_HEIGHT
                             X:x
                             Y:y];
        }
    }
}

- (void)initTiles
{
    self.timer = 0.0;
    for(int y=0;y<COLUMN;y++){
        for(int x=0;x<ROW;x++){
            Tile* tile = [self getTileByX:x Y:y];
            tile.beforeTile = nil;
            tile.isSearched = NO;
            tile.isShortcut = NO;
            tile.isMarked = NO;
            tile.freq = 0;
        }
    }

    Tile* tile = self.tileArray[0];
    tile.beforeTile = nil;
    tile.isSearched = YES;
    tile.isShortcut = YES;
    tile.isMarked = YES;
    tile.freq = 0;
    
    [self scan:tile];
    [self setPathFreq:self.tileArray[ROW*COLUMN-1]];
}

-(void)setButton1
{
    CCMenuItem * item1 = [CCMenuItemImage itemWithNormalImage:@"gen.png"
                                                selectedImage:@"gen_disabled.png"
                                                       target:self
                                                     selector:@selector(genButtonPush:)];
    item1.tag = 11;
    
    CCMenuItem * item2 = [CCMenuItemImage itemWithNormalImage:@"music.png"
                                                selectedImage:@"music_disabled.png"
                                                       target:self
                                                     selector:@selector(enableMusic:)];
    item2.tag = 21;
    
    CCMenu * menu  = [CCMenu menuWithItems:item1,item2,nil];
    [menu alignItemsVerticallyWithPadding:10];
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    NSInteger intPos = 320;
    CGSize winSize = [CCDirector sharedDirector].winSize;
    if (winSize.width == 568) {
        // iPhone 5
        intPos = 320+88;
    }
    
    [menu setPosition:ccp(size.width/2+size.width/3 -intPos, size.height/2)];
    [self addChild:menu];
}

- (void)gameStart{
    // タイマーの初期化
    self.timer = 0.0;
    // ｓタイマーを0.1秒間隔で回す
    [self schedule:@selector(updateTimer) interval:0.1];
}

#pragma mark - Push

- (void)genButtonPush: (id) sender
{
    [self initTiles];
    [self schedule:@selector(updateTimer) interval:0.1];
}

- (void)enableMusic:(id)sender
{
    self.enableSound = !self.enableSound;
    SimpleAudioEngine* ae = [SimpleAudioEngine sharedEngine];
    if(self.enableSound){
        [ae playBackgroundMusic:@"music.mp3" loop:YES];
    }else{
        [ae stopBackgroundMusic];
    }
}

#pragma mark - scan

- (void)scan:(Tile *)tile
{
    NSInteger count = 0;
    for(int i=0;i<[self.tileArray count];i++){
        Tile* tile = self.tileArray[i];
        if(tile.isSearched){
            count++;
        }
    }
    
    if(count >= ROW*COLUMN){
        return;
    }
    else {
        return [self scan:[self choiceTile:tile]];
    }
}

#pragma mark - Set Path

-(void)setPathFreq:(Tile*)tile
{
    if(tile.beforeTile){
        tile.freq = [self getRandomFreq];
        return [self setPathFreq:tile.beforeTile];
    }else{
        return;
    }
}

#pragma mark -

- (void)initTileSize:(NSInteger)width
              height:(NSInteger)height
                   X:(NSInteger)x
                   Y:(NSInteger)y
{
    Tile *tile = [[Tile alloc] init];
    tile.x = x;
    tile.y = y;
    [self.tileArray addObject:tile];
}

-(Tile*)getTileByX:(NSInteger)x Y:(NSInteger)y
{
    if(x<0 || y <0 ){
        return nil;
    }
    if(x>= ROW || y >= COLUMN){
        return nil;
    }
    return self.tileArray[y*ROW + x];
}

#pragma mark -

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

- (void)updateTimer{
    self.timer += 0.1;
    [self.timerLabel setString:[NSString stringWithFormat:@"%.01f",self.timer]];
}

- (void)updatePathSound{
    if(self.playPathIndex >= [self.pathStack count]){
        self.playPathIndex = 0;
        [self unschedule:@selector(updatePathSound)];
    }else{
        [self playPathFreq:self.playPathIndex];
    }
    self.playPathIndex+=1;
}


- (void)stopTimer{
    // タイマーを止める
    [self unschedule:@selector(updateTimer)];
    return;
}

- (void) nextFrame:(ccTime)dt
{
    for (CCSprite* sprite in self.tileArray) {
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
            if((!tile.isMarked) && tile.freq > 0){
                [self.simpleFM setCarrierFreq:tile.freq];
                [self.simpleFM play];
            }

            tile.isMarked = YES;
            if(tile.x == ROW-1 && tile.y == COLUMN-1){
                [self stopTimer];
                self.pathStack = [NSMutableArray array];
                [self path:self.tileArray[ROW*COLUMN-1] :self.pathStack];
                [self schedule:@selector(updatePathSound) interval:0.1];
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

-(double)getRandomFreq{
    NSArray *scaleArray = [self.scaleMap allValues];
    NSInteger index = rand() % [scaleArray count];
    return [[scaleArray objectAtIndex:index] doubleValue];
}

-(void)playPathFreq:(NSInteger)index{
    if(index >= [self.pathStack count]){
        return;
    }
    Tile* tile = self.pathStack[index];
    [self.simpleFM setCarrierFreq:tile.freq];
    [self.simpleFM play];
}

-(void)draw{
    [super draw];
    self.color += 0.01;

    if(self.tileArray){
        for(Tile* tile in self.tileArray){
            if(tile){
                CGPoint p1,p2;
                p1=CGPointMake((float)tile.beforeTile.x*CELL_WIDTH+OFFSET_X,(float)tile.beforeTile.y*CELL_HEIGHT+OFFSET_Y);
                p2=CGPointMake((float)tile.x*CELL_WIDTH+OFFSET_X, (float)tile.y*CELL_HEIGHT+OFFSET_Y);
                if(tile.isShortcut){
                    ccDrawColor4F(1.0f, 0.0f, 0.0f, 1.0f);
                }else if(tile.isMarked){
                    ccDrawColor4F((cos(self.color)+1)/4, (sin(self.color)+1)/2, 0.0f, 1.0f);
                }else{
                    ccDrawColor4F(0.0f, 0.0f, 0.5f, 1.0f);
                }
                glLineWidth(CELL_WIDTH);
                ccDrawLine(p1, p2);
            }
        }
    }
}

//-(void) levelUpButtonPush: (id) sender
//{
//    [self genTiles];
//    [self initTiles];
//    self.level += 1;
//    NSString *str = [[NSString alloc] initWithFormat:@"Level:%d", self.level];
//    [self.levelLabel setString: [NSString stringWithFormat:@"%@",str]];
//    [self schedule:@selector(updateTimer) interval:0.1];
//}

@end
