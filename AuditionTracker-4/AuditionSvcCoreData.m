//
//  AuditionSvcCoreData.m
//  AuditionTracker-4
//
//  Created by PT on 6/12/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "AuditionSvcCoreData.h"

@implementation AuditionSvcCoreData

// object declarations for Core Data usage
NSManagedObjectModel *model = nil;
NSPersistentStoreCoordinator *psc = nil;
NSManagedObjectContext *moc = nil;

- (id)init
{
    if (self = [super init]){
        // call initializeCoreData method
        [self initializeCoreData];
        return  self;
    }
    return nil;
}


+(Auditions *) newContextObjectWithTitle:(NSString *)title andType:(NSString *)type andContact:(NSString *)contact andDate:(NSString *)date{
    
    Auditions *newContextAuditionItem = [self createManagedAuditionItem];
    
    newContextAuditionItem.auditionTitle = title;
    newContextAuditionItem.auditionType = type;
    newContextAuditionItem.auditionContact = contact;
    newContextAuditionItem.auditionDate = date;

    NSError *error;
    // save the managed object context
    if (![moc save:&error]){
        NSLog(@"createAuditionItem ERROR: %@", [error localizedDescription]);
    }
    NSLog(@"\n Value of newContextAuditionItem: %@", newContextAuditionItem);
    
    
    return newContextAuditionItem;
    
}

+(AuditionCategory *) newContextObjectWithCategory:(NSString *)category{
    
    AuditionCategory *newContextCategoryItem = [self createManagedCategoryItem];
    
    newContextCategoryItem.auditionCategory = category;
    NSError *error;
    // save the managed object context
    if (![moc save:&error]){
        NSLog(@"createCategoryItem ERROR: %@", [error localizedDescription]);
    }
    NSLog(@"\n Value of newContextCategoryItem: %@", newContextCategoryItem);
    
    
    return newContextCategoryItem;
    
}

+(AuditionCategory *) newContextObjectForCategory:(NSString *)category{

    AuditionCategory *newCategoryItem = [self createManagedCategoryItem];
    
    NSLog(@"Value of category item: %@", newCategoryItem.auditionCategory);
    
    
    newCategoryItem.auditionCategory = category;
    
    return newCategoryItem;
    
}

+(Contacts *) newContextObjectWithContactName:(NSString *)contact andPhone:(NSString *)phone andEmail:(NSString *)email{
    
    Contacts *newContextContactItem = [self createManagedContactItem];
    
    newContextContactItem.contactName = contact;
    newContextContactItem.contactPhone = phone;
    newContextContactItem.contactEmail = email;
    
    NSError *error;
    // save the managed object context
    if (![moc save:&error]){
        NSLog(@"createContactItem ERROR: %@", [error localizedDescription]);
    }
    NSLog(@"\n Value of newContextContactItem: %@", newContextContactItem);
    
    
    return newContextContactItem;
    
}

+(Contacts *) createManagedContactItem{
    // create a contact from the context
    Contacts *contactItem = [NSEntityDescription insertNewObjectForEntityForName:@"Contacts" inManagedObjectContext:moc];
    return contactItem;
}

+(AuditionCategory *) createManagedCategoryItem{
    // create a contact from the context
    AuditionCategory *categoryItem = [NSEntityDescription insertNewObjectForEntityForName:@"Categories" inManagedObjectContext:moc];
    return categoryItem;
}

+(Auditions *) createManagedAuditionItem{
    // create a contact from the context
    Auditions *auditionItem = [NSEntityDescription insertNewObjectForEntityForName:@"Auditions" inManagedObjectContext:moc];
    return auditionItem;
}

+(Auditions *) createAudition:(Auditions *)auditionItem{
    // create a managed auditionItem
    Auditions *managedAuditionItem = [self createManagedAuditionItem];
    // place data in the managed object
    managedAuditionItem.auditionTitle = auditionItem.auditionTitle;
    managedAuditionItem.auditionType = auditionItem.auditionType;
    managedAuditionItem.auditionContact = auditionItem.auditionContact;
    managedAuditionItem.auditionDate = auditionItem.auditionDate;
    
    NSError *error;
    // save the managed object context
    if (![moc save:&error]){
        NSLog(@"createContact ERROR: %@", [error localizedDescription]);
    }
    return auditionItem;
}

-(NSArray *) retrieveAllAuditions {
    // create fetch request
    NSFetchRequest *fetchrequest = [[NSFetchRequest alloc] init];
    // construct the fetch request
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Auditions" inManagedObjectContext:moc];
    [fetchrequest setEntity:entity];
    // order/sort the contacts by name
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"auditionTitle" ascending:YES];
    [fetchrequest setSortDescriptors:@[sortDescriptor]];
    NSError *error;
    // execute fetch request
    NSArray *fetchedObjects = [moc executeFetchRequest:fetchrequest error:&error];
    
    return fetchedObjects;
}

+(Auditions *) updateAudition:(NSString *)id andOldTitle:(NSString *)title andOldType:(NSString *)type andOldContact:(NSString *)contact andOldDate:(NSString *)date andNewTitle:(NSString *)newTitle andNewType:(NSString *)newType andNewContact:(NSString *)newContact andNewDate:(NSString *)newDate{


    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:[NSEntityDescription entityForName:@"Auditions" inManagedObjectContext:moc]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"auditionTitle == %@", title];
    [request setPredicate:predicate];
    
    Auditions *audition = nil;
    NSError *error = nil;
    audition = [[moc executeFetchRequest:request error:&error] lastObject]; // crashes here because it's using hte new title field to try and find the object
    
    audition.auditionTitle = newTitle;
    audition.auditionType = newType;
    audition.auditionContact = newContact;
    audition.auditionDate = newDate;

    if(![moc save:&error]){
        NSLog(@"selectAudition ERROR: %@", [error localizedDescription]);
    }
    return nil;
}


