//
//  UserApi.m
//  minosound
//
//  Created by Yuta Mizushima on 2013/08/18.
//  Copyright (c) 2013年 水島 雄太. All rights reserved.
//

#import "UserApi.h"

@implementation UserApi

+ (User*)getUser:(NSInteger)user_id {
    NSString *apiUrlJson = @"http://localhost:5000/users/id/1";
    NSLog(@"WebAPIのURL：%@",apiUrlJson );
    NSURL *httpDataUrl2 = [NSURL URLWithString:apiUrlJson];
    NSURLRequest *request = [NSURLRequest requestWithURL:httpDataUrl2];
    NSData *json_data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:json_data options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"jsonObject:%@", jsonObject);
}

@end
