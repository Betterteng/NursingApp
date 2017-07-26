//
//  DrugCalculationResultCell.h
//  Nurse App
//
//  Created by Ram Mendhe on 17/05/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrugCalculationResultCell : UITableViewCell
@property(nonatomic,strong)IBOutlet UILabel * strengthrequiredLbl;
@property(nonatomic,strong)IBOutlet UILabel * strengthinstockLbl;
@property(nonatomic,strong)IBOutlet UILabel * volumeLbl;
@property(nonatomic,strong)IBOutlet UILabel * calculateResultLbl;




@end
