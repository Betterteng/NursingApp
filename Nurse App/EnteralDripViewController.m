//
//  EnteralDripViewController.m
//  Nurse App
//
//  Created by ram mendhe on 11/04/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import "EnteralDripViewController.h"
#import "EnteralDripFormulaCell.h"
#import "EnteralDripResultCell.h"
#import "EnteralDripInputCell.h"

@interface EnteralDripViewController ()<UITextFieldDelegate>
{
     NSMutableArray * cellarray;
    EnteralDripFormulaCell * enteralDripFormulaCell;
    EnteralDripResultCell * enteralDripResultCell;
    EnteralDripInputCell * enteralDripInputCell;
    double volumeValue,topresult,bottomresult,timeValue;
    NSString * volumeUnit,* hoursUnit,*selectedValue;
    NSMutableArray * unitPickerArray;
    NSInteger  selectedbuttonTag;
}

@end

@implementation EnteralDripViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    volumeValue=500.0;
    timeValue=12.0;
    volumeUnit=@"mL";
    hoursUnit=@"hours";
    self.scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ChartTableBackground"]];
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSFontAttributeName:[UIFont fontWithName:@"Roboto-Bold" size:23]}];
    self.tableviewOuterView.layer.cornerRadius = 10.0;
    self.tableviewOuterView.layer.masksToBounds = YES;
    self.navigationItem.title=self.pageTitle;
    self.PickerViewOuterView.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.4];
    UITapGestureRecognizer *PickerGestureViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewClicked)];
    [self.PickerViewOuterView addGestureRecognizer:PickerGestureViewTap];
     [self createCellArrayWithResponseString];
}

-(void)backgroundViewClicked
{
    [self pickerCancelButtonCliked:self];
}

-(IBAction)pickerCancelButtonCliked:(id)sender
{
    [self.PickerViewOuterView setHidden:YES];
}

-(IBAction)pickerDoneButtonClicked:(id)sender
{
    NSLog(@"done button clicked");
    if(selectedbuttonTag==0)
    {
        volumeUnit=selectedValue;
    }
    else if(selectedbuttonTag==1)
    {
       /* NSArray* foo = [selectedValue componentsSeparatedByString: @" "];
        timeValue=(int)[[foo objectAtIndex:0] integerValue] ;*/
    }
    else if(selectedbuttonTag==2)
    {
        hoursUnit=selectedValue;
    }
    [self createCellArrayWithResponseString];
    [self.PickerViewOuterView setHidden:YES];
}




