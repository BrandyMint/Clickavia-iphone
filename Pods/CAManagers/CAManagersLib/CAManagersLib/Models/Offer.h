//
//  Offer.h
//  CAManagersLib
//
//  Created by macmini1 on 26.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OfferConditions.h"
#import "Flight.h"

@interface Offer : NSObject
@property (strong,nonatomic) OfferConditions *offerConditions;
@property BOOL isSpecial;
@property BOOL isMomentaryConfirmation;
@property (strong,nonatomic) Flight *flightDeparture;
@property (strong,nonatomic) Flight *flightReturn;
@property (strong,nonatomic) NSDecimalNumber *bothPrice;
@end
