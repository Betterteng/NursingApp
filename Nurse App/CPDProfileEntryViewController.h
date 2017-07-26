//
//  CPDProfileEntryViewController.h
//  Nurse App
//
//  Created by ram mendhe on 12/04/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPDProfileEntryViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *cpdEntryTableView;
@property (strong, nonatomic) NSArray* titlesArray;

@property (strong, nonatomic) NSString* valueTitle;
@property (strong, nonatomic) NSString* valueNotes;
@property (strong, nonatomic) NSString* valueDate;
@property (strong, nonatomic) NSString* valueDuration;
@property (strong, nonatomic) NSString* valueTimestamp;

@property (strong, nonatomic) NSMutableArray* entryFormCellArray;

@end
