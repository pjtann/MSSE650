//
//  Auditions.h
//  AuditionTracker-4
//
//  Created by PT on 6/12/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Auditions : NSManagedObject

@property (nonatomic, retain) NSString * auditionContact;

@property (nonatomic, retain) NSString * auditionDate;

@property (nonatomic, retain) NSString * auditionTitle;
@property (nonatomic, retain) NSString * auditionType;

@property id id; // added because use in SQL sees id as a long long rather than integer


@property BOOL completed;

@end
