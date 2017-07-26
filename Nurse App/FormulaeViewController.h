//
//  FormulaeViewController.h
//  Nurse App
//
//  Created by ram mendhe on 06/04/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FormulaeViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *formulaeTableView;

@property (strong, nonatomic) NSArray *cellNameArray;
@property (strong, nonatomic) NSArray *cellImageArray;
@property (strong, nonatomic) NSArray *imageArray;

@end
