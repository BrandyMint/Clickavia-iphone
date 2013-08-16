//
//  DMArrivalCountries.m
//  CAManagersLib
//
//  Created by macmini1 on 14.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "DMArrivalCountries.h"

@implementation DMArrivalCountries
+(RKObjectMapping*) createMapping
{
    RKObjectMapping *dmArrivalCountries = [RKObjectMapping mappingForClass:[DMArrivalCountries class]];
    [dmArrivalCountries addAttributeMappingsFromDictionary:
     @{
        @"country_title":@"country_title",
        @"country_iata":@"country_iata"
     }];
    return dmArrivalCountries;
}
-(Destination*) toDestination
{
    Destination *result = [[Destination alloc] init];
    result.code = _country_iata;
    result.title = _country_title;
    result.destinationType = country;
    return result;
}
@end
