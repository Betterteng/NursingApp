//
//  ChapterResultScoreCell.h
//  Nurse App
//
//  Created by Asmita on 01/06/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChapterResultScoreCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIView* scoreView;

@property (nonatomic, strong) IBOutlet UILabel* percentLabel;
@property (nonatomic, strong) IBOutlet UIButton* menuButton;
@property (nonatomic, strong) IBOutlet UIButton* replayButton;
@end
