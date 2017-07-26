//
//  MinutesRemainingInputCell.h
//  Nurse App
//
//  Created by Ram Mendhe on 18/05/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MinutesRemainingInputCell : UITableViewCell
@property(nonatomic,strong)IBOutlet UITextField * volumeTF;
@property(nonatomic,strong)IBOutlet UIButton * volumeUnitBtn;
@property(nonatomic,strong)IBOutlet UIButton * chooseBtn;
@property(nonatomic,strong)IBOutlet UITextField * dropsTF;
@property(nonatomic,strong)IBOutlet UIButton * dropsUnitBtn;
@end
