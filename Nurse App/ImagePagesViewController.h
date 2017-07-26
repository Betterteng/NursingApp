//
//  ImagePagesViewController.h
//  Nurse App
//
//  Created by ram mendhe on 09/04/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridTablevViewCell.h"

@interface ImagePagesViewController : UIViewController<UIScrollViewDelegate,cellProtocol>

@property (strong, nonatomic) NSArray *imageArray;
@property (strong, nonatomic) NSString *pageTitle;
@property (assign, nonatomic) int index;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *pageImageView;

@property (strong, nonatomic) IBOutlet UITableView* rhythmTableView;
@property(nonatomic,strong)IBOutlet UIView * rhythmLargeView;
@property (strong, nonatomic) IBOutlet UIImageView *rhythmLargeImageView;

@property(nonatomic,strong)NSMutableArray * cellArray;
@property(nonatomic)Boolean isRhythmanalysisSelected;

@end
