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