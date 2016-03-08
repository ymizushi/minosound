#import <Foundation/Foundation.h>

#define BASE_URL @"http://minosound.ymizushi.cloudbees.net"
#define DEBUG_BASE_URL @"http://localhost:5000"
#define NOTIFICATIONS_URL @"/notifications"

@interface Config : NSObject
+ (NSString*)getBaseUrl;
+ (NSString*)getNotificationsUrl;
@end