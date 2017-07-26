//
//  ChartsViewController.m
//  Nurse App
//
//  Created by ram mendhe on 06/04/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import "ChartsViewController.h"
#import "ChartViewCell.h"
#import "AboutViewController.h"
#import "TermsViewController.h"
#import "ImagePagesViewController.h"
#import "HeaderCellView.h"
#import "ECGInterpretationViewController.h"

@interface ChartsViewController ()

@end

@implementation ChartsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigationBar];
    
    self.cellNameArray=[[NSArray alloc] initWithObjects:@"",@"Math Conversions/ Daily Care Plan",@"Patient Assessment",@"Ward Routine",@"IV Drip Rate",@"ECG Lead Placement",@"ECG Interpretation",@"Rhythm Analysis",@"Blood Gas Analysis",@"Enteral Feeding Drip Rates",@"CPR", nil];
    self.cellImageArray=[[NSArray alloc] initWithObjects:@"",@"icon-heart",@"icon-man",@"icon-clock",@"icon-drop",@"icon-ecg",@"icon-book",@"icon-graph",@"icon-serin",@"icon-drop",@"icon-graph",nil];
    
    NSArray* patientAssessmentImagesArray=[[NSArray alloc] initWithObjects:@"Pages-PatientAss1",@"Pages-PatientAss2", nil];
    NSArray* dailyCarePlanImagesArray=[[NSArray alloc] initWithObjects:@"Pages-DailyCare1",@"Pages-DailyCare2", nil];
    NSArray* wordRoutineImagesArray=[[NSArray alloc] initWithObjects:@"Pages-WardRoutine1",@"Pages-WardRoutine2", nil];
    NSArray* ivdriprateImagesArray=[[NSArray alloc] initWithObjects:@"Pages-DripRate1",@"Pages-DripRate2", nil];
    NSArray* ecgLeadPlacementImagesArray=[[NSArray alloc] initWithObjects:@"Pages-ECGLead1",@"Pages-ECGLead2", nil];
    NSArray* ecgInterpretationImagesArray=[[NSArray alloc] initWithObjects:@"Pages-ECGInter1",@"Pages-ECGInter2", nil];
    NSArray* emergencyResuscitationImagesArray=[[NSArray alloc] initWithObjects:@"Pages-EmergencyRes1",@"Pages-EmergencyRes2", nil];
    
    //NSArray* rhythmAnalysisImagesArray=[[NSArray alloc] initWithObjects:@"Pages-RhythmAna1",@"Pages-RhythmAna2", nil];
    NSArray* rhythmAnalysisImagesArray=[[NSArray alloc] initWithObjects:@"ra-backround",@"ra-backround", nil];
    NSArray* bloodgasAnalysisImagesArray=[[NSArray alloc] initWithObjects:@"Pages-BloodGasAna1",@"Pages-BloodGasAna2", nil];
    NSArray* enteralFeedingImagesArray=[[NSArray alloc] initWithObjects:@"Pages-EnteralFeeding1",@"Pages-EnteralFeeding2", nil];
    
    self.imageArray=[[NSArray alloc] initWithObjects:@"",dailyCarePlanImagesArray,patientAssessmentImagesArray,wordRoutineImagesArray,ivdriprateImagesArray,ecgLeadPlacementImagesArray,ecgInterpretationImagesArray,rhythmAnalysisImagesArray,bloodgasAnalysisImagesArray,enteralFeedingImagesArray,emergencyResuscitationImagesArray,nil];
    
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ChartTableBackground"]];
    [tempImageView setFrame:self.chartsTableView.frame];
    self.chartsTableView.backgroundView = tempImageView;
    
    
    NSString * termsconditionStatus=[[NSUserDefaults standardUserDefaults]valueForKey:@"termsconditionStatus"];
    if(![termsconditionStatus isEqualToString:@"1"])
    {
        [self termsButtonClicked];
    }

}

