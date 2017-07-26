//
//  ChapterYearSelectionViewController.m
//  Nurse App
//
//  Created by Asmita on 01/06/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import "ChapterYearSelectionViewController.h"
#import "ChapterSelectionHeaderCell.h"
#import "ChapterResultHeaderLabelCell.h"
#import "ChapterSelectionCell.h"
#import "ChapterResultViewController.h"
#import "QuizQuestionViewController.h"

@interface ChapterYearSelectionViewController ()
{
    NSArray *cellButtonArray;
}
@end

@implementation ChapterYearSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ChartTableBackground"]];
    [tempImageView setFrame:self.yearSelectionTableView.frame];
    self.yearSelectionTableView.backgroundView = tempImageView;
    
    cellButtonArray=[[NSArray alloc] initWithObjects:@"",@"",@"Year 1",@"Year 2",@"Year 3",@"Year 4",@"Year 5",@"Year 6",@"Year 7",@"Year 8",@"Year 9",@"Year 10", nil];
    
    [self createNavigationBar];
    
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
    return 12;
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
        ChapterResultHeaderLabelCell *cell = (ChapterResultHeaderLabelCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ChapterResultHeaderLabelCell" owner:nil options:nil] objectAtIndex: 0];;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.userInteractionEnabled=NO;
        cell.chapterLabel.text=@"Chapter 5";
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
    
    cell.chapterButtonLabel.text=[cellButtonArray objectAtIndex:indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 109;
    }
    else if (indexPath.row==1) {
        return 92;
    }
    return 71;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected row %ld",(long)indexPath.row);
    
    QuizQuestionViewController* quizQuestionViewController=[[QuizQuestionViewController alloc] initWithNibName:@"QuizQuestionViewController" bundle:nil];
    quizQuestionViewController.chapterno=@"5";
    quizQuestionViewController.yearno=[NSString stringWithFormat:@"%ld",indexPath.row-1];
    [self.navigationController pushViewController:quizQuestionViewController animated:YES];
    
    
   /* ChapterResultViewController* chapterResultViewController=[[ChapterResultViewController alloc] initWithNibName:@"ChapterResultViewController" bundle:nil];
    chapterResultViewController.chapterNo=@"5";
    [self.navigationController pushViewController:chapterResultViewController animated:YES];*/
    
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
