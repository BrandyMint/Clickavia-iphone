//
//  RegistrationForm.h
//  CAManagersLib
//
//  Created by macmini1 on 28.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegistrationForm : NSObject
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *email;
@property (strong,nonatomic) NSString *phoneNumber;
@property (strong,nonatomic) NSString *countryCode;
@property (strong,nonatomic) NSString *password;
@end
