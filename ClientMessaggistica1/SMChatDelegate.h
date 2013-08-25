//
//  SMChatDelegate.h
//  ClientMessaggistica1
//
//  Created by Marco Velluto on 25/08/13.
//  Copyright (c) 2013 Algos. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SMChatDelegate <NSObject>
- (void) newBuddyOnline:(NSString *)buddyName;
- (void) buddyWentOffline:(NSString *)buddyName;
- (void) didDisconnect;
@end
