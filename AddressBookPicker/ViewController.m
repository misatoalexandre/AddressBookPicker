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
    //Display number of contacts in the address book.
    NSString *countMessage=[NSString stringWithFormat:@" %d contacts in the address book.", [self ContactsCount]];
    
    self.contactCountLabel.text=countMessage;
     
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
    [self messageString:[NSString stringWithFormat:@"%@\n", [self getPersonNameDisplay:person]]];
    [self scrollToEnd];
    [self messageString:[NSString stringWithFormat:@"%@\n",[self getPhoneDisplay:person]]];
}

#pragma mark-Address Book Display
-(int)ContactsCount{
    NSError *error=nil;
    //Core foundation is written in C++. Typedef.
    ABAddressBookRef addressBook=ABAddressBookCreateWithOptions(NULL, (CFErrorRef *)(void *)&error);
   //CFIndex is TypeDef signed long.
    CFIndex nPeople=ABAddressBookGetPersonCount(addressBook);
    
    //Since you created an object with ABAddressBookCreateWithOprions, you need to CFRelease it in order to avoid memory leak.
    CFRelease(addressBook);

    return (int)nPeople;
}
-(NSString *)getPersonNameDisplay:(ABRecordRef)person{
    //init empty string and array.
    NSMutableString *personName=[[NSMutableString alloc]initWithString:@""];
    NSMutableArray *partsOfName=[NSMutableArray arrayWithCapacity:0];
    
    //c++ cast.__brindge_transfer transfers C++ non ARC managed string to NSString ARC managed object.
    NSString *orgName=(__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonOrganizationProperty);
    
    //declaring C array.
    const int k[]={kABPersonPrefixProperty, kABPersonFirstNameProperty, kABPersonMiddleNameProperty, kABPersonLastNameProperty, kABPersonSuffixProperty, -1};
    //declaring c loop that checks each ABproperty in k[].
    for (int i=0; k[i]>=0; ++i) {
        NSString *s=(__bridge_transfer NSString *)ABRecordCopyValue(person, k[i]);
        if (s) [partsOfName addObject:s];
    }
    [personName appendString:[partsOfName componentsJoinedByString:@""]];
    if (orgName) {
        if ([personName length]) [personName appendString:@","];
        [personName appendString:orgName];
    }
    return personName;
}
-(NSString *)getPhoneDisplay:(ABRecordRef)person{
    NSString *phoneStr=@"[none]";
    NSMutableArray *phoneNumbersArray=[NSMutableArray arrayWithCapacity:0];
    
    //multi value property
    ABMultiValueRef phoneNumbers=ABRecordCopyValue(person, kABPersonPhoneProperty);
  
    int phoneCount=ABMultiValueGetCount(phoneNumbers);
    
    for (int i=0; i<phoneCount; ++i) {
        NSString *phone=(__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(phoneNumbers, i);
        [phoneNumbersArray addObject:phone];
    }
    if (phoneNumbersArray.count) {
        phoneStr=[NSString stringWithFormat:@"%d phone number %@:%@", phoneCount, phoneCount>1 ? @"s":@"",[phoneNumbersArray componentsJoinedByString:@","]];
        
    }
    CFRelease(phoneNumbers);
    return phoneStr;
}
#pragma mark-Address Book Display
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
