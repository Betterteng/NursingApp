//
//  UserIdentification+CoreDataProperties.h
//  Nurse App
//
//  Created by 滕施男 on 26/7/17.
//  Copyright © 2017 ram mendhe. All rights reserved.
//

#import "UserIdentification+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface UserIdentification (CoreDataProperties)

+ (NSFetchRequest<UserIdentification *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *userId;

@end

NS_ASSUME_NONNULL_END
