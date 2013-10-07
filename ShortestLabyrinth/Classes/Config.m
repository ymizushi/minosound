//
//  Config.m
//  minosound
//
//  Created by Yuta Mizushima on 2013/08/18.
//  Copyright (c) 2013年 水島 雄太. All rights reserved.
//

#import "Config.h"

@implementation Config

+ (NSString *)getBaseUrl {
    return BASE_URL;
}

+ (NSString *)getNotificationsUrl {
    return [BASE_URL stringByAppendingString:NOTIFICATIONS_URL];
}


@end
