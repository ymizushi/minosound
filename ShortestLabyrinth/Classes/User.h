

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (nonatomic) NSInteger user_id;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* device_token;
@property (nonatomic) NSInteger level;
@property (nonatomic) NSInteger clear_count;
@property (nonatomic, retain) NSDate* created_at;

- (id)init;
- (void)initData:(NSDictionary*)userDict;
- (void)debugLog;
@end


