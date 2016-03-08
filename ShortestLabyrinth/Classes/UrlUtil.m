#import "Config.h"
#import "UrlUtil.h"

@implementation UrlUtil
+ genUrl:(NSArray*)params {
    NSString* urlStr = [Config getBaseUrl];
    for(NSString* paramStr in params){
        urlStr = [urlStr stringByAppendingString:paramStr];
    }
    return urlStr;
}
@end
