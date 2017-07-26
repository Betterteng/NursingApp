//
//  ChapterResultViewController.m
//  Nurse App
//
//  Created by ram mendhe on 01/06/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import "ChapterResultViewController.h"
#import "ChapterResultHeaderLabelCell.h"
#import "ChapterResultScoreCell.h"
#import "ChapterResultLableCell.h"
#import "ChapterResultSaveButtonCell.h"
#import "ChapterResultFooterCell.h"
#import "DBFunctions.h"
#import "ChartsViewController.h"
#import "AppDelegate.h"
#import "ChapterSelectionViewController.h"

@interface ChapterResultViewController ()
{
    int totalQuestion;
    int correctQuestion;
    float correctQ;
    DBFunctions * dbfunction;
    float score;
    long nextChapterNo;
    
    int cellCount;
    int result;
}
@end

@implementation ChapterResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    cellCount=4;
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ChartTableBackground"]];
    [tempImageView setFrame:self.chapterResultTableView.frame];
    self.chapterResultTableView.backgroundView = tempImageView;
    
    [self createNavigationBar];
    
    dbfunction=[[DBFunctions alloc]init];
    
    totalQuestion=[dbfunction getCountOFTotalQuestionsChapter:self.chapterNo];
    correctQuestion=[dbfunction getCountOFCorrectAnswerInChapter:self.chapterNo];
    
    correctQ=(float)correctQuestion;
    
    NSLog(@"totalQuestion %d",totalQuestion);
    NSLog(@"correctQuestion %f",correctQ);
    
    score=(correctQ / (totalQuestion) ) * 100;
    
    if(score>=80)
    {
        nextChapterNo=[self.chapterNo integerValue]+1;
        result=[dbfunction insertInChapterLockTable:[NSString stringWithFormat:@"%ld",nextChapterNo]];
        
        if(result==1)
        {
            cellCount=5;
        }
    }
    
    NSLog(@"score %f",score);
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
}


//Table View Codding. ----- Start
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return cellCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0) {
        static NSString *cellIdentifier = @"Cell";
        ChapterResultHeaderLabelCell *cell = (ChapterResultHeaderLabelCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ChapterResultHeaderLabelCell" owner:nil options:nil] objectAtIndex: 0];;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.userInteractionEnabled=NO;
        cell.chapterLabel.text=[NSString stringWithFormat:@"Chapter %@",self.chapterNo];
        return cell;
    }
    else if (indexPath.row==1){
        static NSString *cellIdentifier = @"Cell";
        ChapterResultScoreCell *cell = (ChapterResultScoreCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ChapterResultScoreCell" owner:nil options:nil] objectAtIndex: 0];;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.percentLabel.text=[NSString stringWithFormat:@"%.2f %@ Pts",score,@"%"];
        [cell.menuButton addTarget:self action:@selector(menuButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.replayButton addTarget:self action:@selector(replayButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else if (indexPath.row==2 && cellCount==5){
        static NSString *cellIdentifier = @"Cell";
        ChapterResultLableCell *cell = (ChapterResultLableCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ChapterResultLableCell" owner:nil options:nil] objectAtIndex: 0];;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.userInteractionEnabled=NO;
        return cell;
    }
    else if ((indexPath.row==3 && cellCount==5) || (indexPath.row==2 && cellCount==4)){
        static NSString *cellIdentifier = @"Cell";
        ChapterResultSaveButtonCell *cell = (ChapterResultSaveButtonCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ChapterResultSaveButtonCell" owner:nil options:nil] objectAtIndex: 0];;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell.saveExitButton addTarget:self action:@selector(saveExitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        //cell.userInteractionEnabled=NO;
        return cell;
    }
    else{
        static NSString *cellIdentifier = @"Cell";
        ChapterResultFooterCell *cell = (ChapterResultFooterCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ChapterResultFooterCell" owner:nil options:nil] objectAtIndex: 0];;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.userInteractionEnabled=NO;
        return cell;
    }
    
}

-(void)saveExitButtonClicked:(id)sender
{
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        UITabBarController *rootController =(UITabBarController*)[[(AppDelegate*)
                                                                   [[UIApplication sharedApplication]delegate] window] rootViewController];
        [rootController setSelectedIndex:0];
    }];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

-(void)menuButtonClicked:(id)sender
{
    if(![self.chapterNo isEqualToString:@"5"])
    {
        NSArray *array = [self.navigationController viewControllers];
        [self.navigationController popToViewController:[array objectAtIndex:2] animated:YES];
    }
    else
    {
        NSArray *array = [self.navigationController viewControllers];
        [self.navigationController popToViewController:[array objectAtIndex:4] animated:YES];
    }
}
/*
 -(void) viewWillDisappear:(BOOL)animated {
 if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
 NSArray *array = [self.navigationController viewControllers];
 [self.navigationController popToViewController:[array objectAtIndex:1] animated:YES];
 }
 [super viewWillDisappear:animated];
 }*/

-(void)replayButtonClicked:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"Replay"];
    if([self.chapterNo isEqualToString:@"5"])
    {
        NSArray *array = [self.navigationController viewControllers];
        [self.navigationController popToViewController:[array objectAtIndex:5] animated:YES];
    }
    else if([self.chapterNo isEqualToString:@"1"])
    {
        NSArray *array = [self.navigationController viewControllers];
        [self.navigationController popToViewController:[array objectAtIndex:3] animated:YES];
    }
    else
    {
        NSArray *array = [self.navigationController viewControllers];
        [self.navigationController popToViewController:[array objectAtIndex:4] animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 92;
    }
    else if (indexPath.row==1) {
        return 256;
    }
    else if (indexPath.row==2 && cellCount==5) {
        return 116;
    }
    else
    {
        return 100;
    }
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
