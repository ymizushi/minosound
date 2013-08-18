//
//  UserRepository.h
//  minosound
//
//  Created by Yuta Mizushima on 2013/08/18.
//  Copyright (c) 2013年 水島 雄太. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserRepository : NSObject
+ getUser:(NSString*)user_id;
@end
