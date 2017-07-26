//
//  DripRateInputCell.h
//  Nurse App
//
//  Created by Ram Mendhe on 17/05/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DripRateInputCell : UITableViewCell
@property(nonatomic,strong)IBOutlet UITextField * volumeTF;
@property(nonatomic,strong)IBOutlet UIButton * volumeUnitBtn;
@property(nonatomic,strong)IBOutlet UITextField * timeTF;
@property(nonatomic,strong)IBOutlet UIButton * hoursUnitBtn;
@property(nonatomic,strong)IBOutlet UIButton * chooseBtn;


@end
