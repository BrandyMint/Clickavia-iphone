//
//  DMDepartureAirports.m
//  CAManagersLib
//
//  Created by macmini1 on 14.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "DMDepartureAirports.h"

@implementation DMDepartureAirports
+(RKObjectMapping*) createMapping
{
    RKObjectMapping *dmDepartureAirports = [RKObjectMapping mappingForClass:[DMDepartureAirports class]];
    [dmDepartureAirports addAttributeMappingsFromDictionary:
     @{
        @"airport_iata":@"airport_iata",
        @"airport_title":@"airport_title"
     }];
    return dmDepartureAirports;
}
- (Destination*) toDestination
{
    Destination *result = [[Destination alloc] init];
    result.code = _airport_iata;
    result.title = _airport_title;
    result.destinationType = airport;
    return result;
}
@end
