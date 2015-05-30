//
//  ViewController.h
//  AuditionTracker-2
//
//  Created by PT on 5/22/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondViewController.h"


@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>



@property (weak, nonatomic) IBOutlet UITextField *auditionTitle;
@property (weak, nonatomic) IBOutlet UITextField *auditionDate;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)saveAudition:(id)sender;
- (IBAction)deleteAudition:(id)sender;

@end

