//
//  DMFMFlight.h
//  CAManagersLib
//
//  Created by macmini1 on 25.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMFMFlight : NSObject
@property (strong,nonatomic) NSString *Id;
@property (strong,nonatomic) NSDate *departure_date;
@property (strong,nonatomic) NSString *code;
@property (strong,nonatomic) NSString *flight_class;
@property (strong,nonatomic) NSString *airline_title;
@property (strong,nonatomic) NSString *airline_cite;
@property (strong,nonatomic) NSDate *departure_time;
@property (strong,nonatomic) NSString *departure_city;
@property (strong,nonatomic) NSString *departure_airport_title;
@property (strong,nonatomic) NSString *departure_airport_code;
@property (strong,nonatomic) NSDate *arrival_date;
@property (strong,nonatomic) NSDate *arrival_time;
@property (strong,nonatomic) NSString *arrival_city;
@property (strong,nonatomic) NSString *arrival_airport_title;
@property (strong,nonatomic) NSString *arrival_airport_code;
@property (strong,nonatomic) NSDate *flight_time;
@end
