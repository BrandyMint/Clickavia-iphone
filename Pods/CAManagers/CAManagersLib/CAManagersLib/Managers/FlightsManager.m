//
//  FlightsManager.m
//  CAManagersLib
//
//  Created by macmini1 on 25.06.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "FlightsManager.h"

@implementation FlightsManager
- (id) init
{
    self = [super init];
    if(self)
    {
        availableDeparturesDates = [NSMutableArray new];
        availableReturnDates = [NSMutableArray new];
    }
    return self;
}

- (void)getAvailableReturnDates:(SearchConditions *)forConditions withDepartureDate:(NSDate *)withDepartureDate completeBlock:(void (^)(NSArray *dates))block
{
    [self loadData:forConditions andDate:withDepartureDate isDeparture:NO completeBlock:block];

}
- (void)getAvailableDepartureDates:(SearchConditions *)forConditions departureDate:(NSDate *)withDepartureDate completeBlock:(void (^)(NSArray *dates))block
{
    
    [self loadData:forConditions andDate:withDepartureDate isDeparture:YES completeBlock:block];
}

- (void)loadData:(SearchConditions*) forConditions andDate:(NSDate*)depDate isDeparture:(BOOL)departure completeBlock:(void (^)(NSArray *dates))block;
{


    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",ROOT_PATH,FLIGHTS_MANAGER_ROUTE];
    NSMutableString *formatString = [[NSMutableString alloc] initWithString: @"?departure_place_iata=%@&departure_place_type=%@&arrival_place_iata=%@&arrival_place_type=%@&flight_class=%@&month=%@&type=%@"];
    
    NSString *departure_place_iata = forConditions.direction_departure.cityCode;
    NSString *departure_place_type = [self destinationTypeToNSString:city];
    NSString *arrival_place_iata = forConditions.direction_return.cityCode;
    NSString *arrival_place_type = [self destinationTypeToNSString:city];
    NSString *fclass = forConditions.typeOfFlight==business?@"1":@"0";
    
    NSString *month;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    if(depDate==nil)
    {
        NSDate *today = [NSDate date];
        month = [formatter stringFromDate:today];
    }
    else
    {
        
        month = [formatter stringFromDate:depDate];
    }
    
    
    
    //NSString *adults = [[NSString alloc] initWithFormat:@"%i",forConditions.countOfTickets.intValue];
    
    NSString *type;
    if(forConditions.isBothWays)
    {
        type = @"both";
    }
    else
    {
        if(departure)
        {
            type = @"depart";
        }
        else
        {
            type = @"return";
        }
    }
    NSString *parameters;
    if(forConditions.isBothWays||!departure)
    {
        [formatString appendFormat:@"&departure_date=%@&return_date=%@",month,month];
    }
    
    parameters = [[NSString alloc] initWithFormat:(NSString*)formatString,
                            departure_place_iata,
                            departure_place_type,
                            arrival_place_iata,
                            arrival_place_type,
                            fclass,
                            month,
                            type
                            ];
    
    NSString *urlWithParams = [[NSString alloc] initWithFormat:@"%@%@",url,parameters];
    [[LRResty client] get:urlWithParams withBlock:^(LRRestyResponse *response)
         {
             stringRepresentationOfResponse = [[NSString alloc] initWithString:[response asString]];
             if(departure)
             {
                 [self mapResponseForAvailableDepartureDates];
                 block(availableDeparturesDates);
             }
             else
             {
                 [self mapResponseForAvailableReturnDates];
                 block(availableReturnDates);
             }


     
         }];
     

    
}
- (void)mapResponseForAvailableReturnDates
{
    [availableReturnDates removeAllObjects];
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:[stringRepresentationOfResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    for(NSString *str in jsonArray)
    {
        
        [availableReturnDates addObject:[formatter dateFromString:str]];
    }
}
- (void)mapResponseForAvailableDepartureDates
{
    [availableDeparturesDates removeAllObjects];
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:[stringRepresentationOfResponse dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    for(NSString *str in jsonArray)
    {
        [availableDeparturesDates addObject:[formatter dateFromString:str]];
    }
    [availableReturnDates removeAllObjects];

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
