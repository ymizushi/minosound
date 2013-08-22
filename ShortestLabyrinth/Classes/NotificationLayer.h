//
//  NotificationLayer.h
//  minosound
//
//  Created by Yuta Mizushima on 2013/08/23.
//  Copyright (c) 2013年 水島 雄太. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "CCTouchDispatcher.h"

#import "cocos2d.h"

@interface NotificationLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>

+ (CCScene *) scene;
@end