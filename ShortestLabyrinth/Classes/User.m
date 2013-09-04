//
//  User.m
//  minosound
//
//  Created by Yuta Mizushima on 2013/08/18.
//  Copyright (c) 2013年 水島 雄太. All rights reserved.
//

#import "User.h"

@implementation User
- (id)init {
	[super init];
	return self;
}

- (void)initData:(NSDictionary*)userDict {
    self.user_id = userDict[@"id"];
    self.name = userDict[@"name"];
    self.device_token = userDict[@"device_token"];
    self.level = userDict[@"level"];
    self.clear_count = userDict[@"clear_count"];
    self.created_at = userDict[@"created_at"];
}

- (void)debugLog {
    NSLog(@"fields:%d", self.user_id);
}

@end
