//
//  AppDelegate.h
//  ClientMessaggistica1
//
//  Created by Marco Velluto on 24/08/13.
//  Copyright (c) 2013 Algos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPP.h"
#import "SMChatDelegate.h"
#import "SMMessageDelegate.h"

@class SMBuddyListViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    SMBuddyListViewController *viewController;
    XMPPStream *xmppStream;
    NSString *password;
    BOOL isOpen;
    
    NSObject <SMChatDelegate> *_chatDelegate;
    NSObject <SMMessageDelegate> *_messageDelegate;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SMBuddyListViewController *viewController;

@property (nonatomic, readonly) XMPPStream *xmppStream;

@property (nonatomic, assign)id chatDelegate;
@property (nonatomic, assign)id messageDelegate;


- (BOOL) connect;
- (void) disconnect;

@end
