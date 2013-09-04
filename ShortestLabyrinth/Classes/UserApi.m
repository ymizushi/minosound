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

@end
