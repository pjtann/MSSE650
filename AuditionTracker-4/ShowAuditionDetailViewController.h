//
//  ShowAuditionDetailViewController.h
//  AuditionTracker-4
//
//  Created by PT on 5/29/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuditionListTableViewController.h"

@interface ShowAuditionDetailViewController : UIViewController

// property declaration for the display scene screen

@property long auditionDetailId; // just added for update
@property (strong, nonatomic) id auditionDetailItem;
@property (strong, nonatomic) id auditionDetailTitle;
@property (strong, nonatomic) id auditionDetailType;
@property (strong, nonatomic) id auditionDetailContact;
@property (strong, nonatomic) id auditionDetailDate;
//@property (strong, nonatomic) id auditionDetailTime;
//@property (strong, nonatomic) id auditionDetailLocation;
//@property (strong, nonatomic) id auditionDetailStatus;
//@property (strong, nonatomic) id auditionDetailCost;


//@property enum UIDatePickerMode *auditionDate; // changing to date format

@end
