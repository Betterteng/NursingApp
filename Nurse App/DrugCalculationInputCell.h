//
//  DrugCalculationInputCell.h
//  Nurse App
//
//  Created by Ram Mendhe on 17/05/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrugCalculationInputCell : UITableViewCell

@property(nonatomic,strong)IBOutlet UITextField * strengthrequiredTF;
@property(nonatomic,strong)IBOutlet UITextField * strengthinstockTF;
@property(nonatomic,strong)IBOutlet UITextField * volumeTF;
@property(nonatomic,strong)IBOutlet UIButton * strengthRequiredUnitButton;
@property(nonatomic,strong)IBOutlet UIButton * strengthinStockUnitButton;
@property(nonatomic,strong)IBOutlet UIButton * volumeUnitButton;

@end
