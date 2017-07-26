//
//  AnswerCell.m
//  Nurse App
//
//  Created by ram mendhe on 01/06/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import "AnswerCell.h"

@implementation AnswerCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    NSLog(@"setSelected");
    if (selected) {
        self.selectionImage.image=[UIImage imageNamed:@"SelectedOptionButton"];
        self.backgroundImage.image=[UIImage imageNamed:@"ChapterSelectionButton"];
    }else{
        self.selectionImage.image=[UIImage imageNamed:@"UnselectedOptionButton"];
        self.backgroundImage.image=[UIImage imageNamed:@"answer_box.png"];
    }
}

@end
