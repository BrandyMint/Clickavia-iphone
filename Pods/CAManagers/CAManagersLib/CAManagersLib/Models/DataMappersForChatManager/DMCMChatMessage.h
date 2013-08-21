//
//  DMCMChatMessage.h
//  CAManagersLib
//
//  Created by macmini1 on 11.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMCMChatMessage : NSObject
@property (strong,nonatomic) NSString *type;
@property (strong,nonatomic) NSString *user;
@property (strong,nonatomic) NSString *text;
@property (strong,nonatomic) NSDate *datetime;
@end
