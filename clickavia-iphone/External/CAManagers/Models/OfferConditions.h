//
//  OfferConditions.h
//  CAManagersLib
//
//  Created by macmini1 on 26.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchConditions.h"

@interface OfferConditions : NSObject
@property (strong,nonatomic) SearchConditions *searchConditions;
@property (strong,nonatomic) NSDate *departureDate;
@property (strong,nonatomic) NSDate *returnDate;
-(id) initWithSearchConditions:(SearchConditions*) searchConditions withDepartureDate:(NSDate*) departureDate andReturnDate:(NSDate*) returnDate;
@end
