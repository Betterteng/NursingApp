//
//  CPDViewController.h
//  Nurse App
//
//  Created by ram mendhe on 06/04/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
@interface CPDViewController : UIViewController<MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) NSString* totalDuration;
@property (strong, nonatomic) IBOutlet UITableView *cpdTableView;
@property (strong, nonatomic) NSMutableArray* cpdEntryArray;

@end
