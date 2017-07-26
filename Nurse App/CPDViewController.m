//
//  CPDViewController.m
//  Nurse App
//
//  Created by ram mendhe on 06/04/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import "CPDViewController.h"
#import "CPDCellView.h"
#import "CPDProfileEntryViewController.h"
#import "DBFunctions.h"
#import "CPDEntryData.h"
#import "CPDMessageCellView.h"
#import "EmailLogCellView.h"
#import "HeaderCellView.h"


@interface CPDViewController ()

@end

@implementation CPDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigationBar];
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ChartTableBackground"]];
    [tempImageView setFrame:self.cpdTableView.frame];
    self.cpdTableView.backgroundView = tempImageView;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self reloadTable];
}
-(void)reloadTable{
    DBFunctions* dBFunctions=[[DBFunctions alloc] init];
    self.cpdEntryArray=[dBFunctions getCPDEntryClassesForm];
    int result=dBFunctions.totalDuration;
    int minutes = result%60;
    int hours = (result - minutes)/60;
    self.totalDuration=[NSString stringWithFormat:@"%dhr,%dmin", hours, minutes];
    [self.cpdTableView reloadData];
    
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

    //Navigation Chart button
    UIImage* addCPDImage=[UIImage imageNamed:@"CPDPluseButton"];
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:addCPDImage forState:UIControlStateNormal];
    addButton.showsTouchWhenHighlighted = YES;
    addButton.frame = CGRectMake(0.0, 0.0, addCPDImage.size.width, addCPDImage.size.height);
    [addButton addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *addCPDButton = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    self.navigationItem.rightBarButtonItem = addCPDButton;

}

-(void)addButtonClicked{
    CPDProfileEntryViewController* cPDProfileEntryViewController=[[CPDProfileEntryViewController alloc] initWithNibName:@"CPDProfileEntryViewController" bundle:nil];
    [self.navigationController pushViewController:cPDProfileEntryViewController animated:YES];
}

-(void)sendLogButtonClciked{
    NSLog(@"send button clicked");
    NSString* emailBody=@"";
    for (int i=0; i<[self.cpdEntryArray count]; i++) {
        CPDEntryData* ced=[self.cpdEntryArray objectAtIndex:i];
        emailBody=[NSString stringWithFormat:@"%@ <br/><b>Activity:</b> %@<br/><b>Date:</b> %@<br/><b>Duration:</b> %@<br/>",emailBody, ced.entrytitle,ced.entrydate, ced.entryduration];
        if ([ced.entrynotes length]!=0) {
            emailBody=[NSString stringWithFormat:@"%@ <b>Notes:</b> %@<br/>",emailBody, ced.entrynotes];
        }
    }
    
    /*  MFMailComposeViewController* composeVC = [[MFMailComposeViewController alloc] init];
     composeVC.mailComposeDelegate = self;
     // Configure the fields of the interface.
     //[composeVC setToRecipients:@[@"address@example.com"]];
     //[composeVC setSubject:@"Hello!"];
     [composeVC setMessageBody:emailBody isHTML:YES];
     // Present the view controller modally.
     [self.navigationController presentViewController:composeVC animated:YES completion:nil];*/
    MFMailComposeViewController *tempMailCompose = [[MFMailComposeViewController alloc] init];
    
    if ([MFMailComposeViewController canSendMail])
    {
        tempMailCompose.mailComposeDelegate = self;
        [tempMailCompose setSubject:@""];
        [tempMailCompose setMessageBody:emailBody isHTML:YES];
        [self presentViewController:tempMailCompose animated:YES completion:^{
        }];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            break;
        case MFMailComposeResultSaved:
            break;
        case MFMailComposeResultSent:
            break;
        case MFMailComposeResultFailed:
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:^{}];
}


