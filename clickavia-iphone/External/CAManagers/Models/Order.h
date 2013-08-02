//
//  Order.h
//  CAManagersLib
//
//  Created by macmini1 on 04.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//
#import "OfferExtended.h"
#import "PersonInfo.h"
#import <Foundation/Foundation.h>

@interface Order : NSObject
@property (strong,nonatomic) NSNumber *idRaceDeparture;
@property (strong,nonatomic) NSNumber *idRaceReturn;
@property (strong,nonatomic) NSNumber *adultsCount;
@property (strong,nonatomic) NSNumber *childCount;
@property (strong,nonatomic) NSNumber *infantCount;
@property PaymentType paymentType;
@property (strong,nonatomic) NSArray *personsInfo;
@end
