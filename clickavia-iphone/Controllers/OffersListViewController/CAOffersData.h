//
//  CAOffersData.h
//  clickavia-iphone
//
//  Created by bespalown on 9/11/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Offer.h"
#import "Flight.h"
#import "FlightPassengersCount.h"

@interface CAOffersData : NSObject

-(NSArray*)arrayOffer;
-(NSArray*)arrayPassangers;

@end