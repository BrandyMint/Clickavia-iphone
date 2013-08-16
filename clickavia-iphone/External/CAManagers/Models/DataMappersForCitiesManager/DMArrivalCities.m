//
//  DMArrivalCities.m
//  CAManagersLib
//
//  Created by macmini1 on 14.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "DMArrivalCities.h"

@implementation DMArrivalCities
+ (RKObjectMapping*) createMapping
{
    RKObjectMapping *dmArrivalCities = [RKObjectMapping mappingForClass:[DMArrivalCities class]];
    [dmArrivalCities addAttributeMappingsFromDictionary:@{
        @"city_iata":@"city_iata",
        @"city_title":@"city_title"
     }];
    return dmArrivalCities;
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
