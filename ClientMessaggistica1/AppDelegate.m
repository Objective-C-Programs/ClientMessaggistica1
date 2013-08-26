//
//  AppDelegate.m
//  ClientMessaggistica1
//
//  Created by Marco Velluto on 24/08/13.
//  Copyright (c) 2013 Algos. All rights reserved.
//

#import "AppDelegate.h"

NSString * const USER_ID = @"userID";
NSString * const USER_PASSWORD = @"userPassword";

@interface AppDelegate ()

- (void) setupStream;
- (void) goOnline;
- (void) goOffline;
@end

@implementation AppDelegate

@synthesize window, xmppStream, viewController;
@synthesize chatDelegate, messageDelegate;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [self disconnect];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self connect];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

///***************************************************************
#pragma mark - XMPP
///***************************************************************

- (void) setupStream {
    xmppStream = [[XMPPStream alloc] init];
   [xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
}

- (void) goOnline {
    XMPPPresence *presence = [XMPPPresence presence];
    [[self xmppStream] sendElement:presence];
}

- (void) goOffline {
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
    [[self xmppStream] sendElement:presence];
}

/**
 Dice se la connessione ha avuto successo oppure no.
 */
- (BOOL) connect {
    [self setupStream];
    NSString *jabberID = [[NSUserDefaults standardUserDefaults] stringForKey:USER_ID];
    NSString *myPassword = [[NSUserDefaults standardUserDefaults] stringForKey:USER_PASSWORD];
    if (![xmppStream isDisconnected]) {
        return YES;
    }
    if (jabberID == nil || myPassword == nil) {
        return NO;
    }
    [xmppStream setMyJID:[XMPPJID jidWithString:jabberID]];
    password = myPassword;
    NSError *error = nil;
    if (![xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error])
    {UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error connecting"
                                                         message:@"See console for error details."
                                                        delegate:nil
                                               cancelButtonTitle:@"Ok"
                                               otherButtonTitles:nil];
        [alertView show];
        NSLog(@"Error connecting: %@", error);
        return NO;
    }
    return YES;
}

- (void) disconnect {
    [self goOffline];
    [xmppStream disconnect];
}

/**
 Connection to the server successful.
 */
- (void) xmppStreamDidConnect:(XMPPStream *)sender {
    isOpen = YES;
    NSError *error = nil;
    [[self xmppStream] authenticateWithPassword:password error:&error];
}

/**
 Authentication successful.
 */
- (void) xmppStreamDidAuthenticate:(XMPPStream *)sender {
    [self goOnline];
}

/**
 Message Receive
 */
- (void) xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message {
    NSString *msg = [[message elementForName:@"body"] stringValue];
    NSString *from = [[message attributeForName:@"from"] stringValue];
    NSMutableDictionary *m = [[NSMutableDictionary alloc] init];
    [m setObject:msg forKey:@"msg"];
    [m setObject:from forKey:@"sender"];
    [messageDelegate newMesssageReceived:m];
}

/**
 A buddy went offline/online
 */
- (void) xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence {
    NSString *presenceType = [presence type]; //online / offline.
    NSString *myUsername = [[sender myJID] user];
    NSString *presenceFromUser = [[presence from] user];
    if (![presenceFromUser isEqualToString:myUsername]) {
        if ([presenceType isEqualToString:@"available"]) {
            [chatDelegate newBuddyOnline:[NSString stringWithFormat:@"%@@%@", presenceFromUser, @"jerry.local"]];
        } else if ([presenceType isEqualToString:@"unavailable"]) {
            [chatDelegate buddyWentOffline:[NSString stringWithFormat:@"%@@%@", presenceFromUser, @"jerry.local"]];
        }
    }
}
@end
