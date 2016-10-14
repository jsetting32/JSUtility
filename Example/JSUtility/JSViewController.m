//
//  JSViewController.m
//  JSUtility
//
//  Created by John Setting on 10/11/2016.
//  Copyright (c) 2016 John Setting. All rights reserved.
//

#import "JSViewController.h"
#import <JSUtility/JSUtility.h>

@interface JSViewController ()
@property (weak, nonatomic) IBOutlet JSTextFieldCardNumber *textField;
@end

@implementation JSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    [self.textField setCardNumberText:@"4111111111111111"];
//    [self.textField setShowCardImage:NO];
//    [self.textField setErrorType:kJSTextFieldCardNumberErrorTypeNever];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
