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

@interface AuditionListTableViewController ()

@property NSMutableArray *auditionItems;

@end

@implementation AuditionListTableViewController

-(IBAction)unwindToList:(UIStoryboardSegue *)seque{
    
    if ([[seque identifier] isEqualToString: @"segueFromAddSaveToList"]) {
    AddAuditionViewController *source = [seque sourceViewController];
    AuditionItem *item = source.auditionItem;
    if (item != nil){
        [self.auditionItems addObject:item];
        [self.tableView reloadData];
        }
    }
    
}

// created just to test getting data on the first screen - TO BE DELETED LATER
-(void) loadInitialData{
    AuditionItem *item1 = [[AuditionItem alloc] init];
    item1.auditionTitle = @"Test Audition Title Entry";
    item1.auditionType = @"Test Type Entry";
    item1.auditionContact = @"Test Contact Entry";
    item1.auditionDate = @"Test Date Entry";
    [self.auditionItems addObject:item1];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.auditionItems = [[NSMutableArray alloc] init]; // initialize an instance to put the input data into from the addAudition scene when it returns back 
    [self loadInitialData]; // loading some bogus test data - TO BE DELETED LATER
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    AuditionItem *auditionItem = [self.auditionItems objectAtIndex:indexPath.row];
    cell.textLabel.text = auditionItem.auditionTitle;
    cell.detailTextLabel.text = auditionItem.auditionType;
    

    if (auditionItem.completed){
        cell.accessoryType = UITableViewCellAccessoryCheckmark; // adding a checkmark that we probably don't need.
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
