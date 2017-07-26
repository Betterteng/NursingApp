//
//  MyTextField.m
//  Nurse App
//
//  Created by Ram Mendhe on 18/05/16.
//  Copyright © 2016 ram mendhe. All rights reserved.
//

#import "MyTextField.h"

IB_DESIGNABLE
@implementation MyTextField

@synthesize padding;

-(CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectInset(bounds, padding, padding);
}

-(CGRect)editingRectForBounds:(CGRect)bounds{
    return [self textRectForBounds:bounds];
}

@end