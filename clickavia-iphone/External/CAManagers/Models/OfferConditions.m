//
//  OfferConditions.m
//  CAManagersLib
//
//  Created by macmini1 on 26.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "OfferConditions.h"

@implementation OfferConditions
-(id)initWithSearchConditions:(SearchConditions *)searchConditions withDepartureDate:(NSDate *)departureDate andReturnDate:(NSDate *)returnDate
{
    self = [super init];
    if(self)
    {
        _searchConditions = searchConditions;
        _departureDate = departureDate;
        _returnDate = returnDate;
    }
    return self;
}
@end
