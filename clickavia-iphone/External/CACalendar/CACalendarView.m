//
//  CACalendarView.m
//  CAManagersLib
//
//  Created by macmini1 on 08.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "CACalendarView.h"

@implementation CACalendarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self baseSetup];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if((self = [super initWithCoder:aDecoder]))
    {
        [self baseSetup];
    }
    return self;
}
- (void)willMoveToWindow:(UIWindow *)newWindow
{
    if(newWindow!=nil)
    {
        if(_calendarScrollView)
        {
            if(flyToDays)
            {
                [_calendarScrollView resetAll];
                [_calendarScrollView selectFlyToDaysByDateArray:flyToDays];
                selectedFlyReturn = nil;
                selectedFlyTo = nil;
            }
        }
    }

}
- (void)layoutSubviews
{
    [super layoutSubviews];

}
- (void)baseSetup
{
    gradientLayer = [CAGradientLayer new];
    backgroundImageView = [[UIImageView alloc] initWithImage:[[CACalendarStyle sharedStyle] getCalendarViewBackgroundImage]];

    [gradientLayer removeFromSuperlayer];
    backgroundImageView.frame = self.bounds;
    gradientLayer.colors = [[CACalendarStyle sharedStyle] getCalendarViewGradienColors];
    gradientLayer.frame = self.bounds;
    [self.layer addSublayer:gradientLayer];
    [self addSubview:backgroundImageView];
    
    currentCalendar = [NSCalendar currentCalendar];
    _spaceBetweenSliderAndCalendar = [[CACalendarStyle sharedStyle] getSpaceBetweenSliderAndScroll];
    _monthSliderView = [[CAMonthSliderView alloc] init];
    _monthSliderView.frame = CGRectMake(0, 0, self.frame.size.width, [[CACalendarStyle sharedStyle] getSliderViewHeight]);
    [self addSubview:_monthSliderView];
    currentMonth = [NSDate date];
    [_monthSliderView setDelegate:self];
    _delegate = nil;
    _calendarScrollView = [[CACalendarScrollView alloc] init];

    [self setupRectForCalendarScrollView];
    [self addSubview:_calendarScrollView];
    [_calendarScrollView setDelegate:self];

    
}
- (void) setupRectForCalendarScrollView
{
    CGRect sliderRect = _monthSliderView.frame;
    sliderRect.origin.y +=_spaceBetweenSliderAndCalendar+sliderRect.size.height;
    sliderRect.origin.x = 0;
    sliderRect.size.height = self.frame.size.height - sliderRect.origin.y;
    _calendarScrollView.frame = sliderRect;
}
- (void)selectDate:(NSDate *)date
{
    [_calendarScrollView updateWithSelectedDate:date];
    [_monthSliderView updateWithSelectedMonth:date];
}
- (void) monthSliderView:(CAMonthSliderView *)monthSliderView selectedMonthChanged:(NSDate *)month
{
    currentMonth = month;
    [_calendarScrollView updateWithSelectedDate:month];
    [_delegate calendarView:self didSelectMonth:month];
//    [_delegate calendarView:self didSelectDate:month];

}
- (void) calendarScrollView:(CACalendarScrollView *)calendarScrollView selectedMonthChanged:(NSDate *)month
{
    currentMonth = month;
    [_monthSliderView updateWithSelectedMonth:month];
    [_delegate calendarView:self didSelectMonth:month];
    //[self updateCalendarScrolView:_calendarScrollView withSelection:month];
}
- (void) updateCalendarScrolView:(CACalendarScrollView *)calendarScrollView withSelection:(NSDate*)date
{
    BOOL isFlyTo = [self isFlyTo:date];
    BOOL isFlyReturn = [self isFlyReturn:date];
    if([CACalendarView compareDate:date and:selectedFlyTo]==NSOrderedSame&&selectedFlyTo!=nil)
    {
        [_calendarScrollView resetSelection];
        [_calendarScrollView selectFlyToDaysByDateArray:flyToDays];
        selectedFlyTo = nil;
        selectedFlyReturn = nil;
    }
    else if([CACalendarView compareDate:date and:selectedFlyReturn]==NSOrderedSame&&selectedFlyReturn!=nil)
    {
        selectedFlyReturn = nil;
        [_calendarScrollView resetSelection];
        NSArray *datesForReturn = [self allDatesFrom:flyReturnDays afterDate:selectedFlyTo];
        [_calendarScrollView selectFlyToDate:selectedFlyTo];
        [_calendarScrollView selectFlyReturnDaysByDateArray:datesForReturn];
    }
    
    else if(selectedFlyTo==nil || selectedFlyReturn==nil)
    {
        if(isFlyTo&&!isFlyReturn)
        {
            selectedFlyTo = date;
            
            if(selectedFlyReturn==nil)
            {
                [_calendarScrollView resetSelection];
                NSArray *datesForReturn = [self allDatesFrom:flyReturnDays afterDate:selectedFlyTo];
                [_calendarScrollView selectFlyToDate:date];
                [_calendarScrollView selectFlyReturnDaysByDateArray:datesForReturn];
            }
            else
            {
                selectedFlyTo = date;
                
                NSArray *distanceDays = [CACalendarScrollView dayDistanceBetweenDate:selectedFlyTo andSecondDate:selectedFlyReturn];
                NSDate *dateSeparator = [NSDate date];
                if(distanceDays.count==0)
                {
                    dateSeparator = selectedFlyReturn;
                }
                else
                {
                    dateSeparator = [distanceDays objectAtIndex:distanceDays.count/2];
                }
                
                NSArray *datesForTo = [self allDatesFrom:flyToDays beforeDate:dateSeparator];
                NSArray *datesForReturn = [self allDatesFrom:flyReturnDays afterDate:dateSeparator];
                [_calendarScrollView resetSelection];
                [_calendarScrollView selectFlyToDaysByDateArray:datesForTo];
                [_calendarScrollView selectFlyReturnDaysByDateArray:datesForReturn];
                [_calendarScrollView selectFlyToDate:selectedFlyTo andReturn:selectedFlyReturn];
            }
            
        }
        if(!isFlyTo&&isFlyReturn)
        {
            selectedFlyReturn = date;
            
            NSArray *distanceDays = [CACalendarScrollView dayDistanceBetweenDate:selectedFlyTo andSecondDate:selectedFlyReturn];
            NSDate *dateSeparator = [NSDate date];
            if(distanceDays.count==0)
            {
                dateSeparator = selectedFlyReturn;
            }
            else
            {
                dateSeparator = [distanceDays objectAtIndex:distanceDays.count/2];
            }
            
            NSArray *datesForTo = [self allDatesFrom:flyToDays beforeDate:dateSeparator];
            NSArray *datesForReturn = [self allDatesFrom:flyReturnDays afterDate:dateSeparator];
            
            
            
            [_calendarScrollView resetSelection];
            [_calendarScrollView selectFlyToDaysByDateArray:datesForTo];
            [_calendarScrollView selectFlyReturnDaysByDateArray:datesForReturn];
            [_calendarScrollView selectFlyToDate:selectedFlyTo andReturn:selectedFlyReturn];
        }
        if(isFlyTo&&isFlyReturn)
        {
            if(selectedFlyTo==nil)
            {
                selectedFlyTo = date;
                if(selectedFlyReturn==nil)
                {
                    NSArray *datesForReturn = [self allDatesFrom:flyReturnDays afterDate:selectedFlyTo];
                    [_calendarScrollView resetSelection];
                    [_calendarScrollView selectFlyToDate:date];
                    [_calendarScrollView selectFlyReturnDaysByDateArray:datesForReturn];
                }
                else
                {
                    selectedFlyTo = date;
                    
                    NSArray *distanceDays = [CACalendarScrollView dayDistanceBetweenDate:selectedFlyTo andSecondDate:selectedFlyReturn];
                    NSDate *dateSeparator = [NSDate date];
                    if(distanceDays.count==0)
                    {
                        dateSeparator = selectedFlyReturn;
                    }
                    else
                    {
                        dateSeparator = [distanceDays objectAtIndex:distanceDays.count/2];
                    }
                    
                    NSArray *datesForTo = [self allDatesFrom:flyToDays beforeDate:dateSeparator];
                    NSArray *datesForReturn = [self allDatesFrom:flyReturnDays afterDate:dateSeparator];
                    
                    
                    
                    [_calendarScrollView resetSelection];
                    [_calendarScrollView selectFlyToDaysByDateArray:datesForTo];
                    [_calendarScrollView selectFlyReturnDaysByDateArray:datesForReturn];
                    [_calendarScrollView selectFlyToDate:selectedFlyTo andReturn:selectedFlyReturn];
                }
            }
            else if(selectedFlyReturn==nil)
            {
                selectedFlyReturn = date;
                NSArray *distanceDays = [CACalendarScrollView dayDistanceBetweenDate:selectedFlyTo andSecondDate:selectedFlyReturn];
                NSDate *dateSeparator = [NSDate date];
                if(distanceDays.count==0)
                {
                    dateSeparator = selectedFlyReturn;
                }
                else
                {
                    dateSeparator = [distanceDays objectAtIndex:distanceDays.count/2];
                }
                
                NSArray *datesForTo = [self allDatesFrom:flyToDays beforeDate:dateSeparator];
                NSArray *datesForReturn = [self allDatesFrom:flyReturnDays afterDate:dateSeparator];
                
                
                
                [_calendarScrollView resetSelection];
                [_calendarScrollView selectFlyToDaysByDateArray:datesForTo];
                [_calendarScrollView selectFlyReturnDaysByDateArray:datesForReturn];
                [_calendarScrollView selectFlyToDate:selectedFlyTo andReturn:selectedFlyReturn];
            }
        }
        
    }
    else
    {
        NSArray *distanceDays = [CACalendarScrollView dayDistanceBetweenDate:selectedFlyTo andSecondDate:selectedFlyReturn];
        NSDate *dateSeparator = [NSDate date];
        if(distanceDays.count==0)
        {
            dateSeparator = selectedFlyReturn;
        }
        else
        {
            dateSeparator = [distanceDays objectAtIndex:distanceDays.count/2];
        }
        
        NSArray *datesForTo = [self allDatesFrom:flyToDays beforeDate:dateSeparator];
        NSArray *datesForReturn = [self allDatesFrom:flyReturnDays afterDate:dateSeparator];
        if([self isDate:date inArray:datesForTo])
        {
            selectedFlyTo = nil;
            [self calendarScrollView:(CACalendarScrollView *)calendarScrollView selectedDateChanged:(NSDate *)date];
        }
        else if([self isDate:date inArray:datesForReturn])
        {
            selectedFlyReturn = nil;
            [self calendarScrollView:(CACalendarScrollView *)calendarScrollView selectedDateChanged:(NSDate *)date];        }
    }

}
- (void) calendarScrollView:(CACalendarScrollView *)calendarScrollView selectedDateChanged:(NSDate *)date
{
    [self updateCalendarScrolView:calendarScrollView withSelection:date];
    [_delegate calendarView:self didSelectDate:date];
}
- (NSArray*)allDatesFrom:(NSArray*) datesArray beforeDate:(NSDate*) date
{
    NSMutableArray *dates = [NSMutableArray new];
    for (NSDate *currentDate in datesArray)
    {
        if([CACalendarView compareDate:currentDate and:date]==NSOrderedAscending)
        {
            [dates addObject:currentDate];
        }
    }
    return dates;
}
- (NSArray*)allDatesFrom:(NSArray*) datesArray afterDate:(NSDate*) date
{
    NSMutableArray *dates = [NSMutableArray new];
    for (NSDate *currentDate in datesArray)
    {
        NSComparisonResult result = [CACalendarView compareDate:currentDate and:date];
        if(result==NSOrderedDescending||result == NSOrderedSame)
        {
            [dates addObject:currentDate];
        }
    }
    return dates;
}

