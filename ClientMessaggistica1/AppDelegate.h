//
//  AppDelegate.h
//  ClientMessaggistica1
//
//  Created by Marco Velluto on 24/08/13.
//  Copyright (c) 2013 Algos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPP.h"

@class SMBuddyListViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    SMBuddyListViewController *viewController;
    XMPPStream *xmppStream;
    NSString *password;
    BOOL isOpen;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SMBuddyListViewController *viewController;
@property (nonatomic, readonly) XMPPStream *xmppStream;

- (BOOL) connect;
- (void) disconnect;

@end
