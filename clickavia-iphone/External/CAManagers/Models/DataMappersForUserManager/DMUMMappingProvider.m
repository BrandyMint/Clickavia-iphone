//
//  DMUMMappingProvider.m
//  CAManagersLib
//
//  Created by macmini1 on 01.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "DMUMMappingProvider.h"

@implementation DMUMMappingProvider
+ (EKObjectMapping*) countryCodeMapping
{
    return [EKObjectMapping mappingForClass:[CountryCodes class] withBlock:^(EKObjectMapping *mapping)
            {
                [mapping mapKey:@"id" toField:@"ID"];
                [mapping mapKey:@"title" toField:@"title"];
                [mapping mapKey:@"phone_code" toField:@"phoneCode"];
            }];
}
+ (EKObjectMapping*) registrationFormMapping
{
    return [EKObjectMapping mappingForClass:[RegistrationForm class] withBlock:^(EKObjectMapping *mapping)
    {
        [mapping mapKey:@"phone_number" toField:@"phoneNumber"];
        [mapping mapKey:@"email" toField:@"email"];
        [mapping mapKey:@"name" toField:@"name"];
        [mapping mapKey:@"password" toField:@"password"];
        [mapping mapKey:@"country_code" toField:@"countryCode"];
    }];
}
+ (EKObjectMapping*) registrationErrorMapping
{
    return  [EKObjectMapping mappingForClass:[DMRegistrationError class] withBlock:^(EKObjectMapping *mapping)
    {
        [mapping mapKey:@"email" toField:@"email"];
        [mapping mapKey:@"password" toField:@"password"];
        [mapping mapKey:@"name" toField:@"name"];
        [mapping mapKey:@"country_code" toField:@"country_code"];
        [mapping mapKey:@"phone_number" toField:@"phone_number"];
    }];
}
+ (EKObjectMapping*) registrationResponseMapping
{
    return [EKObjectMapping mappingForClass:[DMRegistrationResponse class] withBlock:^(EKObjectMapping *mapping)
    {
        [mapping mapKey:@"status" toField:@"status"];
        [mapping hasOneMapping:[self registrationErrorMapping] forKey:@"errors" forField:@"errors"];
    }];
}
@end
