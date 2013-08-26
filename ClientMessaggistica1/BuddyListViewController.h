//
//  BuddyListViewController.h
//  ClientMessaggistica1
//
//  Created by Marco Velluto on 25/08/13.
//  Copyright (c) 2013 Algos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuddyListViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource> {
    UITableView *tView;
    NSMutableArray *onlineBuddies; 
}

@property (nonatomic, retain) IBOutlet UITableView *tView;

//- (IBAction)showLogin;

- (IBAction)showLogin;
@end
