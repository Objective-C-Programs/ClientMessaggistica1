//
//  SMChatViewController.m
//  ClientMessaggistica1
//
//  Created by Marco Velluto on 26/08/13.
//  Copyright (c) 2013 Algos. All rights reserved.
//

#import "SMChatViewController.h"
#import "AppDelegate.h"

@interface SMChatViewController ()

@end

@implementation SMChatViewController

@synthesize messageField, chatWithUser, tView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithUser:(NSString *)userName {
    if (self == [super init]) {
        chatWithUser = userName;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tView.delegate = self;
    self.tView.dataSource = self;
    messages = [[NSMutableArray alloc] init];
    [self.messageField becomeFirstResponder];
    
    AppDelegate *del = [self appDelegate];
    del.messageDelegate = self;
    [self.messageField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///****************************************
#pragma mark - Actions
///****************************************

- (IBAction)closeChat {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendMessage {
    NSString *messageStr = self.messageField.text;
    if ([messageStr length] > 0) {
        NSXMLElement *body = [NSXMLElement elementWithName:@"body"];
        [body setStringValue:messageStr];
        NSXMLElement *message = [NSXMLElement elementWithName:@"message"];
        [message addAttributeWithName:@"type" stringValue:@"chat"];
        [message addAttributeWithName:@"to" stringValue:chatWithUser];
        [message addChild:body];
        
        [self.xmppStream sendElement:message];
        self.messageField.text = @"";
        NSMutableDictionary *m = [[NSMutableDictionary alloc] init];
        [m setObject:messageStr forKey:@"msg"];
        [m setObject:@"you" forKey:@"sender"];
        [messages addObject:m];
        [self.tView reloadData];
    }
}

///****************************************
#pragma mark - Chat Protocol
///****************************************


///****************************************
#pragma mark - Table View Delegate
///****************************************

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *s = (NSDictionary *) [messages objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"MessageCellIdenfier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.textLabel.text = [s objectForKey:@"msg"];
    cell.detailTextLabel.text = [s objectForKey:@"sender"];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.userInteractionEnabled = NO;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [messages count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

///****************************************
#pragma mark - MXMPP
///****************************************

- (AppDelegate *)appDelegate {
    return (AppDelegate *) [[UIApplication sharedApplication] delegate];
}

- (XMPPStream *)xmppStream {
    return [[self appDelegate] xmppStream];
}



@end
