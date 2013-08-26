//
//  SMLoginViewController.m
//  ClientMessaggistica1
//
//  Created by Marco Velluto on 25/08/13.
//  Copyright (c) 2013 Algos. All rights reserved.
//

#import "SMLoginViewController.h"

@interface SMLoginViewController ()

@end

@implementation SMLoginViewController

@synthesize loginField, passwordField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///************************************
#pragma mark - Action Methos
///************************************

- (IBAction)login {
    [[NSUserDefaults standardUserDefaults] setObject:self.loginField.text forKey:@"userID"];
    [[NSUserDefaults standardUserDefaults] setObject:self.passwordField forKey:@"userPassword"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)hideLogin {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
