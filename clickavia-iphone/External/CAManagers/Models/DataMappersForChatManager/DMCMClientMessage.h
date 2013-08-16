//
//  DMCMClientMessage.h
//  CAManagersLib
//
//  Created by macmini1 on 11.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMCMClientMessage : NSObject
@property (strong,nonatomic) NSString *order_id;
@property (strong,nonatomic) NSString *text;
@property (strong,nonatomic) NSString *access_token;
@end
