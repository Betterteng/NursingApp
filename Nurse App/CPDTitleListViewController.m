//
//  CPDTitleListViewController.m
//  Nurse App
//
//  Created by ram mendhe on 12/04/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import "CPDTitleListViewController.h"
#import "TitleListCellView.h"

@interface CPDTitleListViewController ()

@end

@implementation CPDTitleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigationBar];
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ChartTableBackground"]];
    [tempImageView setFrame:self.cpdTitleTableView.frame];
    self.cpdTitleTableView.backgroundView = tempImageView;
    
    self.titlesArray=[[NSArray alloc] initWithObjects:@"Reflecting on feedback",
                      @"Keeping a practice journal",
                      @"Acting as mentor / tutor",
                      @"Participating on committees",
                      @"Undertaking supervised practice",
                      @"Participating in clinical audits",
                      @"Participating in case reviews",
                      @"Participating in professional reading",
                      @"Participating in discussion group",
                      @"Developing IT skills",
                      @"Developing numeracy skills",
                      @"Developing communication skills",
                      @"Writing educational material",
                      @"Reviewing educational material",
                      @"Membership of professional groups",
                      @"Reading professional journals",
                      @"Writing for publication",
                      @"Developing policy or guidelines",
                      @"Working with a mentor",
                      @"Attending workspace education",
                      @"Undergrad or postgrad studies",
                      @"Attending conferences / lectures",
                      @"Contributing to research",
                      @"Undertaking online education",
                      @"Undertaking distance learning", nil];
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
    [self.navigationController popViewControllerAnimated:YES];
}

//Table View Codding. ----- Start
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.titlesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    TitleListCellView *cell = (TitleListCellView *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TitleListCellView" owner:nil options:nil] objectAtIndex: 0];;
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor clearColor];
    cell.titleCellLabel.highlightedTextColor = [UIColor colorWithRed:(140/255.0) green:(12/255.0) blue:(166/255.0) alpha:1] ;
    
    cell.selectedBackgroundView = selectionColor;
    NSString* title=[self.titlesArray objectAtIndex:indexPath.row];
    if ([self.selectedTitle isEqualToString:title]) {
        cell.pluseImageView.hidden=NO;
    }else{
        cell.pluseImageView.hidden=YES;
    }
    cell.titleCellLabel.text=[self.titlesArray objectAtIndex:indexPath.row];
    cell.titleCellLabel.font=[UIFont fontWithName:@"MyriadPro-Semibold" size:22];
    cell.titleCellLabel.textColor = [UIColor colorWithRed:(15/255.0) green:(15/255.0) blue:(15/255.0) alpha:1] ;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected row %ld",(long)indexPath.row);
    self.selectedTitle=[self.titlesArray objectAtIndex:indexPath.row];
    [self.cpdTitleTableView reloadData];
    self.cPDProfileEntryViewController.valueTitle=self.selectedTitle;
    [self.navigationController popViewControllerAnimated:YES];
    /* ImagePagesViewController* imagePagesViewController=[[ImagePagesViewController alloc] initWithNibName:@"ImagePagesViewController" bundle:nil];
     imagePagesViewController.imageArray=[self.imageArray objectAtIndex:indexPath.row];
     imagePagesViewController.pageTitle=[self.cellNameArray objectAtIndex:indexPath.row];
     [self.navigationController pushViewController:imagePagesViewController animated:YES];
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
