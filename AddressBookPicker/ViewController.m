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
    static int count=0;
    [self messageString:[NSString stringWithFormat:@"Button pressed (%d)\n", ++count]];
    //[self scrollToEnd];
}

-(void)initTextView{
    self.textView.font=[UIFont fontWithName:@"Courier" size:12];
}

-(void)messageString:(NSString *)messageString{
    self.textView.text=[self.textView.text stringByAppendingString:messageString];
}
@end
