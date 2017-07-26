//
//  ECGInterpretationViewController.m
//  Nurse App
//
//  Created by ram mendhe on 14/11/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import "ECGInterpretationViewController.h"
#import "ECGImageCell.h"

@interface ECGInterpretationViewController ()

@end

@implementation ECGInterpretationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"ChartTableBackground"]];
    self.imageArray=[[NSArray alloc] initWithObjects:@"ECG-First",@"ECG-Second",@"ECG-Third",@"ECG-Fourth",@"ECG-Five",@"ECG-Six",@"ECG-Button",@"ECG-Seven", nil];
    //self.ecgiTableView.hidden=YES;
    NSLog(@"Page title %@", self.pageTitle);
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSFontAttributeName:[UIFont fontWithName:@"Roboto-Bold" size:23]}];
    self.navigationItem.title=self.pageTitle;
    
    UIImage* nextImage=[UIImage imageNamed:@"icon-arrow"];
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setImage:nextImage forState:UIControlStateNormal];
    nextButton.showsTouchWhenHighlighted = YES;
    nextButton.frame = CGRectMake(0.0, 0.0, nextImage.size.width, nextImage.size.height);
    [nextButton addTarget:self action:@selector(nextImageClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:nextButton];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    [self.view addSubview:self.ecgiInterTwoView];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    CGRect verificationViewFrame=self.ecgiLargeView.frame;
    verificationViewFrame.origin.x=0;
    verificationViewFrame.origin.y=0;
    verificationViewFrame.size.height=screenHeight;
    verificationViewFrame.size.width=self.view.frame.size.width;
    self.ecgiInterTwoView.frame=verificationViewFrame;
    self.ecgiInterTwoView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.ecgiInterTwoView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.ecgiInterTwoView.hidden=YES;
    self.isSecondScreenDisplay=NO;
}

-(void)nextImageClicked{
    
    [self.ecgiLargeView removeFromSuperview];
    
    if(self.isSecondScreenDisplay){
        [UIView transitionWithView:self.view
                          duration:0.4
                           options:UIViewAnimationOptionTransitionFlipFromRight
                        animations:^{
                            self.ecgiInterTwoView.hidden=YES;
                            self.ecgiTableView.hidden=NO;
                        } completion:^(BOOL finished) {
                            self.isSecondScreenDisplay=NO;
                        }];
    }else{
        [UIView transitionWithView:self.view
                          duration:0.4
                           options:UIViewAnimationOptionTransitionFlipFromRight
                        animations:^{
                            self.ecgiInterTwoView.hidden=NO;
                            self.ecgiTableView.hidden=YES;
                        } completion:^(BOOL finished) {
                            self.isSecondScreenDisplay=YES;
                        }];
    }
}

-(void)showGraphView:(UIImage *)img
{
    [self.view addSubview:self.ecgiLargeView];
    
    self.ecgiLargeView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    CGRect verificationViewFrame=self.ecgiLargeView.frame;
    verificationViewFrame.origin.x=0;
    verificationViewFrame.origin.y=0;
    verificationViewFrame.size.height=screenHeight;
    verificationViewFrame.size.width=self.view.frame.size.width;
    self.ecgiLargeView.frame=verificationViewFrame;
    self.ecgiLargeView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.ecgiLargeView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    self.ecgiLargeImageView.image=img;
    
    UITapGestureRecognizer * rhythmLargeImageViewTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewtapped:)];
    [self.ecgiLargeView addGestureRecognizer:rhythmLargeImageViewTap];
}

-(void)viewtapped:(id)sender
{
    [self.ecgiLargeView removeFromSuperview];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    ECGImageCell * eCGImageCell=[self.ecgiTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(eCGImageCell==nil){
        NSArray* objects= [[NSBundle mainBundle] loadNibNamed:@"ECGImageCell" owner:nil options:nil];
        ECGImageCell *acell = [objects objectAtIndex:0];
        eCGImageCell = acell;
    }
    if(indexPath.row==1 || indexPath.row==2 || indexPath.row==3 || indexPath.row==4 || indexPath.row==6 ){
        NSLog(@"userInteractionEnabled=YES");
        eCGImageCell.userInteractionEnabled=YES;
    }else{
        NSLog(@"userInteractionEnabled=NO");
        eCGImageCell.userInteractionEnabled=NO;
    }
    eCGImageCell.ecgRowImages.image=[UIImage imageNamed:[self.imageArray objectAtIndex:indexPath.row]];
    return eCGImageCell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath selected row %ld",(long)indexPath.row);
    if(indexPath.row==1){
        [self showGraphView:[UIImage imageNamed:@"Inferior_Layout"]];
    }else if(indexPath.row==2){
        [self showGraphView:[UIImage imageNamed:@"Lateral_Layout"]];
    }else if(indexPath.row==3){
        [self showGraphView:[UIImage imageNamed:@"Septal_Layout"]];
    }else if(indexPath.row==4){
        [self showGraphView:[UIImage imageNamed:@"Anterior_Layout"]];
    }else if(indexPath.row==6){
        [self showGraphView:[UIImage imageNamed:@"Detail_Layout"]];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat rowHeight = self.ecgiTableView.rowHeight;
    if(indexPath.row==0)
    {
        rowHeight=115;
    }
    else if(indexPath.row==1)
    {
        rowHeight=30;
    }
    else if(indexPath.row==2)
    {
        rowHeight=28;
    }else if(indexPath.row==3)
    {
        rowHeight=30;
    }else if(indexPath.row==4)
    {
        rowHeight=30;
    }else if(indexPath.row==5)
    {
        rowHeight=115;
    }else if(indexPath.row==6)
    {
        rowHeight=50;
    }else if(indexPath.row==7)
    {
        rowHeight=200;
    }
    return rowHeight;
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
