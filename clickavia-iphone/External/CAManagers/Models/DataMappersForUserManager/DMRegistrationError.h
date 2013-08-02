//
//  DMRegistrationError.h
//  CAManagersLib
//
//  Created by macmini1 on 01.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMRegistrationError : NSObject
@property (strong,nonatomic) NSArray *email;
@property (strong,nonatomic) NSArray *password;
@property (strong,nonatomic) NSArray *name;
@property (strong,nonatomic) NSArray *country_code;
@property (strong,nonatomic) NSArray *phone_number;
-(BOOL) isError;
-(NSString*) errorMessage;
@end
