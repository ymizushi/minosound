#import <GameKit/GameKit.h>
#import "CCTouchDispatcher.h"

#import "cocos2d.h"

@interface HelpLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>

    
+(CCScene *) scene;
@end