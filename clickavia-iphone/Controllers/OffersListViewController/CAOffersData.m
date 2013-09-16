//
//  CAOffersData.m
//  clickavia-iphone
//
//  Created by bespalown on 9/11/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CAOffersData.h"

@implementation CAOffersData

-(NSArray*)arrayOffer
{
    NSMutableArray* arrayOffers = [[NSMutableArray alloc] initWithCapacity:10];
    
    NSArray* arraycityDeparture = [[NSArray alloc] initWithObjects:@"D-Анкона", @"D-Бари", @"D-Бергамо" , @"D-Болонья" , @"D-Больцано" , @"D-Брешиа" , @"D-Венеция" , @"D-Верона" , @"D-Виченца" , @"D-Генуя" , @"D-Милан" , @"D-Латина" ,@"D-Модена" , @"D-Парма" ,@"D-Пескара D-" ,@"D-Прато" , @"D-Реджо-дэ Калабрия" , @"D-Реджо-Эмилия" , @"D-Рим" , @"D-Сиракуза" , @"D-Таранто" ,@"D-Триест" ,@"D-Турин" ,@"D-Феррара" ,@"D-Флоренция" , nil];
    NSArray* arraycityArrival = [[NSArray alloc] initWithObjects:@"D-Мытищи", @"D-Нижний Новгород", @"D-Нижний Тагил", @"D-Новороссийск", @"D-Омск", @"D-Орёл", @"D-Павлово на Оке", @"D-Пенза", @"D-Переславль-Залесский", @"D-Ростов-на-Дону", @"D-Санкт-Петербург", @"D-Москва", @"D-Чебоксары", @"D-Рыбинск", @"D-Пятигорск",@"D-Пушкинские горы", @"D-Покров",@" D-Петрозаводск", @"D-Петергоф", nil];
    NSArray* arrayAirport = [[NSArray alloc] initWithObjects:@"D-Aeroflot",@"D-Morflot",@"D-Flot",@"D-Pilot", nil];
    NSArray* arrayAirportTitle = [[NSArray alloc] initWithObjects:@"D-SU 1567",@"D-AB 1234",@"D-BC 5678",@"D-CD 9012", nil];
    
    NSArray* RarraycityDeparture = [[NSArray alloc] initWithObjects:@"R-Анкона", @"R-Бари", @"R-Бергамо" , @"R-Болонья" , @"R-Больцано" , @"R-Брешиа" , @"R-Венеция" , @"R-Верона" , @"R-Виченца" , @"R-Генуя" , @"R-Милан" , @"R-Латина" ,@"R-Модена" , @"R-Парма" ,@"R-Пескара R-" ,@"R-Прато" , @"R-Реджо-дэ Калабрия" , @"R-Реджо-Эмилия" , @"R-Рим" , @"R-Сиракуза" , @"R-Таранто" ,@"R-Триест" ,@"R-Турин" ,@"R-Феррара" ,@"R-Флоренция" , nil];
    NSArray* RarraycityArrival = [[NSArray alloc] initWithObjects:@"R-Мытищи", @"R-Нижний Новгород", @"R-Нижний Тагил", @"R-Новороссийск", @"R-Омск", @"R-Орёл", @"R-Павлово на Оке", @"R-Пенза", @"R-Переславль-Залесский", @"R-Ростов-на-Дону", @"R-Санкт-Петербург", @"R-Москва", @"R-Чебоксары", @"R-Рыбинск", @"R-Пятигорск",@"R-Пушкинские горы", @"R-Покров",@" R-Петрозаводск", @"R-Петергоф", nil];
    NSArray* RarrayAirport = [[NSArray alloc] initWithObjects:@"R-Aeroflot",@"R-Morflot",@"R-Flot",@"R-Pilot", nil];
    NSArray* RarrayAirportTitle = [[NSArray alloc] initWithObjects:@"R-SU 1567",@"R-AB 1234",@"R-BC 5678",@"R-CD 9012", nil];
    
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
    
        [arrayOffers addObject:offer];
    }
    return arrayOffers;
}

-(NSArray*)arrayPassangers
{
    NSMutableArray* arrayPassangers = [[NSMutableArray alloc] initWithCapacity:10];
    for (int i=0; i<10; i++) {
        FlightPassengersCount* passangers = [[FlightPassengersCount alloc] init];
        passangers.adults = arc4random()%5+1;
        passangers.kids = arc4random()%4;
        passangers.babies = arc4random()%3;
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
