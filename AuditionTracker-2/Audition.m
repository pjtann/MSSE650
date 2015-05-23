//
//  Audition.m
//  AuditionTracker-2
//
//  Created by PT on 5/22/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "Audition.h"

@implementation Audition

//array used for cacheing entry field information
-(NSString *)description{
    
    return [NSString stringWithFormat:@"%@, %@", _auditionTitle, _auditionDate];
    
}

@end
