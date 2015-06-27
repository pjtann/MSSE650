//
//  ContactsTableViewController.m
//  AuditionTracker-4
//
//  Created by PT on 6/22/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "ContactsTableViewController.h"
#import "AuditionSvcCoreData.h"
#import "Contacts.h"
#import "AuditionSvc.h"
#import "UpdateContactsViewController.h"

@interface ContactsTableViewController()

@property NSMutableArray *contactItems;


@end

@implementation ContactsTableViewController

AuditionSvcCoreData *contacts = nil; // reference declaration

//AuditionSvcCoreData *auditionSvc = nil; // reference declaration - can't do this here because it will cause a duplicate symbol error with the declaration in the altvc.m file.

-(IBAction)unwindToContactList:(UIStoryboardSegue *)seque{
    
    NSLog(@"Segue value: %@", [seque description]);
    
    
    if ([[seque identifier] isEqualToString: @"segueFromContactUpdateToContactList"]) {
        //    AddAuditionViewController *source = [seque sourceViewController];
        //    Auditions *item = source.auditionItem;
        [self.tableView reloadData];
        
    }else if ([[seque identifier] isEqualToString:@"segueFromAddContactSaveToContactList"]){
            [self.tableView reloadData];
        
    }else if ([[seque identifier] isEqualToString:@"segueFromContactUpdateButtonToContactList"]){
             [self.tableView reloadData];
             
        }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *firstButton = self.editButtonItem;
    
    UIBarButtonItem *secondButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Cancel"
                                     style:UIBarButtonItemStylePlain
                                     target:self
                                     action:@selector(secondLeftBarButton:)];
    
    
    self.navigationItem.leftBarButtonItems= [NSArray arrayWithObjects:firstButton,secondButton,nil];
    
    
    //auditionSvc = [[AuditionSvcCoreData alloc] init]; //init method - Need to have the core initialization run, but can't re-declare the auditionSvc as done in line 37 of the altvc.m file.
    
    // *&*&*&*&*&&*&
    
    AuditionSvcCoreData *contacts = [[AuditionSvcCoreData alloc] init];
    NSLog(@"Value of contacts: %@", contacts);
    
    // &*&*&&*&*&*&&*
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)secondLeftBarButton:(id)sender{
    NSLog(@"Im in action for second button, now what?");
    
    [self performSegueWithIdentifier:@"segueFromContactListToMain" sender:self];
  
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [[AuditionSvcCoreData retrieveAllContacts] count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactPrototypeCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    Contacts *contactItem = [[AuditionSvcCoreData retrieveAllContacts] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = contactItem.contactName;
    cell.detailTextLabel.text = contactItem.contactEmail;
    
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
        
        
        Contacts *contactItem = [[AuditionSvcCoreData retrieveAllContacts] objectAtIndex:indexPath.row];
        
        [AuditionSvcCoreData deleteContact:contactItem];
        
        [self.contactItems removeObject:contactItem];
        
        [self.tableView reloadData];
        
        // Delete the row from the data source
        //        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // segue to the detail scene based on a user row selection
    if ([[segue identifier] isEqualToString: @"segueFromContactListToContactUpdate"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        // Get the new view controller using [segue destinationViewController].
        UpdateContactsViewController *controller = (UpdateContactsViewController *)[[segue destinationViewController] topViewController];
        
        // get object from row selected by user
        Contacts *contactItem = [[AuditionSvcCoreData retrieveAllContacts] objectAtIndex:indexPath.row]; // ADDED
        NSLog(@"Value of contactItem: %@", contactItem);
        
        
        // set fields from selected object into segue fields for segue to showAudition scene; these are to pass data to UpdateCategoryViewController
        
        //     [controller setAuditionDetailCategory:categoryItem.objectID];
        NSLog(@"Value of Object ID: %@", contactItem.objectID);
        
        [controller setContactDetailName: contactItem.contactName];
        [controller setContactDetailPhone: contactItem.contactPhone];
        [controller setContactDetailEmail: contactItem.contactEmail];
        
    }
    
    
}
#pragma mark - Table view delegate
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    Contacts *tappedItem = [self.contactItems objectAtIndex:indexPath.row];
    tappedItem.contactCompleted = !tappedItem.contactCompleted;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
    
}



@end
