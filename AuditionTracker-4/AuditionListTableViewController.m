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
#import "AuditionSvcArchive.h"


@class AuditionSvcArchive;


@interface AuditionListTableViewController ()

@property NSMutableArray *auditionItems;


@end

@implementation AuditionListTableViewController

AuditionSvcArchive *auditionSvc = nil;


-(IBAction)unwindToList:(UIStoryboardSegue *)seque{
    
    if ([[seque identifier] isEqualToString: @"segueFromAddSaveToList"]) {
    AddAuditionViewController *source = [seque sourceViewController];
    AuditionItem *item = source.auditionItem;
    if (item != nil){
        
        // call createAudition method to add new audition objects
        
        [auditionSvc createAudition: item];
        
        
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
    {
        NSLog(@"Archive file has no objects in it; add demo data. Value of fileEmptyMsg: %@", fileEmptyMsg);
    
        AuditionItem *item1 = [[AuditionItem alloc] init];
        item1.auditionTitle = @"Demo Audition Title Entry 1";
        item1.auditionType = @"Demo Type Entry 1";
        item1.auditionContact = @"Demo Contact Entry 1";
        item1.auditionDate = @"Demo Date Entry 1";
        //[self.auditionItems addObject:item1];
        [auditionSvc createAudition: item1]; // add to archive file
    
        AuditionItem *item2 = [[AuditionItem alloc] init];
        item2.auditionTitle = @"Demo Audition Title Entry 2";
        item2.auditionType = @"Demo Type Entry 2";
        item2.auditionContact = @"Demo Contact Entry 2";
        item2.auditionDate = @"Demo Date Entry 2";
        //[self.auditionItems addObject:item2];
        [auditionSvc createAudition: item2]; // add to archive file
    
    }
    else
    {
    NSLog(@"Archive file has some objects in it; do not add demo data. Value of fileEmptyMsg: %@",fileEmptyMsg);
    
}
    
    // call retrieveAllAuditions method to put value of 'auditions' array in asa.m file containing our archive file objects that was loaded earlier
    self.auditionItems = [auditionSvc retrieveAllAuditions];
    NSLog(@"Checking here for value of auditionItems.");

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    auditionSvc = [[AuditionSvcArchive alloc] init]; // ADDED initialize
    
    // go to (call) the loadInitialData method
    [self loadInitialData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
//#warning Incomplete method implementation.

    // Return the number of rows in the section.
    return [self.auditionItems count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListPrototypeCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    // set the row
    AuditionItem *auditionItem = [self.auditionItems objectAtIndex:indexPath.row];

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
        
        NSLog(@"Value of indexPath.row line 158 in adltv.m file: %li", indexPath.row); // has the row number in a long integer value
        
        // TEMPORARY - routine to cycle through and display the objects/records of the archive file - uses 'description' mehod from the AuditionItem.m file to display the objects in a readable format to the screen
        for (AuditionItem *myA in _auditionItems) {
            NSLog(@"The unarchive object is: %@", myA);
            
        }
        
        NSLog(@"\n Between the two For loops.\n");
        
        
        // put indexPath.row/key value into an unsigned integer object to pass to the delete method because row value from tableview is an unsigned long integer value
        NSUInteger audItemKey = indexPath.row;
        
        // call deleteAudItem method with the key/row to the item to delete the object from the archive file
        [auditionSvc deleteAudItem:&audItemKey];
        
        //  PJT ******** believe this is causing teh extra delete somehow
        //[self.auditionItems removeObjectAtIndex:indexPath.row]; // delete object from local arrray; seems to work now!!!!!
        
        [self.tableView reloadData];

        // TEMPORARY - routine to cycle through and display the objects/records of the archive file - uses 'description' mehod from the AuditionItem.m file to display the objects in a readable format to the screen
        
        for (AuditionItem *myA in _auditionItems) {
            NSLog(@"The unarchive object is: %@", myA);
            
        }

        //[tableView reloadData]; // probably dont' have to reload the table so remarked out
        
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
    
    if ([[segue identifier] isEqualToString: @"segueToShowAuditionDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
    // Get the new view controller using [segue destinationViewController].
        ShowAuditionDetailViewController *controller = (ShowAuditionDetailViewController *)[[segue destinationViewController] topViewController];
        
        // get object from row selected by user
        AuditionItem *auditionItem = [self.auditionItems objectAtIndex:indexPath.row];
        
        // set fields from selected object into segue fields for segue to showAudition scene; these are needed to pass data to ShowAuditionDetailViewController

        [controller setAuditionDetailTitle: auditionItem.auditionTitle];
        [controller setAuditionDetailType: auditionItem.auditionType];
        [controller setAuditionDetailContact: auditionItem.auditionContact];
        [controller setAuditionDetailDate: auditionItem.auditionDate];
        
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
