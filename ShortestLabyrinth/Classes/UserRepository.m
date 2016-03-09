#import "UserRepository.h"
#import "UserApi.h"

@implementation UserRepository
+ getUser:(NSInteger)userId {
    User* user = [User new];
    [user initData:[UserApi getJsonUser:userId][@"result"]];
    return user;
}
@end
