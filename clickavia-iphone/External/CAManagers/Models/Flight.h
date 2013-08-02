//
//  Flight.h
//  CAManagersLib
//
//  Created by macmini1 on 26.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Flight : NSObject
@property (strong,nonatomic) NSString *ID;
@property (strong,nonatomic) NSDate *dateAndTimeDeparture;
@property (strong,nonatomic) NSDate *dateAndTimeArrival;
@property (strong,nonatomic) NSDate *timeInFlight;
@property (strong,nonatomic) NSString *cityDeparture;
@property (strong,nonatomic) NSString *cityArrival;
@property (strong,nonatomic) NSString *airportDeparture;
@property (strong,nonatomic) NSString *airportArrival;
@property (strong,nonatomic) NSString *airlineTitle;
@property (strong,nonatomic) NSString *airlineSite;
@property (strong,nonatomic) NSDecimalNumber *price;
@end
