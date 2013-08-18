//
//  UserRepository.m
//  minosound
//
//  Created by Yuta Mizushima on 2013/08/18.
//  Copyright (c) 2013年 水島 雄太. All rights reserved.
//

#import "UserRepository.h"
#import "UserApi.h"

@implementation UserRepository
+ getUser:(NSString*)user_id {
    NSDictionary* jsonUser = [UserApi getJsonUser:user_id];
}
@end
