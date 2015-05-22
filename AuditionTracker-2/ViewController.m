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

AuditionSvcCache *auditionSvc = nil;


- (void)viewDidLoad {
    [super viewDidLoad];
    auditionSvc = [[AuditionSvcCache alloc]init];
    
    // adding edit/done button to navigation bar to test it out
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveAudition:(id)sender {

    
    [self.view endEditing:YES];
    
    Audition *audition = [[Audition alloc] init];
    audition.auditionTitle = _auditionTitle.text;
    audition.auditionDate = _auditionDate.text; // add date to array
    [auditionSvc createAudition:audition];
    [self.tableView reloadData];

    
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[auditionSvc retrieveAllAuditions] count];
    
}



-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
        
        
    }
    Audition *audition = [[auditionSvc retrieveAllAuditions] objectAtIndex:indexPath.row];
   

    cell.textLabel.text = audition.auditionTitle;

    
    cell.detailTextLabel.text = audition.auditionDate;

    
    return cell;
    
    
}

// delete action
- (IBAction)deleteAudition:(id)sender {
    NSLog(@"Audition Delete Button Pressed in vc m file.");
    
    [self.view endEditing:YES];
    
    Audition *audition = [[Audition alloc] init];
    audition.auditionTitle = _auditionTitle.text;
    audition.auditionDate = _auditionDate.text; // add date to array
    [auditionSvc deleteAudition:audition];
    [self.tableView reloadData];
    
    NSLog(@"Value of 'description' array in vc m file: %@ and %@", audition.auditionTitle, audition.auditionDate);
    

    
    NSLog(@"End of audition delete method in vc m file.");
    
}


// delete method
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {

        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }

}

@end
