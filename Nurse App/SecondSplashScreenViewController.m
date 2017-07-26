//
//  SecondSplashScreenViewController.m
//  Nurse App
//
//  Created by Asmita on 04/08/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import "SecondSplashScreenViewController.h"
#import "AppDelegate.h"

@interface SecondSplashScreenViewController ()
{
    NSTimer * timer;
}
@end

@implementation SecondSplashScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.navigationController.navigationBarHidden=YES;
    
    timer = [NSTimer scheduledTimerWithTimeInterval: 4.0 target: self  selector: @selector(callAfterSixtySecond:) userInfo: nil repeats: YES];
    
}

-(void) callAfterSixtySecond:(NSTimer*) t
{
    [timer invalidate];
    // Override point for customization after application launch.
    self.chartsViewController = [[ChartsViewController alloc]initWithNibName:@"ChartsViewController" bundle:nil];
    self.formulaeViewController = [[FormulaeViewController alloc]initWithNibName:@"FormulaeViewController" bundle:nil];
    self.quizViewController = [[QuizViewController alloc]initWithNibName:@"QuizViewController" bundle:nil];
    self.storeViewController = [[StoreViewController alloc]initWithNibName:@"StoreViewController" bundle:nil];
    self.cPDViewController = [[CPDViewController alloc]initWithNibName:@"CPDViewController" bundle:nil];
    
    
    self.chartsNavigationController=[[UINavigationController alloc] initWithRootViewController:self.chartsViewController];
    self.formulaeNavigationController=[[UINavigationController alloc] initWithRootViewController:self.formulaeViewController];
    self.quizNavigationController=[[UINavigationController alloc] initWithRootViewController:self.quizViewController];
    self.storeNavigationController=[[UINavigationController alloc] initWithRootViewController:self.storeViewController];
    self.cPDNavigationController=[[UINavigationController alloc] initWithRootViewController:self.cPDViewController];
    
    self.chartsNavigationController.tabBarItem.selectedImage=[[UIImage imageNamed:@"TabBarChats-Selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.chartsNavigationController.tabBarItem.image=[[UIImage imageNamed:@"TabBarCharts"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.formulaeNavigationController.tabBarItem.selectedImage=[[UIImage imageNamed:@"TabBarFormulae-Selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.formulaeNavigationController.tabBarItem.image=[[UIImage imageNamed:@"TabBarFormulae"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.quizNavigationController.tabBarItem.selectedImage=[[UIImage imageNamed:@"TabBarQuiz-Selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.quizNavigationController.tabBarItem.image=[[UIImage imageNamed:@"TabBarQuiz"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.storeNavigationController.tabBarItem.selectedImage=[[UIImage imageNamed:@"TabBarStore-Selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.storeNavigationController.tabBarItem.image=[[UIImage imageNamed:@"TabBarStore"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.cPDNavigationController.tabBarItem.selectedImage=[[UIImage imageNamed:@"TabBarCPD-Selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.cPDNavigationController.tabBarItem.image=[[UIImage imageNamed:@"TabBarCPD"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.chartsNavigationController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    self.chartsNavigationController.title= nil;
    self.formulaeNavigationController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    self.formulaeNavigationController.title= nil;
    self.quizNavigationController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    self.quizNavigationController.title= nil;
    self.storeNavigationController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    self.storeNavigationController.title= nil;
    self.cPDNavigationController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    self.cPDNavigationController.title= nil;
    
    self.tabBarController=[[UITabBarController alloc]init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:self.chartsNavigationController,self.formulaeNavigationController,self.quizNavigationController,self.storeNavigationController,self.cPDNavigationController, nil];
    //self.tabBarController.tabBar.barStyle = UIBarStyleBlack;
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:(15.0/255.0) green:(15.0/255.0) blue:(15.0/255.0) alpha:1.0]];
    
    AppDelegate *appDelegate =(AppDelegate*) [UIApplication sharedApplication].delegate;
    [appDelegate.window setRootViewController:self.tabBarController];

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
