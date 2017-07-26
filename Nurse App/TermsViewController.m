//
//  TermsViewController.m
//  Nurse App
//
//  Created by ram mendhe on 09/04/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import "TermsViewController.h"

@interface TermsViewController ()

@end

@implementation TermsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigationBar];
    // Do any additional setup after loading the view from its nib.
}

-(void)createNavigationBar
{
    //hide back button
    self.navigationItem.hidesBackButton=true;
    
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSFontAttributeName:[UIFont fontWithName:@"Roboto-Bold" size:25]}];
    self.navigationItem.title=@"Terms and Conditions";
    
    //[textView setFont:[UIFont fontWithName:@"Roboto-Bold" size:25]];
    
    // set navigation bar background color
    self.navigationController.navigationBar.barStyle=UIBarStyleBlack;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:15.0f/255.0f green:15.0f/255.0f blue:15.0f/255.0f alpha:1.0f]];
    self.toolBar.barTintColor = [UIColor colorWithRed:15.0f/255.0f green:15.0f/255.0f blue:15.0f/255.0f alpha:1.0f];
}

-(IBAction)cancelButtonClicked:(id)sender{
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@""
                                          message:@"You must agree to the Terms and Conditions to use this application."
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK action") style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   [alertController dismissViewControllerAnimated:YES completion:nil];
                               }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];

}
-(IBAction)agreeButtonClicked:(id)sender{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"You must agree to the Terms and Conditions to use this application." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *disAgreeAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Disagree", @"OK action") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                               {
                                   [alertController dismissViewControllerAnimated:YES completion:nil];
                                   UIAlertController *alertController1 = [UIAlertController alertControllerWithTitle:@"" message:@"You must agree to the Terms and Conditions to use this application."  preferredStyle:UIAlertControllerStyleAlert];
                                   UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK action") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                                              {
                                                                  [alertController1 dismissViewControllerAnimated:YES completion:nil];
                                                              }];
                                   [alertController1 addAction:okAction];
                                   [self presentViewController:alertController1 animated:YES completion:nil];
                               }];
    [alertController addAction:disAgreeAction];
    
    UIAlertAction *agreeAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Agree", @"OK action") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                               {
                                   [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"termsconditionStatus"];
                                   [alertController dismissViewControllerAnimated:NO completion:nil];
                                   [self dismissViewControllerAnimated:YES completion:nil];
                               }];
    [alertController addAction:agreeAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


-(void)doneButtonClicked{
    [self dismissViewControllerAnimated:YES completion:nil];
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
