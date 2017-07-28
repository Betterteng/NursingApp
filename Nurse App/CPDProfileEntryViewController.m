//
//  CPDProfileEntryViewController.m
//  Nurse App
//
//  Created by ram mendhe on 12/04/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import "CPDProfileEntryViewController.h"
#import "EntryTitleCellView.h"
#import "EntryButtonCellView.h"
#import "EntryFormCellView.h"
#import "CPDTitleListViewController.h"
#import "TextViewController.h"
#import "DatePcikerViewController.h"
#import "DurationPcikerViewController.h"
#import "DBFunctions.h"
#import "UserIdentification+Add.h"

@interface CPDProfileEntryViewController ()

@end

@implementation CPDProfileEntryViewController

@synthesize valueTitle = _valueTitle;
@synthesize valueNotes = _valueNotes;
@synthesize valueDate = _valueDate;
@synthesize valueDuration = _valueDuration;

- (void) setValueTitle:(NSString *)title {
    NSLog(@"setvalueTitle");
    _valueTitle =title;
    if (0!=[self.entryFormCellArray count]) {
        EntryFormCellView *cell = [self.entryFormCellArray objectAtIndex:1];
        cell.entryFormValueLabel.text=title;
    }
}

- (void) setValueNotes:(NSString *)notes {
    NSLog(@"setvalueTitle");
    _valueNotes =notes;
    if (0!=[self.entryFormCellArray count]) {
        EntryFormCellView *cell = [self.entryFormCellArray objectAtIndex:2];
        cell.entryFormValueLabel.text=notes;
    }
}

- (void) setValueDate:(NSString *)date {
    NSLog(@"setvalueTitle");
    _valueDate =date;
    if (0!=[self.entryFormCellArray count]) {
        EntryFormCellView *cell = [self.entryFormCellArray objectAtIndex:3];
        cell.entryFormValueLabel.text=date;
    }
}

- (void) setValueDuration:(NSString *)duration {
    NSLog(@"setvalueTitle %@",duration);
    _valueDuration =duration;
    
    if (0!=[self.entryFormCellArray count]) {
        EntryFormCellView *cell = [self.entryFormCellArray objectAtIndex:4];
        int result=(int)[duration integerValue];
        int minutes = result%60;
        int hours = (result - minutes)/60;
        NSLog(@"result:%d, minutes:%d, hours:%d",result,minutes,hours);
        cell.entryFormValueLabel.text=[NSString stringWithFormat:@"%dhr,%dmin", hours, minutes];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigationBar];
    self.titlesArray=[[NSArray alloc] initWithObjects:@"",@"Title",@"Notes",@"Date",@"Duration", nil];
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ChartTableBackground"]];
    [tempImageView setFrame:self.cpdEntryTableView.frame];
    self.cpdEntryTableView.backgroundView = tempImageView;
    if (!self.valueTimestamp) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd/MM/YYYY"];
        NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
        NSLog(@"date: %@", dateString);
        
        self.valueTitle=@"Reflecting on feedback";
        self.valueNotes=@"";
        self.valueDate=dateString;
        self.valueDuration=@"30";
    }
    [self createEntryFormCell];
    [self.cpdEntryTableView reloadData];
   
}
-(void)createNavigationBar
{
    UIImageView *navigationTitleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavigationTitle"]];
    self.navigationItem.titleView=navigationTitleImage;
    
    // set navigation bar background color
    self.navigationController.navigationBar.barStyle=UIBarStyleBlack;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:15.0f/255.0f green:15.0f/255.0f blue:15.0f/255.0f alpha:1.0f]];
    if (self.valueTimestamp) {
        //Navigation Chart button
        UIImage* trashCPDImage=[UIImage imageNamed:@"TrashButton"];
        UIButton *trashButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [trashButton setImage:trashCPDImage forState:UIControlStateNormal];
        trashButton.showsTouchWhenHighlighted = YES;
        trashButton.frame = CGRectMake(0.0, 0.0, trashCPDImage.size.width, trashCPDImage.size.height);
        [trashButton addTarget:self action:@selector(trashButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *trashCPDButton = [[UIBarButtonItem alloc] initWithCustomView:trashButton];
        self.navigationItem.rightBarButtonItem = trashCPDButton;
    }
}

-(void)trashButtonClicked{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@""
                                          message:@"Are you sure, you want to delete log?"
                                          preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"OK action") style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action)
                                   {
                                       [alertController dismissViewControllerAnimated:YES completion:nil];
                                       
                                   }];
    [alertController addAction:cancelAction];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Delete", @"OK action") style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action)
                               {
                                   DBFunctions* dBFunctions=[[DBFunctions alloc] init];
                                   [dBFunctions deleteCPDEntryWithTimestamp:self.valueTimestamp];
                                   [alertController dismissViewControllerAnimated:YES completion:nil];
                                   [self.navigationController popViewControllerAnimated:YES];
                               }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

