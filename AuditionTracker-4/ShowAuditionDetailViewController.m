//
//  ShowAuditionDetailViewController.m
//  AuditionTracker-4
//
//  Created by PT on 5/29/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "ShowAuditionDetailViewController.h"
#import "AuditionListTableViewController.h"
#import "AuditionSvc.h"
//#import "AuditionSvcSQLite.h"
#import "AuditionSvcCoreData.h"
#import <UIKIT/UIKIT.h>



@interface ShowAuditionDetailViewController () <UIPickerViewDataSource, UIPickerViewDelegate> // ADDED for use of pickerviews
@property (weak, nonatomic) IBOutlet UITextField *auditionTitle;
@property (weak, nonatomic) IBOutlet UITextField *auditionType;
@property (weak, nonatomic) IBOutlet UITextField *auditionContact;
@property (weak, nonatomic) IBOutlet UITextField *auditionDate;
@property (weak, nonatomic) IBOutlet UITextField *auditionTime;
@property (weak, nonatomic) IBOutlet UITextField *auditionLocation;
@property (weak, nonatomic) IBOutlet UITextField *auditionStatus;
@property (weak, nonatomic) IBOutlet UITextField *auditionCost;

// to keep original field values to restore if user leaves field blank
@property NSString *oldTitle;
@property NSString *oldContact;

@property (weak, nonatomic) NSString *pv1String;
@property (weak, nonatomic) NSString *pv2String;
@property NSMutableArray *pickerView1Array;
@property NSMutableArray *pickerView2Array;
@property (nonatomic, retain) IBOutlet UIPickerView *pickerView1;
@property (nonatomic, retain) IBOutlet UIPickerView *pickerView2;
@property (nonatomic, retain) NSArray *pickerData1;
@property (nonatomic, retain) NSArray *pickerData2;
@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker1;


//@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveEditBarButton;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *updateAuditionButton;

@end

@implementation ShowAuditionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // call method 'displayAuditionData' below to place data into the scene fields - instead of setting the values here in the viewDidLoad method
    [self displayAuditionData];
    
    // disable fields not yet used
    self.auditionTime.userInteractionEnabled = NO;
    self.auditionLocation.userInteractionEnabled = NO;
    self.auditionStatus.userInteractionEnabled = NO;
    self.auditionCost.userInteractionEnabled = NO;
    
    _oldTitle = _auditionTitle.text;
    _oldContact = _auditionContact.text;
    
    
    NSMutableArray *pickerView1Array = [[NSMutableArray alloc] init];
    NSMutableArray *pickerView2Array = [[NSMutableArray alloc] init];
    
    for (int pv1Index =0; pv1Index<[[AuditionSvcCoreData retrieveAllCategories]count]; pv1Index++){
        AuditionCategory *category = [[AuditionSvcCoreData retrieveAllCategories] objectAtIndex:pv1Index];
        _pv1String = category.auditionCategory;
        [pickerView1Array addObject:_pv1String];
    }
    
    for (int pv2Index =0; pv2Index<[[AuditionSvcCoreData retrieveAllContacts]count]; pv2Index++){
        Contacts *contact = [[AuditionSvcCoreData retrieveAllContacts] objectAtIndex:pv2Index];
        _pv2String = contact.contactName;
        [pickerView2Array addObject:_pv2String];
    }
    _pickerData1 = pickerView1Array;
    _pickerData2  = pickerView2Array;
    
    UIPickerView *pickerView1 = [[UIPickerView alloc] init]; // picker for auditionType field
    pickerView1.delegate = self;
    pickerView1.dataSource = self;
    pickerView1.showsSelectionIndicator = YES;
    _auditionType.inputView = pickerView1;
    pickerView1.tag = 1;
    
    UIPickerView *pickerView2 = [[UIPickerView alloc] init]; // picker for auditionContact field
    pickerView2.delegate = self;
    pickerView2.dataSource = self;
    pickerView2.showsSelectionIndicator = YES;
    _auditionContact.inputView = pickerView2;
    pickerView2.tag = 2;
    
    UIDatePicker *datePicker1 = [[UIDatePicker alloc] init]; // picker for auditionDate field
    [datePicker1 setDate:[NSDate date]];
    datePicker1.datePickerMode = UIDatePickerModeDate;
    [datePicker1 addTarget:self action:@selector(dateTextField:) forControlEvents:UIControlEventValueChanged];
    [_auditionDate setInputView:datePicker1]; // NOT NEEDED??, same as below in 102?
    _auditionDate.inputView = datePicker1; //?? same as above in 98?
    datePicker1.tag = 3;
    
    // initalize a toolbar for the pickerViews and datePicker
    UIToolbar *toolBar= [[UIToolbar alloc] init];
    // call method to establish toolbar for pickers
    [pickerView1 addSubview:[self setPickerToolBar:toolBar]];
    [pickerView2 addSubview:[self setPickerToolBar:toolBar]];
    [datePicker1 addSubview:[self setPickerToolBar:toolBar]];
    
    // call method '-(BOOL) textfield:...' to disable any editing other than through the pickerViews and datePicker
    self.auditionType.delegate = self;
    self.auditionContact.delegate = self;
    self.auditionDate.delegate = self;
    self.auditionTitle.delegate = self;
    
}

