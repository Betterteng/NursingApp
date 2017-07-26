//
//  ChapterSelectionViewController.m
//  Nurse App
//
//  Created by ram mendhe on 30/05/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import "ChapterSelectionViewController.h"
#import "ChapterSelectionHeaderCell.h"
#import "ChapterSelectionLableCell.h"
#import "ChapterSelectionCell.h"
#import "ChapterResultViewController.h"
#import "QuizQuestionViewController.h"
#import "ChapterYearSelectionViewController.h"
#import "DBFunctions.h"
#import "QuizImagesViewController.h"

@interface ChapterSelectionViewController ()
{
    NSArray *cellButtonArray;
    DBFunctions *dbfunctions;
}
@end

@implementation ChapterSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden=NO;
    
    dbfunctions=[[DBFunctions alloc]init];
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ChartTableBackground"]];
    [tempImageView setFrame:self.chapterSelectionTableView.frame];
    self.chapterSelectionTableView.backgroundView = tempImageView;
    
    cellButtonArray=[[NSArray alloc] initWithObjects:@"",@"",@"Chapter 1",@"Chapter 2",@"Chapter 3",@"Chapter 4",@"Chapter 5", nil];
    
    [self createNavigationBar];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.chapterSelectionTableView reloadData];
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
    return 7;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0) {
        static NSString *cellIdentifier = @"Cell";
        ChapterSelectionHeaderCell *cell = (ChapterSelectionHeaderCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ChapterSelectionHeaderCell" owner:nil options:nil] objectAtIndex: 0];;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.userInteractionEnabled=NO;
        cell.headerImageView.image=[UIImage imageNamed:@"ChapterTableHeader"];
        
        return cell;
    }
    if (indexPath.row==1) {
        static NSString *cellIdentifier = @"Cell";
        ChapterSelectionLableCell *cell = (ChapterSelectionLableCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ChapterSelectionLableCell" owner:nil options:nil] objectAtIndex: 0];;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.userInteractionEnabled=NO;
        
        return cell;
    }
    
    static NSString *cellIdentifier = @"Cell";
    ChapterSelectionCell *cell = (ChapterSelectionCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ChapterSelectionCell" owner:nil options:nil] objectAtIndex: 0];;
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor clearColor];
    
    int checklock;
    
    checklock=[dbfunctions isChapterUnlock:[NSString stringWithFormat:@"%ld",indexPath.row-1]];
    
    if(checklock==1 || indexPath.row==2)
    {
        cell.ChapterSelectionButton.image=[UIImage imageNamed:@"ChapterSelectionButton"];
        cell.userInteractionEnabled=YES;
    }
    else
    {
        cell.ChapterSelectionButton.image=[UIImage imageNamed:@"ChapterSelectionLockButton"];
        cell.userInteractionEnabled=NO;
    }
    
    cell.chapterButtonLabel.text=[cellButtonArray objectAtIndex:indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 115;
    }
    else if (indexPath.row==1) {
        return 141;
    }
    return 71;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected row %ld",(long)indexPath.row);
    //if((indexPath.row==2) || (indexPath.row==3) || (indexPath.row==4) ||( indexPath.row==5) || (indexPath.row==6) || (indexPath.row==7)){
    
    if((indexPath.row==2)){
        QuizQuestionViewController* quizQuestionViewController=[[QuizQuestionViewController alloc] initWithNibName:@"QuizQuestionViewController" bundle:nil];
        quizQuestionViewController.chapterno=[NSString stringWithFormat:@"%ld",indexPath.row-1];
        [self.navigationController pushViewController:quizQuestionViewController animated:YES];
    }
    
    if((indexPath.row==3) || (indexPath.row==4) ||( indexPath.row==5) || (indexPath.row==6)){
        
        QuizImagesViewController* quizImagesViewController=[[QuizImagesViewController alloc] initWithNibName:@"QuizImagesViewController" bundle:nil];
        quizImagesViewController.chapterNumber=(int)indexPath.row-1;
        [self.navigationController pushViewController:quizImagesViewController animated:YES];
    }
    
  /*  if(indexPath.row==6)
    {
        //chapter 5th year page
        ChapterYearSelectionViewController* chapterYearSelectionViewController=[[ChapterYearSelectionViewController alloc] initWithNibName:@"ChapterYearSelectionViewController" bundle:nil];
        [self.navigationController pushViewController:chapterYearSelectionViewController animated:YES];
    }
    */
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
