//
//  DrugCalculationViewController.m
//  Nurse App
//
//  Created by ram mendhe on 11/04/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import "DrugCalculationViewController.h"
#import "DrugCalculationFormulaCell.h"
#import "DrugCalculationResultCell.h"
#import "DrugCalculationInputCell.h"

@interface DrugCalculationViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIPickerViewDelegate>
{
    NSMutableArray * cellarray;
    DrugCalculationFormulaCell * drugCalculationFormulaCell;
    DrugCalculationResultCell * drugCalculationResultCell;
    DrugCalculationInputCell * drugCalculationInputCell;
    double strengthrequiredValue,strengthinstockValue,volumeValue,result;
    NSString * strengthrequiredUnit,*strengthinstockUnit,*volumeUnit,*selectedValue;
    NSMutableArray * unitPickerArray;
    NSInteger  selectedbuttonTag;
}

@end

@implementation DrugCalculationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    unitPickerArray=[[NSMutableArray alloc]initWithObjects:@"μg",@"mg",@"g", nil];
    strengthrequiredValue=500.0;
    strengthinstockValue=500.0;
    volumeValue=0.0;
    strengthrequiredUnit=@"μg";
    strengthinstockUnit=@"μg";
    volumeUnit=@"mL";
    //result=0;
    [self calculateResult];
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
        strengthrequiredUnit=selectedValue;
    }
    else if(selectedbuttonTag==1)
    {
        strengthinstockUnit=selectedValue;
    }
    else
    {
        volumeUnit=selectedValue;
    }
    [self createCellArrayWithResponseString];
    [self.PickerViewOuterView setHidden:YES];
}

-(void)createCellArrayWithResponseString{
    
        cellarray=[[NSMutableArray alloc]init];
    [self calculateResult];
        static NSString *CellIdentifier = @"Cell";
        drugCalculationFormulaCell=[self.drugCalculationTableview dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if(drugCalculationFormulaCell==nil){
            NSArray* objects= [[NSBundle mainBundle] loadNibNamed:@"DrugCalculationFormulaCell" owner:nil options:nil];
            DrugCalculationFormulaCell *acell = [objects objectAtIndex:0];
            drugCalculationFormulaCell = acell;
        }
        [cellarray addObject:drugCalculationFormulaCell];
    
    drugCalculationInputCell=[self.drugCalculationTableview dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(drugCalculationInputCell==nil){
        NSArray* objects= [[NSBundle mainBundle] loadNibNamed:@"DrugCalculationInputCell" owner:nil options:nil];
        DrugCalculationInputCell *acell = [objects objectAtIndex:0];
        drugCalculationInputCell = acell;
    }
    drugCalculationInputCell.strengthrequiredTF.text=[NSString stringWithFormat:@"%.2f",strengthrequiredValue];
    drugCalculationInputCell.strengthrequiredTF.delegate=self;
    UIToolbar *doneToolbar = [[UIToolbar alloc] initWithFrame:(CGRect){0, 0, 50, 50}]; // Create and init
    doneToolbar.barStyle = UIBarStyleDefault; // Specify the preferred barStyle
    UIBarButtonItem *button =[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneEditAction)];
    [button setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:235.0f/255.0f green:73.0f/255.0f blue:81.0f/255.0f alpha:1.0f], NSForegroundColorAttributeName,nil]forState:UIControlStateNormal];
    doneToolbar.items = @[
                          [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                          button // Add your target action
                          ]; // Define items -- you can add more
    drugCalculationInputCell.strengthrequiredTF.inputAccessoryView = doneToolbar; // Now add toolbar to your field's inputview and run
    [doneToolbar sizeToFit]; // call this to auto fit to the view
    drugCalculationInputCell.strengthinstockTF.text=[NSString stringWithFormat:@"%.2f",strengthinstockValue];
    drugCalculationInputCell.strengthinstockTF.delegate=self;
    drugCalculationInputCell.strengthinstockTF.inputAccessoryView = doneToolbar; // Now add toolbar to your field's inputview and run
    [doneToolbar sizeToFit]; // call this to auto fit to the view
    drugCalculationInputCell.volumeTF.text=[NSString stringWithFormat:@"%.2f",volumeValue];
    drugCalculationInputCell.volumeTF.delegate=self;
    drugCalculationInputCell.volumeTF.inputAccessoryView = doneToolbar; // Now add toolbar to your field's inputview and run
    [doneToolbar sizeToFit]; // call this to auto fit to the view
    [drugCalculationInputCell.strengthRequiredUnitButton setTitle:strengthrequiredUnit forState:UIControlStateNormal];
    [drugCalculationInputCell.strengthRequiredUnitButton addTarget:self action:@selector(showPickerMethod:) forControlEvents:UIControlEventTouchUpInside];
    drugCalculationInputCell.strengthRequiredUnitButton.tag=0;
  
    [drugCalculationInputCell.strengthinStockUnitButton setTitle:strengthinstockUnit forState:UIControlStateNormal];
    [drugCalculationInputCell.strengthinStockUnitButton addTarget:self action:@selector(showPickerMethod:) forControlEvents:UIControlEventTouchUpInside];
    drugCalculationInputCell.strengthinStockUnitButton.tag=1;
    
    [drugCalculationInputCell.volumeUnitButton setTitle:volumeUnit forState:UIControlStateNormal];
    [drugCalculationInputCell.volumeUnitButton addTarget:self action:@selector(showPickerMethod:) forControlEvents:UIControlEventTouchUpInside];
    drugCalculationInputCell.volumeUnitButton.tag=2;
    
    
       [cellarray addObject:drugCalculationInputCell];
    drugCalculationResultCell=[self.drugCalculationTableview dequeueReusableCellWithIdentifier:CellIdentifier];
    if(drugCalculationResultCell==nil){
        NSArray* objects= [[NSBundle mainBundle] loadNibNamed:@"DrugCalculationResultCell" owner:nil options:nil];
        DrugCalculationResultCell *acell = [objects objectAtIndex:0];
        drugCalculationResultCell = acell;
    }
    drugCalculationResultCell.strengthinstockLbl.text=[NSString stringWithFormat:@"%.2f (%@)",strengthinstockValue,strengthinstockUnit];
    drugCalculationResultCell.strengthrequiredLbl.text=[NSString stringWithFormat:@"%.2f (%@)",strengthrequiredValue,strengthrequiredUnit];
    drugCalculationResultCell.volumeLbl.text=[NSString stringWithFormat:@"%.2f (%@)",volumeValue,volumeUnit];
    drugCalculationResultCell.calculateResultLbl.text=[NSString stringWithFormat:@"%.3f %@",result,volumeUnit];
    [cellarray addObject:drugCalculationResultCell];
    [self.drugCalculationTableview reloadData];
    
}

