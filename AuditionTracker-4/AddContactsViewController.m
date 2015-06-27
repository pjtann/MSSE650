//
//  AddContactsViewController.m
//  AuditionTracker-4
//
//  Created by PT on 6/22/15.
//  Copyright (c) 2015 msse650. All rights reserved.
//

#import "AddContactsViewController.h"
#import "AuditionSvcCoreData.h"
#import "AuditionSvc.h" 


@interface AddContactsViewController()<UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *contactName;
@property (weak, nonatomic) IBOutlet UITextField *contactPhone;
@property (weak, nonatomic) IBOutlet UITextField *contactEmail;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveContactButton;

// to keep original field values to restore if user leaves field blank
@property NSString *oldName;
@property NSString *oldPhone;
@property NSString *oldEmail;

@end


@implementation AddContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    _oldName = _contactName.text;
    _oldPhone = _contactPhone.text;
    _oldEmail = _contactEmail.text;
    
    //_contactPhone.keyboardType = UIKeyboardTypePhonePad;
    [_contactPhone setKeyboardType:UIKeyboardTypePhonePad];
  
    // call method '-(BOOL) textfield:...' to disable any editing other than through the pickerViews and datePicker
    self.contactName.delegate = self;
    self.contactPhone.delegate = self;
    self.contactEmail.delegate = self;

}


-(void) textFieldDidEndEditing:(UITextField *)textField{
    if (textField == _contactName) {
        if (![textField hasText]) {
            _contactName.text = _oldName;
            textField.textColor = [UIColor lightGrayColor];
            
        }
    }
    if (textField == _contactPhone) {
        if (![textField hasText]) {
            _contactPhone.text = _oldPhone;
            textField.textColor = [UIColor lightGrayColor];
            
        }
    }
    if (textField == _contactEmail) {
        if (![textField hasText]) {
            _contactEmail.text = _oldEmail;
            textField.textColor = [UIColor lightGrayColor];
            
        }
    }
}


// ADDED TO Validate some field entry - works with delegate statements in viewDidLoad above for each field
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField == _contactName)
    {
        NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz -'\n'"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
        textField.textColor = [UIColor darkTextColor];
        
        NSLog(@"\n \t filtered: %@", filtered);
        
        if (!([filtered isEqualToString:string])) // compare entry versus results of filtering above
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"OOOOOOPS!!" message:@"Invalid Character Entered \n Alphabetic Only \n May Include Spaces ' ' And Dashes '-'" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            _contactName.text = nil;
            
            [alertView show];
        }
        NSLog(@"Filtered value: '%@'", filtered);
        
        return [string isEqualToString:filtered];
    }
    
    // &*&*&*&& ADDED FROM HERE
    if (textField == _contactPhone) {
        NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
        //textField.textColor = [UIColor darkTextColor];
        if (!([filtered isEqualToString:string])) // compare entry versus results of filtering above
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"OOOOOOPS!!" message:@"Invalid Character Entered \n Numeric Only" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            _contactName.text = nil;
            
            [alertView show];
        NSLog(@"Filtered value: '%@'", filtered);
        
        return [string isEqualToString:filtered];
        }
       
        textField.textColor = [UIColor darkTextColor]; // change font to black
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        NSArray *components = [newString componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]];
        NSString *decimalString = [components componentsJoinedByString:@""];
        
        NSUInteger length = decimalString.length;
        BOOL hasLeadingOne = length > 0 && [decimalString characterAtIndex:0] == '1';
        
        //if (length == 0 || (length > 10 && !hasLeadingOne) || (length > 11)) {
        
        if (length > 10) {
            //textField.text = decimalString;
            NSLog(@"\n \t Value of length: %lu", (unsigned long)length);
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"OOOOOOPS!!" message:@"Limited to 10 Characters \n Numeric Only" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            //_contactPhone.text = nil;
            
            [alertView show];
            
            return NO;
        }

        
        NSUInteger index = 0;
        NSMutableString *formattedString = [NSMutableString string];
        
        if (hasLeadingOne) {
            [formattedString appendString:@"1 "];
            index += 1;
        }
        
        if (length - index > 3) {
            NSString *areaCode = [decimalString substringWithRange:NSMakeRange(index, 3)];
            [formattedString appendFormat:@"(%@) ",areaCode];
            index += 3;
        }
        
        if (length - index > 3) {
            NSString *prefix = [decimalString substringWithRange:NSMakeRange(index, 3)];
            [formattedString appendFormat:@"%@-",prefix];
            index += 3;
        }
        
        NSString *remainder = [decimalString substringFromIndex:index];
        [formattedString appendString:remainder];
        
        textField.text = formattedString;
        
        return NO;
    }
        // &*&** TO HERE
    if (textField == _contactEmail){
        textField.textColor = [UIColor darkTextColor]; // change font to black
        {
            NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@.ed -'\n'"] invertedSet];
            NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
            textField.textColor = [UIColor darkTextColor];
            //        // check to see if field empty
            //        if (textField == nil) {
            //            _auditionTitle = _oldAuditionTitle;
            //
            //        }
            
            NSLog(@"\n \t filtered: %@", filtered);
            
            if (!([filtered isEqualToString:string])) // compare entry versus results of filtering above
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"OOOOOOPS!!" message:@"Invalid Character Entered \n Alphabetic Only \n May Include Spaces ' ' And Dashes '-'" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                _contactEmail.text = nil;
                
                [alertView show];
            }
            NSLog(@"Filtered value: '%@'", filtered);
            
            return [string isEqualToString:filtered];
        }    }

    return NO;
}

// This method dismisses the pickers
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    
    if (sender != self.saveContactButton) {
        return YES;
    }else{
        
        if ((sender == self.saveContactButton) && ([identifier isEqualToString:@"segueFromAddContactSaveToContactList"])){
            
            NSLog(@"contactName.text value: %@", _contactName.text);
            
            if ((self.contactName.text.length > 0) && (![self.contactName.text isEqualToString: _oldName])){

                
                return YES;
            }else{
                //_contactName.text = _oldName;
                _contactName.text = nil; // clear field to return for entry
                [self.contactName becomeFirstResponder]; // send user back to Title field since they didn't enter anything
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"OOPS!!" message:@"Invalid Contact Name \n This Is A Mandatory Field \n Alphabetic Only \n May Include Spaces ' ' And Dashes '-'" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                [alertView show];
                //_contactName.text = _oldName;
                _contactName.textColor = [UIColor lightGrayColor];
                
                return NO;
            }
        }
    }
    return NO;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if (sender != self.saveContactButton) return;
    if (self.contactName.text.length > 0){
        
        [AuditionSvcCoreData newContextObjectWithContactName:_contactName.text andPhone:_contactPhone.text andEmail:_contactEmail.text];
        
        
        // set display fields in object from entry fields on scene
        self.contactItem.contactName = self.contactName.text;
        self.contactItem.contactPhone = self.contactPhone.text;
        self.contactItem.contactEmail = self.contactEmail.text;
      
        self.contactItem.contactCompleted = NO;
        
    }
    
}


@end
