//
//  FlightDescriptionManager.m
//  CAManagersLib
//
//  Created by macmini1 on 26.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "FlightDescriptionManager.h"

@implementation FlightDescriptionManager
- (id) init:(OfferConditions *)offerConditions
{
    self = [super init];
    if(self)
    {
        _offerConditions = offerConditions;
    }
    return self;
}
- (void) getFlightsDepartureByDateWithCompleteBlock:(void (^)(NSArray *))block
{
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@?",ROOT_PATH,FLIGHT_DESCRIPTION_MANAGER_NEARBY_ROUTE];
    NSString *formatString = @"departure_place_iata=%@&departure_place_type=%@&arrival_place_iata=%@&arrival_place_type=%@&departure_date=%@&flight_class=%@";
    NSString *departure_place_iata = _offerConditions.searchConditions.direction_departure.cityCode;
    NSString *departure_place_type = [self destinationTypeToNSString:city];
    NSString *arrival_place_iata = _offerConditions.searchConditions.direction_return.cityCode;
    NSString *arrival_place_type = [self destinationTypeToNSString:city];
    NSString *fclass = _offerConditions.searchConditions.typeOfFlight==business?@"1":@"0";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *departure_date = [formatter stringFromDate:_offerConditions.departureDate];
    NSString *parameters = [[NSString alloc] initWithFormat:formatString,
                            departure_place_iata,
                            departure_place_type,
                            arrival_place_iata,
                            arrival_place_type,
                            departure_date,
                            fclass
                            ];
    NSString *urlWithParameters = [[NSString alloc] initWithFormat:@"%@%@",url,parameters];
    
    [[LRResty client] get:urlWithParameters withBlock:^(LRRestyResponse *response)
     {
         NSString *stringRepresentationOfResponse = [response asString];
         block([self mapFlightsDeparture:stringRepresentationOfResponse andConditions:_offerConditions]);
     }];
    
}
- (void) getFlightsReturnByDateWithCompleteBlock:(void (^)(NSArray *))block
{
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@?",ROOT_PATH,FLIGHT_DESCRIPTION_MANAGER_NEARBY_ROUTE];
    NSString *formatString = @"departure_place_iata=%@&departure_place_type=%@&arrival_place_iata=%@&arrival_place_type=%@&departure_date=%@&flight_class=%@&return_date=%@";
    NSString *departure_place_iata = _offerConditions.searchConditions.direction_departure.cityCode;
    NSString *departure_place_type = [self destinationTypeToNSString:city];
    NSString *arrival_place_iata = _offerConditions.searchConditions.direction_return.cityCode;
    NSString *arrival_place_type = [self destinationTypeToNSString:city];
    NSString *fclass = _offerConditions.searchConditions.typeOfFlight==business?@"1":@"0";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *departure_date = [formatter stringFromDate:_offerConditions.departureDate];
    NSString *return_date = [formatter stringFromDate:_offerConditions.departureDate];
    NSString *parameters = [[NSString alloc] initWithFormat:formatString,
                            departure_place_iata,
                            departure_place_type,
                            arrival_place_iata,
                            arrival_place_type,
                            departure_date,
                            fclass,
                            return_date
                            ];
    NSString *urlWithParameters = [[NSString alloc] initWithFormat:@"%@%@",url,parameters];
    
    [[LRResty client] get:urlWithParameters withBlock:^(LRRestyResponse *response)
     {
         NSString *stringRepresentationOfResponse = [response asString];
         block([self mapFlightsReturn:stringRepresentationOfResponse andConditions:_offerConditions]);
     }];

}
- (void) getAvailableOffersWithCompleteBlock:(void (^)(NSArray *))block
{


    NSString *url = [[NSString alloc] initWithFormat:@"%@%@?",ROOT_PATH,FLIGHT_DESCRIPTION_MANAGER_OFFER_ROUTE];
    NSMutableString *formatString = [[NSMutableString alloc] initWithString: @"departure_place_iata=%@&departure_place_type=%@&arrival_place_iata=%@&arrival_place_type=%@&flight_class=%@&departure_date=%@&adults=%@"];
    //&return_date=
    NSString *departure_place_iata = _offerConditions.searchConditions.direction_departure.cityCode;
    NSString *departure_place_type = [self destinationTypeToNSString:city];
    NSString *arrival_place_iata = _offerConditions.searchConditions.direction_return.cityCode;
    NSString *arrival_place_type = [self destinationTypeToNSString:city];
    NSString *flight_class = _offerConditions.searchConditions.typeOfFlight==business?@"1":@"0";
    NSString *adults = [[NSString alloc] initWithFormat:@"%i",_offerConditions.searchConditions.countOfTickets.intValue];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *departure_date = [formatter stringFromDate:_offerConditions.departureDate];
    if(_offerConditions.returnDate!=nil)
    {
        NSString *return_date = [formatter stringFromDate:_offerConditions.returnDate];
        [formatString appendFormat:@"&return_date=%@",return_date];
    }
    NSString *parameters = [[NSString alloc] initWithFormat:formatString,
                            departure_place_iata,
                            departure_place_type,
                            arrival_place_iata,
                            arrival_place_type,
                            flight_class,
                            departure_date,
                            adults];
    NSString *urlWithParameters = [[NSString alloc] initWithFormat:@"%@%@",url,parameters];
    [[LRResty client] get:urlWithParameters withBlock:^(LRRestyResponse *response)
    {
        NSString *stringRepresentationOfResponse = [response asString];
        block([self mapOffers:stringRepresentationOfResponse]);
    }];
    
}
- (NSArray*)mapOffers:(NSString*)response
{
    NSMutableArray *arrayOfOffers = [NSMutableArray new];
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    NSArray *offersArray = [EKMapper arrayOfObjectsFromExternalRepresentation:jsonArray withMapping:[DMFMMappingProvider fullFlightMapping]];
    for (DMFMFullFlight *dmoffer in offersArray)
    {
        Offer *offer = [Offer new];
        //map departure flight
        offer.flightDeparture = [self fromDMFMFlight:dmoffer.flight_to];
        //map return flight
        offer.flightReturn = dmoffer.flight_return.departure_date!=nil?[self fromDMFMFlight:dmoffer.flight_return]:nil;
        //map offer
        offer.bothPrice = dmoffer.trip_price;
        offer.isSpecial = dmoffer.is_special.intValue!=-1;
        offer.isMomentaryConfirmation = dmoffer.is_guaranted;
        offer.offerConditions = _offerConditions;
        [arrayOfOffers addObject:offer];
    }
    return arrayOfOffers;
}
- (Flight*)fromDMFMFlight:(DMFMFlight*)dmflight
{
    Flight *flight = [Flight new];
    flight.ID = dmflight.Id;
    flight.airlineCite = dmflight.airline_cite;
    flight.airlineTitle = dmflight.airline_title;
    flight.timeInFlight =  [self correctDate:dmflight.flight_time];
    flight.cityDeparture = dmflight.departure_city;
    flight.airportDeparture = dmflight.departure_airport_title;
    flight.cityArrival = dmflight.arrival_city;
    flight.airportArrival = dmflight.arrival_city;
    flight.dateAndTimeDeparture = [self combineDay:dmflight.departure_date andTime:dmflight.departure_time];
    flight.dateAndTimeArrival = [self combineDay:dmflight.arrival_date andTime:dmflight.arrival_time];
    return flight;
}
- (NSDate*) correctDate:(NSDate*) date
{
    return [date dateByAddingTimeInterval:60*60*-3];//minus 3 hours
}
- (NSDate*) combineDay:(NSDate*) day andTime:(NSDate*) time
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *correctedTime = [self correctDate:time];
    NSDateComponents *dayComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:day];
    NSDateComponents *timeComp = [calendar components:NSHourCalendarUnit|NSMinuteCalendarUnit fromDate:correctedTime];
    [dayComp setHour:([timeComp hour])];
    [dayComp setMinute:[timeComp minute]];
    NSDate *result = [calendar dateFromComponents:dayComp];
    return result;
}
- (NSArray*)mapFlightsReturn:(NSString*)response andConditions:(OfferConditions*) offerConditions
{
    NSMutableArray *arrayOfFlights = [NSMutableArray new];
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    NSArray *flightsArray = [EKMapper arrayOfObjectsFromExternalRepresentation:jsonArray withMapping:[DMFDMMappingProvider fullFlightMapping]];
    for (DMFDMFullFlight *fullFlight in flightsArray)
    {
        Flight *flight = [Flight new];
        flight.cityArrival = offerConditions.searchConditions.direction_return.cityTitle;
        flight.cityDeparture = offerConditions.searchConditions.direction_departure.cityTitle;
        flight.airportArrival = offerConditions.searchConditions.direction_return.airportTitle;
        flight.airportDeparture = offerConditions.searchConditions.direction_departure.airportTitle;
        flight.dateAndTimeDeparture = fullFlight.flight_return.departure_date;
        flight.price = fullFlight.trip_price;
        [arrayOfFlights addObject:flight];
    }
    return arrayOfFlights;
}
- (NSArray*)mapFlightsDeparture:(NSString*)response andConditions:(OfferConditions*) offerConditions
{
    NSMutableArray *arrayOfFlights = [NSMutableArray new];
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    NSArray *flightsArray = [EKMapper arrayOfObjectsFromExternalRepresentation:jsonArray withMapping:[DMFDMMappingProvider fullFlightMapping]];
    for (DMFDMFullFlight *fullFlight in flightsArray)
    {
        Flight *flight = [Flight new];
        flight.cityArrival = offerConditions.searchConditions.direction_return.cityTitle;
        flight.cityDeparture = offerConditions.searchConditions.direction_departure.cityTitle;
        flight.airportArrival = offerConditions.searchConditions.direction_return.airportTitle;
        flight.airportDeparture = offerConditions.searchConditions.direction_departure.airportTitle;
        flight.dateAndTimeDeparture = fullFlight.flight_to.departure_date;
        flight.price = fullFlight.trip_price;
        [arrayOfFlights addObject:flight];
    }
    return arrayOfFlights;
}
- (NSString*)destinationTypeToNSString:(DestinationType) destType
{
    if(destType==airport)
    {
        return @"airport";
    }
    else if(destType==city)
    {
        return @"city";
    }
    else if(destType==country)
    {
        return @"country";
    }
    else
    {
        return nil;
    }
}
@end
