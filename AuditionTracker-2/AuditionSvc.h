//
//  AuditionSvc.h
//  AuditionTracker-2
//
//  Created by PT on 5/22/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "Audition.h"


@protocol AuditionSvc <NSObject>

-(NSMutableArray *) retrieveAllAuditions; //declare audition array


-(Audition *) createAudition: (Audition *) audition; // declare audition creation method

-(Audition *) deleteAudition: (Audition *) audition; // declare audition deletion method


@end

