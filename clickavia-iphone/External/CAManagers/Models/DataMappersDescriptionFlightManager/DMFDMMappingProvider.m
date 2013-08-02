//
//  DMFDMMappingProvider.m
//  CAManagersLib
//
//  Created by macmini1 on 27.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "DMFDMMappingProvider.h"

@implementation DMFDMMappingProvider

+ (EKObjectMapping*) flightMapping
{
    return [EKObjectMapping mappingForClass:[DMFDMFlight class] withBlock:^(EKObjectMapping *mapping)
            {
                [mapping mapKey:@"id" toField:@"Id"];
                [mapping mapKey:@"departure_date" toField:@"departure_date" withDateFormat:@"yyyy-MM-dd"];
            }];
}
+ (EKObjectMapping*) fullFlightMapping
{
    return [EKObjectMapping mappingForClass:[DMFDMFullFlight class] withBlock:^(EKObjectMapping *mapping)
    {
        [mapping mapKey:@"trip_price" toField:@"trip_price"];
        [mapping hasOneMapping:[self flightMapping] forKey:@"flight_to" forField:@"flight_to"];
        [mapping hasOneMapping:[self flightMapping] forKey:@"flight_return" forField:@"flight_return"];
    }];
}
@end
