//
//  OfferExtended.h
//  CAManagersLib
//
//  Created by macmini1 on 02.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Offer.h"

typedef enum
{
    evrosetOrSvyaznoy = 1,
    masterCardOrVisa = 2,
    cash = 3
} PaymentType;

@interface OfferExtended : NSObject
@property (strong,nonatomic) Offer *offer;
@property PaymentType paymentType;
@property NSNumber *adultsCount;
@property NSNumber *childrenCount;
@property NSNumber *infantsCount;
@end
