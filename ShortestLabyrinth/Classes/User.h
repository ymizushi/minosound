//
//  User.h
//  minosound
//
//  Created by Yuta Mizushima on 2013/08/18.
//  Copyright (c) 2013年 水島 雄太. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (nonatomic, readonly) NSInteger user_id;
@property (nonatomic, readonly) NSString* name;
@property (nonatomic, readonly) NSString* device_token;
@property (nonatomic, readonly) NSInteger level;
@property (nonatomic, readonly) NSInteger clear_count;
@property (nonatomic, readonly) NSDate* created_at;
- (id)init;
@end


