//
//  UserApi.h
//  minosound
//
//  Created by Yuta Mizushima on 2013/08/18.
//  Copyright (c) 2013年 水島 雄太. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Api.h"
#import "UserApi.h"
#import "User.h"

@interface UserApi : Api
+ (NSDictionary*)getJsonUser: (NSInteger)user_id;
@end
