//
//  AddAuditionViewController.m
//  AuditionTracker-4
//
//  Created by PT on 5/29/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "AddAuditionViewController.h"
#import "AuditionSvc.h" // added to try and call methods in SvcCore files
#import "AuditionSvcCoreData.h"
//#import <CoreData/CoreData.h> // is this needed for core data usage here?
//#import "Auditions.h"
//#import "AuditionListTableViewController.h"
#import <UIKit/UIKit.h> // needed for use of pickerView



@interface AddAuditionViewController () <UIPickerViewDataSource, UIPickerViewDelegate> // ADDED for use of pickerviews



@property (weak, nonatomic) IBOutlet UITextField *auditionTitle;
@property (weak, nonatomic) IBOutlet UITextField *auditionType;
@property (weak, nonatomic) IBOutlet UITextField *auditionContact;
@property (weak, nonatomic) IBOutlet UITextField *auditionDate;


//@property (weak, nonatomic) IBOutlet UITextField *auditionTime;
//@property (weak, nonatomic) IBOutlet UITextField *auditionLocation;
//@property (weak, nonatomic) IBOutlet UITextField *auditionStatus;
//@property (weak, nonatomic) IBOutlet UITextField *auditionCost;

// type picker
@property (nonatomic, retain) IBOutlet UIPickerView *auditionTypePicker; // ADDED FOR PICKERVIEW USEAGE
@property (nonatomic, retain) IBOutlet UIPickerView *auditionCategoryPickerView;

@property (nonatomic, retain) IBOutlet UIPickerView *pickerView1;

@property (nonatomic, retain) IBOutlet UITextField *auditionTypeText;

@property (nonatomic, retain) NSArray *pickerData;
@property (nonatomic, retain) NSArray *pickerData2;

//- (IBAction)testAudition:(id)sender;
//@property (nonatomic, retain) IBOutlet UITextField *testAudition;
@property (weak, nonatomic) IBOutlet UITextField *testAudition;

@property (weak, nonatomic) IBOutlet UITextField *testAudition2;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveAuditionButton;


@end

@implementation AddAuditionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
//    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
//    [[self.auditionDate.text cell] setFormatter:numberFormatter];

    
    _pickerData = [[NSMutableArray alloc] initWithObjects:@"Film", @"TV Series", @"Commercial", @"WebSeries", nil];
    
    _pickerData2 = [[NSMutableArray alloc] initWithObjects:@"Features", @"Shows", @"Ads", @"Internet", @"Other", nil];
    
    /*
    // put some data in an array to display in the pickerview
    _pickerData = [[NSMutableArray alloc] initWithObjects:@"Film", @"TV Series", @"Commercial", @"WebSeries", nil];
    
    
    _auditionTypeText = [[UITextField alloc] initWithFrame:CGRectMake(44, 400, 288, 200)];
    _auditionTypeText.hidden = NO;
    _auditionTypeText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

    [self.view addSubview:_auditionTypeText];
    
    
    
    
    _auditionTypePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(44, 368, 288, 200)];
    
    _auditionTypePicker.delegate = self; // makes it visible on screen for some reason?
    
    NSLog(@"pickerData: %@", _pickerData);
    
    _auditionTypePicker.hidden = NO;
    
    // load the pickerview
    [self.view addSubview:_auditionTypePicker];

    */
    
    
    
    UIPickerView *pickerView1 = [[UIPickerView alloc] init];
    pickerView1.delegate = self;
    pickerView1.dataSource = self;
    pickerView1.showsSelectionIndicator = YES;
    _testAudition.inputView = pickerView1;
    pickerView1.tag = 1;
   
    UIPickerView *auditionCategoryPickerView = [[UIPickerView alloc] init];
    auditionCategoryPickerView.delegate = self;
    auditionCategoryPickerView.dataSource = self;
    auditionCategoryPickerView.showsSelectionIndicator = YES;
    _testAudition2.inputView = auditionCategoryPickerView;
    auditionCategoryPickerView.tag = 2;
    
}







// columns in the pickerview
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (pickerView.tag == 1){
        return 1;
    }
    if (pickerView.tag == 2){
        return 2;
    }
    else{
        return 0;
    }
        
}

// rows in each column in the pickerview
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView.tag == 1){
        return 4;
    }
    if (pickerView.tag == 2){
        return 5;
    }
    else{
        return 0;
    }

}

//// rows in each column in the pickerview
//-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
//    if ([pickerView isEqual:_pickerView1]){
//        return 4;
//    }
//    if ([pickerView isEqual: _auditionCategoryPickerView]){
//        return 5;
//    }
//    else{
//        return 0;
//    }
//    
//}

//display the row from the datasource in the pickerview
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView.tag == 1){
        return [_pickerData objectAtIndex:row];
    }
    if (pickerView.tag == 2){
        return [_pickerData2 objectAtIndex:row];
    }
    else{
        return 0;
    }
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
        
        //self.auditionItem = [[Auditions alloc] init]; // auditionItem is the object getting passed back. THis is where it errors because you can't alloc init with Core Data usage

        //[[Auditions class] createAudition: _auditionItem];
        
       //[AuditionSvcCoreData createAudition: auditionItem];
        
        // %%%%%%%
        //[AuditionSvcCoreData newContextObjectWithTitle:_auditionTitle.text andType: _auditionType.text andContact:_auditionContact.text andDate: _auditionDate.text];
        //%%%%%%%%
        
        // date field fixing
        
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"yyyy-mm-dd"];
//        NSString *test = _auditionDate.text;
//        
//        NSString *dateString = [dateFormatter dateFromString:test];
//        
//        NSDate *newDate = [dateFormatter dateFromString:_auditionDate.text];
        
        
        
        
        [AuditionSvcCoreData newContextObjectWithTitle:_auditionTitle.text andType: _auditionType.text andContact:_auditionContact.text andDate:_auditionDate.text];
        
        
        // set display fields in object from entry fields on scene
        self.auditionItem.auditionTitle = self.auditionTitle.text;
        self.auditionItem.auditionType = self.auditionType.text;
        self.auditionItem.auditionContact = self.auditionContact.text;
        self.auditionItem.auditionDate = self.auditionDate.text;

        
        
//        self.auditionItem.auditionTime = self.auditionTime.text;
//        self.auditionItem.auditionLocation = self.auditionLocation.text;
//        self.auditionItem.auditionStatus = self.auditionStatus.text;
//        self.auditionItem.auditionCost = self.auditionCost.text;
        
        //self.auditionItem.auditionDate = self.auditionDate.
        
        
        self.auditionItem.completed = NO;
        
    }
    
}

//- (IBAction)testAudition:(id)sender {
//    
//    [_testAudition addTarget:self action:@selector(showPicker)forControlEvents:UIControlEventEditingDidBegin];
//    [self.view addSubview:_testAudition];
//    
//}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView.tag == 1){
        _testAudition.text = [_pickerData objectAtIndex:row];
    }
    if (pickerView.tag == 2){
        _testAudition2.text = [_pickerData2 objectAtIndex:row];
    }
    else{
        NSLog(@"In didSelect last else.");
    }
   
    
}




//-(void) showPicker{
//    //_auditionTypePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(44, 368, 288, 200)];
//
//    
//    _auditionTypePicker.delegate = self; // makes it visible on screen for some reason?
//    
//    NSLog(@"pickerData: %@", _pickerData);
//    
//    _auditionTypePicker.hidden = NO;
//    
//    // load the pickerview
//    [self.view addSubview:_auditionTypePicker];
//
//}

@end
