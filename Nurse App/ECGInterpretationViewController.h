//
//  ECGInterpretationViewController.h
//  Nurse App
//
//  Created by ram mendhe on 14/11/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ECGInterpretationViewController : UIViewController


@property (strong, nonatomic) NSArray *imageArray;
@property (strong, nonatomic) NSString *pageTitle;
@property (assign, nonatomic) int index;

@property (strong, nonatomic) IBOutlet UITableView *ecgiTableView;

@property(nonatomic,strong)IBOutlet UIView * ecgiLargeView;
@property (strong, nonatomic) IBOutlet UIImageView *ecgiLargeImageView;

@property(nonatomic,strong)IBOutlet UIView * ecgiInterTwoView;

@property(nonatomic,assign) BOOL isSecondScreenDisplay;


-(void)showGraphView:(UIImage *)img;

@end
