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
+ getUser:(NSInteger)userId {
    User* user = [User new];
    [user initData:[UserApi getJsonUser:userId][@"result"]];
    return user;
}
@end
