//
//  SimpleFMViewController.m
//  SimpleFM
//
//  Created by Norihisa Nagano
//

#import "SimpleFMViewController.h"

@implementation SimpleFMViewController

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self != nil){
        simpleFM = [[SimpleFM alloc]init];
    }
    return self;
}

-(IBAction)play:(id)sender{
    [simpleFM play];
}

-(IBAction)stop:(id)sender{
    [simpleFM stop];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self updateAllValues];
}

-(void)updateAllValues{
    simpleFM.carrierFreq = carrierFreqSlider.value = [carrierFreqField.text doubleValue];
    simpleFM.harmonicityRatio = modulatorFreqSlider.value = [modulatorFreqField.text doubleValue];
    simpleFM.modulatorIndex = modulatorAmpSlider.value = [modulatorAmpField.text doubleValue];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self updateAllValues];
    return YES;
}

- (void)viewDidLoad{
    carrierFreqSlider.value = simpleFM.carrierFreq;
    modulatorFreqSlider.value = simpleFM.harmonicityRatio;
    modulatorAmpSlider.value = simpleFM.modulatorIndex;
    
    carrierFreqField.text = [NSString stringWithFormat:@"%.3f",simpleFM.carrierFreq];
    modulatorFreqField.text = [NSString stringWithFormat:@"%.3f",simpleFM.harmonicityRatio];
    modulatorAmpField.text = [NSString stringWithFormat:@"%.3f",simpleFM.modulatorIndex];
    
    [self updateAllValues];
}

-(IBAction)carrierFreqAction:(UISlider*)sender{
    simpleFM.carrierFreq = sender.value;
    carrierFreqField.text = [NSString stringWithFormat:@"%.3f",sender.value];
}

-(IBAction)modulatorFreqAction:(UISlider*)sender{
    simpleFM.harmonicityRatio = sender.value;
    modulatorFreqField.text = [NSString stringWithFormat:@"%.3f",sender.value];
}

-(IBAction)modulatorAmpAction:(UISlider*)sender{
    simpleFM.modulatorIndex = sender.value;
    modulatorAmpField.text = [NSString stringWithFormat:@"%.3f",sender.value];
}

- (void)dealloc {
    [simpleFM release];
    [super dealloc];
}

@end