- (BOOL)isDate:(NSDate*)date inArray:(NSArray*)datesArray
{
    BOOL result = NO;
    for(NSDate *currentDate in datesArray)
    {
        if([CACalendarView compareDate:currentDate and:date]==NSOrderedSame)
        {
            result = YES;
            return result;
        }
    }
    return result;
}
- (BOOL)isFlyTo:(NSDate*)date
{
    return [self isDate:date inArray:flyToDays];
}
- (BOOL)isFlyReturn:(NSDate*)date
{
    return [self isDate:date inArray:flyReturnDays];
}

+(NSComparisonResult) compareDate:(NSDate*)first and:(NSDate*)second
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    if(first==nil||second==nil) return NSOrderedSame;
    NSDateComponents *firstComponents = [calendar components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:first];
    NSDateComponents *secondComponents = [calendar components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:second];
    
    NSDate *firstDate = [calendar dateFromComponents:firstComponents];
    NSDate *secondDate = [calendar dateFromComponents:secondComponents];
    return [firstDate compare:secondDate];
}
- (void) selectFlyToDaysByDateArray:(NSArray *)dayArray
{
    flyToDays = dayArray;
    [_calendarScrollView selectFlyToDaysByDateArray:dayArray];
}
- (void) selectFlyReturnDaysByDateArray:(NSArray *)dayArray
{
    flyReturnDays = dayArray;
    [_calendarScrollView selectFlyReturnDaysByDateArray:dayArray];
}
- (NSDate*) getFlyToDate
{
    return selectedFlyTo;
}
- (NSDate*) getFlyReturnDate
{
    return selectedFlyReturn;
}
- (NSDate*) getCurrentMonth
{
    return currentMonth;
}
- (void)resetSelections
{
    flyToDays = [NSArray new];
    flyReturnDays = [NSArray new];
    selectedFlyTo = nil;
    selectedFlyReturn = nil;
    [_calendarScrollView selectFlyReturnDaysByDateArray:flyReturnDays];
    [_calendarScrollView selectFlyToDaysByDateArray:flyToDays];
    [_calendarScrollView resetSelection];
}
@end
