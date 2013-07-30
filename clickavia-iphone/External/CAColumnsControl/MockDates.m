//
//  MockDates.m
//  CAManagersLib
//
//  Created by macmini1 on 16.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "MockDates.h"
#import "Flight.h"

@implementation MockDates
+(NSArray*)generateFlyToDates
{
    NSMutableArray *daysFlyTo = [NSMutableArray new];
    for (int j = 0 ; j<12; j++)
    {
        NSDate *date = [NSDate date];
        if (j !=0)
        {
            NSDateComponents *dateComps = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSDayCalendarUnit|NSMonthCalendarUnit fromDate:date];
            [dateComps setDay:1];
            date = [[NSCalendar currentCalendar] dateFromComponents:dateComps];
        }
        for (int i = 1; i<11;i++)
        {

            NSDateComponents *dateComps = [[NSCalendar currentCalendar] components:NSDayCalendarUnit|NSMonthCalendarUnit fromDate:date];
            if(j==0)
            {
                dateComps.day = i+arc4random()%2+1;
            }
            else
            {
                dateComps.day = arc4random()%28+1;
            }

            dateComps.month = j;
            NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComps toDate:date options:0];
            
            Flight *newFlightDep = [[Flight alloc] init];
            newFlightDep.dateAndTimeDeparture = newDate;
            newFlightDep.price = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithInt:(arc4random()%50000+20000)] decimalValue]];
            
            [daysFlyTo addObject:newFlightDep];
        }
    }
    return daysFlyTo;
}
+(NSArray*)generateFlyReturnDates:(NSDate *)flyToDate
{
    NSMutableArray *daysFlyReturn = [NSMutableArray new];
    int count = 12-ABS(([[NSCalendar currentCalendar] components:NSMonthCalendarUnit fromDate:[NSDate date]].month - [[NSCalendar currentCalendar] components:NSMonthCalendarUnit fromDate:flyToDate].month));
    
    for (int j = 0 ; j<count; j++)
    {
        NSDate *date = flyToDate;
        if (j !=0)
        {
            NSDateComponents *dateComps = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSDayCalendarUnit|NSMonthCalendarUnit fromDate:date];
            [dateComps setDay:1];
            date = [[NSCalendar currentCalendar] dateFromComponents:dateComps];
        }
        for (int i = 1; i<11; i++)
        {
            
            NSDateComponents *dateComps = [[NSCalendar currentCalendar] components:NSDayCalendarUnit|NSMonthCalendarUnit fromDate:date];
            if(j==0)
            {
                dateComps.day = i+arc4random()%2+1;
            }
            else
            {
                dateComps.day = arc4random()%28+1;
            }
            
            dateComps.month = j;
            NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComps toDate:date options:0];
            
            Flight *newFlightRet = [[Flight alloc] init];
            newFlightRet.dateAndTimeDeparture = newDate;
            newFlightRet.price = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithInt:(arc4random()%50000+20000)] decimalValue]];
            
            [daysFlyReturn addObject:newFlightRet];
        }
    }
    return daysFlyReturn;
}
@end
