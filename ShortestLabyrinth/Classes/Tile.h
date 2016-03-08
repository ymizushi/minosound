@interface Tile : NSObject {
    Tile* beforeTile;
    BOOL isSearched;
    BOOL isShortcut;
    BOOL isMarked;
    NSInteger x;
    NSInteger y;
    double freq;
}

@property (nonatomic, retain)Tile* beforeTile;
@property (nonatomic)BOOL isSearched;
@property (nonatomic)BOOL isShortcut;
@property (nonatomic)BOOL isMarked;
@property (nonatomic)NSInteger x;
@property (nonatomic)NSInteger y;
@property (nonatomic)double freq;

@end
