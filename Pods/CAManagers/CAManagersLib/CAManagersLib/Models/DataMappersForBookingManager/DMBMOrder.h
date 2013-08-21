//
//  DMBMOrder.h
//  CAManagersLib
//
//  Created by macmini1 on 05.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMBMOrder : NSObject
@property (strong,nonatomic) NSString *departure_flight_id;
@property (strong,nonatomic) NSString *return_flight_id;
@property (strong,nonatomic) NSNumber *adults;
@property (strong,nonatomic) NSNumber *children;
@property (strong,nonatomic) NSNumber *infants;
@property (strong,nonatomic) NSNumber *payment_type_id;
@property (strong,nonatomic) NSArray *passports;
@end