-(void) textFieldDidBeginEditing:(UITextField *)textField{
    if ([textField.inputView isKindOfClass:[UIPickerView class]]){
        if (textField == _auditionType) {
            if ([textField.text isEqualToString:@""]) {
                textField.text = _pickerData1[0]; // set to first field with the [0]
            }
        }
        if (textField == _auditionContact) {
            if ([textField.text isEqualToString:@""]) {
                textField.text = _pickerData2[0]; // set to first field with the [0]
                
            }
        }
    }
    if ([textField.inputView isKindOfClass:[UIDatePicker class]]){
        if (textField == _auditionDate) {
            if([textField.text isEqualToString:@""]){
                NSString *currentDate;
                currentDate = [self getCurrentDate:currentDate];
                NSLog(@"myDate in line 155:%@", currentDate);
                
                textField.text = currentDate;
                //textField.text = @"06-24-2015";
                _auditionDate.textColor = [UIColor darkTextColor];
            }
        }
    }
    
}

-(NSString *) getCurrentDate: (NSString *)currentDate{
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"MM/dd/yyyy"];
    //NSString *currentDate = [DateFormatter stringFromDate:[NSDate date]];
    currentDate = [DateFormatter stringFromDate:[NSDate date]];
    NSLog(@"%@",[DateFormatter stringFromDate:[NSDate date]]);
    NSLog(@"\n \n \t Value of currentDate: %@", currentDate);
    
    return currentDate;
    
}

-(void) textFieldDidEndEditing:(UITextField *)textField{
    if (textField == _auditionTitle) {
        if (![textField hasText]) {
            _auditionTitle.text = _oldTitle;
            textField.textColor = [UIColor lightGrayColor];
            
        }
    }
    if (textField == _auditionContact) {
        if (![textField hasText]) {
            _auditionContact.text = _oldContact;
            textField.textColor = [UIColor lightGrayColor];
            
        }
    }
}


// ADDED TO TEST WITH DISABLING EDITING FOR THE PICKER AND DATE PICKER VIEWS - works with delegate statements in viewDidLoad above for each field
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField == _auditionTitle)
    {
        NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz -"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
        textField.textColor = [UIColor darkTextColor];
        if (!([filtered isEqualToString:string])) // compare entry versus results of filtering above
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"OOOOOOPS!!" message:@"Invalid Character Entered \n Alphabetic Only \n May Include Spaces ' ' And Dashes '-'" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            _auditionTitle.text = nil;
            
            [alertView show];
        }
        
        return [string isEqualToString:filtered];
    }
    else{
        if (textField == nil) {
            
            textField.textColor = [UIColor lightGrayColor];
        }
    }
    //return YES;
    
    
    return NO;
}

-(void)changeDateFromLabel:(id)sender
{
    [_pickerView1 resignFirstResponder];
}

