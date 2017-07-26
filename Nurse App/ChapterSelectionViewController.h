//
//  ChapterSelectionViewController.h
//  Nurse App
//
//  Created by ram mendhe on 30/05/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChapterSelectionViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *chapterSelectionTableView;
@property (nonatomic, assign) int chapterNumber;

@end
