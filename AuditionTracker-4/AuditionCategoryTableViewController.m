//
//  AuditionCategoryTableViewController.m
//  AuditionTracker-4
//
//  Created by PT on 6/19/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "AuditionCategoryTableViewController.h"
#import "AuditionSvcCoreData.h"
//#import "AuditionListTableViewController.h"
#import "AuditionCategory.h"
#import "AuditionSvc.h"
#import "UpdateCategoryViewController.h"



@interface AuditionCategoryTableViewController ()

@property NSMutableArray *categoryItems;

@end

@implementation AuditionCategoryTableViewController

AuditionSvcCoreData *auditionCategory = nil; // reference declaration

//AuditionSvcCoreData *auditionSvc = nil; // reference declaration - can't do this here because it will cause a duplicate symbol error with the declaration in the altvc.m file.

-(IBAction)unwindToCategoryList:(UIStoryboardSegue *)seque{
    
    if ([[seque identifier] isEqualToString: @"segueFromCategoryUpdateToCategoryList"]) {
        //    AddAuditionViewController *source = [seque sourceViewController];
        //    Auditions *item = source.auditionItem;
        [self.tableView reloadData];

    }else{
        if ([[seque identifier] isEqualToString:@"segueFromAddCategorySaveToCategoryList"]){
            [self.tableView reloadData];
            
        }
    
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];

    
    UIBarButtonItem *firstButton = self.editButtonItem;
    
    UIBarButtonItem *secondButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Cancel"
                                     style:UIBarButtonItemStylePlain
                                     target:self
                                     action:@selector(secondLeftBarButton:)];
    
    
    self.navigationItem.leftBarButtonItems= [NSArray arrayWithObjects:firstButton,secondButton,nil];

    
    // *&*&*&*&*&&*&
    
    AuditionSvcCoreData *auditionCategory = [[AuditionSvcCoreData alloc] init];
    NSLog(@"Value of auditionCategory: %@", auditionCategory);
    
    // &*&*&&*&*&*&&*
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(IBAction)secondLeftBarButton:(id)sender{
    [self performSegueWithIdentifier:@"segueFromCategoryToMain" sender:self];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    return [[AuditionSvcCoreData retrieveAllCategories] count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryPrototypeCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    AuditionCategory *auditionCategoryItem = [[AuditionSvcCoreData retrieveAllCategories] objectAtIndex:indexPath.row];
  
    cell.textLabel.text = auditionCategoryItem.auditionCategory;
    
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
        
        
        AuditionCategory *categoryItem = [[AuditionSvcCoreData retrieveAllCategories] objectAtIndex:indexPath.row];
        
        [AuditionSvcCoreData deleteCategory:categoryItem];
        
        [self.categoryItems removeObject:categoryItem];
        
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
 if ([[segue identifier] isEqualToString: @"segueFromCategoryListToUpdateCategory"]) {
 NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
 
 // Get the new view controller using [segue destinationViewController].
 UpdateCategoryViewController *controller = (UpdateCategoryViewController *)[[segue destinationViewController] topViewController];
 
 // get object from row selected by user
 AuditionCategory *categoryItem = [[AuditionSvcCoreData retrieveAllCategories] objectAtIndex:indexPath.row]; // ADDED
 NSLog(@"Value of categoryItem: %@", categoryItem);
 
     
     // set fields from selected object into segue fields for segue to showAudition scene; these are to pass data to UpdateCategoryViewController
     
     [controller setAuditionDetailCategory: categoryItem.auditionCategory];

 }
 
 
}
#pragma mark - Table view delegate
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    AuditionCategory *tappedItem = [self.categoryItems objectAtIndex:indexPath.row];
    tappedItem.categoryCompleted = !tappedItem.categoryCompleted;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
    
}
@end
