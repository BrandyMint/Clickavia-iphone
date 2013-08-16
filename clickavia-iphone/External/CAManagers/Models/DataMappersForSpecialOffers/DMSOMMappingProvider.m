//
//  DMSOMMappingProvider.m
//  CAManagersLib
//
//  Created by macmini1 on 19.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "DMSOMMappingProvider.h"

@implementation DMSOMMappingProvider
+ (EKObjectMapping*) flightMapping
{
    return [EKObjectMapping mappingForClass:[DMSOMFlight class] withBlock:^(EKObjectMapping *mapping)
            {
                [mapping mapKey:@"id" toField:@"Id"];
                [mapping mapKey:@"departure_date" toField:@"departure_date" withDateFormat:@"yyyy-MM-dd"];
            }];
}
+ (EKObjectMapping*) offerMapping
{
    return [EKObjectMapping mappingForClass:[DMSOMOffer class] withBlock:^(EKObjectMapping *mapping)
            {
                [mapping mapKey:@"departure_city" toField:@"departure_city"];
                [mapping mapKey:@"arrival_city" toField:@"arrival_city"];
                [mapping mapKey:@"price" toField:@"price"];
                [mapping hasOneMapping:[self flightMapping] forKey:@"departure_flight" forField:@"departure_flight"];
                [mapping hasOneMapping:[self flightMapping] forKey:@"return_flight" forField:@"return_flight"];
                [mapping mapKey:@"kind" toField:@"kind"];
            }];
}
+ (EKObjectMapping*)  countryMapping
{
    return [EKObjectMapping mappingForClass:[DMSOMCountry class] withBlock:^(EKObjectMapping *mapping)
            {
                [mapping mapKey:@"country" toField:@"title"];
                [mapping hasManyMapping:[self offerMapping] forKey:@"offers" forField:@"offers"];
            }];
}
+ (EKObjectMapping*) cityMapping
{
    return [EKObjectMapping mappingForClass:[DMSOMCity class] withBlock:^(EKObjectMapping *mapping)
            {
                [mapping mapKey:@"city" toField:@"title"];
                [mapping hasManyMapping:[self countryMapping] forKey:@"countries" forField:@"countries"];
            }];
}
@end
