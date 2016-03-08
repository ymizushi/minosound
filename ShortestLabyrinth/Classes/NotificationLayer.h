#import <GameKit/GameKit.h>
#import "CCTouchDispatcher.h"

#import "cocos2d.h"

@interface NotificationLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate> {
    UIView* notificationView;
}
@property (nonatomic, retain)UIView* notificationView;
+ (CCScene *) scene;
@end