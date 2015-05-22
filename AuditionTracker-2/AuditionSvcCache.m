//
//  AuditionSvcCache.m
//  AuditionTracker-2
//
//  Created by PT on 5/22/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

//#import "AuditionSvcCache.h"
//
//@implementation AuditionSvcCache
//
//
//
//@end
#import "AuditionSvcCache.h"

@implementation AuditionSvcCache

NSMutableArray *auditions = nil;


- (id)init
{
    //    self = [super init];
    if (self = [super init]) {
        auditions = [NSMutableArray array];
        return self;
    }
    return nil;
}

-(Audition *) createAudition:(Audition *)audition{
    [auditions addObject:audition];
    return audition;
    
}

-(NSMutableArray *) retrieveAllAuditions{
//    NSLog(@"Contents of auditions in cache m file - %@", auditions);
    return auditions;
    
}

-(Audition *) updateAudition: (Audition *) audition{
    return audition;
    
}

-(Audition *) deleteAudition:(Audition *)audition{
    NSLog(@"Delete method in svc m file, auditions value: %@", auditions);
    [auditions removeObject:audition];
    return audition;
    
}



@end