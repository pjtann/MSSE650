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

@property (strong, nonatomic) id auditionDetailItem;
@property (strong, nonatomic) id auditionDetailTitle;
@property (strong, nonatomic) id auditionDetailType;
@property (strong, nonatomic) id auditionDetailContact;
@property (strong, nonatomic) id auditionDetailDate;

@end
