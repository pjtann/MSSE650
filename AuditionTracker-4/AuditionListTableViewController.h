//
//  AuditionListTableViewController.h
//  AuditionTracker-4
//
//  Created by PT on 5/29/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuditionListTableViewController : UITableViewController

// segue declaration for returning to AuditionListTableViewController from Add and Show scenes
-(IBAction)unwindToList:(UIStoryboardSegue *)seque;


@end
