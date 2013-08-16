//
//  DMFDMFullFlight.h
//  CAManagersLib
//
//  Created by macmini1 on 27.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMFDMFlight.h"

@interface DMFDMFullFlight : NSObject
@property (strong,nonatomic) DMFDMFlight *flight_to;
@property (strong,nonatomic) DMFDMFlight *flight_return;
@property (strong,nonatomic) NSDecimalNumber *trip_price;
@end
