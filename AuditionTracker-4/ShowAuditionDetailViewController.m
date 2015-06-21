//
//  ShowAuditionDetailViewController.m
//  AuditionTracker-4
//
//  Created by PT on 5/29/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "ShowAuditionDetailViewController.h"
#import "AuditionListTableViewController.h"
#import "AuditionSvc.h"
//#import "AuditionSvcSQLite.h"
#import "AuditionSvcCoreData.h"


@interface ShowAuditionDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *auditionTitle;
@property (weak, nonatomic) IBOutlet UITextField *auditionType;
@property (weak, nonatomic) IBOutlet UITextField *auditionContact;
@property (weak, nonatomic) IBOutlet UITextField *auditionDate;
//@property (weak, nonatomic) IBOutlet UITextField *auditionTime;
//@property (weak, nonatomic) IBOutlet UITextField *auditionLocation;
//@property (weak, nonatomic) IBOutlet UITextField *auditionStatus;
//@property (weak, nonatomic) IBOutlet UITextField *auditionCost;




//@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveEditBarButton;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *updateAuditionButton;



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

    // turn off editing of the display fields not yet used
//    self.auditionTime.userInteractionEnabled = NO;
//    self.auditionLocation.userInteractionEnabled = NO;
//    self.auditionStatus.userInteractionEnabled = NO;
//    self.auditionCost.userInteractionEnabled = NO;
    
}

- (IBAction)updateAuditionButton:(id)sender {

    
    [self updateAuditonData];
    
    //[self performSegueWithIdentifier:@"segueFromUpdateToList" sender:self];
    
}
    


-(void)updateAuditonData{
       [AuditionSvcCoreData updateAudition:_auditionDetailId andOldTitle:_auditionDetailTitle andOldType: _auditionDetailType andOldContact:_auditionDetailContact andOldDate: _auditionDetailDate andNewTitle:_auditionTitle.text andNewType:_auditionType.text andNewContact:_auditionContact.text andNewDate:_auditionDate.text];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    if (sender == self.updateAuditionButton){
        
        [self updateAuditonData];
        
    }
    
    
    // %%%%%%%
    
    //[AuditionSvcCoreData updateAudition:_auditionDetailId andOldTitle:_auditionDetailTitle andOldType: _auditionDetailType andOldContact:_auditionDetailContact andOldDate: _auditionDetailDate andNewTitle:_auditionTitle.text andNewType:_auditionType.text andNewContact:_auditionContact.text andNewDate:_auditionDate.text];
    
    //%%%%%%%%
    
    
   // returns to list scene from here after update or cancel

}


//- (IBAction)updateAuditionBarButton:(id)sender {
//}
@end
