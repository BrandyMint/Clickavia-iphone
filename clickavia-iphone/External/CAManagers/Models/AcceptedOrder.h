//
//  AcceptedOrder.h
//  CAManagersLib
//
//  Created by macmini1 on 04.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AcceptedOrder : NSObject
@property (strong,nonatomic) NSString *orderCode;
@property (strong,nonatomic) NSString *countryDeparture;
@property (strong,nonatomic) NSString *countryArrival;
@property (strong,nonatomic) NSString *cityDeparture;
@property (strong,nonatomic) NSString *cityArrival;
@property (strong,nonatomic) NSDate *dateDeparture;
@property (strong,nonatomic) NSDate *dateArrival;
@property (strong,nonatomic) NSString *state;
@end
