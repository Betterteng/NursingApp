//
//  Questions.h
//  Nurse App
//
//  Created by ram mendhe on 01/06/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Questions : NSObject

@property (nonatomic,strong) NSString* questionid;
@property (nonatomic,strong) NSString* chapterno;
@property (nonatomic,strong) NSString* question;
@property (nonatomic,strong) NSString* answer;
@property (nonatomic,strong) NSString* optiona;
@property (nonatomic,strong) NSString* optionb;
@property (nonatomic,strong) NSString* optionc;
@property (nonatomic,strong) NSString* optiond;
@property (nonatomic,strong) NSString* iscorrect;
@property (nonatomic,strong) NSString* idl;

@end