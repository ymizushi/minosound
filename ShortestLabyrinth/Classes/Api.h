#import <Foundation/Foundation.h>
#import "Request.h"

@interface Api : NSObject

+ (NSDictionary*)fetch: (Request*)request;

@end
