//
//  DripRatesViewController.m
//  Nurse App
//
//  Created by ram mendhe on 11/04/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import "DripRatesViewController.h"
#import "DripRatesFormulaCell.h"
#import "DripRateResultCell.h"
#import "DripRateInputCell.h"
@interface DripRatesViewController ()<UITextFieldDelegate>
{
    DripRatesFormulaCell * dripRatesFormulaCell;
    DripRateResultCell * dripRateResultCell;
    DripRateInputCell * dripRateInputCell;
    NSMutableArray * cellarray;
    double volumeValue,topresult,bottomresult,timeValue;
    int chooseValue;
    NSString * volumeUnit,* hoursUnit,* chooseValueFromPicker,*selectedValue;
     NSMutableArray * unitPickerArray;
     NSInteger  selectedbuttonTag;
}

@end

@implementation DripRatesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    volumeValue=1000.0;
    timeValue=12.0;
    volumeUnit=@"mL";
    hoursUnit=@"hours";
    chooseValue=20;
    chooseValueFromPicker=@"20 dpm(Std.Adult)";
    self.scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ChartTableBackground"]];
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSFontAttributeName:[UIFont fontWithName:@"Roboto-Bold" size:23]}];
    self.navigationItem.title=self.pageTitle;
    [self createCellArrayWithResponseString];
    self.tableviewOuterView.layer.cornerRadius = 10.0;
    self.tableviewOuterView.layer.masksToBounds = YES;
    self.PickerViewOuterView.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.4];
    UITapGestureRecognizer *PickerGestureViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewClicked)];
    [self.PickerViewOuterView addGestureRecognizer:PickerGestureViewTap];
    
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
    else
    {
        NSArray* foo = [selectedValue componentsSeparatedByString: @" "];
        chooseValue=(int)[[foo objectAtIndex:0]integerValue];
        chooseValueFromPicker=selectedValue;
        
    }
    [self createCellArrayWithResponseString];
    [self.PickerViewOuterView setHidden:YES];
}




