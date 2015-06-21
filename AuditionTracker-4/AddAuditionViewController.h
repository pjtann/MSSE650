//
//  AddAuditionViewController.h
//  AuditionTracker-4
//
//  Created by PT on 5/29/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "AuditionItem.h" // removed with convert to 'Auditions' class with Core Data implementation
#import "Auditions.h"


@interface AddAuditionViewController : UIViewController

@property Auditions *auditionItem;


@end
