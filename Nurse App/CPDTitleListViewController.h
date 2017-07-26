//
//  CPDTitleListViewController.h
//  Nurse App
//
//  Created by ram mendhe on 12/04/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPDProfileEntryViewController.h"

@interface CPDTitleListViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *cpdTitleTableView;
@property (strong, nonatomic) NSArray* titlesArray;
@property (strong, nonatomic) NSString* selectedTitle;
@property (strong, nonatomic) CPDProfileEntryViewController* cPDProfileEntryViewController;

@end
