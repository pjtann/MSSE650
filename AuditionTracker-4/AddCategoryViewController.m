//
//  AddCategoryViewController.m
//  AuditionTracker-4
//
//  Created by PT on 6/22/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "AddCategoryViewController.h"
#import "AuditionSvcCoreData.h"
#import "AuditionSvc.h"



@interface AddCategoryViewController()

@property (weak, nonatomic) IBOutlet UITextField *auditionCategory;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveCategoryButton;


@end

@implementation AddCategoryViewController

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if (sender != self.saveCategoryButton) return;
    if (self.auditionCategory.text.length > 0){
        
        [AuditionSvcCoreData newContextObjectWithCategory:_auditionCategory.text];
       
        // set display fields in object from entry fields on scene
        self.categoryItem.auditionCategory = self.auditionCategory.text;
      
        self.categoryItem.categoryCompleted = NO;
        
    }
    
}


@end
