//
//  QuizQuestionViewController.h
//  Nurse App
//
//  Created by ram mendhe on 01/06/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuizQuestionViewController : UIViewController

@property (nonatomic,strong) IBOutlet UITableView* questionsTableView;
@property (nonatomic,strong) NSString* chapterno;
@property (nonatomic,strong) NSString* yearno;
@end
