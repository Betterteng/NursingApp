//
//  EnteralDripResultCell.h
//  Nurse App
//
//  Created by Ram Mendhe on 17/05/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EnteralDripResultCell : UITableViewCell

@property(nonatomic,strong)IBOutlet UILabel * volumeLbl;
@property(nonatomic,strong)IBOutlet UILabel * hourLbl;
@property(nonatomic,strong)IBOutlet UILabel * dpmLbl;
@property(nonatomic,strong)IBOutlet UILabel * minuteLbl;
@property(nonatomic,strong)IBOutlet UILabel * topResultLbl;
@property(nonatomic,strong)IBOutlet UILabel * bottomResultLbl;
@end
