//
//  FormulaeViewController.m
//  Nurse App
//
//  Created by ram mendhe on 06/04/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import "FormulaeViewController.h"
#import "ImagePagesViewController.h"
#import "ChartViewCell.h"
#import "MinutesRemainingViewController.h"
#import "EnteralDripViewController.h"
#import "DripRatesViewController.h"
#import "DrugCalculationViewController.h"
#import "HeaderCellView.h"
#import "ECGInterpretationViewController.h"

@interface FormulaeViewController ()

@end

@implementation FormulaeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    [self createNavigationBar];
    
    self.cellNameArray=[[NSArray alloc] initWithObjects:@"",@"Blood Gas Analysis",@"ECG Interpretation",@"Oxygen Delivery",@"Drug Calculation/Converter",@"IVT- Drip Rates",@"IVT- Minutes Remaining",@"Enteral Drip Rates", nil];
    self.cellImageArray=[[NSArray alloc] initWithObjects:@"",@"icon-serin",@"icon-book",@"icon-o2",@"icon-calcy",@"icon-calcy",@"icon-calcy",@"icon-calcy", nil];
    
    NSArray* patientAssessmentImagesArray=[[NSArray alloc] initWithObjects:@"Pages-BloodGasAna1",@"Pages-BloodGasAna2", nil];
    NSArray* dailyCarePlanImagesArray=[[NSArray alloc] initWithObjects:@"Pages-ECGInter1", nil];
    NSArray* wordRoutineImagesArray=[[NSArray alloc] initWithObjects:@"Pages-OxygenDel1",@"Pages-OxygenDel2", nil];
    
    self.imageArray=[[NSArray alloc] initWithObjects:@"",patientAssessmentImagesArray,dailyCarePlanImagesArray,wordRoutineImagesArray,nil];
    
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ChartTableBackground"]];
    [tempImageView setFrame:self.formulaeTableView.frame];
    self.formulaeTableView.backgroundView = tempImageView;
}

-(void)createNavigationBar
{
    //hide back button
    self.navigationItem.hidesBackButton=true;
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
    return 8;
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
        cell.headerImageView.image=[UIImage imageNamed:@"FormulaeTableHeader"];
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
    UIImage* chartImage=[UIImage imageNamed:@"FormulaeTableHeader"];
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
    if(indexPath.row==2){
        ECGInterpretationViewController* eCGInterpretationViewController=[[ECGInterpretationViewController alloc] initWithNibName:@"ECGInterpretationViewController" bundle:nil];
        eCGInterpretationViewController.imageArray=[self.imageArray objectAtIndex:indexPath.row];
        eCGInterpretationViewController.pageTitle=[self.cellNameArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:eCGInterpretationViewController animated:YES];
    }else if (3==indexPath.row || 1==indexPath.row) {
        ImagePagesViewController* imagePagesViewController=[[ImagePagesViewController alloc] initWithNibName:@"ImagePagesViewController" bundle:nil];
        imagePagesViewController.imageArray=[self.imageArray objectAtIndex:indexPath.row];
        imagePagesViewController.pageTitle=[self.cellNameArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:imagePagesViewController animated:YES];
    }else if (4==indexPath.row){
        DrugCalculationViewController* drugCalculationViewController=[[DrugCalculationViewController alloc] initWithNibName:@"DrugCalculationViewController" bundle:nil];
        drugCalculationViewController.pageTitle=[self.cellNameArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:drugCalculationViewController animated:YES];
    }else if (5==indexPath.row){
        DripRatesViewController* dripRatesViewController=[[DripRatesViewController alloc] initWithNibName:@"DripRatesViewController" bundle:nil];
        dripRatesViewController.pageTitle=[self.cellNameArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:dripRatesViewController animated:YES];
    }else if (6==indexPath.row){
        MinutesRemainingViewController* minutesRemainingViewController=[[MinutesRemainingViewController alloc] initWithNibName:@"MinutesRemainingViewController" bundle:nil];
        minutesRemainingViewController.pageTitle=[self.cellNameArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:minutesRemainingViewController animated:YES];
    }else if (7==indexPath.row){
        EnteralDripViewController* enteralDripViewController=[[EnteralDripViewController alloc] initWithNibName:@"EnteralDripViewController" bundle:nil];
        enteralDripViewController.pageTitle=[self.cellNameArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:enteralDripViewController animated:YES];
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
