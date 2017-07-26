//
//  AppDelegate.h
//  Nurse App
//
//  Created by ram mendhe on 28/03/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CPDViewController.h"
#import "StoreViewController.h"
#import "QuizViewController.h"
#import "FormulaeViewController.h"
#import "ChartsViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

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


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
@end

