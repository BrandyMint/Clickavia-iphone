//
//  CitiesManager.m
//  CAManagersLib
//
//  Created by macmini1 on 14.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "CitiesManager.h"

@implementation CitiesManager
-(id) init
{
    self = [super init];
    if(self)
    {
        [self setupRKKit];
        _delay = 300;
    }
    return self;
}

- (BOOL) searchRuleForDestination:(Destination*) destination ForDepartureByText:(NSString*)byText
{
    BOOL result = NO;
    NSRange searchResults = [[[NSString alloc] initWithFormat:@"%@, (%@)",destination.title,destination.code] rangeOfString:byText options:NSCaseInsensitiveSearch];
    result = searchResults.location != NSNotFound || (byText.length==0);
    return result;
}

- (BOOL) searchRuleForDestination:(Destination*) destination ForReturnByText:(NSString*) byText
{
    return [self searchRuleForDestination:destination ForDepartureByText:byText];
}
- (void) getDestinationsForDeparture:(NSString *)byText completeBlock:(void (^)(NSArray *array))block
{
    BOOL needUpdate = NO;
    if(lastUpdateForDeparture == nil)
    {
        lastUpdateForDeparture = [NSDate date];
        needUpdate = YES;
    }
    else
    {
        NSDate *today = [NSDate date];
        double seconds = [today timeIntervalSinceDate:lastUpdateForDeparture];
        int wholeMilliSeconds = (int)(seconds * 1000.0);
        needUpdate = wholeMilliSeconds>_delay;
    }
    
    if(needUpdate)
    {
        [self loadDataWithBlock:^()
         {
             lastUpdateForDeparture = [NSDate date];
             destinationsForDeparture = [self getDestinationsForDeparture:byText];
             block(destinationsForDeparture);
         }];
    }
    else
    {
        block(destinationsForDeparture);
    }

}
- (void) getDestinationsForReturn:(NSString *)byText forDepartureDestination:(Destination *)forDepartureDestination completeBlock:(void (^)(NSArray *))block
{
    BOOL needUpdate = NO;
    if(lastUpdateForReturn == nil)
    {
        lastUpdateForReturn = [NSDate date];
        needUpdate = YES;
    }
    else
    {
        NSDate *today = [NSDate date];
        double seconds = [today timeIntervalSinceDate:lastUpdateForReturn];
        int wholeMilliSeconds = (int)(seconds * 1000.0);
        needUpdate = wholeMilliSeconds>_delay;
    }
    
    if(needUpdate)
    {
        [self loadDataWithBlock:^()
         {
             lastUpdateForReturn = [NSDate date];
             destinationsForReturn = [self getDestinationsForReturn:byText forDepartureDestination:forDepartureDestination];
             block(destinationsForReturn);
         }];
    }
    else
    {
        block(destinationsForReturn);
    }
    
}
- (NSArray*) getDestinationsForDeparture:(NSString *)byText
{
    //[self loadData];
    NSMutableArray *sortedArray = [NSMutableArray new];

    for (DMDepartureCountry *country in countries)
    {
        //search Country
        BOOL countryIsFinded = NO;
        Destination *destinationCountry = [DMObjectMapperToDestination mapFrom:country];
        if([self searchRuleForDestination:destinationCountry ForDepartureByText:byText])
        {
            countryIsFinded = YES;
        }
        for (DMDepartureCities *city in country.departure_cities)
        {
            //search city
            BOOL cityIsFinded = NO;
            Destination *destinationCity = [DMObjectMapperToDestination mapFrom:city];
            if([self searchRuleForDestination:destinationCity ForDepartureByText:byText]&&!countryIsFinded)
            {
                cityIsFinded = YES;
            }
            
            for (DMDepartureAirports *airport in city.departure_airports)
            {
                //search airport
                BOOL airportIsFinded = NO;
                Destination *destinationAirport = [DMObjectMapperToDestination mapFrom:airport];
                if([self searchRuleForDestination:destinationAirport ForDepartureByText:byText]&&!(cityIsFinded||countryIsFinded))
                {
                    airportIsFinded = YES;
                }
                if(airportIsFinded||countryIsFinded||cityIsFinded)
                {
                    Destination *destination = [Destination new];
                    destination.countryTitle = destinationCountry.title;
                    destination.cityTitle = destinationCity.title;
                    destination.airportTitle = destinationAirport.title;
                    destination.cityCode = destinationCity.code;
                    if(airportIsFinded)
                    {
                        destination.title = destinationAirport.title;
                        destination.destinationType = destinationAirport.destinationType;
                        destination.code = destinationAirport.code;
                    }
                    else if(countryIsFinded)
                    {
                        destination.title = destinationCountry.title;
                        destination.destinationType = destinationCountry.destinationType;
                        destination.code = destinationCountry.code;
                    }
                    else if(cityIsFinded)
                    {
                        destination.title = destinationCity.title;
                        destination.destinationType = destinationCity.destinationType;
                        destination.code = destinationCity.code;
                    }
                    [sortedArray addObject:destination];
                }
            }
        }
    }
    return sortedArray;
}

