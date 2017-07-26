//
//  ImagePagesViewController.m
//  Nurse App
//
//  Created by ram mendhe on 09/04/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import "ImagePagesViewController.h"
#import "GridTablevViewCell.h"
#import "HeaderTablevViewCell.h"
#import "BottomTablevViewCell.h"

@interface ImagePagesViewController ()
{
   
}
@end

@implementation ImagePagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.scrollView.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"ChartTableBackground"]];
    float minScale=self.scrollView.frame.size.width / self.pageImageView.frame.size.width;
    self.scrollView.minimumZoomScale = minScale;
    self.scrollView.maximumZoomScale = 3.0;
    self.scrollView.contentSize = self.pageImageView.frame.size;
    self.scrollView.delegate = self;
    
    if (1!=[self.imageArray count]) {
        //Navigation Chart button
        UIImage* nextImage=[UIImage imageNamed:@"icon-arrow"];
        UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [nextButton setImage:nextImage forState:UIControlStateNormal];
        nextButton.showsTouchWhenHighlighted = YES;
        nextButton.frame = CGRectMake(0.0, 0.0, nextImage.size.width, nextImage.size.height);
        [nextButton addTarget:self action:@selector(nextImageClicked) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:nextButton];
        if(self.isRhythmanalysisSelected==NO)
        self.navigationItem.rightBarButtonItem = rightButton;
    }
    
    if(self.isRhythmanalysisSelected==YES)
    {
        self.scrollView.hidden=YES;
        self.rhythmTableView.hidden=NO;
    }
    else
    {
        self.scrollView.hidden=NO;
        self.rhythmTableView.hidden=YES;

    }
    NSLog(@"Page title %@", self.pageTitle);
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSFontAttributeName:[UIFont fontWithName:@"Roboto-Bold" size:23]}];
    self.navigationItem.title=self.pageTitle;
    self.index=0;
    //[self nextImageClicked];
    NSString* imageName=[self.imageArray objectAtIndex:self.index];
    self.pageImageView.image=[UIImage imageNamed:imageName];
    self.index++;    
    
    /*CGAffineTransform rotate = CGAffineTransformMakeRotation(1.57079633);
    [self.rhythmTableView setTransform:rotate];
    [self.scrollView bringSubviewToFront:self.rhythmTableView];
    [self.scrollView sendSubviewToBack:self.pageImageView];*/
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    NSLog(@"viewForZoomingInScrollView");
    return self.pageImageView;
    
}

-(void)nextImageClicked{
    NSString* imageName=[self.imageArray objectAtIndex:self.index];
    
    [UIView transitionWithView:self.pageImageView
                      duration:0.4
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                         self.pageImageView.image=[UIImage imageNamed:imageName];
                    } completion:^(BOOL finished) {
                        self.index++;
                        if (self.index==[self.imageArray count]) {
                            self.index=0;
                        }
                    }];
}

//Table View Codding. ----- Start
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.cellArray=[[NSMutableArray alloc]init];
    
    static NSString *cellIdentifier = @"Cell";
    if(indexPath.row==0)
    {
    HeaderTablevViewCell * headerCell=[self.rhythmTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(headerCell==nil){
        NSArray* objects= [[NSBundle mainBundle] loadNibNamed:@"HeaderTablevViewCell" owner:nil options:nil];
        HeaderTablevViewCell *acell = [objects objectAtIndex:0];
        headerCell = acell;
    }
    return headerCell;
    }
    else if(indexPath.row==1)
    {
    GridTablevViewCell * gridCell=[self.rhythmTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(gridCell==nil){
        NSArray* objects= [[NSBundle mainBundle] loadNibNamed:@"GridTablevViewCell" owner:nil options:nil];
        GridTablevViewCell *acell = [objects objectAtIndex:0];
        gridCell = acell;
    }
    gridCell.delegate=self;
    return gridCell;
    }
    else
    {
    BottomTablevViewCell * bottomCell=[self.rhythmTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(bottomCell==nil){
        NSArray* objects= [[NSBundle mainBundle] loadNibNamed:@"BottomTablevViewCell" owner:nil options:nil];
        BottomTablevViewCell *acell = [objects objectAtIndex:0];
        bottomCell = acell;
    }
    return bottomCell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath selected row %ld",(long)indexPath.row);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat rowHeight = self.rhythmTableView.rowHeight;
    
    if(indexPath.row==0)
    {
        rowHeight=73;
        
    }
    else if(indexPath.row==1)
    {
        rowHeight=489;
    }
    else
    {
        rowHeight=90;
    }   
   return rowHeight;
}

-(void)sendData:(UIImage *)img
{
    [self.view addSubview:self.rhythmLargeView];
    
    self.rhythmLargeView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    CGRect verificationViewFrame=self.rhythmLargeView.frame;
    verificationViewFrame.origin.x=0;
    verificationViewFrame.origin.y=0;
    verificationViewFrame.size.height=screenHeight;
    verificationViewFrame.size.width=self.view.frame.size.width;
    self.rhythmLargeView.frame=verificationViewFrame;
    self.rhythmLargeView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.rhythmLargeView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    self.rhythmLargeImageView.image=img;
    
    UITapGestureRecognizer * rhythmLargeImageViewTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewtapped:)];
    [self.rhythmLargeView addGestureRecognizer:rhythmLargeImageViewTap];
}

-(void)viewtapped:(id)sender
{
    [self.rhythmLargeView removeFromSuperview];
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
