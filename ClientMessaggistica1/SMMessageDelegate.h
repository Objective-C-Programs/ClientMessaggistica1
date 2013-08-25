//
//  SMMessageDelegate.h
//  ClientMessaggistica1
//
//  Created by Marco Velluto on 25/08/13.
//  Copyright (c) 2013 Algos. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SMMessageDelegate <NSObject>
- (void) newMesssageReceived:(NSDictionary *)messageContent;
@end
