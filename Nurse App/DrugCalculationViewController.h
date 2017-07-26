//
//  DrugCalculationViewController.h
//  Nurse App
//
//  Created by ram mendhe on 11/04/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrugCalculationViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) NSString *pageTitle;
@property(nonatomic,strong)IBOutlet UITableView * drugCalculationTableview;
@property(nonatomic,strong)IBOutlet UIView * tableviewOuterView;
@property (strong, nonatomic) IBOutlet UIPickerView* UnitsPickerView;
@property(nonatomic,strong)IBOutlet UIView * PickerViewOuterView;
@end
