//
//  DMFMMappingProvider.m
//  CAManagersLib
//
//  Created by macmini1 on 25.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "DMFMMappingProvider.h"

@implementation DMFMMappingProvider
+ (EKObjectMapping*) flightMapping
{
    return [EKObjectMapping mappingForClass:[DMFMFlight class] withBlock:^(EKObjectMapping *mapping)
    {
        [mapping mapKey:@"id" toField:@"Id"];
        [mapping mapKey:@"departure_date" toField:@"departure_date" withDateFormat:@"yyyy-MM-dd"];
        [mapping mapKey:@"code" toField:@"code"];
        [mapping mapKey:@"flight_class" toField:@"flight_class"];
        [mapping mapKey:@"airline_title" toField:@"airline_title"];
        [mapping mapKey:@"airline_site" toField:@"airline_site"];
        [mapping mapKey:@"departure_time" toField:@"departure_time" withDateFormat:@"HH:mm"];
        [mapping mapKey:@"departure_city" toField:@"departure_city"];
        [mapping mapKey:@"departure_airport_title" toField:@"departure_airport_title"];
        [mapping mapKey:@"departure_airport_code" toField:@"departure_airport_code"];
        [mapping mapKey:@"arrival_date" toField:@"arrival_date" withDateFormat:@"yyyy-MM-dd"];
        [mapping mapKey:@"arrival_time" toField:@"arrival_time" withDateFormat:@"HH:mm"];
        [mapping mapKey:@"arrival_city" toField:@"arrival_city"];
        [mapping mapKey:@"arrival_airport_title" toField:@"arrival_airport_title"];
        [mapping mapKey:@"arrival_airport_code" toField:@"arrival_airport_code"];
        [mapping mapKey:@"flight_time" toField:@"flight_time" withDateFormat:@"HH:mm"];
    }];
}
+ (EKObjectMapping*) fullFlightMapping
{
    return [EKObjectMapping mappingForClass:[DMFMFullFlight class] withBlock:^(EKObjectMapping *mapping)
    {
        [mapping mapKey:@"trip_price" toField:@"trip_price"];
        [mapping mapKey:@"kind_special" toField:@"is_special"];
        [mapping mapKey:@"is_guaranted" toField:@"is_guaranted"];
        [mapping hasOneMapping:[self flightMapping] forKey:@"flight_to" forField:@"flight_to"];
        [mapping hasOneMapping:[self flightMapping] forKey:@"flight_return" forField:@"flight_return"];
    }];
}

@end
