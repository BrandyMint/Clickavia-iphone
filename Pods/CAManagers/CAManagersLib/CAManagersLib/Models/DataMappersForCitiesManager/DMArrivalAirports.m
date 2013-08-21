//
//  DMArrivalAirports.m
//  CAManagersLib
//
//  Created by macmini1 on 14.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "DMArrivalAirports.h"

@implementation DMArrivalAirports
+ (RKObjectMapping*) createMapping
{
    RKObjectMapping *dmArrivalAirports = [RKObjectMapping mappingForClass:[DMArrivalAirports class]];
    [dmArrivalAirports addAttributeMappingsFromDictionary:@{@"airport_iata":@"airport_iata",@"airport_title":@"airport_title"}];
    return dmArrivalAirports;
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
