//
//  DMRegistrationResponse.h
//  CAManagersLib
//
//  Created by macmini1 on 01.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMRegistrationError.h"

@interface DMRegistrationResponse : NSObject
@property BOOL status;
@property (strong,nonatomic) DMRegistrationError *errors;
@end
