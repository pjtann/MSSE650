//
//  AuditionSvc.h
//  AuditionTracker-4
//
//  Created by PT on 6/2/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "AuditionItem.h" // removed when converted to 'Auditions' class for Core Data
#import <CoreData/CoreData.h> // placed this in here because they had it in the .pch file that we no longer have - do we need this???
#import "Auditions.h"



@protocol AuditionSvc <NSObject>

+(Auditions *) createAudition: (Auditions *) auditionItem;
+(Auditions *) createManagedAuditionItem: (Auditions *) auditionItem; // added to see if this would allow use from vc.m file

+(Auditions *) updateAudition:(NSString *)id andOldTitle:(NSString *)title andOldType:(NSString *)type andOldContact:(NSString *)contact andOldDate:(NSString *)date andNewTitle:(NSString *)newTitle andNewType:(NSString *)newType andNewContact:(NSString *)newContact andNewDate:(NSString *)newDate;

-(Auditions *) deleteAudition: (Auditions *) auditionItem;
//-(Auditions *) selectAudition: (Auditions *) auditionItem; // added to individually select an object from SQL database

+(Auditions *) newContextObjectWithTitle:(NSString *)title andType:(NSString *)type andContact:(NSString *)contact andDate:(NSString *)date;//added to get a new context object





//-(void) deleteAudItem: (NSUInteger *) AudItemKey; // PJT ADDED for method TO DELETE FROM ARCHIVE
//-(id) getFilePath: (NSString *) audFilePath; // PJT ADDED to try and get file path returned
//-(id) checkForEmptyFile: (NSString *) fileEmptyMessage; // PJT ADDED to try and check if file empty to load with bogus data

//-(NSMutableArray *) retrieveAllAuditions; // removed = changed to NSArray for Core Data
-(NSArray *) retrieveAllAuditions;
-(NSArray *) retrieveAllCategories;


@end
