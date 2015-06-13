//
//  AuditionSvcSQLite.m
//  AuditionTracker-4
//
//  Created by PT on 6/7/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "AuditionSvcSQLite.h"
#import "sqlite3.h" // import the SQLite framework we added to the project in the project general settings tab framework section


@implementation AuditionSvcSQLite


// variables to hold the path and database connection parameters
NSString *databasePath = nil;
sqlite3 *database = nil;

-(id) init{
    if ((self = [super init])){
        // get the path to the documents directory
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
        // append the database name to it and set the databasePath value into the variable
        databasePath = [documentsDir stringByAppendingPathComponent:@"auditions.sqlite3"];
        
        // open the database
        if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK){
            // create and define table in database if not existing
            NSString *createSql = @"create table if not exists auditions(id integer primary key autoincrement, auditionTitle varchar(40), auditionType varchar(30), auditionContact varchar(30), auditionDate varchar(8))";
            // , auditionTime varchar(5), auditionLocation varchar(40), auditionStatus varchar(20), auditionCost varchar(12))";
            
            char *errMsg;
            if (sqlite3_exec(database, [createSql UTF8String], NULL, NULL, &errMsg) != SQLITE_OK){
                //NSLog(@"*** Failed to create table %s", errMsg);
            }
            
        }else{
            //NSLog(@"*** Failed to open database!");
            //NSLog(@"*** SQL error: %s\n", sqlite3_errmsg(database));
        }
    }
    return self;
}

