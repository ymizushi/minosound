//
//  SimpleFM.m
//  SimpleFM
//
//  Created by Norihisa Nagano
//  Modified by Yuta Mizushima
//

#import "SimpleFM.h"


@implementation SimpleFM

@synthesize carrierFreq;
@synthesize harmonicityRatio;
@synthesize modulatorIndex;

static OSStatus renderCallback(void*                       inRefCon,
                               AudioUnitRenderActionFlags* ioActionFlags,
                               const AudioTimeStamp*       inTimeStamp,
                               UInt32                      inBusNumber,
                               UInt32                      inNumberFrames,
                               AudioBufferList*            ioData){
    FMInfo *def = (FMInfo*)inRefCon;
    Envelope *ampEnv = def->ampEnv;
    Envelope *ratioEnv = def->ratioEnv;
    
    //再生済みの場合は、0で埋めてreturn;
    AudioUnitSampleType *output = ioData->mBuffers[0].mData;
    if(def->isDone){
        memset(output, 0, sizeof(AudioUnitSampleType) * inNumberFrames);
        return noErr;
    }
    
    Float64 sampleRate = def->sampleRate;
    double carrierFreq = def->carrierFreq;
    double harmonicityRatio = def->harmonicityRatio;
    double modulatorIndex = def->modulatorIndex;
    
    double phase = def->phase;
    double modulatorPhase = def->modulatorPhase;
    
    UInt32 currentFrame = def->currentFrame;
    UInt32 totalFrames = def->totalFrames;
    
    //キャリア周波数 * C:M比 = モジュレーター周波数
    double modulatorFreq = carrierFreq * harmonicityRatio;
    double modfreq = modulatorFreq * 2.0 * M_PI / sampleRate;
    
    for(int i = 0; i< inNumberFrames; i++){
        //totalFrames分再生したら、0で埋める
        if(currentFrame >= totalFrames){
            def->isDone = YES;
            *output++ = 0;
        }else{
            //先にモジュレーターの波形を計算
            double modWave = sin(modulatorPhase);
            
            //変調指数のエンベローブ
            float ratioEnvValue = [ratioEnv valueForFrame:currentFrame];
            //モジュレーター周波数 * 変調指数 A = M x Iにエンベローブを反映する
            double modulatorAmp = modulatorIndex * ratioEnvValue * modulatorFreq;
            
            //キャリアの周波数を計算
            double freq = (carrierFreq + (modWave * modulatorAmp)) * 2.0 * M_PI / sampleRate;
            //キャリアの波形を計算
            float wave = sin(phase);
            //音量のエンベローブを反映する
            float ampEnvValue = [ampEnv valueForFrame:currentFrame];
            AudioUnitSampleType sample = wave * ampEnvValue * (1 << kAudioUnitSampleFractionBits);
            *output++ = sample;
            
            phase = phase + freq;
            modulatorPhase = modulatorPhase + modfreq;
            
            currentFrame++;
        }
    }
    
    def->currentFrame = currentFrame;
    
    def->phase = phase;
    def->modulatorPhase = modulatorPhase;
    return noErr;
}

- (id)init{
    self = [super init];
    if (self != nil)[self prepareAudioUnit];
    return self;
}


-(void)setCarrierFreq:(double)carrierFreq{
    fmInfo.carrierFreq = carrierFreq;
}

-(void)setHarmonicityRatio:(double)harmonicityRatio{
    fmInfo.harmonicityRatio = harmonicityRatio;
}

-(void)setModulatorIndex:(double)modulatorIndex{
    fmInfo.modulatorIndex = modulatorIndex;
}


-(double)carrierFreq{
    return fmInfo.carrierFreq;
}

-(double)harmonicityRatio{
    return fmInfo.harmonicityRatio;
}

-(double)modulatorIndex{
    return fmInfo.modulatorIndex;
}

- (void)prepareAudioUnit{
    AudioComponentDescription cd;
    cd.componentType = kAudioUnitType_Output;
    cd.componentSubType = kAudioUnitSubType_RemoteIO;
    cd.componentManufacturer = kAudioUnitManufacturer_Apple;
    cd.componentFlags = 0;
    cd.componentFlagsMask = 0;
    
    AudioComponent component = AudioComponentFindNext(NULL, &cd);
    AudioComponentInstanceNew(component, &audioUnit);
    
    AudioUnitInitialize(audioUnit);
    
    AURenderCallbackStruct callbackStruct;
    callbackStruct.inputProc = renderCallback;
    callbackStruct.inputProcRefCon = &fmInfo;
    
    AudioUnitSetProperty(audioUnit, 
                         kAudioUnitProperty_SetRenderCallback, 
                         kAudioUnitScope_Input,
                         0,
                         &callbackStruct,
                         sizeof(AURenderCallbackStruct));
        
    AudioStreamBasicDescription audioFormat = AUCanonicalASBD(44100.0, 1);
    AudioUnitSetProperty(audioUnit,
                         kAudioUnitProperty_StreamFormat,
                         kAudioUnitScope_Input,
                         0,
                         &audioFormat,
                         sizeof(audioFormat));
    
    fmInfo.sampleRate = 44100.0;
    fmInfo.phase = 0.0;
    fmInfo.modulatorPhase = 0.0;
    
    fmInfo.carrierFreq = 2597.701;
    fmInfo.harmonicityRatio = 8.410;
    fmInfo.modulatorIndex = 7.797;
    
    //音量のエンベローブ
    fmInfo.ampEnv = [[Envelope alloc]initWithDuration:0.233
                                           sampleRate:44100 
                                                  max:1.0];
    //変調指数のエンベローブ    
    fmInfo.ratioEnv = [[Envelope alloc]initWithDuration:0.233 
                                             sampleRate:44100 
                                                    max:1.0];
    
    fmInfo.totalFrames = [fmInfo.ratioEnv totalFrames];
    
    fmInfo.isDone = YES;
    [self start]; //処理を開始しておく
}

-(void)play{
    //Envelopeクラスの現在の位置（x軸）を0にする
    [fmInfo.ampEnv toTheTop];
    [fmInfo.ratioEnv toTheTop];
    fmInfo.isDone = NO;
    fmInfo.currentFrame = 0;
}

-(void)start{
    if(!isPlaying)AudioOutputUnitStart(audioUnit);
    isPlaying = YES;
}

-(void)stop{
    if(isPlaying)AudioOutputUnitStop(audioUnit);
    isPlaying = NO;
}

-(void)dealloc{
    [self stop];
    [fmInfo.ampEnv release];
    [fmInfo.ratioEnv release];
    AudioUnitUninitialize(audioUnit);
    AudioComponentInstanceDispose(audioUnit);
    [super dealloc];
}

@end