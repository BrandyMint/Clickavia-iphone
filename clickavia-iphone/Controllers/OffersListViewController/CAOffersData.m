//
//  CAOffersData.m
//  clickavia-iphone
//
//  Created by bespalown on 9/11/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CAOffersData.h"

@implementation CAOffersData
{
    /*
    Flight* flightDepartureObject;
    Flight* flightReturnObject;
    OfferConditions* offerConditions;
    SearchConditions* searchConditions;
    Destination* destinationDeparture;
    Destination* destinationReturn;
     */
}

-(NSArray*)arrayOffer
{
    NSMutableArray* arrayOffers = [[NSMutableArray alloc] initWithCapacity:10];
    
    NSArray* arraycityDeparture = [[NSArray alloc] initWithObjects:@"Анкона", @"Бари", @"Бергамо" , @"Болонья" , @"Больцано" , @"Брешиа" , @"Венеция" , @"Верона" , @"Виченца" , @"Генуя" , @"Милан" , @"Латина" ,@"Модена" , @"Парма" ,@"Пескара " ,@"Прато" , @"Реджо-дэ Калабрия" , @"Реджо-Эмилия" , @"Рим" , @"Сиракуза" , @"Таранто" ,@"Триест" ,@"Турин" ,@"Феррара" ,@"Флоренция" , nil];
    NSArray* arraycityArrival = [[NSArray alloc] initWithObjects:@"Мытищи", @"Нижний Новгород", @"Нижний Тагил", @"Новороссийск", @"Омск", @"Орёл", @"Павлово на Оке", @"Пенза", @"Переславль-Залесский", @"Ростов-на-Дону", @"Санкт-Петербург", @"Москва", @"Чебоксары", @"Рыбинск", @"Пятигорск",@"Пушкинские горы", @"Покров",@" Петрозаводск", @"Петергоф", nil];
    NSArray* arrayAirport = [[NSArray alloc] initWithObjects:@"Aeroflot",@"Morflot",@"Flot",@"Pilot", nil];
    NSArray* arrayAirportTitle = [[NSArray alloc] initWithObjects:@"SU 1567",@"AB 1234",@"BC 5678",@"CD 9012", nil];
    
    NSArray* RarraycityDeparture = [[NSArray alloc] initWithObjects:@"Анкона", @"Бари", @"Бергамо" , @"Болонья" , @"Больцано" , @"Брешиа" , @"Венеция" , @"Верона" , @"Виченца" , @"Генуя" , @"Милан" , @"Латина" ,@"Модена" , @"Парма" ,@"Пескара " ,@"Прато" , @"Реджо-дэ Калабрия" , @"Реджо-Эмилия" , @"Рим" , @"Сиракуза" , @"Таранто" ,@"Триест" ,@"Турин" ,@"Феррара" ,@"Флоренция" , nil];
    NSArray* RarraycityArrival = [[NSArray alloc] initWithObjects:@"Мытищи", @"Нижний Новгород", @"Нижний Тагил", @"Новороссийск", @"Омск", @"Орёл", @"Павлово на Оке", @"Пенза", @"Переславль-Залесский", @"Ростов-на-Дону", @"Санкт-Петербург", @"Москва", @"Чебоксары", @"Рыбинск", @"Пятигорск",@"Пушкинские горы", @"Покров",@" Петрозаводск", @"Петергоф", nil];
    NSArray* RarrayAirport = [[NSArray alloc] initWithObjects:@"Aeroflot",@"Morflot",@"Flot",@"Pilot", nil];
    NSArray* RarrayAirportTitle = [[NSArray alloc] initWithObjects:@"SU 1567",@"AB 1234",@"BC 5678",@"CD 9012", nil];
    NSArray *DestinationCodeArray = [[NSArray alloc] initWithObjects:@"SVO", @"KVO", @"PVO", @"TVO", @"OGO", @"ITD", nil];
    NSArray *DestinationCityCodeArray = [[NSArray alloc] initWithObjects:@"MOW",@"SPT", @"CHE", @"VOR", nil];
    NSArray* airportTitle = [[NSArray alloc] initWithObjects:@"Шереметьево",@"Пашковский",@"Московский",@"Домодедово",@"Внуково", nil];
    
    for (int i = 0; i<10; i++) {
        Offer* offer = [[Offer alloc] init];
        
        offer.isSpecial = arc4random()%2;
        offer.isMomentaryConfirmation = arc4random()%2;
        
        Flight* flightDeparture = [[Flight alloc] init];
        flightDeparture.cityDeparture = [arraycityDeparture objectAtIndex:arc4random()%arraycityDeparture.count];
        flightDeparture.cityArrival = [arraycityArrival objectAtIndex:arc4random()%arraycityArrival.count];
        flightDeparture.airportDeparture = [arrayAirport objectAtIndex:arc4random()%arrayAirport.count];
        flightDeparture.airportArrival = [arrayAirport objectAtIndex:arc4random()%arrayAirport.count];
        flightDeparture.airlineTitle = [arrayAirport objectAtIndex:arc4random()%arrayAirport.count];
        flightDeparture.ID = [arrayAirportTitle objectAtIndex:arc4random()%arrayAirportTitle.count];
        flightDeparture.dateAndTimeDeparture = [self generateRandomDateWithinDaysBeforeToday:90 hours:23];
        flightDeparture.dateAndTimeArrival = [self generateRandomDateWithinDaysBeforeToday:90 hours:23];
        flightDeparture.timeInFlight = [self generateRandomDateWithinDaysBeforeToday:1 hours:2];
        offer.flightDeparture = flightDeparture;

        Flight* flightReturn = [[Flight alloc] init];
        flightReturn.cityDeparture = [RarraycityDeparture objectAtIndex:arc4random()%arraycityDeparture.count];
        flightReturn.cityArrival = [RarraycityArrival objectAtIndex:arc4random()%arraycityArrival.count];
        flightReturn.airportDeparture = [RarrayAirport objectAtIndex:arc4random()%arrayAirport.count];
        flightReturn.airportArrival = [RarrayAirport objectAtIndex:arc4random()%arrayAirport.count];
        flightReturn.airlineTitle = [RarrayAirport objectAtIndex:arc4random()%arrayAirport.count];
        flightReturn.ID = [RarrayAirportTitle objectAtIndex:arc4random()%arrayAirportTitle.count];
        flightReturn.dateAndTimeDeparture = [self generateRandomDateWithinDaysBeforeToday:90 hours:23];
        flightReturn.dateAndTimeArrival = [self generateRandomDateWithinDaysBeforeToday:90 hours:23];
        flightReturn.timeInFlight = [self generateRandomDateWithinDaysBeforeToday:1 hours:2];
        offer.flightReturn = flightReturn;
        
        NSDecimalNumber *bothPrice = [[NSDecimalNumber alloc] initWithInt:arc4random()%10000+1000];
        offer.bothPrice = bothPrice;

        OfferConditions* offerConditions = [[OfferConditions alloc] init];

        
        SearchConditions* searchConditions = [[SearchConditions alloc] init];

        
        Destination* destinationDeparture = [[Destination alloc] init];
        destinationDeparture.airportTitle = [airportTitle objectAtIndex:arc4random()%airportTitle.count];
        destinationDeparture.code = [DestinationCodeArray objectAtIndex:arc4random()%DestinationCodeArray.count];
        
        Destination* destinationReturn = [[Destination alloc] init];
        destinationReturn.airportTitle = [airportTitle objectAtIndex:arc4random()%airportTitle.count];
        destinationReturn.code = [DestinationCodeArray objectAtIndex:arc4random()%DestinationCodeArray.count];
        
        searchConditions.direction_return = destinationReturn;
        searchConditions.direction_departure = destinationDeparture;
        offerConditions.searchConditions = searchConditions;
        offer.offerConditions = offerConditions;

        
        [arrayOffers addObject:offer];
    }
    return arrayOffers;
}

-(NSArray*)arrayPassangers
{
    NSMutableArray* arrayPassangers = [[NSMutableArray alloc] initWithCapacity:10];
    for (int i=0; i<10; i++) {
        CAFlightPassengersCount* passangers = [[CAFlightPassengersCount alloc] init];
        passangers.adultsCount = arc4random()%5+1;
        passangers.childrenCount = arc4random()%4;
        passangers.infantsCount = arc4random()%3;
        [arrayPassangers addObject:passangers];
    }
    return arrayPassangers;
}

- (NSDate *) generateRandomDateWithinDaysBeforeToday:(NSInteger)days hours:(NSUInteger)hours
{
    int r1 = arc4random_uniform(days);
    int r2 = arc4random_uniform(hours);
    int r3 = arc4random_uniform(59);
    
    NSDate *today = [NSDate new];
    NSCalendar *gregorian =
    [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *offsetComponents = [NSDateComponents new];
    [offsetComponents setDay:(r1*-1)];
    [offsetComponents setHour:r2];
    [offsetComponents setMinute:r3];
    
    NSDate *rndDate1 = [gregorian dateByAddingComponents:offsetComponents
                                                  toDate:today options:0];
    return rndDate1;
}

@end
