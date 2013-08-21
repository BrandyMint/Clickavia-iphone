//
//  DMSOMOffer.h
//  CAManagersLib
//
//  Created by macmini1 on 19.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMSOMFlight.h"

@interface DMSOMOffer : NSObject
@property (strong,nonatomic) NSString *departure_city;
@property (strong,nonatomic) NSString *arrival_city;
@property (strong,nonatomic) DMSOMFlight *departure_flight;
@property (strong,nonatomic) DMSOMFlight *return_flight;
@property (strong,nonatomic) NSDecimalNumber *price;
@property (strong,nonatomic) NSNumber *kind;
@end