-(void)createCellArrayWithResponseString{
    
    cellarray=[[NSMutableArray alloc]init];
    [self calculateResult];
    static NSString *CellIdentifier = @"Cell";
    enteralDripFormulaCell=[self.enteraldripTableview dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(enteralDripFormulaCell==nil){
        NSArray* objects= [[NSBundle mainBundle] loadNibNamed:@"EnteralDripFormulaCell" owner:nil options:nil];
        EnteralDripFormulaCell *acell = [objects objectAtIndex:0];
        enteralDripFormulaCell = acell;
    }
    [cellarray addObject:enteralDripFormulaCell];
    
    enteralDripInputCell=[self.enteraldripTableview dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(enteralDripInputCell==nil){
        NSArray* objects= [[NSBundle mainBundle] loadNibNamed:@"EnteralDripInputCell" owner:nil options:nil];
        EnteralDripInputCell *acell = [objects objectAtIndex:0];
        enteralDripInputCell = acell;
    }
    
    enteralDripInputCell.volumeTF.text=[NSString stringWithFormat:@"%.1f",volumeValue];
    enteralDripInputCell.volumeTF.delegate=self;
    UIToolbar *doneToolbar = [[UIToolbar alloc] initWithFrame:(CGRect){0, 0, 50, 50}]; // Create and init
    doneToolbar.barStyle = UIBarStyleDefault; // Specify the preferred barStyle
    UIBarButtonItem *button =[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneEditAction)];
    [button setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:235.0f/255.0f green:73.0f/255.0f blue:81.0f/255.0f alpha:1.0f], NSForegroundColorAttributeName,nil]forState:UIControlStateNormal];
    doneToolbar.items = @[
                          [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                          button // Add your target action
                          ]; // Define items -- you can add more
    enteralDripInputCell.volumeTF.inputAccessoryView = doneToolbar; // Now add toolbar to your field's inputview and run
    [doneToolbar sizeToFit]; // call this to auto fit to the view
    
    [enteralDripInputCell.volumeUnitBtn setTitle:volumeUnit forState:UIControlStateNormal];
    [enteralDripInputCell.volumeUnitBtn addTarget:self action:@selector(showPickerMethod:) forControlEvents:UIControlEventTouchUpInside];
    enteralDripInputCell.volumeUnitBtn.tag=0;
    
    
    enteralDripInputCell.timeTF.text=[NSString stringWithFormat:@"%.1f",timeValue];
    enteralDripInputCell.timeTF.delegate=self;
    UIToolbar *donetimeTFToolbar = [[UIToolbar alloc] initWithFrame:(CGRect){0, 0, 50, 50}]; // Create and init
    donetimeTFToolbar.barStyle = UIBarStyleDefault; // Specify the preferred barStyle
    UIBarButtonItem *buttontimeTF =[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneEditAction)];
    [buttontimeTF setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:235.0f/255.0f green:73.0f/255.0f blue:81.0f/255.0f alpha:1.0f], NSForegroundColorAttributeName,nil]forState:UIControlStateNormal];
    donetimeTFToolbar.items = @[
                          [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                          buttontimeTF // Add your target action
                          ]; // Define items -- you can add more
    enteralDripInputCell.timeTF.inputAccessoryView = donetimeTFToolbar; // Now add toolbar to your field's inputview and run
    [donetimeTFToolbar sizeToFit]; // call this to auto fit to the view
    
    
   /* [enteralDripInputCell.timeBtn setTitle:[NSString stringWithFormat:@"%d",timeValue] forState:UIControlStateNormal];
    [enteralDripInputCell.timeBtn addTarget:self action:@selector(showPickerMethod:) forControlEvents:UIControlEventTouchUpInside];
    enteralDripInputCell.timeBtn.tag=1;*/
    
    [enteralDripInputCell.hoursUnitBtn setTitle:hoursUnit forState:UIControlStateNormal];
    [enteralDripInputCell.hoursUnitBtn addTarget:self action:@selector(showPickerMethod:) forControlEvents:UIControlEventTouchUpInside];
    enteralDripInputCell.hoursUnitBtn.tag=2;

    
    
    
    
    
    
    
    
    
    
    [cellarray addObject:enteralDripInputCell];
    
    enteralDripResultCell=[self.enteraldripTableview dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(enteralDripResultCell==nil){
        NSArray* objects= [[NSBundle mainBundle] loadNibNamed:@"EnteralDripResultCell" owner:nil options:nil];
        EnteralDripResultCell *acell = [objects objectAtIndex:0];
        enteralDripResultCell = acell;
    }
    enteralDripResultCell.volumeLbl.text=[NSString stringWithFormat:@"%.1f (mL)",volumeValue];
    enteralDripResultCell.hourLbl.text=[NSString stringWithFormat:@"%.1f(hours)",timeValue];
    enteralDripResultCell.topResultLbl.text=[NSString stringWithFormat:@"%.1fmL/Hr",topresult];
    enteralDripResultCell.bottomResultLbl.text=[NSString stringWithFormat:@"%.1fdpm",bottomresult];
    
    
    [cellarray addObject:enteralDripResultCell];
    
    [self.enteraldripTableview reloadData];
    
}
-(void)showPickerMethod:(UIButton*)sender
{
    [self.view endEditing:YES];
    if(sender.tag==0)
    {
        unitPickerArray=[[NSMutableArray alloc]initWithObjects:@"mL", nil];
        selectedValue=volumeUnit;
    }
    else if(sender.tag==1)
    {
       /* unitPickerArray=[[NSMutableArray alloc]initWithObjects:@"1 hours",@"2 hours",@"3 hours",@"4 hours",@"5 hours",@"6 hours",@"7 hours",@"8 hours",@"9 hours",@"10 hours",@"11 hours",@"12 hours",@"13 hours",@"14 hours",@"15 hours",@"16 hours",@"17 hours",@"18 hours",@"19 hours",@"20 hours",@"21 hours",@"22 hours",@"23 hours",@"24 hours", nil];
        selectedValue=[NSString stringWithFormat:@"%d",timeValue];
        */
    }
    else
    {
        unitPickerArray=[[NSMutableArray alloc]initWithObjects:@"hours", nil];
        selectedValue=[NSString stringWithFormat:@"%@",hoursUnit];
    }
    [self.UnitsPickerView selectedRowInComponent:0];
    selectedbuttonTag=sender.tag;
    [self.UnitsPickerView reloadAllComponents];
    [self.PickerViewOuterView setHidden:NO];
}

- (void)doneEditAction {
    [self.view endEditing:YES];
    [self createCellArrayWithResponseString];
}

-(void)calculateResult
{
    topresult=(volumeValue/timeValue);
    bottomresult=(((topresult)*14)/60);
}






#pragma tableview delegate method
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return cellarray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellarray[indexPath.row];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
        return 164;
    else if(indexPath.row==1)
        return 130;
    else
        return 107;
}

#pragma textfield delegate method
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if(textField==enteralDripInputCell.volumeTF)
    {
        volumeValue=[textField.text doubleValue];
    }
    else
    {
        timeValue=[textField.text doubleValue];
    }

    return YES;
}

#pragma pickerView delegate method
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [unitPickerArray count];
}


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *columnView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    columnView.text = unitPickerArray[row];
    columnView.textAlignment = NSTextAlignmentCenter;
    return columnView;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    NSLog(@"%@",unitPickerArray[row]);
    selectedValue=unitPickerArray[row];
    
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
