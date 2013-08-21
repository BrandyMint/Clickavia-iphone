//
//  SpecialOffersManager.m
//  CAManagersLib
//
//  Created by macmini1 on 19.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "SpecialOffersManager.h"

@implementation SpecialOffersManager
- (id) init
{
    self = [super init];
    if(self)
    {
    }
    return self;
}
- (NSArray*) getCities
{
    NSMutableArray *specialOfferCities = [NSMutableArray new];
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:[stringRepresentationOfResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    NSArray *citiesArray = [EKMapper arrayOfObjectsFromExternalRepresentation:jsonArray withMapping:[DMSOMMappingProvider cityMapping]];
    for (DMSOMCity *city in citiesArray)
    {
        SpecialOfferCity *citySOC = [[SpecialOfferCity alloc] init];
        citySOC.title = city.title;
        [specialOfferCities addObject:citySOC];
    }
    return (NSArray*)specialOfferCities;
}
- (void)getCitiesWithCompleteBlock:(void (^)(NSArray *))block
{
    [self loadDataWithBlock:^()
    {
        block([self getCities]);
    }];
}
- (NSArray*) getAvailableCountries:(SpecialOfferCity *)forCity
{
    NSMutableArray *specialOfferCountries = [NSMutableArray new];
    if(forCity)
    {
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:[stringRepresentationOfResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        NSArray *citiesArray = [EKMapper arrayOfObjectsFromExternalRepresentation:jsonArray withMapping:[DMSOMMappingProvider cityMapping]];
        for (DMSOMCity *city in citiesArray)
        {
            if([city.title isEqualToString:forCity.title])
            {
                for (DMSOMCountry *country in city.countries)
                {
                    SpecialOfferCountry *countrySoc = [[SpecialOfferCountry alloc] init];
                    countrySoc.title = country.title;
                    countrySoc.countOfOffers = country.offers.count;
                    [specialOfferCountries addObject:countrySoc];
                }
            }
        }
    }
    return (NSArray*)specialOfferCountries;
}
- (void)getAvailableCountries:(SpecialOfferCity *)forCity completeBlock:(void (^)(NSArray *))block
{
    [self loadDataWithBlock:^()
     {
         block([self getAvailableCountries:forCity]);
     }];
}
- (NSArray*) getSpecialOffers:(SpecialOfferCity *)forCity :(SpecialOfferCountry *)forCountry
{
    NSMutableArray *specialOffers = [NSMutableArray new];
    if (forCity&&forCountry)
    {
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:[stringRepresentationOfResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        NSArray *citiesArray = [EKMapper arrayOfObjectsFromExternalRepresentation:jsonArray withMapping:[DMSOMMappingProvider cityMapping]];
        for (DMSOMCity *city in citiesArray)
        {
            if([city.title isEqualToString:forCity.title])
            {
                for (DMSOMCountry *country in city.countries)
                {
                    if([country.title isEqualToString:forCountry.title])
                    {
                        for (DMSOMOffer *offer in country.offers)
                        {
                            SpecialOffer *SOC_offer = [SpecialOffer new];
                            SOC_offer.flightCity = offer.arrival_city;
                            SOC_offer.price = offer.price;
                            SOC_offer.isHot = offer.kind.integerValue==1;
                            NSMutableArray *dates = [NSMutableArray new];
                            NSMutableArray *ids = [NSMutableArray new];
                            [dates addObject:offer.departure_flight.departure_date];
                            [ids addObject:offer.departure_flight.Id];
                            SOC_offer.departureCity = offer.departure_city;
                            SOC_offer.isReturn = !((offer.return_flight.Id==nil)||(offer.return_flight.departure_date==nil));
                            if(SOC_offer.isReturn)
                            {
                                [dates addObject:offer.return_flight.departure_date];
                                [ids addObject:offer.return_flight.Id];
                            }
                            SOC_offer.dates = (NSArray*)[dates copy];
                            SOC_offer.flightIds = (NSArray*)[ids copy];
                            [specialOffers addObject:SOC_offer];
                            
                        }
                    }
                }
            }
        }
    }
    return specialOffers;
}
- (void) getSpecialOffers:(SpecialOfferCity *)forCity :(SpecialOfferCountry *)forCountry completeBlock:(void (^)(NSArray *))block
{
    [self loadDataWithBlock:^()
    {
        block([self getSpecialOffers:forCity :forCountry]);
    }];
}
- (void) loadDataWithBlock:(void (^)())block
{
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",ROOT_PATH,SPECIAL_OFFERS_MANAGER_ROUTE];
    [[LRResty client] get:url withBlock:^(LRRestyResponse *response)
    {
        stringRepresentationOfResponse = [[NSString alloc] initWithString:[response asString]];
        block();
    }];
}

@end
