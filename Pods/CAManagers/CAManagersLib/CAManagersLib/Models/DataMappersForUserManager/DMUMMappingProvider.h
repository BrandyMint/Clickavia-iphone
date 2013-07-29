//
//  DMUMMappingProvider.h
//  CAManagersLib
//
//  Created by macmini1 on 01.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EasyMapping/EasyMapping.h>
#import "CountryCodes.h"
#import "RegistrationForm.h"
#import "DMRegistrationError.h"
#import "DMRegistrationResponse.h"

@interface DMUMMappingProvider : NSObject
+ (EKObjectMapping*) countryCodeMapping;
+ (EKObjectMapping*) registrationFormMapping;
+ (EKObjectMapping*) registrationErrorMapping;
+ (EKObjectMapping*) registrationResponseMapping;
@end
