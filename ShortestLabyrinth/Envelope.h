//
//  Envelope.h
//  Env
//
//  Created by Norihisa Nagano
//

#import <Foundation/Foundation.h>
#define ENV_NUMBER_OF_POINT 5

@interface Envelope : NSObject {
    CGPoint points[ENV_NUMBER_OF_POINT];
    UInt32 currentIndex;
    UInt32 totalFrames;
    float sampleRate;
    float duration; //seconds
    float max;
}

@property float duration;

-(id)initWithDuration:(float)dur sampleRate:(float)sampleRate max:(float)max_;
-(float)valueForFrame:(UInt32)frame;
-(void)toTheTop;

-(float)max;
-(CGPoint*)points;
-(UInt32)totalFrames;
@end