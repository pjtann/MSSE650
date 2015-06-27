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
#import "AuditionCategory.h"
#import "Contacts.h"





@protocol AuditionSvc <NSObject>

+(Auditions *) createAudition: (Auditions *) auditionItem;

+(Auditions *) updateAudition:(NSString *)id andOldTitle:(NSString *)title andOldType:(NSString *)type andOldContact:(NSString *)contact andOldDate:(NSString *)date andNewTitle:(NSString *)newTitle andNewType:(NSString *)newType andNewContact:(NSString *)newContact andNewDate:(NSString *)newDate;

+(AuditionCategory *) updateCategory:(NSString *)oldcategory andNewCategory:(NSString *)newCategory;

+(Contacts *) updateContactWithName:(NSString *)oldName andPhone:(NSString*)oldPhone andEmail:(NSString *)oldEmail andNewName:(NSString *)newName andNewPhone:(NSString *)newPhone andNewEmail:(NSString *)newEmail;

-(Auditions *) deleteAudition: (Auditions *) auditionItem;

+(AuditionCategory *) deleteCategory: (AuditionCategory *) categoryItem;

+(Contacts *) deleteContact: (Contacts *) contactItem;

+(Auditions *) newContextObjectWithTitle:(NSString *)title andType:(NSString *)type andContact:(NSString *)contact andDate:(NSString *)date;//added to get a new context object for the auditions table

+(AuditionCategory *) newContextObjectWithCategory:(NSString *)category;//added to get a new context object for the category table

+(AuditionCategory *) newContextObjectForCategory:(NSString *)newCategoryItem;

+(Contacts *) newContextObjectWithContactName:(NSString *)name andPhone:(NSString *)phone andEmail:(NSString *)email;//added to get a new context object for the contacts table

//-(NSMutableArray *) retrieveAllAuditions; // removed = changed to NSArray for Core Data
-(NSArray *) retrieveAllAuditions;
+(NSArray *) retrieveAllCategories;
+(NSArray *) retrieveAllContacts;

@end
