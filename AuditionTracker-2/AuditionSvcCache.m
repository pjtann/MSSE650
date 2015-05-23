//
//  AuditionSvcCache.m
//  AuditionTracker-2
//
//  Created by PT on 5/22/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "AuditionSvcCache.h"

@implementation AuditionSvcCache

NSMutableArray *auditions = nil;

- (id)init
{
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
    return auditions;
    
}

-(Audition *) updateAudition: (Audition *) audition{
    return audition;
    
}
//delete method
-(Audition *) deleteAudition:(Audition *)audition{
    [auditions removeObject:audition];
    return audition;
    
}

@end