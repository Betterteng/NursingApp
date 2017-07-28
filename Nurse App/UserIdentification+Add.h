//
//  UserIdentification+Add.h
//  Nurse App
//
//  Created by 滕施男 on 26/7/17.
//  Copyright © 2017 ram mendhe. All rights reserved.
//

#import "UserIdentification+CoreDataClass.h"

@interface UserIdentification (Add)
+ (UserIdentification *)addUserInfoFromDictionary:(NSDictionary *) userInfo;
@end
