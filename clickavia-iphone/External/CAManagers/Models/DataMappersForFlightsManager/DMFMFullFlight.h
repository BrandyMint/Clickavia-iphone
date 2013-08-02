//
//  DMFMFullFlight.h
//  CAManagersLib
//
//  Created by macmini1 on 25.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMFMFlight.h"

@interface DMFMFullFlight : NSObject
@property (strong,nonatomic) NSDecimalNumber *trip_price;
@property (strong,nonatomic) DMFMFlight *flight_to;
@property (strong,nonatomic) DMFMFlight *flight_return;
@property (strong,nonatomic) NSNumber *is_special;
@property BOOL is_guaranted;
@end