-(AuditionItem *) createAudition:(AuditionItem *)auditionItem{
    sqlite3_stmt *statement;
    
    // contruct the SQL command
    NSString *insertSQL = [NSString stringWithFormat:
                           @"Insert into auditions (auditionTitle, auditionType, auditionContact, auditionDate) values (\"%@\", \"%@\", \"%@\", \"%@\")", auditionItem.auditionTitle, auditionItem.auditionType, auditionItem.auditionContact, auditionItem.auditionDate];
    // \"%@\", \"%@\", \"%@\", \"%@\")", auditionItem.auditionTime, auditionItem.auditionLocation, auditionItem.auditionStatus, auditionItem.auditionCost];
    
    // compile and evaluate - this line actually sets the value into 'statement' too
    if (sqlite3_prepare_v2(database, [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        if (sqlite3_step(statement) == SQLITE_DONE) {
            // get the last insert ID
            auditionItem.id = sqlite3_last_insert_rowid(database);
            //NSLog(@"*** AuditionItem added.");
        }else{
            //NSLog(@"*** AuditionItem NOT added.");
            //NSLog(@"*** SQL error: %s\n", sqlite3_errmsg(database));
        }
        // close the SQL statement
        sqlite3_finalize(statement);
    }
    return auditionItem;
}

-(NSMutableArray *) retrieveAllAuditions {
    NSMutableArray *auditions = [NSMutableArray array];
    // construct teh SQL select command
    NSString *selectSQL = [NSString stringWithFormat:@"SELECT * FROM auditions ORDER BY auditionTitle"];
    sqlite3_stmt *statement;
    // compile
    if (sqlite3_prepare_v2(database, [selectSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        //NSLog(@"*** AuditionItems retrieved.");
        // evalute and iterate through the rows
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int id = sqlite3_column_int(statement, 0);
            char *auditionTitleChars = (char *) sqlite3_column_text(statement, 1);
            char *auditionTypeChars = (char *) sqlite3_column_text(statement, 2);
            char *auditionContactChars = (char *) sqlite3_column_text(statement, 3);
            char *auditionDateChars = (char *) sqlite3_column_text(statement, 4);
//            char *auditionTimeChars = (char *) sqlite3_column_text(statement, 5);
//            char *auditionLocationChars = (char *) sqlite3_column_text(statement, 6);
//            char *auditionStatusChars = (char *) sqlite3_column_text(statement,7);
//            char *auditionCostChars = (char *) sqlite3_column_text(statement, 8);
            
            AuditionItem *auditionItem = [[AuditionItem alloc]init];
            auditionItem.id = id;            
            
            auditionItem.auditionTitle = [[NSString alloc] initWithUTF8String:auditionTitleChars];
            auditionItem.auditionType = [[NSString alloc] initWithUTF8String:auditionTypeChars];
            auditionItem.auditionContact = [[NSString alloc] initWithUTF8String:auditionContactChars];
            auditionItem.auditionDate = [[NSString alloc] initWithUTF8String:auditionDateChars];
            
//            auditionItem.auditionTime = [[NSString alloc] initWithUTF8String:auditionTimeChars];
//            auditionItem.auditionLocation = [[NSString alloc] initWithUTF8String:auditionLocationChars];
//            auditionItem.auditionStatus = [[NSString alloc] initWithUTF8String:auditionStatusChars];
//            auditionItem.auditionCost = [[NSString alloc] initWithUTF8String:auditionCostChars];

            // update the collection of Auditions array for each iteration through the SQLite database
            [auditions addObject:auditionItem];

        }
        // close the statement
        sqlite3_finalize(statement);
    }else{
        //NSLog(@"*** AuditionItems NOT retrieved.");
        //NSLog(@"*** SQL error: %s\n", sqlite3_errmsg(database));
    }
    //NSLog(@"Count of auditions array?: %lu", (unsigned long)auditions.count);

    return auditions;
    
}

-(AuditionItem *) selectAudition:(AuditionItem *)auditionItem{

    // construct teh SQL select command
    NSString *selectSQL = [NSString stringWithFormat:@"SELECT FROM auditions WHERE id = %li", auditionItem.id];
    
    sqlite3_stmt *statement;

    // compile
    if (sqlite3_prepare_v2(database, [selectSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        // evaluate the statement
        if (sqlite3_step(statement) == SQLITE_DONE){
            //NSLog(@"*** AuditionItem updated.");
        }else{
            //NSLog(@"*** AuditionItem NOT updated.");
            //NSLog(@"*** SQL error: %s\n", sqlite3_errmsg(database));
        }
        // close the statement
        sqlite3_finalize(statement);
    }
    
    return auditionItem;
}


// made this a class method to access it from the show audition controller
+(AuditionItem *) updateAudition:(AuditionItem *)auditionItem{
    // construct the SQL command
    NSString *updateSQL = [NSString stringWithFormat:
                           @"UPDATE auditions SET auditionTitle=\"%@\", auditionType=\"%@\", auditionContact=\"%@\", auditionDate=\"%@\" WHERE id = %li ", auditionItem.auditionTitle, auditionItem.auditionType, auditionItem.auditionContact, auditionItem.auditionDate, auditionItem.id];
            // auditionTime=\"%@\", auditionLocation=\"%@\", auditionStatus=\"%@\", auditionCost=\"%@\" WHERE id = %li ", auditionItem.auditionTime, auditionItem.auditionLocation, auditionItem.auditionStatus, auditionItem.auditionCost, auditionItem.id];
    
    
    sqlite3_stmt *statement;
    
        //NSLog(@"Value of id inside top of update: %li", auditionItem.id);
    // compile
    if (sqlite3_prepare_v2(database, [updateSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        // evaluate the statement
        if (sqlite3_step(statement) == SQLITE_DONE){
            //NSLog(@"*** AuditionItem updated.");
        }else{
            //NSLog(@"*** AuditionItem NOT updated.");
            //NSLog(@"*** SQL error: %s\n", sqlite3_errmsg(database));
        }
        // close the statement
        sqlite3_finalize(statement);
    }
    
    return auditionItem;
}

// delete method
-(AuditionItem *) deleteAudition: (AuditionItem *) auditionItem{
    // construct the SQL delete command
    NSString *deleteSQL = [NSString stringWithFormat:
        @"DELETE FROM auditions WHERE id = %li", auditionItem.id];
     NSLog(@"Value of id inside delete: %li", auditionItem.id);
        sqlite3_stmt *statement;
        // compile
        if (sqlite3_prepare_v2(database, [deleteSQL UTF8String], -1, &statement, NULL) == SQLITE_OK){
            // evaluate SQL statement
            if (sqlite3_step(statement) == SQLITE_DONE){
                //NSLog(@"*** AuditionItem deleted.");
            }else {
                //NSLog(@"*** AuditionItem NOT deleted.");
                //NSLog(@"*** SQL error: %s\n", sqlite3_errmsg(database));
            }
            // close statement
            sqlite3_finalize(statement);
        }
    
    return auditionItem;
}

-(void) dealloc {
    sqlite3_close(database);
}


// method to see if the local array for populating the archive file is empty or not

-(id) checkForEmptyFile: (NSString *) fileEmptyMessage
{

    
//    if  (!auditions || !auditions.count) // checks to see if array has no objects
//        
//    {
//        fileEmptyMessage = @"Yes"; // if it's empty, send back yes
//        
//    }
//    else
//    {
//        fileEmptyMessage = @"No"; // if it has objects send back no
//    }
    return fileEmptyMessage;
}


// method to delete/remove an object from the archive file
-(void) deleteAudItem: (NSUInteger *) AudItemKey
{
//    [auditions removeObjectAtIndex:*AudItemKey];
//    [self writeAuditionArchive]; // testing to see if we need to re-write the array to the archive file
    
    // construct the SQL delete command
    NSString *deleteSQL = [NSString stringWithFormat:
                           @"DELETE FROM auditions WHERE id = %lu", *AudItemKey];
    //NSLog(@"Value of id inside delete: %lu", *AudItemKey);
    sqlite3_stmt *statement;
    // compile
    if (sqlite3_prepare_v2(database, [deleteSQL UTF8String], -1, &statement, NULL) == SQLITE_OK){
        // evaluate SQL statement
        if (sqlite3_step(statement) == SQLITE_DONE){
            //NSLog(@"*** AuditionItem deleted.");
        }else {
            //NSLog(@"*** AuditionItem NOT deleted.");
            //NSLog(@"*** SQL error: %s\n", sqlite3_errmsg(database));
        }
        // close statement
        sqlite3_finalize(statement);
    }
    

}


@end
