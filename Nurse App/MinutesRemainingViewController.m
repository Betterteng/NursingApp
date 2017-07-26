//
//  MinutesRemainingViewController.m
//  Nurse App
//
//  Created by ram mendhe on 11/04/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import "MinutesRemainingViewController.h"
#import "MinutesRemainingFormulaCell.h"
#import "MinutesRemainingInputCell.h"
#import "MinutesRemainingResultCell.h"

@interface MinutesRemainingViewController ()<UITextFieldDelegate>
{
     NSMutableArray * cellarray;
    MinutesRemainingFormulaCell * minutesRemainingFormulaCell;
    MinutesRemainingInputCell * minutesRemainingInputCell;
    MinutesRemainingResultCell * minutesRemainingResultCell;
    double volumeValue,resultValue,dropsValue;
    int chooseValue;
    NSString * volumeUnit,* dropsUnit,* chooseValueFromPicker,*selectedValue;
    NSMutableArray * unitPickerArray;
    NSInteger  selectedbuttonTag;
}

@end

@implementation MinutesRemainingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    volumeValue=1000.0;
    volumeUnit=@"mL";
    dropsValue=14.0;
    dropsUnit=@"min";
    chooseValue=20;
    chooseValueFromPicker=@"20 (adult)";
    
    self.scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ChartTableBackground"]];
    self.tableviewOuterView.layer.cornerRadius = 10.0;
    self.tableviewOuterView.layer.masksToBounds = YES;
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSFontAttributeName:[UIFont fontWithName:@"Roboto-Bold" size:23]}];
    self.navigationItem.title=self.pageTitle;
    [self createCellArrayWithResponseString];
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
        chooseValueFromPicker=selectedValue;
        NSArray* foo = [selectedValue componentsSeparatedByString: @" "];
        chooseValue=(int)[[foo objectAtIndex:0] integerValue] ;
    }
    else
    {
        dropsUnit=selectedValue;
    }
    [self createCellArrayWithResponseString];
    [self.PickerViewOuterView setHidden:YES];
}




-(void)createCellArrayWithResponseString{
    
    cellarray=[[NSMutableArray alloc]init];
    [self calculateResult];
    static NSString *CellIdentifier = @"Cell";
    minutesRemainingFormulaCell=[self.minutesremainigTableview dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(minutesRemainingFormulaCell==nil){
        NSArray* objects= [[NSBundle mainBundle] loadNibNamed:@"MinutesRemainingFormulaCell" owner:nil options:nil];
        MinutesRemainingFormulaCell *acell = [objects objectAtIndex:0];
        minutesRemainingFormulaCell = acell;
    }
    
    


    
    
    [cellarray addObject:minutesRemainingFormulaCell];
    
    minutesRemainingInputCell=[self.minutesremainigTableview dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(minutesRemainingInputCell==nil){
        NSArray* objects= [[NSBundle mainBundle] loadNibNamed:@"MinutesRemainingInputCell" owner:nil options:nil];
        MinutesRemainingInputCell *acell = [objects objectAtIndex:0];
        minutesRemainingInputCell = acell;
    }
    minutesRemainingInputCell.volumeTF.text=[NSString stringWithFormat:@"%.1f",volumeValue];
    minutesRemainingInputCell.volumeTF.delegate=self;
    UIToolbar *doneToolbar = [[UIToolbar alloc] initWithFrame:(CGRect){0, 0, 50, 50}]; // Create and init
    doneToolbar.barStyle = UIBarStyleDefault; // Specify the preferred barStyle
    UIBarButtonItem *button =[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneEditAction)];
    [button setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:235.0f/255.0f green:73.0f/255.0f blue:81.0f/255.0f alpha:1.0f], NSForegroundColorAttributeName,nil]forState:UIControlStateNormal];
    doneToolbar.items = @[
                          [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                          button // Add your target action
                          ]; // Define items -- you can add more
    minutesRemainingInputCell.volumeTF.inputAccessoryView = doneToolbar; // Now add toolbar to your field's inputview and run
    [doneToolbar sizeToFit]; // call this to auto fit to the view
    
    [minutesRemainingInputCell.volumeUnitBtn setTitle:volumeUnit forState:UIControlStateNormal];
    [minutesRemainingInputCell.volumeUnitBtn addTarget:self action:@selector(showPickerMethod:) forControlEvents:UIControlEventTouchUpInside];
    minutesRemainingInputCell.volumeUnitBtn.tag=0;
    
    
    [minutesRemainingInputCell.chooseBtn setTitle:chooseValueFromPicker forState:UIControlStateNormal];
    [minutesRemainingInputCell.chooseBtn addTarget:self action:@selector(showPickerMethod:) forControlEvents:UIControlEventTouchUpInside];
    minutesRemainingInputCell.chooseBtn.tag=1;
    
    
    minutesRemainingInputCell.dropsTF.text=[NSString stringWithFormat:@"%.1f",dropsValue];
    minutesRemainingInputCell.dropsTF.delegate=self;
    minutesRemainingInputCell.dropsTF.inputAccessoryView = doneToolbar; // Now add toolbar to your field's inputview and run
    [doneToolbar sizeToFit]; // call this to auto fit to the view
    
    [minutesRemainingInputCell.dropsUnitBtn setTitle:dropsUnit forState:UIControlStateNormal];
    [minutesRemainingInputCell.dropsUnitBtn addTarget:self action:@selector(showPickerMethod:) forControlEvents:UIControlEventTouchUpInside];
    minutesRemainingInputCell.dropsUnitBtn.tag=2;
    [cellarray addObject:minutesRemainingInputCell];
    

    minutesRemainingResultCell=[self.minutesremainigTableview dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(minutesRemainingResultCell==nil){
        NSArray* objects= [[NSBundle mainBundle] loadNibNamed:@"MinutesRemainingResultCell" owner:nil options:nil];
        MinutesRemainingResultCell *acell = [objects objectAtIndex:0];
        minutesRemainingResultCell = acell;
    }
    minutesRemainingResultCell.volumeLbl.text=[NSString stringWithFormat:@"%.1f (mL)",volumeValue];
    minutesRemainingResultCell.dropLbl.text=[NSString stringWithFormat:@"%.1f",dropsValue];
    minutesRemainingResultCell.chooseLbl.text=[NSString stringWithFormat:@"%@",chooseValueFromPicker];
    minutesRemainingResultCell.ResultLbl.text=[NSString stringWithFormat:@"%.1fmin",resultValue];
    
    [cellarray addObject:minutesRemainingResultCell];
    
    [self.minutesremainigTableview reloadData];    
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
        unitPickerArray=[[NSMutableArray alloc]initWithObjects:@"20 (adult)",@"60 (adult)", nil];
        selectedValue=chooseValueFromPicker;
    }
    else
    {
        unitPickerArray=[[NSMutableArray alloc]initWithObjects:@"min", nil];
        selectedValue=[NSString stringWithFormat:@"%@",dropsUnit];
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
    resultValue=(((volumeValue/dropsValue)*chooseValue))/1;
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
    if(textField==minutesRemainingInputCell.volumeTF)
    {
        volumeValue=[textField.text doubleValue];
    }
    else
    {
        dropsValue=[textField.text doubleValue];
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
