//
//  ChatMessage.h
//  CAManagersLib
//
//  Created by macmini1 on 11.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatMessage : NSObject
@property BOOL isClient;
@property (strong,nonatomic) NSString *senderName;
@property (strong,nonatomic) NSString *text;
@property (strong,nonatomic) NSDate *dateAndTime;
@end
