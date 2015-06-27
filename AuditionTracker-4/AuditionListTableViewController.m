//
//  AuditionListTableViewController.m
//  AuditionTracker-4
//
//  Created by PT on 5/29/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "AuditionListTableViewController.h"
#import "Auditions.h"
#import "AddAuditionViewController.h"
#import "ShowAuditionDetailViewController.h"
//#import "AuditionSvcArchive.h" // REMOVED
//#import "AuditionSvcSQLite.h" // REMOVED
#import "AuditionSvcCoreData.h"
#import "AuditionCategory.h"







//@class AuditionSvcArchive;

@interface AuditionListTableViewController ()

@property NSMutableArray *auditionItems;


@end

@implementation AuditionListTableViewController

//AuditionSvcArchive *auditionSvc = nil; // REMOVED
//AuditionSvcSQLite *auditionSvc = nil; // REMOVED
AuditionSvcCoreData *auditionSvc = nil; // reference declaration

-(IBAction)secondLeftBarButton:(id)sender{
    NSLog(@"Im in action for second button, now what?");
    
    [self performSegueWithIdentifier:@"segueFromListToMain" sender:self];
    
}

-(IBAction)unwindToList:(UIStoryboardSegue *)seque{
    
    if ([[seque identifier] isEqualToString: @"segueFromAddSaveToList"]) {

     [self.tableView reloadData];

    }else{
        if ([[seque identifier] isEqualToString:@"segueFromShowSaveToList"]){
            [self.tableView reloadData];
            
        }
    }

}

// method to load data on presentation of AuditionListTableViewController Scene
-(void) loadInitialData{


}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    auditionSvc = [[AuditionSvcCoreData alloc] init]; //init method
    
    
    // go to (call) the loadInitialData method
    [self loadInitialData];
    
    // displays an Edit button in the navigation bar for this view controller.
     self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *firstButton = self.editButtonItem;
    
    UIBarButtonItem *secondButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Cancel"
                                     style:UIBarButtonItemStylePlain
                                     target:self
                                     action:@selector(secondLeftBarButton:)];
    
    self.navigationItem.leftBarButtonItems= [NSArray arrayWithObjects:firstButton,secondButton,nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated here.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [[auditionSvc retrieveAllAuditions] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListPrototypeCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    Auditions *auditionItem = [[auditionSvc retrieveAllAuditions] objectAtIndex:indexPath.row]; // ADDED
    
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

        // fill an object with all objects from database with the retrieveAllAuditions method using row from table
        Auditions *auditionItem = [[auditionSvc retrieveAllAuditions] objectAtIndex:indexPath.row]; // ADDED
        
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // segue to the detail scene based on a user row selection
    if ([[segue identifier] isEqualToString: @"segueToShowAuditionDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
    // Get the new view controller using [segue destinationViewController].
        ShowAuditionDetailViewController *controller = (ShowAuditionDetailViewController *)[[segue destinationViewController] topViewController];
        
        // get object from row selected by user
        Auditions *auditionItem = [[auditionSvc retrieveAllAuditions] objectAtIndex:indexPath.row]; // ADDED
        NSLog(@"Value of auditions: %@", auditionItem);
        
       
        // set fields from selected object into segue fields for segue to showAudition scene; these are to pass data to ShowAuditionDetailViewController
        //[controller setAuditionDetailId: auditionItem.id];
        [controller setAuditionDetailId:auditionItem.objectID];
        NSLog(@"Value of Object ID: %@", auditionItem.objectID);
        
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
    Auditions *tappedItem = [self.auditionItems objectAtIndex:indexPath.row];
    tappedItem.completed = !tappedItem.completed;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];

}



@end