-(void)createNavigationBar
{
    //hide back button
    self.navigationItem.hidesBackButton=true;
    
    //Navigation About button
    UIImage* aboutImage=[UIImage imageNamed:@"ChartsAboutButton"];
    UIButton *aboutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [aboutButton setImage:aboutImage forState:UIControlStateNormal];
    aboutButton.showsTouchWhenHighlighted = YES;
    aboutButton.frame = CGRectMake(0.0, 0.0, aboutImage.size.width, aboutImage.size.height);
    [aboutButton addTarget:self action:@selector(aboutButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:aboutButton];
    self.navigationItem.leftBarButtonItem = leftButton;

    //Navigation Chart button
    UIImage* chartImage=[UIImage imageNamed:@"ChartsTermsButton"];
    UIButton *chartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [chartButton setImage:chartImage forState:UIControlStateNormal];
    chartButton.showsTouchWhenHighlighted = YES;
    chartButton.frame = CGRectMake(0.0, 0.0, aboutImage.size.width, aboutImage.size.height);
    [chartButton addTarget:self action:@selector(termsButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:chartButton];
    self.navigationItem.rightBarButtonItem = rightButton;

    
    //Nativation title
    UIImageView *navigationTitleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavigationTitle"]];
    self.navigationItem.titleView=navigationTitleImage;
    
    // set navigation bar background color
    self.navigationController.navigationBar.barStyle=UIBarStyleBlack;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:15.0f/255.0f green:15.0f/255.0f blue:15.0f/255.0f alpha:1.0f]];
}

-(void)aboutButtonClicked{
    AboutViewController* aboutViewController=[[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
    UINavigationController* aboutNac=[[UINavigationController alloc] initWithRootViewController:aboutViewController];
    [self presentViewController:aboutNac animated:YES completion:nil];
}
-(void)termsButtonClicked{
    TermsViewController* termsViewController=[[TermsViewController alloc] initWithNibName:@"TermsViewController" bundle:nil];
    UINavigationController* aboutNac=[[UINavigationController alloc] initWithRootViewController:termsViewController];
    [self presentViewController:aboutNac animated:YES completion:nil];
}

//Table View Codding. ----- Start
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 11;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     
     if (indexPath.row==0) {
         static NSString *cellIdentifier = @"Cell";
         HeaderCellView *cell = (HeaderCellView *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
         if(cell == nil)
         {
             cell = [[[NSBundle mainBundle] loadNibNamed:@"HeaderCellView" owner:nil options:nil] objectAtIndex: 0];;
         }
         cell.selectionStyle=UITableViewCellSelectionStyleNone;
         cell.userInteractionEnabled=NO;
         cell.headerImageView.image=[UIImage imageNamed:@"ChartTableHeader"];
         return cell;
     }
     static NSString *cellIdentifier = @"Cell";
     ChartViewCell *cell = (ChartViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
     if(cell == nil)
     {
         cell = [[[NSBundle mainBundle] loadNibNamed:@"ChartViewCell" owner:nil options:nil] objectAtIndex: 0];;
     }
     cell.selectionStyle=UITableViewCellSelectionStyleGray;
     UIView *selectionColor = [[UIView alloc] init];
     selectionColor.backgroundColor = [UIColor clearColor];
     cell.cellnameLabel.highlightedTextColor = [UIColor colorWithRed:(140/255.0) green:(12/255.0) blue:(166/255.0) alpha:1] ;
     
     cell.selectedBackgroundView = selectionColor;
     cell.cellimage.image=[UIImage imageNamed:[self.cellImageArray objectAtIndex:indexPath.row]];
     cell.cellnameLabel.text=[self.cellNameArray objectAtIndex:indexPath.row];
     cell.cellnameLabel.font=[UIFont fontWithName:@"MyriadPro-Semibold" size:22];

     return cell;
 }

/*
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImage* chartImage=[UIImage imageNamed:@"ChartTableHeader"];
    UIImageView* chartHeaderImageView=[[UIImageView alloc] initWithImage:chartImage];
    [chartHeaderImageView setContentMode:UIViewContentModeScaleAspectFit];
    chartHeaderImageView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, 163.0);
    return chartHeaderImageView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 163.0;
}*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 183;
    }
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected row %ld",(long)indexPath.row);
    if(indexPath.row==6){
        ECGInterpretationViewController* eCGInterpretationViewController=[[ECGInterpretationViewController alloc] initWithNibName:@"ECGInterpretationViewController" bundle:nil];
        eCGInterpretationViewController.imageArray=[self.imageArray objectAtIndex:indexPath.row];
        eCGInterpretationViewController.pageTitle=[self.cellNameArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:eCGInterpretationViewController animated:YES];
    }else{
        ImagePagesViewController* imagePagesViewController=[[ImagePagesViewController alloc] initWithNibName:@"ImagePagesViewController" bundle:nil];
        imagePagesViewController.imageArray=[self.imageArray objectAtIndex:indexPath.row];
        imagePagesViewController.pageTitle=[self.cellNameArray objectAtIndex:indexPath.row];
        
        if(indexPath.row==7)
        {
            imagePagesViewController.isRhythmanalysisSelected=YES;
        }
        else
        {
            imagePagesViewController.isRhythmanalysisSelected=NO;
        }
        [self.navigationController pushViewController:imagePagesViewController animated:YES];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//Table View Codding. ----- end

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