- (BOOL) thisDestination:(Destination*) destination isDestinationForDeparture:(Destination*)depDestination
{
    BOOL result = NO;
    if([depDestination.title length]==0) result = YES;
    else
    {
        NSRange findRange = [[[NSString alloc] initWithFormat:@"%@, (%@)",destination.title,destination.code] rangeOfString:depDestination.title options:NSCaseInsensitiveSearch];
        result = findRange.location!=NSNotFound;
    }
    return result;
}

-(NSArray*) getDestinationsForReturn:(NSString *)byText forDepartureDestination:(Destination*) forDepartureDestination
{
    //[self loadData];
    NSMutableArray *sortedArray = [NSMutableArray new];
    for (DMDepartureCountry *depCountry in countries)
    {
        for (DMDepartureCities *depCity in depCountry.departure_cities)
            {
                for (DMDepartureAirports *depAirport in depCity.departure_airports)
                    {
                        Destination *countryDepDest = [DMObjectMapperToDestination mapFrom:depCountry];
                        Destination *cityDepDest = [DMObjectMapperToDestination mapFrom:depCity];
                        Destination *airportDepDest = [DMObjectMapperToDestination mapFrom:depAirport];
                        
                        BOOL isCorrectDeparture = [self thisDestination:countryDepDest isDestinationForDeparture:forDepartureDestination];
                        isCorrectDeparture = isCorrectDeparture || [self thisDestination:cityDepDest isDestinationForDeparture:forDepartureDestination];
                        isCorrectDeparture = isCorrectDeparture || [self thisDestination:airportDepDest isDestinationForDeparture:forDepartureDestination];
                        
                        if(isCorrectDeparture)
                        {
                            for (DMArrivalCountries *country in depAirport.arrival_countries)
                            {
                                //search arrival country
                                Destination *destinationCountry = [DMObjectMapperToDestination mapFrom:country];
                                BOOL countryIsFinded = NO;
                                if([self searchRuleForDestination:destinationCountry ForDepartureByText:byText])
                                {
//                                    [sortedArray addObject:destinationCountry];
                                    countryIsFinded = YES;
                                }
                                for (DMArrivalCities *city in country.arrival_cities)
                                {
                                    //search arrival city
                                    Destination *destinationCity = [DMObjectMapperToDestination mapFrom:city];
                                    BOOL cityIsFinded = NO;
                                    if([self searchRuleForDestination:destinationCity ForReturnByText:byText]&&!countryIsFinded)
                                    {
//                                        [sortedArray addObject:destinationCity];
                                        cityIsFinded = YES;
                                    }
                                    for (DMArrivalAirports *airport in city.arrival_airports)
                                    {
                                        //search airport
                                        Destination *destinationAirport = [DMObjectMapperToDestination mapFrom:airport];
                                        BOOL airportIsFinded = NO;
                                        if([self searchRuleForDestination:destinationAirport ForReturnByText:byText]&&!(cityIsFinded||countryIsFinded))
                                        {
//                                            [sortedArray addObject:destinationAirport];
                                            airportIsFinded = YES;
                                        }
                                        if(airportIsFinded||countryIsFinded||cityIsFinded)
                                        {
                                            Destination *destination = [Destination new];
                                            destination.countryTitle = destinationCountry.title;
                                            destination.cityTitle = destinationCity.title;
                                            destination.airportTitle = destinationAirport.title;
                                            destination.cityCode= destinationCity.code;
                                            if(airportIsFinded)
                                            {
                                                destination.title = destinationAirport.title;
                                                destination.destinationType = destinationAirport.destinationType;
                                                destination.code = destinationAirport.code;
                                            }
                                            else if(countryIsFinded)
                                            {
                                                destination.title = destinationCountry.title;
                                                destination.destinationType = destinationCountry.destinationType;
                                                destination.code = destinationCountry.code;
                                            }
                                            else if(cityIsFinded)
                                            {
                                                destination.title = destinationCity.title;
                                                destination.destinationType = destinationCity.destinationType;
                                                destination.code = destinationCity.code;
                                            }
                                            [sortedArray addObject:destination];
                                        }
                                    }
                                }
                            }
                        }
                        
                
                    }
                        
            }
    }
    return (NSArray*)sortedArray;
}
- (void) setupRKKit
{
    NSURL *baseURL = [NSURL URLWithString:ROOT_PATH];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];

    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    //creating mappings
    RKObjectMapping *dmArrivalAirports = [DMArrivalAirports createMapping];
    RKObjectMapping *dmArrivalCities = [DMArrivalCities createMapping];
    RKObjectMapping *dmArrivalCountries = [DMArrivalCountries createMapping];
    RKObjectMapping *dmDepartureAirports = [DMDepartureAirports createMapping];
    RKObjectMapping *dmDepartureCities = [DMDepartureCities createMapping];
    RKObjectMapping *dmDepartureCountry = [DMDepartureCountry createMapping];
    //turn off logging
    RKLogConfigureByName("RestKit", RKLogLevelOff);
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelOff);
    RKLogConfigureByName("RestKit/Network", RKLogLevelOff);
    //creating relationship mappings
    
    RKRelationshipMapping *arrivalAirports = [RKRelationshipMapping relationshipMappingFromKeyPath:@"arrival_airports" toKeyPath:@"arrival_airports" withMapping:dmArrivalAirports];
    [dmArrivalCities addPropertyMapping:arrivalAirports];
    
    RKRelationshipMapping *arrivalCities = [RKRelationshipMapping relationshipMappingFromKeyPath:@"arrival_cities" toKeyPath:@"arrival_cities" withMapping:dmArrivalCities];
    [dmArrivalCountries addPropertyMapping:arrivalCities];
    
    RKRelationshipMapping *arrivalCountries = [RKRelationshipMapping relationshipMappingFromKeyPath:@"arrival_countries" toKeyPath:@"arrival_countries" withMapping:dmArrivalCountries];
    [dmDepartureAirports addPropertyMapping:arrivalCountries];
    
    RKRelationshipMapping *departureAirports = [RKRelationshipMapping relationshipMappingFromKeyPath:@"departure_airports" toKeyPath:@"departure_airports" withMapping:dmDepartureAirports];
    [dmDepartureCities addPropertyMapping:departureAirports];
    
    RKRelationshipMapping *departureCities = [RKRelationshipMapping relationshipMappingFromKeyPath:@"departure_cities" toKeyPath:@"departure_cities" withMapping:dmDepartureCities];
    [dmDepartureCountry addPropertyMapping:departureCities];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:dmDepartureCountry pathPattern:nil keyPath:nil statusCodes:[NSIndexSet indexSetWithIndex:200]];
    [objectManager addResponseDescriptor:responseDescriptor];
}
- (void) loadDataWithBlock:(void(^)(void))block;
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [objectManager getObjectsAtPath:CITIES_MANAGER_ROUTE
                         parameters:nil
                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                countries = [mappingResult array];
                                block();
                            }
                            failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                NSLog(@"Error %@",[error localizedDescription]);

                            }];
}
@end
