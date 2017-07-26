//
//  TermsViewController.h
//  Nurse App
//
//  Created by ram mendhe on 09/04/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TermsViewController : UIViewController

@property(nonatomic, strong) IBOutlet UIToolbar* toolBar;

-(IBAction)cancelButtonClicked:(id)sender;
-(IBAction)agreeButtonClicked:(id)sender;
@end
