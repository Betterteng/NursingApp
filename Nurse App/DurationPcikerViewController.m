//
//  DurationPcikerViewController.m
//  Nurse App
//
//  Created by ram mendhe on 14/04/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import "DurationPcikerViewController.h"

@interface DurationPcikerViewController ()

@end

@implementation DurationPcikerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNavigationBar];
    self.durationpicker.backgroundColor = [UIColor lightGrayColor];
    NSLog(@"selected date %@", self.selectedduration);
    
    UILabel *hourLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, self.durationpicker.frame.size.height / 1.35 , 75, 30)];
    hourLabel.text = @"hours";
    [self.durationpicker addSubview:hourLabel];
    
    UILabel *minsLabel = [[UILabel alloc] initWithFrame:CGRectMake(100 + (self.durationpicker.frame.size.width / 3), self.durationpicker.frame.size.height /1.35, 75, 30)];
    minsLabel.text = @"min";
    [self.durationpicker addSubview:minsLabel];
    
    if (self.selectedduration) {
        int result=(int)[self.selectedduration integerValue];
        int minutes = result%60;
        int hours = (result - minutes)/60;
        NSLog(@"Hours:%d  min:%d",hours,minutes);
        self.hours=hours;
        self.mins=minutes;
        NSLog(@"Hours:%ld  min:%ld",(long)self.hours,(long)self.mins);
        [self.durationpicker selectRow:hours inComponent:0 animated:YES];
        [self.durationpicker reloadComponent:0];
        [self.durationpicker selectRow:minutes inComponent:1 animated:YES];
        [self.durationpicker reloadComponent:1];
        
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
    self.selectedduration=[NSString stringWithFormat:@"%ld",self.hours*60+self.mins];
    NSLog(@" doneButtonClicked selectedduration%@",self.selectedduration);
    self.cPDProfileEntryViewController.valueDuration=self.selectedduration;
    [self.navigationController popViewControllerAnimated:YES];
}

//Picker view coding
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.hours = row;
    } else if (component == 1) {
        self.mins = row;
    } 
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0)
        return 24;
    
    return 60;
}


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *columnView = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, self.view.frame.size.width/3 - 35, 30)];
    columnView.text = [NSString stringWithFormat:@"%lu", (long) row];
    columnView.textAlignment = NSTextAlignmentLeft;
    return columnView;
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
