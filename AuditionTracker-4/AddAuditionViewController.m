//
//  AddAuditionViewController.m
//  AuditionTracker-4
//
//  Created by PT on 5/29/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "AddAuditionViewController.h"

@interface AddAuditionViewController ()

@property (weak, nonatomic) IBOutlet UITextField *auditionTitle;
@property (weak, nonatomic) IBOutlet UITextField *auditionType;
@property (weak, nonatomic) IBOutlet UITextField *auditionContact;
@property (weak, nonatomic) IBOutlet UITextField *auditionDate;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveAuditionButton;


@end

@implementation AddAuditionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if (sender != self.saveAuditionButton) return;
    if (self.auditionTitle.text.length > 0){
        
        self.auditionItem = [[AuditionItem alloc] init]; // auditionItem is the object getting passed back
        
        // set display fields in object from entry fields on scene
        self.auditionItem.auditionTitle = self.auditionTitle.text;
        self.auditionItem.auditionType = self.auditionType.text;
        self.auditionItem.auditionContact = self.auditionContact.text;
        self.auditionItem.auditionDate = self.auditionDate.text;
        
        self.auditionItem.completed = NO;
        
    }
    
    
}


@end
