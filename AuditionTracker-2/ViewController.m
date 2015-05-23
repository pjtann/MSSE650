//
//  ViewController.m
//  AuditionTracker-2
//
//  Created by PT on 5/22/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "ViewController.h"
#import "Audition.h"
#import "AuditionSvcCache.h"

@interface ViewController ()

@end

@implementation ViewController

// clear the cacheing object
AuditionSvcCache *auditionSvc = nil;

- (void)viewDidLoad {
    [super viewDidLoad];
    auditionSvc = [[AuditionSvcCache alloc]init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// save new audition action
- (IBAction)saveAudition:(id)sender {

    [self.view endEditing:YES];
    
    Audition *audition = [[Audition alloc] init];
    audition.auditionTitle = _auditionTitle.text;
    audition.auditionDate = _auditionDate.text; // add date to array
    [auditionSvc createAudition:audition];
    [self.tableView reloadData];

}

// get count of number of rows
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[auditionSvc retrieveAllAuditions] count];
    
}
// fill table rows
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    
    Audition *audition = [[auditionSvc retrieveAllAuditions] objectAtIndex:indexPath.row];
    
    // set prototype cell values for row in display table
    cell.textLabel.text = audition.auditionTitle;
    cell.detailTextLabel.text = audition.auditionDate;
    
    return cell;
    
}

// delete action
- (IBAction)deleteAudition:(id)sender {

    [self.view endEditing:YES];
    
    Audition *audition = [[Audition alloc] init];
//    audition.auditionTitle = _auditionTitle.text;
//    audition.auditionDate = _auditionDate.text; // add date to array
    [auditionSvc deleteAudition:audition];

//    [self.tableView reloadData];

    
}

// delete method
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {

        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade]; // this is causing the error
        
        // reload the table data
        [self.tableView reloadData];
        
    }

}

@end