//Table View Codding. ----- Start
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.entryFormCellArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.entryFormCellArray objectAtIndex:indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 130;
    }
    if (indexPath.row==5) {
        return 100;
    }
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected row %ld",(long)indexPath.row);
    if (indexPath.row==1) {
        CPDTitleListViewController* cPDTitleListViewController=[[CPDTitleListViewController alloc] initWithNibName:@"CPDTitleListViewController" bundle:nil];
        cPDTitleListViewController.cPDProfileEntryViewController=self;
        cPDTitleListViewController.selectedTitle=self.valueTitle;
        [self.navigationController pushViewController:cPDTitleListViewController animated:YES];
    }else if(indexPath.row==2){
        TextViewController* textViewController=[[TextViewController alloc] initWithNibName:@"TextViewController" bundle:nil];
        textViewController.cPDProfileEntryViewController=self;
        textViewController.selectedNotes=self.valueNotes;
        [self.navigationController pushViewController:textViewController animated:YES];
    }else if(indexPath.row==3){
        DatePcikerViewController* datePcikerViewController=[[DatePcikerViewController alloc] initWithNibName:@"DatePcikerViewController" bundle:nil];
        datePcikerViewController.cPDProfileEntryViewController=self;
        datePcikerViewController.selectedDate=self.valueDate;
        [self.navigationController pushViewController:datePcikerViewController animated:YES];
    }else if(indexPath.row==4){
        DurationPcikerViewController* durationPcikerViewController=[[DurationPcikerViewController alloc] initWithNibName:@"DurationPcikerViewController" bundle:nil];
        durationPcikerViewController.cPDProfileEntryViewController=self;
        durationPcikerViewController.selectedduration=self.valueDuration;
        [self.navigationController pushViewController:durationPcikerViewController animated:YES];
    }
}

