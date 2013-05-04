//
//  Envelope.m
//  Env
//
//  Created by Norihisa Nagano
//

#import "Envelope.h"

@implementation Envelope

@synthesize duration;

-(id)initWithDuration:(float)dur sampleRate:(float)sampleRate_ max:(float)max_{
    self = [super init];
    if (self != nil) {
        sampleRate = sampleRate_;
        duration = dur;
        totalFrames = sampleRate * duration;
        max = max_;
		
		//初期値の設定
		UInt32 xunit = totalFrames / (ENV_NUMBER_OF_POINT - 1);
        float yunit = max / ENV_NUMBER_OF_POINT;
        for(int i = 0; i < ENV_NUMBER_OF_POINT; i++){
            points[i] = CGPointMake(xunit * i, max - (yunit * i));
        }
        points[ENV_NUMBER_OF_POINT - 1].x = totalFrames;
        points[ENV_NUMBER_OF_POINT - 1].y = 0.0;
        
        currentIndex = 0;
    }
    return self;
}

-(float)max{
    return max;
}

-(void)toTheTop{
    currentIndex = 0;
}

-(void)setDuration:(float)dur{
    if(dur < 0.05){
        dur = 0.05;
    }
    
    duration = dur;
    UInt32 totalFrame_ = totalFrames;
    totalFrames = sampleRate * duration;
    
    float unit = (float)totalFrames / totalFrame_;
    for(int i = 0; i < ENV_NUMBER_OF_POINT; i++){
        points[i].x = (UInt32)(points[i].x * unit);
    }
}

-(float)valueForFrame:(UInt32)frame{
    if(frame >= points[ENV_NUMBER_OF_POINT - 1].x){
        return 0;
    }
    
    if(frame >= points[currentIndex + 1].x){
        currentIndex++;
    }
    
    CGPoint a = points[currentIndex];
    CGPoint b = points[currentIndex + 1];
    
    //傾き
    float m = (b.y - a.y) / (b.x - a.x);
    float y = (m * frame - m * a.x) + a.y;
    return y;
}


-(CGPoint*)points{
    return points;
}

-(UInt32)totalFrames{
    return totalFrames;
}

@end