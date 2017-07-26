//
//  AppDelegate.m
//  Nurse App
//
//  Created by ram mendhe on 28/03/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import "AppDelegate.h"
#import "NSObject+JSONSerializableSupport.h"
#import "SecondSplashScreenViewController.h"

@interface AppDelegate ()
{
    UINavigationController *navigationController;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   /* SecondSplashScreenViewController* secondSplashScreenVC=[[SecondSplashScreenViewController alloc] initWithNibName:@"SecondSplashScreenViewController" bundle:nil];
    [self changeRootViewController:secondSplashScreenVC];*/
    
    //self.window.rootViewController=navigationController;
    
    
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
    
    self.window.rootViewController=self.tabBarController;
    return YES;
}
- (void)changeRootViewController:(UIViewController*)viewController {
    
    if (!self.window.rootViewController) {
        self.window.rootViewController = viewController;
        return;
    }
    UIView *snapShot = [self.window snapshotViewAfterScreenUpdates:YES];
    [viewController.view addSubview:snapShot];
    self.window.rootViewController = viewController;
    [UIView transitionWithView:self.window duration:1.0
                       options:UIViewAnimationOptionTransitionCrossDissolve //change to whatever animation you like
                    animations:^ {
                        snapShot.layer.opacity = 0;
                        snapShot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
                    }
                    completion:^(BOOL finished){
                        if (finished) {
                            // Successful
                            
                        }
                        [snapShot removeFromSuperview];
                        NSLog(@"Animations completed.");
                        // do something...
                    }];
    
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "pv.Nurse_App" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Nurse_App" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Nurse_App.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
