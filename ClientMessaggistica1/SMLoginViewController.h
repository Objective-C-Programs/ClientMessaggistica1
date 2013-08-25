//
//  SMLoginViewController.h
//  ClientMessaggistica1
//
//  Created by Marco Velluto on 25/08/13.
//  Copyright (c) 2013 Algos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMLoginViewController : UIViewController {
    UITextField *loginField;
    UITextField *passwordField;
    UIView *aView;
}

@property (nonatomic, retain) IBOutlet UITextField *loginField;
@property (nonatomic, retain) IBOutlet UITextField *passwordField;
@property (nonatomic, retain) IBOutlet UIView *aView;

- (IBAction)login;
- (IBAction)hideLogin;

@end
