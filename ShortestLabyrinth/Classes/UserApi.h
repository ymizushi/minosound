

#import <Foundation/Foundation.h>
#import "Api.h"
#import "UserApi.h"
#import "User.h"

@interface UserApi : Api
+ (NSDictionary*)getJsonUser: (NSInteger)user_id;
@end
