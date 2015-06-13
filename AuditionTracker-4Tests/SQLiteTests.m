//
//  SQLiteTests.m
//  AuditionTracker-4
//
//  Created by PT on 6/7/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "AuditionItem.h"
#import "AuditionSvcSQLite.h"


@interface SQLiteTests : XCTestCase

@end

@implementation SQLiteTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

-(void) testAuditionSvcQLite{
    NSLog(@" ");
    NSLog(@"*** Starting testAuditionSvcSQLite ***");

    // add object
    AuditionSvcSQLite *AuditionSvc = [[AuditionSvcSQLite alloc]init];
    AuditionItem *auditionItem1 = [[AuditionItem alloc]init];
    auditionItem1.auditionTitle = @"The Magnificent Seven";
    auditionItem1.auditionType = @"Film";
    auditionItem1.auditionContact = @"505 Shopworks";
    auditionItem1.auditionDate = @"07-23-15";
    [AuditionSvc createAudition:auditionItem1];
    
    //AuditionSvcSQLite *AuditionSvc = [[AuditionSvcSQLite alloc]init];
   
    AuditionItem *auditionItem2 = [[AuditionItem alloc]init];
    auditionItem2.auditionTitle = @"Indiana Jones, The Beginning";
    auditionItem2.auditionType = @"Film";
    auditionItem2.auditionContact = @"Angelelique Thundercloud";
    auditionItem2.auditionDate = @"07-30-15";
    [AuditionSvc createAudition:auditionItem2];
    
    // retrieve all objects
    NSMutableArray *auditions = [AuditionSvc retrieveAllAuditions];
    NSLog(@"*** Number of audition items: %lu",(unsigned long)auditions.count);

    // update an object
    auditionItem1.auditionTitle = @"The Magnificent 7";
    auditionItem1.auditionType = @"Film";
    auditionItem1.auditionContact = @"505 Studioworks";
    auditionItem1.auditionDate = @"07-24-15";
    //[AuditionSvc updateAudition:auditionItem1];
    
    //delete an object
    [AuditionSvc deleteAudition:auditionItem1];
    
    
    
    
    NSLog(@"*** Ending testAuditionSvcSQLite ***");
    NSLog(@" ");
}


@end