-(void)showPickerMethod:(UIButton*)sender
{
     [self.view endEditing:YES];
     if(sender.tag==0)
     {
         unitPickerArray=[[NSMutableArray alloc]initWithObjects:@"μg",@"mg",@"g", nil];
         selectedValue=strengthrequiredUnit;
     }
     else if(sender.tag==1)
     {
         unitPickerArray=[[NSMutableArray alloc]initWithObjects:@"μg",@"mg",@"g", nil];
         selectedValue=strengthinstockUnit;
     }
    else
    {
        unitPickerArray=[[NSMutableArray alloc]initWithObjects:@"mL",@"tablets", nil];
        selectedValue=volumeUnit;
    }
    [self.UnitsPickerView selectedRowInComponent:0];
    selectedbuttonTag=sender.tag;
    [self.UnitsPickerView reloadAllComponents];
    [self.PickerViewOuterView setHidden:NO];
}
-(void)calculateResult
{
     double calculateRequiredValue=strengthrequiredValue*[self getMultiplyByValue:strengthrequiredUnit];
    double calculateStockValue=strengthinstockValue *[self getMultiplyByValue:strengthinstockUnit];
    result=(calculateRequiredValue/calculateStockValue)*volumeValue;
    NSLog(@"%f",result);
}

-(double)getMultiplyByValue:(NSString *)unit
{
    double multiplyBy;
    if([unit isEqualToString:@"μg"])
    {
        multiplyBy=1;
    }
    else if([unit isEqualToString:@"mg"])
    {
        multiplyBy=1000;
    }
    else if([unit isEqualToString:@"g"])
    {
        multiplyBy=1000000;
    }
    return multiplyBy;
}

- (void)doneEditAction {
    [self.view endEditing:YES];
     [self createCellArrayWithResponseString];
}

#pragma textfield delegate method
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
  if(textField==drugCalculationInputCell.strengthinstockTF)
  {
      strengthinstockValue=[textField.text doubleValue];
  }
  else if(textField==drugCalculationInputCell.strengthrequiredTF)
  {
      strengthrequiredValue=[textField.text doubleValue];
  }
  else
  {
      volumeValue=[textField.text doubleValue];
  }
    return YES;
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
    UILabel *columnView = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, self.view.frame.size.width/3 - 35, 30)];
    columnView.text = unitPickerArray[row];
    columnView.textAlignment = NSTextAlignmentLeft;
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
