//
//  AuditionListTableViewController.m
//  AuditionTracker-4
//
//  Created by PT on 5/29/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "AuditionListTableViewController.h"
#import "AuditionItem.h"
#import "AddAuditionViewController.h"
#import "ShowAuditionDetailViewController.h"
//#import "AuditionSvcArchive.h" // REMOVED
#import "AuditionSvcSQLite.h" // ADDED

@class AuditionSvcArchive;

@interface AuditionListTableViewController ()

@property NSMutableArray *auditionItems;

@end

@implementation AuditionListTableViewController

//AuditionSvcArchive *auditionSvc = nil; // REMOVED
AuditionSvcSQLite *auditionSvc = nil; // ADDED


-(IBAction)unwindToList:(UIStoryboardSegue *)seque{
    
    if ([[seque identifier] isEqualToString: @"segueFromAddSaveToList"]) {
    AddAuditionViewController *source = [seque sourceViewController];
    AuditionItem *item = source.auditionItem;
    if (item != nil){
        
        // call createAudition method to add new audition objects
        
        [auditionSvc createAudition: item];
        [self.auditionItems addObject:item];
        
        
        [self.tableView reloadData];
        }
    }else{
        if ([[seque identifier] isEqualToString:@"segueFromShowSaveToList"]){
            [self.tableView reloadData];
            
        }
    }
    
}

// method to load data on presentation of AuditionListTableViewController Scene
-(void) loadInitialData{
    

    NSString *fileEmptyMsg;
    // call fileEmptyMsg method to see if the archive file has any objects in it
    fileEmptyMsg = [auditionSvc checkForEmptyFile:fileEmptyMsg];
    // if the archive file is empty, populate with these demo objects
    
    if ([fileEmptyMsg  isEqual: @"Yes"])
//    if (myCount == 0)
    
    {
        //NSLog(@"Archive file has no objects in it; add demo data. Value of fileEmptyMsg: %@", fileEmptyMsg);
    
        AuditionItem *item1 = [[AuditionItem alloc] init];
        item1.auditionTitle = @"Demo Audition Title Entry 1";
        item1.auditionType = @"Demo Type Entry 1";
        item1.auditionContact = @"Demo Contact Entry 1";
        item1.auditionDate = @"Demo Date Entry 1";
//        item1.auditionTime = @"Demo Audition Time Entry 1";
//        item1.auditionLocation = @"Demo Location Entry 1";
//        item1.auditionStatus = @"Demo Status Entry 1";
//        item1.auditionCost = @"Demo Cost Entry 1";
        //[self.auditionItems addObject:item1];
        [auditionSvc createAudition: item1]; // add to archive file
    
        AuditionItem *item2 = [[AuditionItem alloc] init];
        item2.auditionTitle = @"Demo Audition Title Entry 2";
        item2.auditionType = @"Demo Type Entry 2";
        item2.auditionContact = @"Demo Contact Entry 2";
        item2.auditionDate = @"Demo Date Entry 2";
//        item2.auditionTime = @"Demo Audition Time Entry 2";
//        item2.auditionLocation = @"Demo Location Entry 2";
//        item2.auditionStatus = @"Demo Status Entry 2";
//        item2.auditionCost = @"Demo Cost Entry 2";
        //[self.auditionItems addObject:item2];
        [auditionSvc createAudition: item2]; // add to archive file
    
    }
    else
    {
    //NSLog(@"Archive file has some objects in it; do not add demo data. Value of fileEmptyMsg: %@",fileEmptyMsg);
    
}
    
    // call retrieveAllAuditions method to put value of 'auditions' array in asa.m file containing our archive file objects that was loaded earlier
    self.auditionItems = [auditionSvc retrieveAllAuditions];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    auditionSvc = [[AuditionSvcSQLite alloc] init]; // ADDED
    
    // go to (call) the loadInitialData method
    [self loadInitialData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // displays an Edit button in the navigation bar for this view controller.
     self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated here.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [[auditionSvc retrieveAllAuditions] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListPrototypeCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    AuditionItem *auditionItem = [[auditionSvc retrieveAllAuditions] objectAtIndex:indexPath.row]; // ADDED
    
    // fill the table view scene rows with the auditionTitle value as primary label and auditionType value as secondary label
    
    cell.textLabel.text = auditionItem.auditionTitle;
    cell.detailTextLabel.text = auditionItem.auditionType;

    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the row from the data source
        
//        AuditionItem *auditionItem = [[auditionSvc retrieveAllAuditions] objectAtIndex:indexPath.row]; // TO BE DELETED
//        AuditionItem *auditionItem = [_auditionItems objectAtIndex:indexPath.row]; // TO BE DELETED
        
        // fill an object with all objects from database with the retrieveAllAuditions method using row from table
        AuditionItem *auditionItem = [[auditionSvc retrieveAllAuditions] objectAtIndex:indexPath.row]; // ADDED
        
        // delete from database using deleteAudtion method
        [auditionSvc deleteAudition:auditionItem];
        
        // delete from local array auditionItems
        [self.auditionItems removeObject:auditionItem];
        
        // reload the table scene
        [self.tableView reloadData];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // segue to the detail scene based on a user row selection
    if ([[segue identifier] isEqualToString: @"segueToShowAuditionDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
    // Get the new view controller using [segue destinationViewController].
        ShowAuditionDetailViewController *controller = (ShowAuditionDetailViewController *)[[segue destinationViewController] topViewController];
        
        // get object from row selected by user
        AuditionItem *auditionItem = [[auditionSvc retrieveAllAuditions] objectAtIndex:indexPath.row]; // ADDED
       
        // set fields from selected object into segue fields for segue to showAudition scene; these are to pass data to ShowAuditionDetailViewController
        [controller setAuditionDetailId: auditionItem.id];
        [controller setAuditionDetailTitle: auditionItem.auditionTitle];
        [controller setAuditionDetailType: auditionItem.auditionType];
        [controller setAuditionDetailContact: auditionItem.auditionContact];
        [controller setAuditionDetailDate: auditionItem.auditionDate];
//        [controller setAuditionDetailTime: auditionItem.auditionTime];
//        [controller setAuditionDetailLocation: auditionItem.auditionLocation];
//        [controller setAuditionDetailStatus: auditionItem.auditionStatus];
//        [controller setAuditionDetailCost: auditionItem.auditionCost];
    }

    // Pass the selected object to the new view controller.
}

#pragma mark - Table view delegate
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    AuditionItem *tappedItem = [self.auditionItems objectAtIndex:indexPath.row];
    tappedItem.completed = !tappedItem.completed;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];

}

@end
