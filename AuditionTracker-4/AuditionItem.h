//
//  AuditionItem.h
//  AuditionTracker-4
//
//  Created by PT on 5/29/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuditionItem : NSObject <NSCoding> // added NSCoding for archiving to files

// declare the properties
@property NSString *auditionTitle;
@property NSString *auditionType;
@property NSString *auditionContact;
@property NSString *auditionDate;

@property BOOL completed;

@end
