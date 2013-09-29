//
//  ViewController.m
//  AddressBookPicker
//
//  Created by Misato Tina Alexandre on 9/29/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initTextView];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonGet:(id)sender {
    ABPeoplePickerNavigationController  *picker=[[ABPeoplePickerNavigationController alloc]init];
    picker.peoplePickerDelegate=self;
    [self presentViewController:picker animated:YES completion:nil];
   
    /*
     //Replacing this block of code with new set so it displayes a person contact.
     static int count=0;
    [self messageString:[NSString stringWithFormat:@"Button pressed (%d)\n", ++count]];
    [self scrollToEnd];*/
}
//Remove Keyboard when tapped uiview.
- (IBAction)bkgdTap:(id)sender {
    [self.textView resignFirstResponder];
}

-(void)initTextView{
    self.textView.font=[UIFont fontWithName:@"Courier" size:12];
}

-(void)messageString:(NSString *)messageString{
    self.textView.text=[self.textView.text stringByAppendingString:messageString];
}
-(void)clearMessageString{
    self.textView.text=@"";
}
-(void)scrollToEnd{
    [self.textView scrollRangeToVisible:NSMakeRange(self.textView.text.length, 0)];
    
}
-(void)displayPerson:(ABRecordRef)person{
    [self messageString:@"displayPerson\n"];
    [self scrollToEnd];
}

#pragma mark-Address Book Display
-(int)ContactsCount{
    return 1;
}

//3 required methods.
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    
    return NO;
}
    

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person{
    [self displayPerson:person];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    return NO;
}
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

    









@end
