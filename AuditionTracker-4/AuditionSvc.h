//
//  AuditionSvc.h
//  AuditionTracker-4
//
//  Created by PT on 6/2/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuditionItem.h"


@protocol AuditionSvc <NSObject>

-(AuditionItem *) createAudition: (AuditionItem *) auditionItem;
+(AuditionItem *) updateAudition: (AuditionItem *) auditionItem;
-(AuditionItem *) deleteAudition: (AuditionItem *) auditionItem;
-(AuditionItem *) selectAudition: (AuditionItem *) auditionItem; // added to individually select an object from SQL database

-(void) deleteAudItem: (NSUInteger *) AudItemKey; // PJT ADDED for method TO DELETE FROM ARCHIVE
//-(id) getFilePath: (NSString *) audFilePath; // PJT ADDED to try and get file path returned
-(id) checkForEmptyFile: (NSString *) fileEmptyMessage; // PJT ADDED to try and check if file empty to load with bogus data

-(NSMutableArray *) retrieveAllAuditions;

@end
