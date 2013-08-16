//
//  SearchConditions.h
//  CAManagersLib
//
//  Created by macmini1 on 24.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Destination.h"
typedef enum
{
    business,
    econom
} flightType;

@interface SearchConditions : NSObject
@property BOOL isBothWays;
@property NSNumber *countOfTickets;
@property flightType typeOfFlight;
@property (strong,nonatomic) Destination *direction_departure;
@property (strong,nonatomic) Destination *direction_return;
@end
