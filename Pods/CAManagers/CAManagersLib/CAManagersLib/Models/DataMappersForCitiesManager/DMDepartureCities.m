//
//  DMDepartureCities.m
//  CAManagersLib
//
//  Created by macmini1 on 14.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "DMDepartureCities.h"

@implementation DMDepartureCities
+(RKObjectMapping*) createMapping
{
    RKObjectMapping *dmDepartureCities = [RKObjectMapping mappingForClass:[DMDepartureCities class]];
    [dmDepartureCities addAttributeMappingsFromDictionary:@{
     @"city_title":@"city_title",
     @"city_iata":@"city_iata"
     }];
    return dmDepartureCities;
}
- (Destination*) toDestination
{
    Destination *result = [[Destination alloc] init];
    result.code = _city_iata;
    result.title = _city_title;
    result.destinationType = city;
    return result;
}
@end
