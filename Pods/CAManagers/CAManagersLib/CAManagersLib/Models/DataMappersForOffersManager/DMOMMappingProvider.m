//
//  DMOMMappingProvider.m
//  CAManagersLib
//
//  Created by macmini1 on 04.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "DMOMMappingProvider.h"

@implementation DMOMMappingProvider
+ (EKObjectMapping*) orderMapping
{
    return [EKObjectMapping mappingForClass:[DMOMOrder class] withBlock:^(EKObjectMapping *mapping)
    {
        [mapping mapKey:@"id" toField:@"ID"];
        [mapping mapKey:@"status" toField:@"status"];
        [mapping mapKey:@"manager" toField:@"manager"];
        [mapping hasManyMapping:[self orderFlightMapping] forKey:@"flights" forField:@"flights"];
    }];
}
+ (EKObjectMapping*) orderFlightMapping
{
    return [EKObjectMapping mappingForClass:[DMOMFlight class] withBlock:^(EKObjectMapping *mapping)
            {
                [mapping mapKey:@"departure_date" toField:@"departure_date" withDateFormat:@"yyyy-MM-dd"];
                [mapping mapKey:@"arrival_date" toField:@"arrival_date" withDateFormat:@"yyyy-MM-dd"];
                [mapping mapKey:@"arrival_city" toField:@"arrival_city"];
                [mapping mapKey:@"departure_city" toField:@"departure_city"];
            }];
}
@end
