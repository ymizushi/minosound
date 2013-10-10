//
//  Config.h
//  minosound
//
//  Created by Yuta Mizushima on 2013/08/18.
//  Copyright (c) 2013年 水島 雄太. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BASE_URL @"http://minosound.ymizushi.cloudbees.net"
#define DEBUG_BASE_URL @"http://localhost:5000"
#define NOTIFICATIONS_URL @"/notifications"

@interface Config : NSObject
+ (NSString*)getBaseUrl;
+ (NSString*)getNotificationsUrl;
@end