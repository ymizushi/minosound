//
//  SimpleFMAppDelegate.h
//  SimpleFM
//
//  Created by Norihisa Nagano
//

#import <UIKit/UIKit.h>

@class SimpleFMViewController;

@interface SimpleFMAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    SimpleFMViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SimpleFMViewController *viewController;

@end

