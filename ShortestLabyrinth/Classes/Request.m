//
//  Request.m
//  minosound
//
//  Created by Yuta Mizushima on 2013/11/09.
//  Copyright (c) 2013年 水島 雄太. All rights reserved.
//

#import "Request.h"

@implementation Request
@synthesize pathParams;
@synthesize queryParams;
@synthesize resourceParams;

- (id) init {
	return self;
}

+ (Request*) create:(NSString*)baseUrl :(NSString*)methodType :(NSDictionary*) pathParams :(NSDictionary*) queryParams :(NSDictionary*) resourceParams {
    Request* request =  [Request new];
    request.methodType = methodType;
    request.pathParams = pathParams;
    request.queryParams = queryParams;
    request.resourceParams = resourceParams;
    return request;
}

- (NSDictionary*) getParams {
    NSMutableDictionary* mergeDictionary = [NSMutableDictionary dictionary];
    [mergeDictionary setDictionary:self.pathParams];
    [mergeDictionary setDictionary:self.queryParams];
    [mergeDictionary setDictionary:self.resourceParams];
    return mergeDictionary;
}

- (NSDictionary*) getParam: (NSString*)key{
    return [[self getParams] objectForKey:key];
}

@end