+(AuditionCategory *) updateCategory:(NSString *)oldcategory andNewCategory:(NSString *)newCategory{
    
    
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:[NSEntityDescription entityForName:@"Categories" inManagedObjectContext:moc]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"auditionCategory == %@", oldcategory];
    [request setPredicate:predicate];
    
    AuditionCategory *category = nil;
    NSError *error = nil;
    category = [[moc executeFetchRequest:request error:&error] lastObject]; // crashes here because it's using hte new title field to try and find the object
    
    category.auditionCategory = newCategory;

    if(![moc save:&error]){
        NSLog(@"updateCategory ERROR: %@", [error localizedDescription]);
    }
    return nil;
}


+(Contacts *) updateContactWithName:(NSString *)oldName andPhone:(NSString*)oldPhone andEmail:(NSString *)oldEmail andNewName:(NSString *)newName andNewPhone:(NSString *)newPhone andNewEmail:(NSString *)newEmail{
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:[NSEntityDescription entityForName:@"Contacts" inManagedObjectContext:moc]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"contactName == %@", oldName];
    [request setPredicate:predicate];
    
    Contacts *contact = nil;
    NSError *error = nil;
    contact = [[moc executeFetchRequest:request error:&error] lastObject]; // crashes here because it's using hte new title field to try and find the object
    
    contact.contactName = newName;
    contact.contactPhone = newPhone;
    contact.contactEmail = newEmail;

    if(![moc save:&error]){
        NSLog(@"updateCategory ERROR: %@", [error localizedDescription]);
    }
    return nil;
}


-(Auditions *) deleteAudition:(Auditions *)auditionItem {
    
    NSArray *count = [self retrieveAllAuditions];
    NSLog(@"Count before: %@", count);

    [moc deleteObject:auditionItem];
    
    NSError *error;
    // save the updated audition using the context
    if(![moc save:&error]){
        NSLog(@"selectAudition ERROR: %@", [error localizedDescription]);
    }
    
    NSLog(@"\n Did it delete from database?");
    [[self retrieveAllAuditions] count];
    NSLog(@"Count after: %@", count);
    
    return auditionItem;
}

+(AuditionCategory *) deleteCategory:(AuditionCategory *)categoryItem {
    
    NSArray *count = [AuditionSvcCoreData retrieveAllCategories];
    NSLog(@"Count before: %@", count);
 
    [moc deleteObject:categoryItem];
    
    NSError *error;
    // save the updated audition using the context
    if(![moc save:&error]){
        NSLog(@"deleteCategory ERROR: %@", [error localizedDescription]);
    }
    
    NSLog(@"\n Did it delete from database?");
    [[AuditionSvcCoreData retrieveAllCategories] count];
    NSLog(@"Count after: %@", count);
  
    return categoryItem;
}

+(Contacts *) deleteContact:(Contacts *)contactItem {
    
    NSArray *count = [AuditionSvcCoreData retrieveAllContacts];
    NSLog(@"Count before: %@", count);
    
    [moc deleteObject:contactItem];
    
    NSError *error;
    // save the updated audition using the context
    if(![moc save:&error]){
        NSLog(@"deleteCategory ERROR: %@", [error localizedDescription]);
    }
    
    NSLog(@"\n Did it delete from database?");
    [[AuditionSvcCoreData retrieveAllContacts] count];
    NSLog(@"Count after: %@", count);
    
    return contactItem;
}
-(void) initializeCoreData{
    //initialize (load) the schema model; the URLForResource is the name of your schema model without the extension
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    // initialize teh persisten store coordinator with the model
    NSURL *applicationDocumentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]lastObject];
    
    NSURL *storeURL = [applicationDocumentsDirectory URLByAppendingPathComponent:@"AuditionTracker.sqlite"];
    NSLog(@"Value of storeURL: %@", storeURL);
    
    NSError *error = nil;
    psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    if ([psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        // initialize the managed object context
        moc = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
        // set the coordinator
        [moc setPersistentStoreCoordinator:psc];
    }else{
        NSLog(@"**** The initializeCoreData FAILED with error: %@", error);
    }
}

+(NSArray *) retrieveAllCategories {
    // create fetch request
    NSFetchRequest *fetchrequest = [[NSFetchRequest alloc] init];
    // construct the fetch request
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Categories" inManagedObjectContext:moc];
    [fetchrequest setEntity:entity];
    // order/sort the contacts by name
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"auditionCategory" ascending:YES];
    [fetchrequest setSortDescriptors:@[sortDescriptor]];
    NSError *error;
    // execute fetch request
    NSArray *fetchedObjects = [moc executeFetchRequest:fetchrequest error:&error];
    
    return fetchedObjects;
}

+(NSArray *) retrieveAllContacts {
    // create fetch request
    NSFetchRequest *fetchrequest = [[NSFetchRequest alloc] init];
    // construct the fetch request
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Contacts" inManagedObjectContext:moc];
    [fetchrequest setEntity:entity];
    // order/sort the contacts by name
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"contactName" ascending:YES];
    [fetchrequest setSortDescriptors:@[sortDescriptor]];
    NSError *error;
    // execute fetch request
    NSArray *fetchedObjects = [moc executeFetchRequest:fetchrequest error:&error];
    
    return fetchedObjects;
}

@end
