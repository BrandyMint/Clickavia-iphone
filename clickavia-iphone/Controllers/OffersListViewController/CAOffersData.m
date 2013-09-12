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
    
    NSArray* arraycityDeparture = [[NSArray alloc] initWithObjects:@"Анкона", @"Бари", @"Бергамо" ,@"Болонья" ,@"Больцано" ,@"Брешиа" ,@"Венеция" ,@"Верона" ,@"Виченца" ,@"Генуя" ,@"Милан" ,@"Латина" ,@"Модена" ,@"Парма" ,@"Пескара" ,@"Прато" ,@"Реджо-дэ Калабрия" ,@"Реджо-Эмилия" ,@"Рим" ,@"Сиракуза" ,@"Таранто" ,@"Триест" ,@"Турин" ,@"Феррара" ,@"Флоренция" , nil];
    NSArray* arraycityArrival = [[NSArray alloc] initWithObjects:@"Мытищи",@"Нижний Новгород",@"Нижний Тагил",@"Новороссийск",@"Омск",@"Орёл",@"Павлово на Оке",@"Пенза",@"Переславль-Залесский",@"Ростов-на-Дону",@"Санкт-Петербург",@"Москва",@"Чебоксары",@"Рыбинск",@"Пятигорск",@"Пушкинские горы",@"Покров",@"Петрозаводск",@"Петергоф", nil];
    NSArray* arrayAirport = [[NSArray alloc] initWithObjects:@"Aeroflot",@"Morflot",@"Flot",@"Pilot", nil];
    NSArray* arrayAirportTitle = [[NSArray alloc] initWithObjects:@"SU 1567",@"AB 1234",@"BC 5678",@"CD 9012", nil];
    
    for (int i = 0; i<10; i++) {
        Offer* offer = [[Offer alloc] init];
        Flight* flight = [[Flight alloc] init];
        
        offer.isSpecial = arc4random()%2;
        offer.isMomentaryConfirmation = arc4random()%2;
        //offer.isSpecial = 1;
        //offer.isMomentaryConfirmation = 0;
        
        flight.cityDeparture = [arraycityDeparture objectAtIndex:arc4random()%arraycityDeparture.count];
        flight.cityArrival = [arraycityArrival objectAtIndex:arc4random()%arraycityArrival.count];
        flight.airportDeparture = [arrayAirport objectAtIndex:arc4random()%arrayAirport.count];
        flight.airportArrival = [arrayAirport objectAtIndex:arc4random()%arrayAirport.count];
        flight.airlineTitle = [arrayAirport objectAtIndex:arc4random()%arrayAirport.count];
        flight.ID = [arrayAirportTitle objectAtIndex:arc4random()%arrayAirportTitle.count];
        flight.dateAndTimeDeparture = [self generateRandomDateWithinDaysBeforeToday:90 hours:23];
        flight.dateAndTimeArrival = [self generateRandomDateWithinDaysBeforeToday:90 hours:23];
        flight.timeInFlight = [self generateRandomDateWithinDaysBeforeToday:1 hours:2];
        
        offer.flightDeparture = flight;
        offer.flightReturn = flight;
        
        NSDecimalNumber *bothPrice = [[NSDecimalNumber alloc] initWithInt:arc4random()%10000+1000];
        offer.bothPrice = bothPrice;
        
        NSLog(@"до %d %d",offer.isSpecial, offer.isMomentaryConfirmation);
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
