//
//  DMDepartureCoutry.m
//  CAManagersLib
//
//  Created by macmini1 on 14.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "DMDepartureCountry.h"

@implementation DMDepartureCountry
+(RKObjectMapping*) createMapping
{
    RKObjectMapping *dmDepartureCountry = [RKObjectMapping mappingForClass:[DMDepartureCountry class]];
    [dmDepartureCountry addAttributeMappingsFromDictionary:@{
     @"departure_country_title":@"departure_country_title",
     @"departure_country_iata":@"departure_country_iata"
     }];
    return dmDepartureCountry;
}
-(Destination*) toDestination
{
    Destination *result = [[Destination alloc] init];
    result.code = _departure_country_iata;
    result.title = _departure_country_title;
    result.destinationType = country;
    return result;
}
@end
