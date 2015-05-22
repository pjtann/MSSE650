//
//  Audition.m
//  AuditionTracker-2
//
//  Created by PT on 5/22/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "Audition.h"

@implementation Audition

-(NSString *)description{
    NSLog(@"Description string in audition m file - %@ %@", _auditionTitle, _auditionDate);
    return [NSString stringWithFormat:@"%@, %@", _auditionTitle, _auditionDate];
    
}

@end
