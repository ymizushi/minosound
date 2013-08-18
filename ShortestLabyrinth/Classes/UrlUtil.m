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
+ genUrl:(NSString*)paramString {
    NSString *str = [NSString stringWithFormat:@"%@%@",[Config getBaseUrl],paramString];
    return str;
}
@end
