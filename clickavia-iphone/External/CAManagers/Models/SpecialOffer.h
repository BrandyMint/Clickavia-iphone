//
//  SpecialOffer.h
//  CAManagersLib
//
//  Created by macmini1 on 19.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpecialOffer : NSObject
@property BOOL isHot;
@property BOOL isReturn;
@property (strong,nonatomic) NSString *flightCity;
@property (strong,nonatomic) NSDecimalNumber *price;
@property (strong,nonatomic) NSArray *dates;
@property (strong,nonatomic) NSArray *flightIds;
@property (strong,nonatomic) NSString *departureCity;
@end

