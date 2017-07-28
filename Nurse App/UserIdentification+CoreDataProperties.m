//
//  UserIdentification+CoreDataProperties.m
//  Nurse App
//
//  Created by 滕施男 on 26/7/17.
//  Copyright © 2017 ram mendhe. All rights reserved.
//

#import "UserIdentification+CoreDataProperties.h"

@implementation UserIdentification (CoreDataProperties)

+ (NSFetchRequest<UserIdentification *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"UserIdentification"];
}

@dynamic userId;

@end