-(void)createCellArrayWithResponseString{
    
    cellarray=[[NSMutableArray alloc]init];
     [self calculateResult];
    static NSString *CellIdentifier = @"Cell";
    dripRatesFormulaCell=[self.dripratesTableview dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(dripRatesFormulaCell==nil){
        NSArray* objects= [[NSBundle mainBundle] loadNibNamed:@"DripRatesFormulaCell" owner:nil options:nil];
        DripRatesFormulaCell *acell = [objects objectAtIndex:0];
        dripRatesFormulaCell = acell;
    }
    [cellarray addObject:dripRatesFormulaCell];
    
    dripRateInputCell=[self.dripratesTableview dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(dripRateInputCell==nil){
        NSArray* objects= [[NSBundle mainBundle] loadNibNamed:@"DripRateInputCell" owner:nil options:nil];
        DripRateInputCell *acell = [objects objectAtIndex:0];
        dripRateInputCell = acell;
    }
    dripRateInputCell.volumeTF.text=[NSString stringWithFormat:@"%.1f",volumeValue];
    dripRateInputCell.volumeTF.delegate=self;
    UIToolbar *doneToolbar = [[UIToolbar alloc] initWithFrame:(CGRect){0, 0, 50, 50}]; // Create and init
    doneToolbar.barStyle = UIBarStyleDefault; // Specify the preferred barStyle
    UIBarButtonItem *button =[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneEditAction)];
    [button setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:235.0f/255.0f green:73.0f/255.0f blue:81.0f/255.0f alpha:1.0f], NSForegroundColorAttributeName,nil]forState:UIControlStateNormal];
    doneToolbar.items = @[
                          [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                          button // Add your target action
                          ]; // Define items -- you can add more
    dripRateInputCell.volumeTF.inputAccessoryView = doneToolbar; // Now add toolbar to your field's inputview and run
    [doneToolbar sizeToFit]; // call this to auto fit to the view

    [dripRateInputCell.volumeUnitBtn setTitle:volumeUnit forState:UIControlStateNormal];
    [dripRateInputCell.volumeUnitBtn addTarget:self action:@selector(showPickerMethod:) forControlEvents:UIControlEventTouchUpInside];
    dripRateInputCell.volumeUnitBtn.tag=0;

   /* [dripRateInputCell.timeBtn setTitle:[NSString stringWithFormat:@"%d",timeValue] forState:UIControlStateNormal];
   // [dripRateInputCell.timeBtn addTarget:self action:@selector(showPickerMethod:) forControlEvents:UIControlEventTouchUpInside];
    dripRateInputCell.timeBtn.tag=1;
*/
    
    dripRateInputCell.timeTF.text=[NSString stringWithFormat:@"%.1f",timeValue];
    dripRateInputCell.timeTF.delegate=self;
    UIToolbar *donetimeTFToolbar = [[UIToolbar alloc] initWithFrame:(CGRect){0, 0, 50, 50}]; // Create and init
    donetimeTFToolbar.barStyle = UIBarStyleDefault; // Specify the preferred barStyle
    UIBarButtonItem *timeTFbutton =[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneEditAction)];
    [timeTFbutton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:235.0f/255.0f green:73.0f/255.0f blue:81.0f/255.0f alpha:1.0f], NSForegroundColorAttributeName,nil]forState:UIControlStateNormal];
    donetimeTFToolbar.items = @[
                          [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                          timeTFbutton // Add your target action
                          ]; // Define items -- you can add more
    dripRateInputCell.timeTF.inputAccessoryView = donetimeTFToolbar; // Now add toolbar to your field's inputview and run
    [donetimeTFToolbar sizeToFit]; // call this to auto fit to the view

    
    
    
    
    
    
    
    [dripRateInputCell.hoursUnitBtn setTitle:hoursUnit forState:UIControlStateNormal];
    [dripRateInputCell.hoursUnitBtn addTarget:self action:@selector(showPickerMethod:) forControlEvents:UIControlEventTouchUpInside];
    dripRateInputCell.hoursUnitBtn.tag=2;
 
    [dripRateInputCell.chooseBtn setTitle:chooseValueFromPicker forState:UIControlStateNormal];
    [dripRateInputCell.chooseBtn addTarget:self action:@selector(showPickerMethod:) forControlEvents:UIControlEventTouchUpInside];
    dripRateInputCell.chooseBtn.tag=3;
   
    [cellarray addObject:dripRateInputCell];
    dripRateResultCell=[self.dripratesTableview dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(dripRateResultCell==nil){
        NSArray* objects= [[NSBundle mainBundle] loadNibNamed:@"DripRateResultCell" owner:nil options:nil];
        DripRateResultCell *acell = [objects objectAtIndex:0];
        dripRateResultCell = acell;
    }
    
    dripRateResultCell.volumeLbl.text=[NSString stringWithFormat:@"%.1f (mL)",volumeValue];
    dripRateResultCell.hourLbl.text=[NSString stringWithFormat:@"%.1f(hours)",timeValue];
    dripRateResultCell.dpmLbl.text=[NSString stringWithFormat:@"%d(drops/mL)",chooseValue];
    dripRateResultCell.topResultLbl.text=[NSString stringWithFormat:@"%.1fmL/Hr",topresult];
    dripRateResultCell.bottomResultLbl.text=[NSString stringWithFormat:@"%.1fdpm",bottomresult];
    [cellarray addObject:dripRateResultCell];
    
    [self.dripratesTableview reloadData];
    
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
        selectedValue=[NSString stringWithFormat:@"%d",timeValue];*/
    }
    else if(sender.tag==2)
    {
        unitPickerArray=[[NSMutableArray alloc]initWithObjects:@"hours", nil];
        selectedValue=[NSString stringWithFormat:@"%@",hoursUnit];
    }
    else
    {
        unitPickerArray=[[NSMutableArray alloc]initWithObjects:@"20 dpm(Std.Adult)",@"60 dpm(std.Paed)", nil];
        selectedValue=chooseValueFromPicker;
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
    bottomresult=(((topresult)*chooseValue)/60);
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
        return 176;
    else
        return 107;
}
#pragma textfield delegate method
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if(textField==dripRateInputCell.volumeTF)
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
