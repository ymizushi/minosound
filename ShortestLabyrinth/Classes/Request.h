#import <Foundation/Foundation.h>

#define GET "GET"
#define POST "POST"
#define PUT "PUT"
#define DELETE "DELETE"

@interface Request : NSObject

@property (nonatomic, strong) NSString*methodType;
@property (nonatomic, strong) NSDictionary* pathParams;
@property (nonatomic, strong) NSDictionary* queryParams;
@property (nonatomic, strong) NSDictionary* resourceParams;

@end
