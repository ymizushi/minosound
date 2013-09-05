//
//  UserApi.m
//  minosound
//
//  Created by Yuta Mizushima on 2013/08/18.
//  Copyright (c) 2013年 水島 雄太. All rights reserved.
//

#import "UserApi.h"
#import "UrlUtil.h"

@implementation UserApi

+ (NSDictionary*)getJsonUser:(NSInteger)userId {
    NSString* userIdStr = [NSString stringWithFormat:@"%d", userId];
    NSArray* params = @[@"/users/", userIdStr];
    NSString *apiUrlJson = [UrlUtil genUrl:params];
    NSURL *httpDataUrl2 = [NSURL URLWithString:apiUrlJson];
    NSURLRequest *request = [NSURLRequest requestWithURL:httpDataUrl2];
    NSData *json_data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:json_data options:NSJSONReadingAllowFragments error:nil];
    return jsonObject;
}

+ (NSDictionary*)update:(NSInteger)userId :(NSDictionary*)params {
    NSString* userIdStr = [NSString stringWithFormat:@"%d", userId];
    NSString *apiUrlJson = [UrlUtil genUrl:@[@"/users/", userIdStr]];
    NSURL *httpDataUrl2 = [NSURL URLWithString:apiUrlJson];
    
    NSString *postString = [NSString stringWithFormat:@"id=%@&passwd=%@", @"122", @"hogehog"];
    NSData *post = [postString dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSMutableURLRequest *request =  [NSMutableURLRequest requestWithURL:httpDataUrl2 cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [request setHTTPBody:post];
    
    NSURLResponse* response;
    NSError* error = nil;
    NSData* result = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString* resultString = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    NSLog(@"%@", resultString);
    return @{};
    
}

@end
