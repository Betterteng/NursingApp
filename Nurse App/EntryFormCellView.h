//
//  EntryFormCellView.h
//  Nurse App
//
//  Created by ram mendhe on 12/04/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EntryFormCellView : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *entryFormBackgroundImage;
@property (strong, nonatomic) IBOutlet UILabel *entryFormTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *entryFormValueLabel;


@end
