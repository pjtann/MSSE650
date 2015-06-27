//
//  UpdateCategoryViewController.m
//  AuditionTracker-4
//
//  Created by PT on 6/22/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "UpdateCategoryViewController.h"
#import "AuditionCategoryTableViewController.h"
#import "AuditionSvc.h"
#import "AuditionSvcCoreData.h"


@interface UpdateCategoryViewController()

@property (weak, nonatomic) IBOutlet UITextField *auditionCategory;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *updateCategoryButton;

@end

@implementation UpdateCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // call method 'displayAuditionData' below to place data into the scene fields - instead of setting the values here in the viewDidLoad method
    [self displayCategoryData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// method to display data from row selected by user of table from AuditionListTableViewController
-(void)displayCategoryData{
    
    // set the display field values
    
    self.auditionCategory.text = _auditionDetailCategory;

    
    // turn off editing of the display fields not yet used
    //    self.auditionTime.userInteractionEnabled = NO;
    //    self.auditionLocation.userInteractionEnabled = NO;
    //    self.auditionStatus.userInteractionEnabled = NO;
    //    self.auditionCost.userInteractionEnabled = NO;
    
}

- (IBAction)updateCategoryButton:(id)sender {
    
    [self updateCategoryData];
    
}

-(void)updateCategoryData{
    [AuditionSvcCoreData updateCategory:_auditionDetailCategory andNewCategory:_auditionCategory.text];
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if (sender == self.updateCategoryButton){
        
        [self updateCategoryData];
        
    }
    
}

@end
