//
//  AuditionItem.h
//  AuditionTracker-4
//
//  Created by PT on 5/29/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import <Foundation/Foundation.h>

//@interface AuditionItem : NSObject <NSCoding> // added NSCoding for archiving to files
@interface AuditionItem: NSObject



// declare the properties
@property NSString *auditionTitle;
@property NSString *auditionType;
@property NSString *auditionContact;
@property NSString *auditionDate;

//@property NSDate *auditionDate;// change to NSDate property


@property long id; // added because use in SQL sees id as a long long rather than integer


@property BOOL completed;

@end
