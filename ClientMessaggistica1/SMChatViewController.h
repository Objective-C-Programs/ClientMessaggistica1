//
//  SMChatViewController.h
//  ClientMessaggistica1
//
//  Created by Marco Velluto on 26/08/13.
//  Copyright (c) 2013 Algos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMChatViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    UITextField *messageField;
    NSString *chatWithUser;
    UITableView *tView;
    NSMutableArray *messages;
}

@property (nonatomic, retain) IBOutlet UITextField *messageField;
@property (nonatomic, retain) IBOutlet UITableView *tView;
@property (nonatomic, retain) NSString *chatWithUser;

- (id) initWithUser:(NSString *)userName;
- (IBAction)sendMessage;
- (IBAction)closeChat;

@end
