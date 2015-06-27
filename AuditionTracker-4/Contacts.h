//
//  Contacts.h
//  AuditionTracker-4
//
//  Created by PT on 6/22/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Contacts : NSManagedObject

@property (nonatomic, retain) NSString *contactName;
@property (nonatomic, retain) NSString *contactPhone;
@property (nonatomic, retain) NSString *contactEmail;

@property BOOL contactCompleted;


@end
