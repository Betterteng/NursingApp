//
//  SecondSplashScreenViewController.h
//  Nurse App
//
//  Created by Asmita on 04/08/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPDViewController.h"
#import "StoreViewController.h"
#import "QuizViewController.h"
#import "FormulaeViewController.h"
#import "ChartsViewController.h"

@interface SecondSplashScreenViewController : UIViewController


@property(nonatomic,strong) ChartsViewController * chartsViewController;
@property(nonatomic,strong) FormulaeViewController * formulaeViewController;
@property(nonatomic,strong) QuizViewController * quizViewController;
@property(nonatomic,strong) StoreViewController * storeViewController;
@property(nonatomic,strong) CPDViewController * cPDViewController;

@property(nonatomic,strong) UINavigationController *chartsNavigationController;
@property(nonatomic,strong) UINavigationController *formulaeNavigationController;
@property(nonatomic,strong) UINavigationController *quizNavigationController;
@property(nonatomic,strong) UINavigationController *storeNavigationController;
@property(nonatomic,strong) UINavigationController *cPDNavigationController;


@property(nonatomic,strong) UITabBarController *tabBarController;


@end
