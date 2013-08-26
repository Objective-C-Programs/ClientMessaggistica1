//
//  BuddyListViewController.m
//  ClientMessaggistica1
//
//  Created by Marco Velluto on 25/08/13.
//  Copyright (c) 2013 Algos. All rights reserved.
//
// Questa vista contiene la lista dei contatti online.

#import "BuddyListViewController.h"
#import "XMPP.h"
#import "XMPPRoster.h"
#import "SMChatViewController.h"
@interface BuddyListViewController ()

@end

@implementation BuddyListViewController

@synthesize tView;

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tView.delegate = self;
	self.tView.dataSource = self;
	AppDelegate *del = [self appDelegate];
	del.chatDelegate = self;
	onlineBuddies = [[NSMutableArray alloc ] init];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    NSString *login = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
	if (login) {
		if ([[self appDelegate] connect]) {
			NSLog(@"show buddy list");
		}
	} else {
        [self showLogin];
	}
}
///*********************************************
#pragma mark - Table view delegate
///*********************************************

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [onlineBuddies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *s = (NSString *) [onlineBuddies objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"UserCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = s;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *userName = (NSString *) [onlineBuddies objectAtIndex:indexPath.row];
	SMChatViewController *chatController = [[SMChatViewController alloc] initWithUser:userName];
    [self presentViewController:chatController animated:YES completion:nil];
}

///*********************************************
#pragma mark - Action Methods
///*********************************************

- (void)showLogin {
    SMLoginViewController *loginController = [[SMLoginViewController alloc] init];
    [self presentViewController:loginController animated:YES completion:NULL];
}


///*********************************************
#pragma mark - Action Methods
///*********************************************


- (AppDelegate *)appDelegate {
	return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (XMPPStream *)xmppStream {
	return [[self appDelegate] xmppStream];
}

- (XMPPRoster *)xmppRoster {

}

///*********************************************
#pragma mark - Chat Delegate
///*********************************************

- (void)newBuddyOnline:(NSString *)buddyName {
    [onlineBuddies addObject:buddyName];
    [self.tView reloadData];
}

- (void)buddyWentOffline:(NSString *)buddyName {
    [onlineBuddies removeObject:buddyName];
    [self.tView reloadData];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/



@end