//Table View Codding. ----- Start
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0!=[self.cpdEntryArray count]) {
         return ([self.cpdEntryArray count]+4);
    }
    return 2;
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
        cell.headerImageView.image=[UIImage imageNamed:@"CPDTableHeader"];
        return cell;
    }
    
    if (0==[self.cpdEntryArray count]) {
         static NSString *cellIdentifier = @"Cell";
         CPDMessageCellView *cell = (CPDMessageCellView *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
         if(cell == nil)
         {
             cell = [[[NSBundle mainBundle] loadNibNamed:@"CPDMessageCellView" owner:nil options:nil] objectAtIndex: 0];;
         }
         cell.selectionStyle=UITableViewCellSelectionStyleNone;
         return cell;
     }
    
    if (indexPath.row==1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
        
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
        cell.textLabel.font=[UIFont fontWithName:@"MyriadPro-Semibold" size:22];
        cell.textLabel.textColor=[UIColor whiteColor];
        cell.textLabel.numberOfLines=2;
        cell.textLabel.text=[NSString stringWithFormat:@"Total Time   %@",self.totalDuration];
        return cell;
    }else if (indexPath.row==([self.cpdEntryArray count]+2)){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell1"];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell1"];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];
        cell.textLabel.font=[UIFont fontWithName:@"MyriadPro-Semibold" size:22];
        cell.textLabel.textColor=[UIColor whiteColor];
        NSLog(@"Last Cell %@",self.totalDuration);
        cell.textLabel.text=[NSString stringWithFormat:@"Total Time   %@",self.totalDuration];
        return cell;
    }else if (indexPath.row==([self.cpdEntryArray count]+3)){
        static NSString *cellIdentifier = @"Cell";
        EmailLogCellView *cell = (EmailLogCellView *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"EmailLogCellView" owner:nil options:nil] objectAtIndex: 0];;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell.sendLogButton addTarget:self action:@selector(sendLogButtonClciked) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    
    }else{
        static NSString *cellIdentifier = @"Cell";
        CPDCellView *cell = (CPDCellView *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CPDCellView" owner:nil options:nil] objectAtIndex: 0];;
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        UIView *selectionColor = [[UIView alloc] init];
        selectionColor.backgroundColor = [UIColor clearColor];
        cell.entryListTitleLabel.highlightedTextColor = [UIColor colorWithRed:(140/255.0) green:(12/255.0) blue:(166/255.0) alpha:1] ;
        cell.selectedBackgroundView = selectionColor;
        
        CPDEntryData* cpdEntry=[self.cpdEntryArray objectAtIndex:(indexPath.row-2)];
        NSLog(@"entry Title %@",cpdEntry.entrytitle);
        cell.entryListTitleLabel.font=[UIFont fontWithName:@"MyriadPro-Semibold" size:22];
        cell.entryListTitleLabel.textColor=[UIColor colorWithRed:21.0f/255.0f green:21.0f/255.0f blue:21.0f/255.0f alpha:1.0f];
        cell.entryListTitleLabel.text=cpdEntry.entrytitle;
        
        cell.entryListDescription.font=[UIFont fontWithName:@"MyriadPro-Semibold" size:18];
        cell.entryListDescription.textColor=[UIColor colorWithRed:100.0f/255.0f green:100.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
        
        int result=(int)[cpdEntry.entryduration intValue];
        int minutes = result%60;
        int hours = (result - minutes)/60;
        cell.entryListDescription.text=[NSString stringWithFormat:@"%@ %dhr,%dmin %@",cpdEntry.entrydate,hours, minutes, cpdEntry.entrynotes];
        return cell;
    }
    
}
/*
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImage* cPDImage=[UIImage imageNamed:@"CPDTableHeader"];
    UIImageView* cPDtHeaderImageView=[[UIImageView alloc] initWithImage:cPDImage];
    [cPDtHeaderImageView setContentMode:UIViewContentModeScaleAspectFit];
    cPDtHeaderImageView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, 163.0);
    return cPDtHeaderImageView;
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
    if (0==[self.cpdEntryArray count]) {
        return 148;
    }
    
    if (indexPath.row==1) {
        return 30;
    }
    if (indexPath.row==([self.cpdEntryArray count]+2)) {
        return 30;
    }
    if (indexPath.row==([self.cpdEntryArray count]+3)) {
        return 100;
    }
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected row %ld",(long)indexPath.row);
    if (0!=[self.cpdEntryArray count]) {
        if (indexPath.row==1 || indexPath.row==([self.cpdEntryArray count]+2) || indexPath.row==([self.cpdEntryArray count]+3)) {
            return;
        }
        CPDEntryData* cpdentryData=[self.cpdEntryArray objectAtIndex:indexPath.row-1];
        CPDProfileEntryViewController* cPDProfileEntryViewController=[[CPDProfileEntryViewController alloc] initWithNibName:@"CPDProfileEntryViewController" bundle:nil];
        cPDProfileEntryViewController.valueTitle=cpdentryData.entrytitle;
        cPDProfileEntryViewController.valueNotes=cpdentryData.entrynotes;
        cPDProfileEntryViewController.valueDate=cpdentryData.entrydate;
        cPDProfileEntryViewController.valueDuration=cpdentryData.entryduration;
        cPDProfileEntryViewController.valueTimestamp=cpdentryData.entryTimestamp;
        [self.navigationController pushViewController:cPDProfileEntryViewController animated:YES];
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