-(UIToolbar *)setPickerToolBar: (id)sender{
    
    UIToolbar *toolBar= [[UIToolbar alloc] init];
    UIToolbarPositionTop; // places toolbar at top of pickerview
    [toolBar setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                      style:UIBarButtonItemStylePlain target:self action:@selector(changeDateFromLabel:)];
    toolBar.items = @[barButtonDone];
    barButtonDone.tintColor=[UIColor blackColor];
    
    
    return toolBar;
}

// columns in the pickerview
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (pickerView.tag == 1){
        return 1;
    }
    if (pickerView.tag == 2){
        return 1;
    }
    else{
        return 0;
    }
    
}

// rows in each column in the pickerview
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView.tag == 1){
        return [[AuditionSvcCoreData retrieveAllCategories]count]; // get and return count of records/objects in categories table
    }
    if (pickerView.tag == 2){
        return [[AuditionSvcCoreData retrieveAllContacts]count]; // get and return count of records/objects in contacts table
    }
    else{
        return 0;
    }
    
}

//display the row from the datasource in the pickerview
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView.tag == 1){
        _auditionType.textColor = [UIColor darkTextColor]; // set text color to black
        return [_pickerData1 objectAtIndex:row];
    }
    if (pickerView.tag == 2){
        _auditionContact.textColor = [UIColor darkTextColor]; // set text color to black
        return [_pickerData2 objectAtIndex:row];
    }
    else{
        return 0;
    }
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView.tag == 1){
        _auditionType.text = [_pickerData1 objectAtIndex:row];
    }
    if (pickerView.tag == 2){
        _auditionContact.text = [_pickerData2 objectAtIndex:row];
    }
    else{
        NSLog(@"In didSelect last else.");
    }
    
}

-(void) dateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)_auditionDate.inputView;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = picker.date;
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    _auditionDate.text = [NSString stringWithFormat:@"%@",dateString];
    _auditionDate.textColor = [UIColor darkTextColor]; // set text color to black
}

// This method dismisses the pickers
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    
    if (sender != self.updateAuditionButton) {
        return YES;
    }else{
        
        if ((sender == self.updateAuditionButton) && ([identifier isEqualToString:@"segueFromShowSaveToList"])){
            
            if ((self.auditionTitle.text.length > 0) && (![self.auditionTitle.text isEqualToString: _oldTitle])){
                NSLog(@"\n \t Value of auditionTitle.text: '%@'", _auditionTitle.text);
                NSLog(@"\n \t Value of oldTitle: '%@'", _oldTitle);
                
                return YES;
            }else{
                //_auditionTitle.text = _oldTitle;
                _auditionTitle.text = nil; // clear field to return for entry
                [self.auditionTitle becomeFirstResponder]; // send user back to Title field since they didn't enter anything
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"OOPS!!" message:@"Invalid Entry In Mandatory Field \n Please Re-Enter Audition Title \n Alphabetic Only \n May Include Spaces ' ' And Dashes '-'" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                [alertView show];
                
                return NO;
            }
        }
    }
    return NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// method to display data from row selected by user of table from AuditionListTableViewController
-(void)displayAuditionData{
    
    // set the display field values
    
    self.auditionTitle.text = _auditionDetailTitle;
    self.auditionType.text = _auditionDetailType;
    self.auditionContact.text = _auditionDetailContact;
    self.auditionDate.text = _auditionDetailDate;

    // turn off editing of the display fields not yet used
//    self.auditionTime.userInteractionEnabled = NO;
//    self.auditionLocation.userInteractionEnabled = NO;
//    self.auditionStatus.userInteractionEnabled = NO;
//    self.auditionCost.userInteractionEnabled = NO;
    
}

- (IBAction)updateAuditionButton:(id)sender {
    
    [self updateAuditonData];
    
    //[self performSegueWithIdentifier:@"segueFromUpdateToList" sender:self];
    
}

-(void)updateAuditonData{
       [AuditionSvcCoreData updateAudition:_auditionDetailId andOldTitle:_auditionDetailTitle andOldType: _auditionDetailType andOldContact:_auditionDetailContact andOldDate: _auditionDetailDate andNewTitle:_auditionTitle.text andNewType:_auditionType.text andNewContact:_auditionContact.text andNewDate:_auditionDate.text];
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    if (sender == self.updateAuditionButton){
        
        [self updateAuditonData];
        
    }

}

@end
