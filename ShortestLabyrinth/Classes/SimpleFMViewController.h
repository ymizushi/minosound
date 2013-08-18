//
//  SimpleFMViewController.h
//  SimpleFM
//
//  Created by Norihisa Nagano
//  Modified by Yuta Mizushima

//

#import <UIKit/UIKit.h>
#import "SimpleFM.h"
@interface SimpleFMViewController : UIViewController {
    SimpleFM *simpleFM;
    IBOutlet UITextField *carrierFreqField;
    IBOutlet UITextField *modulatorFreqField;
    IBOutlet UITextField *modulatorAmpField;
    
    IBOutlet UISlider *carrierFreqSlider;
    IBOutlet UISlider *modulatorFreqSlider;
    IBOutlet UISlider *modulatorAmpSlider;
}

- (IBAction)carrierFreqAction:(UISlider*)sender;
- (IBAction)modulatorFreqAction:(UISlider*)sender;
- (IBAction)modulatorAmpAction:(UISlider*)sender;

- (void)updateAllValues;

- (IBAction)play:(id)sender;
- (IBAction)stop:(id)sender;

@end