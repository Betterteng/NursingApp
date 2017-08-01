//
//  UserIdentification+Add.m
//  Nurse App
//
//  Created by 滕施男 on 26/7/17.
//  Copyright © 2017 ram mendhe. All rights reserved.
//

#import "UserIdentification+Add.h"
#import "AppDelegate.h"

@implementation UserIdentification (Add)


+ (UserIdentification *)addUserInfoFromDictionary:(NSDictionary *) userInfo
{
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    UserIdentification *userIdentificationEntity = nil;
    
    // Create a new object
    userIdentificationEntity = [NSEntityDescription insertNewObjectForEntityForName:@"UserIdentification" inManagedObjectContext:context];
    userIdentificationEntity.userId = [userInfo valueForKey:@"userId"];
    
    return userIdentificationEntity;
}

+ (BOOL)checkIsEmpty
{
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"UserIdentification"];
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if ([results count] == 0) {
        return true;
    } else {
        return false;
    }
}

@end