-(void)createEntryFormCell{
    self.entryFormCellArray=[[NSMutableArray alloc] init];
    
    //First Cell
    static NSString *cellIdentifier = @"Cell";
    EntryTitleCellView *cell1 = (EntryTitleCellView *)[self.cpdEntryTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell1 == nil)
    {
        cell1 = [[[NSBundle mainBundle] loadNibNamed:@"EntryTitleCellView" owner:nil options:nil] objectAtIndex: 0];;
    }
    cell1.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.entryFormCellArray addObject:cell1];
    
    //Second Cell
    EntryFormCellView *cell2 = (EntryFormCellView *)[self.cpdEntryTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell2 == nil)
    {
        cell2 = [[[NSBundle mainBundle] loadNibNamed:@"EntryFormCellView" owner:nil options:nil] objectAtIndex: 0];;
    }
    cell2.selectionStyle=UITableViewCellSelectionStyleNone;
    cell2.entryFormBackgroundImage.image=[UIImage imageNamed:@"EntryFormTopCellBackground"];
    cell2.entryFormTitleLabel.font=[UIFont fontWithName:@"MyriadPro-Semibold" size:22];
    cell2.entryFormTitleLabel.textColor=[UIColor colorWithRed:21.0f/255.0f green:21.0f/255.0f blue:21.0f/255.0f alpha:1.0f];
    cell2.entryFormTitleLabel.text=[self.titlesArray objectAtIndex:1];
    cell2.entryFormValueLabel.font=[UIFont fontWithName:@"MyriadPro-Semibold" size:20];
    cell2.entryFormValueLabel.textColor=[UIColor colorWithRed:100.0f/255.0f green:100.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
    cell2.entryFormValueLabel.text=self.valueTitle;
    [self.entryFormCellArray addObject:cell2];
    
    //Thired Cell
    EntryFormCellView *cell3 = (EntryFormCellView *)[self.cpdEntryTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell3 == nil)
    {
        cell3 = [[[NSBundle mainBundle] loadNibNamed:@"EntryFormCellView" owner:nil options:nil] objectAtIndex: 0];;
    }
    cell3.selectionStyle=UITableViewCellSelectionStyleNone;
    cell3.entryFormBackgroundImage.image=[UIImage imageNamed:@"EntryFormMiddleCellBackground"];
    cell3.entryFormTitleLabel.font=[UIFont fontWithName:@"MyriadPro-Semibold" size:22];
    cell3.entryFormTitleLabel.textColor=[UIColor colorWithRed:21.0f/255.0f green:21.0f/255.0f blue:21.0f/255.0f alpha:1.0f];
    cell3.entryFormTitleLabel.text=[self.titlesArray objectAtIndex:2];
    cell3.entryFormValueLabel.font=[UIFont fontWithName:@"MyriadPro-Semibold" size:20];
    cell3.entryFormValueLabel.textColor=[UIColor colorWithRed:100.0f/255.0f green:100.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
    cell3.entryFormValueLabel.text=self.valueNotes;
    [self.entryFormCellArray addObject:cell3];
    
    //Forth Cell
    EntryFormCellView *cell4 = (EntryFormCellView *)[self.cpdEntryTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell4 == nil)
    {
        cell4 = [[[NSBundle mainBundle] loadNibNamed:@"EntryFormCellView" owner:nil options:nil] objectAtIndex: 0];;
    }
    cell4.selectionStyle=UITableViewCellSelectionStyleNone;
    cell4.entryFormBackgroundImage.image=[UIImage imageNamed:@"EntryFormMiddleCellBackground"];
    cell4.entryFormTitleLabel.font=[UIFont fontWithName:@"MyriadPro-Semibold" size:22];
    cell4.entryFormTitleLabel.textColor=[UIColor colorWithRed:21.0f/255.0f green:21.0f/255.0f blue:21.0f/255.0f alpha:1.0f];
    cell4.entryFormTitleLabel.text=[self.titlesArray objectAtIndex:3];
    cell4.entryFormValueLabel.font=[UIFont fontWithName:@"MyriadPro-Semibold" size:20];
    cell4.entryFormValueLabel.textColor=[UIColor colorWithRed:100.0f/255.0f green:100.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
    cell4.entryFormValueLabel.text=self.valueDate;
    [self.entryFormCellArray addObject:cell4];
    
    
    //Fifth Cell
    EntryFormCellView *cell5 = (EntryFormCellView *)[self.cpdEntryTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell5 == nil)
    {
        cell5 = [[[NSBundle mainBundle] loadNibNamed:@"EntryFormCellView" owner:nil options:nil] objectAtIndex: 0];;
    }
    cell5.selectionStyle=UITableViewCellSelectionStyleNone;
    cell5.entryFormBackgroundImage.image=[UIImage imageNamed:@"EntryFormBottomCellBackground"];
    cell5.entryFormTitleLabel.font=[UIFont fontWithName:@"MyriadPro-Semibold" size:22];
    cell5.entryFormTitleLabel.textColor=[UIColor colorWithRed:21.0f/255.0f green:21.0f/255.0f blue:21.0f/255.0f alpha:1.0f];
    cell5.entryFormTitleLabel.text=[self.titlesArray objectAtIndex:4];
    cell5.entryFormValueLabel.font=[UIFont fontWithName:@"MyriadPro-Semibold" size:20];
    cell5.entryFormValueLabel.textColor=[UIColor colorWithRed:100.0f/255.0f green:100.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
    int result=(int)[self.valueDuration integerValue];
    int minutes = result%60;
    int hours = (result - minutes)/60;
    cell5.entryFormValueLabel.text=[NSString stringWithFormat:@"%dhr,%dmin", hours, minutes];
    [self.entryFormCellArray addObject:cell5];
    
    //Sixth Cell
    EntryButtonCellView *cell6 = (EntryButtonCellView *)[self.cpdEntryTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell6 == nil)
    {
        cell6 = [[[NSBundle mainBundle] loadNibNamed:@"EntryButtonCellView" owner:nil options:nil] objectAtIndex: 0];;
    }
    cell6.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell6.cancelButton addTarget:self action:@selector(cancelButtonClciked) forControlEvents:UIControlEventTouchUpInside];
    [cell6.saveButton addTarget:self action:@selector(saveButtonClciked) forControlEvents:UIControlEventTouchUpInside];
    [self.entryFormCellArray addObject:cell6];
    
}

//-(void)addToDatabase:(NSString*) userIdentity{
//    NSDictionary *userInfo = @{@"userId": userIdentity};
//    [UserIdentification addUserInfoFromDictionary:userInfo];
//}

-(void)cancelButtonClciked{
    NSLog(@"cancelButtonClciked");
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)saveButtonClciked{
    NSLog(@"saveButtonClciked");
    DBFunctions* dBFunctions=[[DBFunctions alloc] init];
    if (self.valueTimestamp) {
        NSLog(@"data updated");
        [dBFunctions updateCPDEntryWithTitle:self.valueTitle notes:self.valueNotes date:self.valueDate duration:self.valueDuration timestamp:self.valueTimestamp];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        NSLog(@"data saved");
        // Do the validation now - check if user's identification has been saved in the core data
        BOOL hasId = true;
                
        if (hasId) {
            // Pop up an alert to ask user's identification such as email address
            NSLog(@"********************************");
            UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"User Identification Needed"
                                                                                     message:@"This alert won't show up again after the identification has been saved."
                                                                                     preferredStyle:UIAlertControllerStyleAlert];
            // Add a textField to the alert
            [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
                textField.placeholder = @"Type your userID correctly.";
                textField.secureTextEntry = nil;
            }];
            // Extract user input from textField
            UIAlertAction* saveAction = [UIAlertAction actionWithTitle:@"SAVE" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                            NSString *userInput = ((UITextField *)[alertController.textFields objectAtIndex:0]).text;
                                            // Save userId to core data - [UserIdentification]
                                            NSDictionary *userInfo = @{@"userId": userInput};
                                            [UserIdentification addUserInfoFromDictionary:userInfo];
                                                                   
                                            NSLog(@"_+_+_+_+_+_+_+_+_+_+_+");
                                            NSLog(@"%@", userInput);
                                            NSLog(@"%@", [UserIdentification addUserInfoFromDictionary:userInfo].description);
                
                                            // Stroe CPD portfolio into core data
                                            [dBFunctions addCPDEntryInDbWithTitle:self.valueTitle notes:self.valueNotes date:self.valueDate duration:self.valueDuration];
                                            // Go back to previous level screen
                                            [self.navigationController popViewControllerAnimated:YES];
                                        }];
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"CANCEL" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
            // Add actions to the alert
            [alertController addAction:saveAction];
            [alertController addAction:cancelAction];
            // Show the alert
            [self presentViewController:alertController animated:YES completion:nil];
        } else {
            // Collect user's input and ready to form a JSON file
            NSLog(@"********************************");
            NSDictionary *jsonReady = [NSDictionary dictionaryWithObjectsAndKeys:
                                       self.valueTitle, @"Title",
                                       self.valueNotes, @"Notes",
                                       self.valueDate, @"Date",
                                       self.valueDuration, @"Duration",
                                       nil];
            NSError *error;
            // Generate the JSON data
            NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonReady options:NSJSONWritingPrettyPrinted error:&error];
            // Convert JSON into NSString
            NSString* newStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSLog(@"%@", newStr);
            NSLog(@"********************************");
            // Save CPD portfolio to core data
            [dBFunctions addCPDEntryInDbWithTitle:self.valueTitle notes:self.valueNotes date:self.valueDate duration:self.valueDuration];
            // Go back to the previous screen
            [self.navigationController popViewControllerAnimated:YES];
        }
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
