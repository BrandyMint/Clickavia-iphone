//
//  SpecialOffersManager.h
//  CAManagersLib
//
//  Created by macmini1 on 19.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Routes.h"
#import <LRResty/LRResty.h>
#import "DMSOMMappingProvider.h"
#import <EasyMapping/EasyMapping.h>
#import "SpecialOfferCity.h"
#import "SpecialOfferCountry.h"
#import "SpecialOffer.h"

@interface SpecialOffersManager : NSObject
{
    NSString *stringRepresentationOfResponse;

}
- (void) getCitiesWithCompleteBlock:(void (^)(NSArray*))block;
- (void) getAvailableCountries: (SpecialOfferCity*) forCity completeBlock:(void (^) (NSArray*))block;
- (void) getSpecialOffers:(SpecialOfferCity*) forCity : (SpecialOfferCountry*) forCountry completeBlock:(void (^) (NSArray*))block;
@end
