//
//  SimpleFM.h
//  SimpleFM
//
//  Created by Norihisa Nagano
//  Modified by Yuta Mizushima
//

#import <Foundation/Foundation.h>
#import <AudioUnit/AudioUnit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "iPhoneCoreAudio.h"
#import "Envelope.h"

typedef struct FMInfo {
    double carrierFreq; //キャリア周波数
    double harmonicityRatio; //C:M比
    double modulatorIndex; //変調指数
	double phase; //キャリアの位相
    double modulatorPhase;//モジュレーターの位相
    Float64 sampleRate;
    
    //追加
    Envelope *ampEnv; //音量のエンベローブ
    Envelope *ratioEnv; //変調指数のエンベローブ
    UInt32 currentFrame; //現在のフレーム
    UInt32 totalFrames;  //総フレーム数
    BOOL isDone; //総フレーム数再生したかどうかを表すフラグ
}FMInfo;

@interface SimpleFM : NSObject {
    FMInfo fmInfo;    
    AudioUnit audioUnit;
    BOOL isPlaying;
}

@property double carrierFreq;
@property double harmonicityRatio;
@property double modulatorIndex;

- (void)start;
- (void)play;
- (void)stop;
- (void)prepareAudioUnit;

@end