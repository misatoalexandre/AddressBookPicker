//
//  ViewController.h
//  AddressBookPicker
//
//  Created by Misato Tina Alexandre on 9/29/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
//When using AddressBookUI, this AddressBook.h is automatically being imported,so technically, it doesn't need to be here.) For clarity, I'll leave it here for now.
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
@interface ViewController : UIViewController<ABPeoplePickerNavigationControllerDelegate>




@property (weak, nonatomic) IBOutlet UITextView *textView;

- (IBAction)buttonGet:(id)sender;
//hide the keyboard when background is tapped.
- (IBAction)bkgdTap:(id)sender;

@end
