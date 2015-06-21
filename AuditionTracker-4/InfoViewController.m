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



@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //&&&&&&&&&&&&&&&&&&&&
    // prepare information for the popover info scene when "i" is selected on main scene
    Info *info = [[Info alloc] init];
    info.infoName = @"Audition Tracker";
    info.inforVersion = @"v.7.0";
    info.infoVersionDate = @"June 15, 2015";
    
    
    NSString *infoAll = [NSString stringWithFormat:@"%@\n %@\n %@\n", [info infoName], [info inforVersion], [info infoVersionDate]];

    self.infoTextView.text = infoAll;
    
    
}



    
    
    


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
