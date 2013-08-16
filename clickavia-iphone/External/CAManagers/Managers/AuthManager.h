//
//  AuthManager.h
//  CAManagersLib
//
//  Created by macmini1 on 23.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LRResty/LRResty.h>
#import <EasyMapping/EasyMapping.h>
#import "LoginForm.h"
#import "User.h"
#import "DMAMMappingProvider.h"
#import "Routes.h"
@interface AuthManager : NSObject
- (void) getUser:(LoginForm *) withLoginForm completeBlock:(void (^) (User *user)) block  failBlock:(void (^) (NSException *exception)) blockException;
@end
