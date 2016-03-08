

#import "User.h"

@implementation User
- (id)init {
	[super init];
	return self;
}

- (void)initData:(NSDictionary*)userDict {
    self.user_id = (int)userDict[@"id"];
    self.name = userDict[@"name"];
    self.device_token = userDict[@"device_token"];
    self.level = (int)userDict[@"level"];
    self.clear_count = (int)userDict[@"clear_count"];
    self.created_at = userDict[@"created_at"];
}

- (void)debugLog {
    NSLog(@"fields:%ld, %@ ,%@ ,%ld , %ld ,%@ end", self.user_id, self.name, self.device_token, self.level, self.clear_count, self.created_at);
}

@end
