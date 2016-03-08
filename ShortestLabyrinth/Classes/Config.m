#import "Config.h"

@implementation Config

+ (NSString *)getBaseUrl {
    return BASE_URL;
}

+ (NSString *)getNotificationsUrl {
    return [BASE_URL stringByAppendingString:NOTIFICATIONS_URL];
}


@end
