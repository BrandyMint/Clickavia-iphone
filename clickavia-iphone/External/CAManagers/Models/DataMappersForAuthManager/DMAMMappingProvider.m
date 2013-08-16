//
//  DMAMMappingProvider.m
//  CAManagersLib
//
//  Created by macmini1 on 23.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "DMAMMappingProvider.h"

@implementation DMAMMappingProvider

+ (EKObjectMapping*) userMapping
{
    return [EKObjectMapping mappingForClass:[User class] withBlock:^(EKObjectMapping *mapping)
            {
                [mapping mapKey:@"name" toField:@"name"];
                [mapping mapKey:@"email" toField:@"email"];
                [mapping mapKey:@"access_token" toField:@"authKey"];
                [mapping mapKey:@"phone_number" toField:@"phoneNumber"];
            }];
}
+ (EKObjectMapping*) authMapping
{
    return [EKObjectMapping mappingForClass:[LoginForm class] withBlock:^(EKObjectMapping *mapping)
            {
                [mapping mapKey:@"password" toField:@"password"];
                [mapping mapKey:@"email" toField:@"email"];
            }];
}
@end
