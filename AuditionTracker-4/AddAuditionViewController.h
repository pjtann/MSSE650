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


@interface AddAuditionViewController : UIViewController <UITextFieldDelegate> // added delegate to see if it helps control the textfield shouldend, didend, shouldbegin, etc. validation controls in the AAVC.m file.

@property Auditions *auditionItem;


@end
