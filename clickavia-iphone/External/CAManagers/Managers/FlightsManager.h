//
//  FlightsManager.h
//  CAManagersLib
//
//  Created by macmini1 on 25.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchConditions.h"
#import <LRResty/LRResty.h>
#import <EasyMapping/EasyMapping.h>
#import "DMFMMappingProvider.h"
#import "DMFMFullFlight.h"
#import "Routes.h"
@interface FlightsManager : NSObject
{
    NSMutableArray *availableDeparturesDates;
    NSMutableArray *availableReturnDates;
    NSString *stringRepresentationOfResponse;
}

- (void) getAvailableDepartureDates: (SearchConditions*) forConditions departureDate:(NSDate*)withDepartureDate completeBlock:(void (^)(NSArray *dates))block;
- (void) getAvailableReturnDates:(SearchConditions*) forConditions withDepartureDate:(NSDate*)withDepartureDate completeBlock:(void (^)(NSArray *dates))block;
@end
