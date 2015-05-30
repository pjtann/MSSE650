//
//  ShowAuditionDetailViewController.m
//  AuditionTracker-4
//
//  Created by PT on 5/29/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "ShowAuditionDetailViewController.h"
#import "AuditionListTableViewController.h"


@interface ShowAuditionDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *auditionTitle;
@property (weak, nonatomic) IBOutlet UITextField *auditionType;
@property (weak, nonatomic) IBOutlet UITextField *auditionContact;
@property (weak, nonatomic) IBOutlet UITextField *auditionDate;

@end

@implementation ShowAuditionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // call method 'displayAuditionData' below to place data into the scene fields - instead of setting the values here in the viewDidLoad method
    [self displayAuditionData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// method to display data from row selected by user of table from AuditionListTableViewController
-(void)displayAuditionData{
    
    // set the display field values
    self.auditionTitle.text = _auditionDetailTitle;
    self.auditionType.text = _auditionDetailType;
    self.auditionContact.text = _auditionDetailContact;
    self.auditionDate.text = _auditionDetailDate;

    // turn off editing of the display fields
    self.auditionTitle.userInteractionEnabled = NO;
    self.auditionType.userInteractionEnabled = NO;
    self.auditionContact.userInteractionEnabled = NO;
    self.auditionDate.userInteractionEnabled = NO;
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
