//
//  DurationPcikerViewController.h
//  Nurse App
//
//  Created by ram mendhe on 14/04/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPDProfileEntryViewController.h"

@interface DurationPcikerViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIPickerView* durationpicker;
@property (strong, nonatomic) NSString* selectedduration;

@property (assign, nonatomic) NSInteger hours;
@property (assign, nonatomic) NSInteger mins;

@property (strong, nonatomic) CPDProfileEntryViewController* cPDProfileEntryViewController;


@end
