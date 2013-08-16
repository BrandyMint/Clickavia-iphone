//
//  FlightDescriptionManager.h
//  CAManagersLib
//
//  Created by macmini1 on 26.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OfferConditions.h"
#import "Offer.h"
#import "Flight.h"
#import "Routes.h"
#import <LRResty/LRResty.h>
#import "DMFDMMappingProvider.h"
#import "DMFMMappingProvider.h"

@interface FlightDescriptionManager : NSObject
@property (strong,nonatomic) OfferConditions *offerConditions;
- (id) init:(OfferConditions*) offerConditions;
- (void) getFlightsDepartureByDateWithCompleteBlock:(void (^) (NSArray *flights))block;
- (void) getFlightsReturnByDateWithCompleteBlock:(void (^) (NSArray *flights))block;
- (void) getAvailableOffersWithCompleteBlock:(void (^) (NSArray *offers))block;
@end
