//
//  SynthesizerLayer.h
//  minosound
//
//  Created by Yuta Mizushima on 2013/09/11.
//  Copyright (c) 2013年 水島 雄太. All rights reserved.
//

#import <GameKit/GameKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CCTouchDispatcher.h"

#import "cocos2d.h"
#import "SimpleFM.h"

@interface SynthesizerLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate, CLLocationManagerDelegate> {
}
@property (nonatomic, retain) SimpleFM *synthesizer;
@property (nonatomic) BOOL touching;
@property (nonatomic, retain) CLLocationManager *locationManager;

+ (CCScene *) scene;
@end