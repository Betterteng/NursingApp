//
//  DatePcikerViewController.m
//  Nurse App
//
//  Created by ram mendhe on 14/04/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import "DatePcikerViewController.h"

@interface DatePcikerViewController ()

@end

@implementation DatePcikerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigationBar];
    self.datepicker.backgroundColor = [UIColor lightGrayColor];
    NSLog(@"selected date %@", self.selectedDate);
    if (self.selectedDate) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd/MM/yyyy"];;
        [dateFormat setTimeZone:[NSTimeZone localTimeZone]];
        NSDate *anyDate = [dateFormat dateFromString:self.selectedDate];
        NSLog(@"anyDate %@", [anyDate debugDescription]);
        [self.datepicker setDate:anyDate  animated:NO];
    }
}

-(void)createNavigationBar
{
    //hide back button
    //self.navigationItem.hidesBackButton=true;
    //Nativation title
    UIImageView *navigationTitleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavigationTitle"]];
    self.navigationItem.titleView=navigationTitleImage;
    
    // set navigation bar background color
    self.navigationController.navigationBar.barStyle=UIBarStyleBlack;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:15.0f/255.0f green:15.0f/255.0f blue:15.0f/255.0f alpha:1.0f]];
    
    //Navigation Chart button
    UIImage* doneImage=[UIImage imageNamed:@"DoneButton"];
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton setImage:doneImage forState:UIControlStateNormal];
    doneButton.showsTouchWhenHighlighted = YES;
    doneButton.frame = CGRectMake(0.0, 0.0, doneImage.size.width, doneImage.size.height);
    [doneButton addTarget:self action:@selector(doneButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *doneCPDButton = [[UIBarButtonItem alloc] initWithCustomView:doneButton];
    self.navigationItem.rightBarButtonItem = doneCPDButton;
}
-(void)doneButtonClicked{
    NSDate *date = self.datepicker.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/YYYY"];
    self.selectedDate = [formatter stringFromDate:date];
    
    self.cPDProfileEntryViewController.valueDate=self.selectedDate;
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
