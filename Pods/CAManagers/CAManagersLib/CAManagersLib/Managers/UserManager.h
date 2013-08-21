//
//  UserManager.h
//  CAManagersLib
//
//  Created by macmini1 on 28.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginForm.h"
#import "User.h"
#import "RegistrationForm.h"
#import "CountryCodes.h"
#import "DMUMMappingProvider.h"
#import <LRResty/LRResty.h>
#import "Routes.h"
#import <Base64/MF_Base64Additions.h>


@interface UserManager : NSObject
- (void) getUser:(LoginForm *) withLoginForm completeBlock:(void (^) (User *user)) block  failBlock:(void (^) (NSException *exception)) blockException;
- (void) registrateUser:(RegistrationForm *) withRegistrationForm completeBlock:(void (^) (User *user)) block failBlock:(void (^) (NSException *exception)) blockException;
- (void) getCountryCodes:(void (^) (NSArray *codes))block;
@end
