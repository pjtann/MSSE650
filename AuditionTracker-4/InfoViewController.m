//
//  InfoViewController.m
//  AuditionTracker-4
//
//  Created by PT on 6/15/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "InfoViewController.h"
#import "Info.h"


@interface InfoViewController ()

@property (weak, nonatomic) IBOutlet UITextView *infoTextView;

@property (weak, nonatomic) IBOutlet UITextView *infoReleaseTextView;
@property (weak, nonatomic) IBOutlet UITextField *infoReleaseTextViewTitle;

@property (weak, nonatomic) IBOutlet UITextView *infoEnhancementsTextView;
@property (weak, nonatomic) IBOutlet UITextField *infoEnhancementsTextViewTitle;


@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // prepare information for the popover info scene when "i" is selected on main scene
    Info *info = [[Info alloc] init];
    info.infoName = @"Audition Tracker";
    info.inforVersion = @"v.8.5";
    info.infoVersionDate = @"June 27, 2015";
    
    NSString *infoAll = [NSString stringWithFormat:@"%@\n %@\n %@\n", [info infoName], [info inforVersion], [info infoVersionDate]];

    self.infoTextView.text = infoAll;
    
    [self infoReleaseText];
    
}

-(void) infoReleaseText{
    
    self.infoReleaseTextViewTitle.text = @"Features Of This Release";
    
    self.infoReleaseTextView.text = @"* Added field validation for several fields including Audition Title, Contact Name, and Contact Phone. \n \n * Added selectable picker dials for Audition Type, Auditon Date, and Audition Contact. \n \n * Added formatting and phone dial pad usage for Contact Phone. \n\n * Incorporated use of seperate data store tables for Auditions, Contacts, and Categories. \n\n * Add release notes and future enhancements to application information scene. \n\n * Added overall consistency of field usage across scenes including sizing and position. \n\n * Created seperate update scenes for Auditions, Contacts, and Categories. \n\n * Added scrolling in some scenes to compensate for device rotation.";
    
    self.infoEnhancementsTextViewTitle.text  = @"Future Enhancements";
    
    self.infoEnhancementsTextView.text = @"* Improve cosmetics with features such as backgrond color and images. \n\n * Resolve constraint issues causing inconsistent field and text positioning. \n\n * Activate remaining Audition fields of Time, Location, Status, and Cost.";
    
}

-(IBAction)unwindToInfo:(UIStoryboardSegue *)seque{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
