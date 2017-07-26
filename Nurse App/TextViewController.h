//
//  TextViewController.h
//  Nurse App
//
//  Created by ram mendhe on 14/04/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPDProfileEntryViewController.h"
@interface TextViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextView* notesTextView;
@property (strong, nonatomic) NSString* selectedNotes;
@property (strong, nonatomic) CPDProfileEntryViewController* cPDProfileEntryViewController;


@end
