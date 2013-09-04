//
//  UrlUtil.m
//  minosound
//
//  Created by Yuta Mizushima on 2013/08/18.
//  Copyright (c) 2013年 水島 雄太. All rights reserved.
//

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
