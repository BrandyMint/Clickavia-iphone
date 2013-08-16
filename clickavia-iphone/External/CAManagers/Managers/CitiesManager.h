//
//  CitiesManager.h
//  CAManagersLib
//
//  Created by macmini1 on 14.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "Destination.h"
#import "Routes.h"
#import "DMArrivalAirports.h"
#import "DMArrivalCities.h"
#import "DMArrivalCountries.h"
#import "DMDepartureAirports.h"
#import "DMDepartureCities.h"
#import "DMDepartureCountry.h"
#import "DMObjectMapperToDestination.h"


@interface CitiesManager : NSObject
{
    NSArray *countries;
    NSDate *lastUpdateForDeparture;
    NSDate *lastUpdateForReturn;
    
    NSArray *destinationsForDeparture;
    NSArray *destinationsForReturn;
}
@property NSInteger delay; //delay between requests in milliseconds 300 by default
- (void) getDestinationsForDeparture: (NSString*) byText completeBlock:(void(^)(NSArray *array))block;
- (void) getDestinationsForReturn:(NSString*) byText forDepartureDestination:(Destination*) forDepartureDestination completeBlock:(void(^)(NSArray *array))block;
@end
