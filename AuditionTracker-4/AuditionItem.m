//
//  AuditionItem.m
//  AuditionTracker-4
//
//  Created by PT on 5/29/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "AuditionItem.h"

// for best practices purposes define these archiving properties here once as constants then use them in the encodeWithCoder and initWithCoder methods rather than listing them each time in the methods themselves.
//static NSString *const AUDITIONTITLE = @"auditionTitle";
//static NSString *const AUDITIONTYPE = @"auditionType";
//static NSString *const AUDITIONCONTACT = @"auditionContact";
//static NSString *const AUDITIONDATE = @"auditionDate";


@implementation AuditionItem


-(NSString *) description {
    NSString *desc = [NSString stringWithFormat:@" \n \t ID: %lu \n \t Audition Title: %@ \n \t Audition Type: %@ \n \t Audition Contact: %@ \n \t Audition Date: %@ \n -----",[self id], [self auditionTitle],[self auditionType],[self auditionContact], [self auditionDate]];
    //[self auditionTime],[self auditionLocation],[self auditionStatus], [self auditionCost]];
    return  desc;
}

// implementing the encoding method for the archive file
//- (void)encodeWithCoder:(NSCoder *)coder
//{
//
//    [coder encodeObject:self.auditionTitle forKey:AUDITIONTITLE];
//    [coder encodeObject:self.auditionType forKey:AUDITIONTYPE];
//    [coder encodeObject:self.auditionContact forKey: AUDITIONCONTACT];
//    [coder encodeObject:self.auditionDate forKey:AUDITIONDATE];
//    
//}

// implementing the decoding method for the archive file
//- (instancetype)initWithCoder:(NSCoder *)coder
//{
//    self = [super init];
//    if (self) {
//        _auditionTitle = [coder decodeObjectForKey:AUDITIONTITLE];
//        _auditionType = [coder decodeObjectForKey:AUDITIONTYPE];
//        _auditionContact = [coder decodeObjectForKey:AUDITIONCONTACT];
//        _auditionDate = [coder decodeObjectForKey:AUDITIONDATE];
//        
//    }
//    return self;
//}


@end
