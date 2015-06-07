//
//  AuditionSvcArchive.m
//  AuditionTracker-4
//
//  Created by PT on 6/2/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "AuditionSvcArchive.h"

@implementation AuditionSvcArchive

// the archive file location
NSString *auditionFilePath;

// the collection of audition items for the archive file usage
NSMutableArray *auditions;

// the initialization method
-(id) init{
    // find the document directory
    NSLog(@"Finding starting point.");
    
///*

 // remarked out for testing hard code archive file
    NSArray *dirPaths =
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    // append a file name to the end of the directory path
    auditionFilePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"Auditions.plist"]];
//*/

    [self getFilePath: auditionFilePath];
    NSLog(@"Value of auditionFilePath: %@", auditionFilePath);
    
    //read in the archive via the readAuditionArchive method
    [self readAuditionArchive];
    
    
    return self;
}

-(id) getFilePath: (NSString *) audFilePath
{
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    auditionFilePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"Auditions.plist"]];
    
    //******* to use a hard coded file unremark the following line
    //auditionFilePath = @"/Users/PT/Desktop/AuditionsHardCode.plist";
    
    return auditionFilePath; // archive file with full path
    
}

// the read from archive method
-(void) readAuditionArchive{
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath:auditionFilePath]) {
        
        // if file exists, read from the file
        auditions = [NSKeyedUnarchiver unarchiveObjectWithFile:auditionFilePath];
        
        for (AuditionItem *myA in auditions) {
            NSLog(@"The unarchive object is: %@", myA);
            
        }
        
    }
    else
    {
        // create an empty list if file doesn't exist already
        auditions = [NSMutableArray array];
        
    }
    
}


// the write to archive method
-(void) writeAuditionArchive{
    // archive auditions to the archive file

    [NSKeyedArchiver archiveRootObject:auditions toFile:auditionFilePath];
    
}

-(AuditionItem *) createAudition:(AuditionItem *)auditionItem
{

    // add the audition to the archive file, then go to the writeAuditionArchive method
  
    [auditions addObject:auditionItem];
    [self writeAuditionArchive];
    return auditionItem;
}
-(AuditionItem *) updateAudition:(AuditionItem *)auditionItem
{
    return auditionItem;
}
/* // remarking out this method - OLD ONE THAT DOESN"T WORK
-(AuditionItem *) deleteAudition:(AuditionItem *)auditionItem
{
    // delete the audition item from the archive file, then go to the writeAuditionArchive method
    [auditions removeObject:auditionItem];
    
//    [self writeAuditionArchive];
    
    return auditionItem;
}
*/

// method to delete/remove an object from the archive file
-(void) deleteAudItem: (NSUInteger *) AudItemKey
{
    [auditions removeObjectAtIndex:*AudItemKey];
    [self writeAuditionArchive]; // testing to see if we need to re-write the array to the archive file
}

-(NSMutableArray *) retrieveAllAuditions
{
    return auditions;
}


// method to see if the local array for populating the archive file is empty or not

-(id) checkForEmptyFile: (NSString *) fileEmptyMessage
{
    if  (!auditions || !auditions.count) // checks to see if array has no objects
        
    {
        fileEmptyMessage = @"Yes"; // if it's empty, send back yes
        
    }
    else
    {
        fileEmptyMessage = @"No"; // if it has objects send back no
    }
    return fileEmptyMessage;
}



@end
