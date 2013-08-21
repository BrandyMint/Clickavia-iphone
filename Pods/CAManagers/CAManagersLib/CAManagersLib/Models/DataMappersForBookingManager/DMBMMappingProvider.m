//
//  DMBMMappingProvider.m
//  CAManagersLib
//
//  Created by macmini1 on 05.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "DMBMMappingProvider.h"

@implementation DMBMMappingProvider
+ (EKObjectMapping*) personMapping
{
    return [EKObjectMapping mappingForClass:[DMBMPerson class] withBlock:^(EKObjectMapping *mapping)
            {
                [mapping mapKey:@"title" toField:@"title"];
                [mapping mapKey:@"second_name" toField:@"second_name"];
                [mapping mapKey:@"first_name" toField:@"first_name"];
                [mapping mapKey:@"birthday" toField:@"birthday"];
                [mapping mapKey:@"series" toField:@"series"];
                [mapping mapKey:@"number" toField:@"number"];
                [mapping mapKey:@"expiration" toField:@"expiration"];
            }];
}
+ (EKObjectMapping*) orderMapping
{
    return [EKObjectMapping mappingForClass:[DMBMOrder class] withBlock:^(EKObjectMapping *mapping)
            {
                [mapping mapKey:@"departure_flight_id" toField:@"departure_flight_id"];
                [mapping mapKey:@"return_flight_id" toField:@"return_flight_id"];
                [mapping mapKey:@"adults" toField:@"adults"];
                [mapping mapKey:@"children" toField:@"children"];
                [mapping mapKey:@"infants" toField:@"infants"];
                [mapping mapKey:@"payment_type_id" toField:@"payment_type_id"];
                [mapping hasManyMapping:[DMBMMappingProvider personMapping] forKey:@"passports" forField:@"passports"];
            }];
}
+ (EKObjectMapping*) responseMapping
{
    return [EKObjectMapping mappingForClass:[DMBMResponse class] withBlock:^(EKObjectMapping *mapping)
            {
                [mapping mapKey:@"id" toField:@"ID"];
                [mapping mapKey:@"state" toField:@"state"];
            }];
}
@end
