//
//  CPDEntryData.h
//  Nurse App
//
//  Created by ram mendhe on 15/04/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPDEntryData : NSObject

@property (nonatomic,strong) NSString* entryTimestamp;
@property (nonatomic,strong) NSString* entrytitle;
@property (nonatomic,strong) NSString* entrynotes;
@property (nonatomic,strong) NSString* entrydate;
@property (nonatomic,strong) NSString* entryduration;

@end
