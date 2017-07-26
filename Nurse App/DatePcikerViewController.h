//
//  DatePcikerViewController.h
//  Nurse App
//
//  Created by ram mendhe on 14/04/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPDProfileEntryViewController.h"

@interface DatePcikerViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIDatePicker* datepicker;
@property (strong, nonatomic) NSString* selectedDate;
@property (strong, nonatomic) CPDProfileEntryViewController* cPDProfileEntryViewController;


@end
