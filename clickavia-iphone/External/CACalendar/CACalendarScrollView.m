//
//  CACalendarScrollView.m
//  CAManagersLib
//
//  Created by macmini1 on 08.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "CACalendarScrollView.h"

@implementation CACalendarScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        calendar = [NSCalendar currentCalendar];
        [self baseSetup];
        [self initLogicCalendar];
        lastUpdateScroll = [NSDate date];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if((self = [super initWithCoder:aDecoder]))
    {
        calendar = [NSCalendar currentCalendar];
        [self baseSetup];
        lastUpdateScroll = [NSDate date];
        [self initLogicCalendar];

    }
    return self;
}
- (void)initLogicCalendar
{
    allDays = [NSMutableArray new];
    NSDate *today = [NSDate date];

    for (int i=0;i<12;i++)
    {
        NSDateComponents *components = [[NSDateComponents alloc] init];
        components.month = i;
        NSDate *requiredMonth = [calendar dateByAddingComponents:components toDate:today options:0];
        NSMutableArray *daysInThisMonth = [NSMutableArray new];
        NSRange days = [calendar rangeOfUnit:NSDayCalendarUnit
                                      inUnit:NSMonthCalendarUnit
                                     forDate:requiredMonth];
        for(int j = 0; j<days.length;j++)
        {
            dayType typeOfThisDay = CADayTypeOther;
            if(i==0)
            {
                NSDateComponents *comps = [calendar components:NSMonthCalendarUnit|NSDayCalendarUnit|NSYearCalendarUnit fromDate:[NSDate date]];
                if(j<(comps.day-1))
                {
                    typeOfThisDay = CADayTypeLast;
                }
                else if(j==(comps.day - 1 ))
                {
                    typeOfThisDay = CADayTypeToday;
                }
            }
            NSNumber *number = [[NSNumber alloc] initWithInteger:typeOfThisDay];
            [daysInThisMonth addObject:number];
        }
        [allDays addObject:daysInThisMonth];
    }

}
- (void) baseSetup
{
    lastUpdateScroll = [NSDate date];
    offset = 0;
    _testIPhone = 0;
    firstMonthDayNamesLabels = [NSMutableArray new];
    _spaceBetweenDayTitlesAndCalendar = 20;
    _font = [UIFont systemFontOfSize:12];
    _textNamesColor = [UIColor colorWithWhite:0 alpha:1];
     _delegate = nil;
    _defaultDayColor = [UIColor blackColor];
    _todayDayColor = [UIColor grayColor];
    _lastDayColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.2];
    _selectReturnDateColor = [UIColor colorWithRed:0 green:0.0 blue:0.5 alpha:1];
    _selectToDateColor = [UIColor colorWithRed:0 green:0.5 blue:0.0 alpha:1];
    
    
    //scrollViewForDays = [[UIView alloc] init];
    
    if(_testIPhone==0)
    {
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            secondMonthDayNamesLabels = [NSMutableArray new];
            [self baseSetupIPad];
        }
        else
        {
            secondMonthDayNamesLabels = nil;
            [self baseSetupIPhone];
        }
    }
    else
    {
        secondMonthDayNamesLabels = nil;
        [self baseSetupIPhone];
    }
    flowLayout = [[CACalendarCollectionViewFlowLayout alloc] init];
    if(_testIPhone==0)
    {
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
        }
        else
        {
            flowLayout.itemSize = CGSizeMake(flowLayout.parentFrame.size.width, flowLayout.parentFrame.size.height);
        }
    }
    else
    {
            flowLayout.itemSize = CGSizeMake(flowLayout.parentFrame.size.width, flowLayout.parentFrame.size.height);
    }
    collectionDaysView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:flowLayout];
    [collectionDaysView setDelegate:self];
    [collectionDaysView setDataSource:self];
    [collectionDaysView registerClass:[CAMonthView class] forCellWithReuseIdentifier:@"cell"];
    collectionDaysView.backgroundColor = [UIColor whiteColor];
    
}
- (void)monthView:(CAMonthView *)calendarView didSelectDay:(NSInteger)day
{
        NSDate *today = [NSDate date];
        NSDateComponents *dateComps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:today];
        dateComps.month = calendarView.tag;
        day++;
        dateComps.day = dateComps.day>day?day-dateComps.day:day-dateComps.day;
        dateComps.year = 0;
        NSDate *selectedDate = [calendar dateByAddingComponents:dateComps toDate:today options:0];
        [_delegate calendarScrollView:self selectedDateChanged:selectedDate];
}

- (void)baseSetupIPad
{

    for(int i = 0; i<7;i++)
    {
        UILabel *label = [UILabel new];
        label.font = _font;
        label.text = [self dayOfWeekString:i];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = _textNamesColor;
        label.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        [firstMonthDayNamesLabels addObject:label];
    }
    for(int i = 0; i<7;i++)
    {
        UILabel *label = [UILabel new];
        label.font = _font;
        label.text = [self dayOfWeekString:i];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = _textNamesColor;
        label.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        [secondMonthDayNamesLabels addObject:label];
    }

}
- (void)baseSetupIPhone
{
    for(int i = 0; i<7;i++)
    {
        UILabel *label = [UILabel new];
        label.font = _font;
        label.text = [self dayOfWeekString:i];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = _textNamesColor;
        label.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        [firstMonthDayNamesLabels addObject:label];
    }
    
}


- (void) layoutSubviews
{
    [super layoutSubviews];

    
    for (UIView *subView in self.subviews)
    {
        [subView removeFromSuperview];
    }
    if(_testIPhone==0)
    {
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            [self layoutSubviewsIPad];
        }
        else
        {
            [self layoutSubviewsIPhone];
        }
    }
    else
    {
        [self layoutSubviewsIPhone];
    }
    collectionDaysView.frame = CGRectMake(0, _spaceBetweenDayTitlesAndCalendar+((UILabel*)[firstMonthDayNamesLabels objectAtIndex:0]).frame.size.height, self.frame.size.width, self.frame.size.height - _spaceBetweenDayTitlesAndCalendar-((UILabel*)[firstMonthDayNamesLabels objectAtIndex:0]).frame.size.height);
    flowLayout = [[CACalendarCollectionViewFlowLayout alloc] initWithParentFrame:collectionDaysView.frame];
    if(_testIPhone==0)
    {
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
        }
        else
        {
            flowLayout.itemSize = CGSizeMake(flowLayout.parentFrame.size.width, flowLayout.parentFrame.size.height);
        }
    }
    else
    {
        flowLayout.itemSize = CGSizeMake(flowLayout.parentFrame.size.width, flowLayout.parentFrame.size.height);
    }
    [collectionDaysView setCollectionViewLayout:flowLayout];
    self.backgroundColor = [UIColor clearColor];
    collectionDaysView.backgroundColor = [UIColor clearColor];
    //[self addSubview:scrollViewForDays];
}
 - (void) layoutSubviewsIPad
{
    for (int i = 0; i < firstMonthDayNamesLabels.count; i++)
    {
        UILabel *dayLabel = [firstMonthDayNamesLabels objectAtIndex:i];
        CGSize stringBoundingBox = [dayLabel.text sizeWithFont:_font];
        CGFloat x = 0;
        if(i!=0)
        {
            UILabel *previousMonth = [firstMonthDayNamesLabels objectAtIndex:i-1];
            x = previousMonth.frame.origin.x + previousMonth.frame.size.width;
        }
        
        dayLabel.frame = CGRectMake(x,0, self.frame.size.width/2.0/7.0, stringBoundingBox.height);
    }
    for (int i = secondMonthDayNamesLabels.count-1; i >=0; i--)
        {
            UILabel *dayLabel = [secondMonthDayNamesLabels objectAtIndex:i];
            CGSize stringBoundingBox = [dayLabel.text sizeWithFont:_font];
            CGFloat x = self.frame.size.width-self.frame.size.width/2.0/7.0;
            if(i!=6)
            {
                UILabel *previousMonth = [secondMonthDayNamesLabels objectAtIndex:i+1];
                x = previousMonth.frame.origin.x - previousMonth.frame.size.width;
            }
            dayLabel.frame = CGRectMake(x,0, self.frame.size.width/2.0/7.0, stringBoundingBox.height);
        }

    
    for (UIView *view in firstMonthDayNamesLabels)
    {
        [self addSubview:view];
    }
    for (UIView *view in secondMonthDayNamesLabels)
    {
        [self addSubview:view];
    }
    [collectionDaysView removeFromSuperview];
    collectionDaysView.frame = self.frame;
    [self addSubview:collectionDaysView];


}
- (void) layoutSubviewsIPhone
{
    for (int i = 0; i < firstMonthDayNamesLabels.count; i++)
    {
        UILabel *dayLabel = [firstMonthDayNamesLabels objectAtIndex:i];
        CGSize stringBoundingBox = [dayLabel.text sizeWithFont:_font];
        CGFloat x = 0;
        if(i!=0)
        {
            UILabel *previousMonth = [firstMonthDayNamesLabels objectAtIndex:i-1];
            x = previousMonth.frame.origin.x + previousMonth.frame.size.width;
        }

        dayLabel.frame = CGRectMake(x,0, self.frame.size.width/7.0, stringBoundingBox.height);
    }

    
    for (UIView *view in firstMonthDayNamesLabels)
    {
        [self addSubview:view];
    }
    [collectionDaysView removeFromSuperview];
    collectionDaysView.frame = self.frame;
    [self addSubview:collectionDaysView];

}

- (void)updateWithSelectedDate:(NSDate *)selectedDate
{
    NSDate *today = [NSDate date];
    NSInteger todayMonth = [[calendar components:NSMonthCalendarUnit fromDate:today] month];
    NSInteger selected = [[calendar components:NSMonthCalendarUnit fromDate:selectedDate] month];
    NSInteger difference = todayMonth>selected?selected+12-todayMonth:selected-todayMonth;
    CGFloat newOffset = collectionDaysView.frame.size.width;
    if(_testIPhone==0)
    {
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            newOffset/=2.0;
        }
        else
        {
            
        }
    }
    
    collectionDaysView.contentOffset = CGPointMake(difference*newOffset+difference*1,0);
    offset = difference;
//    [UIView commitAnimations];
}
- (NSString*) dayOfWeekString:(NSInteger) day
{
    NSString *dayString;
    switch (day)
    {
        case 0:
            dayString = @"ПН";
            break;
        case 1:
            dayString = @"ВТ";
            break;
        case 2:
            dayString = @"СР";
            break;
        case 3:
            dayString = @"ЧТ";
            break;
        case 4:
            dayString = @"ПТ";
            break;
        case 5:
            dayString = @"СБ";
            break;
        case 6:
            dayString = @"ВС";
            break;
        default:
            break;
    }
    return dayString;
}

- (BOOL)isToday:(dayType)dayType
{
    return dayType==CADayTypeTodayTo||
            dayType==CADayTypeToday||
            dayType==CADayTypeTodayToSelected;
}

- (void)selectFlyReturnDaysByDateArray:(NSArray *)dayArray
{
    if(dayArray.count==0)
    {

        for (NSDate *date in daysReturn)
        {
            NSDate *today = [NSDate date];
            NSInteger todayMonth = [[calendar components:NSMonthCalendarUnit fromDate:today] month];
            NSInteger selected = [[calendar components:NSMonthCalendarUnit fromDate:date] month];
            NSInteger differenceMonth = todayMonth>selected?selected+12-todayMonth:selected-todayMonth;
            NSInteger day = [[calendar components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:date] day];
            CAMonthView *monthView = (CAMonthView*)[collectionDaysView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:differenceMonth inSection:0]];
            CADay *dayButton = [monthView.daysButtons objectAtIndex:day-1];
            
            NSNumber *number = [((NSMutableArray*)[allDays objectAtIndex:differenceMonth]) objectAtIndex:day-1];
            if(number.integerValue!=CADayTypeOther)
            {
               if([self isToday:number.integerValue])
               {
                   number = [[NSNumber alloc] initWithInt:CADayTypeToday];
                   [((NSMutableArray*)[allDays objectAtIndex:differenceMonth]) replaceObjectAtIndex:day-1 withObject:number];
                   dayButton.typeOfDay = CADayTypeToday;
               }
                else
                {
                    number = [[NSNumber alloc] initWithInt:CADayTypeOther];
                    [((NSMutableArray*)[allDays objectAtIndex:differenceMonth]) replaceObjectAtIndex:day-1 withObject:number];
                    dayButton.typeOfDay = CADayTypeOther;
                }
                

            }
           [dayButton refreshDay];
        }
        daysReturn = dayArray;
        
    }
    else
    {
        daysReturn = dayArray;
        for (NSDate *date in dayArray)
        {
            NSDate *today = [NSDate date];
            NSInteger todayMonth = [[calendar components:NSMonthCalendarUnit fromDate:today] month];
            NSInteger selected = [[calendar components:NSMonthCalendarUnit fromDate:date] month];
            NSInteger differenceMonth = todayMonth>selected?selected+12-todayMonth:selected-todayMonth;
            NSInteger day = [[calendar components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:date] day];
            CAMonthView *monthView = (CAMonthView*)[collectionDaysView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:differenceMonth inSection:0]];
            CADay *dayButton = [monthView.daysButtons objectAtIndex:day-1];
            
            NSNumber *number = [((NSMutableArray*)[allDays objectAtIndex:differenceMonth]) objectAtIndex:day-1];
            if(number.integerValue!=CADayTypeDayToSelected&&![self isToday:number.integerValue])
            {
                number = [[NSNumber alloc] initWithInt:CADayTypeDayReturn];
                [((NSMutableArray*)[allDays objectAtIndex:differenceMonth]) replaceObjectAtIndex:day-1 withObject:number];
                dayButton.typeOfDay = CADayTypeDayReturn;
                
            }
            [dayButton refreshDay];
        }
        
    }
}
- (void)resetAll
{
    [self initLogicCalendar];
    [self resetSelection];
}
- (void)resetSelection
{
    
    for (int i = 0; i< 12;i++)
    {
        CAMonthView *view = (CAMonthView*)[collectionDaysView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        NSMutableArray *array = [allDays objectAtIndex:i];
        for(int j = 0; j<array.count;j++)
        {
            NSNumber *number = [array objectAtIndex:j];
            CADay *button = [view.daysButtons objectAtIndex:j];
            if(number.integerValue!=CADayTypeLast&&
               ![self isToday:number.integerValue])
            {
                number = [[NSNumber alloc] initWithInt:CADayTypeOther];
                [array replaceObjectAtIndex:j withObject:number];
                button.typeOfDay = number.integerValue;
            }
            else if([self isToday:number.integerValue])
            {
                number = [[NSNumber alloc] initWithInt:CADayTypeToday];
                [array replaceObjectAtIndex:j withObject:number];
                button.typeOfDay = number.integerValue;
            }
            else
            {
                button.typeOfDay = number.integerValue;                
            }

            [button refreshDay];
        }
        view.daysType = [allDays objectAtIndex:i];
    }
}
- (void)selectFlyReturnDate:(NSDate *)date
{
    NSDate *today = [NSDate date];
    NSInteger todayMonth = [[calendar components:NSMonthCalendarUnit fromDate:today] month];
    NSInteger selected = [[calendar components:NSMonthCalendarUnit fromDate:date] month];
    NSInteger differenceMonth = todayMonth>selected?selected+12-todayMonth:selected-todayMonth;
    
    NSInteger day = [[calendar components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:date] day];
    
    CAMonthView *monthView = (CAMonthView*)[collectionDaysView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:differenceMonth inSection:0]];
    CADay *dayButton = [monthView.daysButtons objectAtIndex:day-1];
    
    if(![self isToday:dayButton.typeOfDay])
    {
        dayButton.typeOfDay = CADayTypeDayReturnSelected;
        
        NSNumber *number = [((NSMutableArray*)[allDays objectAtIndex:differenceMonth]) objectAtIndex:day-1];
        number = [[NSNumber alloc] initWithInt:CADayTypeDayReturnSelected];
        [((NSMutableArray*)[allDays objectAtIndex:differenceMonth]) replaceObjectAtIndex:day-1 withObject:number];
        
    }

    for (NSDate *date in daysReturn)
    {
        NSDate *today = [NSDate date];
        NSInteger todayMonth = [[calendar components:NSMonthCalendarUnit fromDate:today] month];
        NSInteger selected = [[calendar components:NSMonthCalendarUnit fromDate:date] month];
        NSInteger differenceMonth = todayMonth>selected?selected+12-todayMonth:selected-todayMonth;
        NSInteger day = [[calendar components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:date] day];
        CAMonthView *monthView = (CAMonthView*)[collectionDaysView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:differenceMonth inSection:0]];
        CADay *dayButton = [monthView.daysButtons objectAtIndex:day-1];
        
        NSNumber *number = [((NSMutableArray*)[allDays objectAtIndex:differenceMonth]) objectAtIndex:day-1];
        if(number.integerValue!=CADayTypeDayReturnSelected&&![self isToday:number.integerValue])
        {
            number = [[NSNumber alloc] initWithInt:CADayTypeDayReturnHidden];
            [((NSMutableArray*)[allDays objectAtIndex:differenceMonth]) replaceObjectAtIndex:day-1 withObject:number];
            dayButton.typeOfDay = CADayTypeDayReturnHidden;
        }
        [dayButton refreshDay];
    }
}
- (void)selectFlyReturnDateNotHide:(NSDate *)date
{
    NSDate *today = [NSDate date];
    NSInteger todayMonth = [[calendar components:NSMonthCalendarUnit fromDate:today] month];
    NSInteger selected = [[calendar components:NSMonthCalendarUnit fromDate:date] month];
    NSInteger differenceMonth = todayMonth>selected?selected+12-todayMonth:selected-todayMonth;
    
    NSInteger day = [[calendar components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:date] day];
    
    CAMonthView *monthView = (CAMonthView*)[collectionDaysView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:differenceMonth inSection:0]];
    CADay *dayButton = [monthView.daysButtons objectAtIndex:day-1];
    
    if(![self isToday:dayButton.typeOfDay])
    {
        dayButton.typeOfDay = CADayTypeDayReturnSelected;
        
        NSNumber *number = [((NSMutableArray*)[allDays objectAtIndex:differenceMonth]) objectAtIndex:day-1];
        number = [[NSNumber alloc] initWithInt:CADayTypeDayReturnSelected];
        [((NSMutableArray*)[allDays objectAtIndex:differenceMonth]) replaceObjectAtIndex:day-1 withObject:number];
        
    }
    
    
    for (NSDate *date in daysReturn)
    {
        NSDate *today = [NSDate date];
        NSInteger todayMonth = [[calendar components:NSMonthCalendarUnit fromDate:today] month];
        NSInteger selected = [[calendar components:NSMonthCalendarUnit fromDate:date] month];
        NSInteger differenceMonth = todayMonth>selected?selected+12-todayMonth:selected-todayMonth;
        NSInteger day = [[calendar components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:date] day];
        CAMonthView *monthView = (CAMonthView*)[collectionDaysView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:differenceMonth inSection:0]];
        CADay *dayButton = [monthView.daysButtons objectAtIndex:day-1];
        
        NSNumber *number = [((NSMutableArray*)[allDays objectAtIndex:differenceMonth]) objectAtIndex:day-1];
        if(number.integerValue!=CADayTypeDayReturnSelected&&![self isToday:number.integerValue])
        {
            number = [[NSNumber alloc] initWithInt:CADayTypeDayReturn];
            [((NSMutableArray*)[allDays objectAtIndex:differenceMonth]) replaceObjectAtIndex:day-1 withObject:number];
            dayButton.typeOfDay = CADayTypeDayReturn;
        }
        [dayButton refreshDay];
    }
}
- (void)selectFlyToDate:(NSDate *)toDate andReturn:(NSDate *)returnDate
{
    [self selectFlyToDateNotHide:toDate];
    [self selectFlyReturnDateNotHide:returnDate];
    NSArray *distanceDays = [CACalendarScrollView dayDistanceBetweenDate:toDate andSecondDate:returnDate];
    for (NSDate *date in distanceDays)
    {
        NSDate *today = [NSDate date];
        NSInteger todayMonth = [[calendar components:NSMonthCalendarUnit fromDate:today] month];
        NSInteger selected = [[calendar components:NSMonthCalendarUnit fromDate:date] month];
        NSInteger differenceMonth = todayMonth>selected?selected+12-todayMonth:selected-todayMonth;
        
        NSInteger day = [[calendar components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:date] day];
        
        CAMonthView *monthView = (CAMonthView*)[collectionDaysView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:differenceMonth inSection:0]];
        CADay *dayButton = [monthView.daysButtons objectAtIndex:day-1];
        NSNumber *number = [((NSMutableArray*)[allDays objectAtIndex:differenceMonth]) objectAtIndex:day-1];
        if(number.integerValue==CADayTypeDayTo||number.integerValue==CADayTypeDayToHidden)
        {
            number = [[NSNumber alloc] initWithInt:CADayTypeDayToBetween];
            [((NSMutableArray*)[allDays objectAtIndex:differenceMonth]) replaceObjectAtIndex:day-1 withObject:number];
            dayButton.typeOfDay = CADayTypeDayToBetween;
        }
        else if(number.integerValue==CADayTypeDayReturn||number.integerValue==CADayTypeDayReturnHidden)
        {
            number = [[NSNumber alloc] initWithInt:CADayTypeDayReturnBetween];
            [((NSMutableArray*)[allDays objectAtIndex:differenceMonth]) replaceObjectAtIndex:day-1 withObject:number];
            dayButton.typeOfDay = CADayTypeDayReturnBetween;
        }
        else
        {
            number = [[NSNumber alloc] initWithInt:CADayTypeDayBetweeen];
            [((NSMutableArray*)[allDays objectAtIndex:differenceMonth]) replaceObjectAtIndex:day-1 withObject:number];
            dayButton.typeOfDay = CADayTypeDayBetweeen;
        }
        [dayButton refreshDay];

    }
}
- (void)selectFlyToDateNotHide:(NSDate *)date
{
    
    NSDate *today = [NSDate date];
    NSInteger todayMonth = [[calendar components:NSMonthCalendarUnit fromDate:today] month];
    NSInteger selected = [[calendar components:NSMonthCalendarUnit fromDate:date] month];
    NSInteger differenceMonth = todayMonth>selected?selected+12-todayMonth:selected-todayMonth;
    
    NSInteger day = [[calendar components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:date] day];
    
    CAMonthView *monthView = (CAMonthView*)[collectionDaysView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:differenceMonth inSection:0]];
    
    NSNumber *number = [((NSMutableArray*)[allDays objectAtIndex:differenceMonth]) objectAtIndex:day-1];
    
    if([self isToday:number.integerValue])
    {
        number = [[NSNumber alloc] initWithInt:CADayTypeTodayToSelected];
        [((NSMutableArray*)[allDays objectAtIndex:differenceMonth]) replaceObjectAtIndex:day-1 withObject:number];
        CADay *dayButton = [monthView.daysButtons objectAtIndex:day-1];
        dayButton.typeOfDay = CADayTypeTodayToSelected;
    }
    else
    {
        number = [[NSNumber alloc] initWithInt:CADayTypeDayToSelected];
        [((NSMutableArray*)[allDays objectAtIndex:differenceMonth]) replaceObjectAtIndex:day-1 withObject:number];
        CADay *dayButton = [monthView.daysButtons objectAtIndex:day-1];
        dayButton.typeOfDay = CADayTypeDayToSelected;
    }
    
    
    //[dayButton refreshDay];
    for (NSDate *date in daysTo)
    {
        NSDate *today = [NSDate date];
        NSInteger todayMonth = [[calendar components:NSMonthCalendarUnit fromDate:today] month];
        NSInteger selected = [[calendar components:NSMonthCalendarUnit fromDate:date] month];
        NSInteger differenceMonth = todayMonth>selected?selected+12-todayMonth:selected-todayMonth;
        NSInteger day = [[calendar components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:date] day];
        CAMonthView *monthView = (CAMonthView*)[collectionDaysView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:differenceMonth inSection:0]];
        CADay *dayButton = [monthView.daysButtons objectAtIndex:day-1];
        
        NSNumber *number = [((NSMutableArray*)[allDays objectAtIndex:differenceMonth]) objectAtIndex:day-1];
        if(number.integerValue!=CADayTypeDayToSelected&&number.integerValue!=CADayTypeTodayToSelected)
        {
            if([self isToday:number.integerValue])
            {
                number = [[NSNumber alloc] initWithInt:CADayTypeTodayTo];
                [((NSMutableArray*)[allDays objectAtIndex:differenceMonth]) replaceObjectAtIndex:day-1 withObject:number];
                dayButton.typeOfDay = CADayTypeTodayTo;
            }
            else
            {
                number = [[NSNumber alloc] initWithInt:CADayTypeDayTo];
                [((NSMutableArray*)[allDays objectAtIndex:differenceMonth]) replaceObjectAtIndex:day-1 withObject:number];
                dayButton.typeOfDay = CADayTypeDayTo;
            }
            

        }
        [dayButton refreshDay];
    }
    
}
- (void)selectFlyToDate:(NSDate *)date
{
    
    NSDate *today = [NSDate date];
    NSInteger todayMonth = [[calendar components:NSMonthCalendarUnit fromDate:today] month];
    NSInteger selected = [[calendar components:NSMonthCalendarUnit fromDate:date] month];
    NSInteger differenceMonth = todayMonth>selected?selected+12-todayMonth:selected-todayMonth;
    
    NSInteger day = [[calendar components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:date] day];
    
    CAMonthView *monthView = (CAMonthView*)[collectionDaysView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:differenceMonth inSection:0]];
    
    NSNumber *number = [((NSMutableArray*)[allDays objectAtIndex:differenceMonth]) objectAtIndex:day-1];

    if([self isToday:number.integerValue])
    {
        number = [[NSNumber alloc] initWithInt:CADayTypeTodayToSelected];
        [((NSMutableArray*)[allDays objectAtIndex:differenceMonth]) replaceObjectAtIndex:day-1 withObject:number];
        CADay *dayButton = [monthView.daysButtons objectAtIndex:day-1];
        dayButton.typeOfDay = CADayTypeTodayToSelected;
    }
    else
    {
        number = [[NSNumber alloc] initWithInt:CADayTypeDayToSelected];
        [((NSMutableArray*)[allDays objectAtIndex:differenceMonth]) replaceObjectAtIndex:day-1 withObject:number];
        CADay *dayButton = [monthView.daysButtons objectAtIndex:day-1];
        dayButton.typeOfDay = CADayTypeDayToSelected;
    }

    //[dayButton refreshDay];

        for (NSDate *date in daysTo)
        {
            NSDate *today = [NSDate date];
            NSInteger todayMonth = [[calendar components:NSMonthCalendarUnit fromDate:today] month];
            NSInteger selected = [[calendar components:NSMonthCalendarUnit fromDate:date] month];
            NSInteger differenceMonth = todayMonth>selected?selected+12-todayMonth:selected-todayMonth;
            NSInteger day = [[calendar components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:date] day];
            CAMonthView *monthView = (CAMonthView*)[collectionDaysView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:differenceMonth inSection:0]];
            CADay *dayButton = [monthView.daysButtons objectAtIndex:day-1];
            
            NSNumber *number = [((NSMutableArray*)[allDays objectAtIndex:differenceMonth]) objectAtIndex:day-1];
            if(number.integerValue!=CADayTypeDayToSelected&&number.integerValue!=CADayTypeTodayToSelected)
            {
                if([self isToday:number.integerValue])
                {
                    number = [[NSNumber alloc] initWithInt:CADayTypeToday];
                    [((NSMutableArray*)[allDays objectAtIndex:differenceMonth]) replaceObjectAtIndex:day-1 withObject:number];
                    dayButton.typeOfDay = CADayTypeToday;
                    
                }
                else
                {
                    number = [[NSNumber alloc] initWithInt:CADayTypeDayToHidden];
                    [((NSMutableArray*)[allDays objectAtIndex:differenceMonth]) replaceObjectAtIndex:day-1 withObject:number];
                    dayButton.typeOfDay = CADayTypeDayToHidden;
                }
            }
            [dayButton refreshDay];
        }
}
- (void)selectFlyToDaysByDateArray:(NSArray *)dayArray
{
    if(dayArray.count==0)
    {
        for (NSDate *date in daysTo)
        {
            NSDate *today = [NSDate date];
            NSInteger todayMonth = [[calendar components:NSMonthCalendarUnit fromDate:today] month];
            NSInteger selected = [[calendar components:NSMonthCalendarUnit fromDate:date] month];
            NSInteger differenceMonth = todayMonth>selected?selected+12-todayMonth:selected-todayMonth;
            NSInteger day = [[calendar components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:date] day];
            CAMonthView *monthView = (CAMonthView*)[collectionDaysView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:differenceMonth inSection:0]];
            CADay *dayButton = [monthView.daysButtons objectAtIndex:day-1];
            
            NSNumber *number = [((NSMutableArray*)[allDays objectAtIndex:differenceMonth]) objectAtIndex:day-1];
            
            if([self isToday:number.integerValue])
            {
                number = [[NSNumber alloc] initWithInt:CADayTypeToday];
                [((NSMutableArray*)[allDays objectAtIndex:differenceMonth]) replaceObjectAtIndex:day-1 withObject:number];
                dayButton.typeOfDay = CADayTypeToday;
                [dayButton refreshDay];
                
            }
            else
            {
                number = [[NSNumber alloc] initWithInt:CADayTypeOther];
                [((NSMutableArray*)[allDays objectAtIndex:differenceMonth]) replaceObjectAtIndex:day-1 withObject:number];
                dayButton.typeOfDay = CADayTypeOther;
                [dayButton refreshDay];
            }
            

        }
        daysTo = dayArray;
    }
    else
    {
        daysTo = dayArray;
        
        for (NSDate *date in dayArray)
        {
            NSDate *today = [NSDate date];
            NSInteger todayMonth = [[calendar components:NSMonthCalendarUnit fromDate:today] month];
            NSInteger selected = [[calendar components:NSMonthCalendarUnit fromDate:date] month];
            NSInteger differenceMonth = todayMonth>selected?selected+12-todayMonth:selected-todayMonth;
            NSInteger day = [[calendar components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:date] day];
            CAMonthView *monthView = (CAMonthView*)[collectionDaysView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:differenceMonth inSection:0]];
            CADay *dayButton = [monthView.daysButtons objectAtIndex:day-1];
            
            NSNumber *number = [((NSMutableArray*)[allDays objectAtIndex:differenceMonth]) objectAtIndex:day-1];
            
            if([self isToday:number.integerValue])
            {
                number = [[NSNumber alloc] initWithInt:CADayTypeTodayTo];
                [((NSMutableArray*)[allDays objectAtIndex:differenceMonth]) replaceObjectAtIndex:day-1 withObject:number];
                dayButton.typeOfDay = CADayTypeTodayTo;
                [dayButton refreshDay];
                
            }
            else
            {
                number = [[NSNumber alloc] initWithInt:CADayTypeDayTo];
                [((NSMutableArray*)[allDays objectAtIndex:differenceMonth]) replaceObjectAtIndex:day-1 withObject:number];
                dayButton.typeOfDay = CADayTypeDayTo;
                [dayButton refreshDay];
            }
        }
    }
    
    
}
+ (NSInteger)daysCountIntervalBetween:(NSDate*)firstDate andDate:(NSDate*)secondDate
{

    if(firstDate==nil) firstDate = [NSDate date];
    if(secondDate==nil) secondDate = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger startDay=[calendar ordinalityOfUnit:NSDayCalendarUnit
                                           inUnit: NSEraCalendarUnit forDate:firstDate];
    NSInteger endDay=[calendar ordinalityOfUnit:NSDayCalendarUnit
                                         inUnit: NSEraCalendarUnit forDate:secondDate];
    return endDay-startDay-1;
}
+ (NSArray*)dayDistanceBetweenDate:(NSDate*)firstDate andSecondDate:(NSDate*)secondDate
{
    if(ABS([self daysCountIntervalBetween:firstDate andDate:secondDate])<1)
    {
        return nil;
    }
    else
    {
        NSMutableArray *array = [NSMutableArray new];
        NSInteger daysCount = [self daysCountIntervalBetween:firstDate andDate:secondDate];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        for (int i = 1;i<=daysCount;i++)
        {
            NSDateComponents *components = [[NSDateComponents alloc] init];
            [components setDay:i];
            
            NSDate *newDate = [calendar dateByAddingComponents:components toDate:firstDate options:0];
            [array addObject:newDate];
        }
        return array;
    }
}
#pragma mark UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CAMonthView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSDate *today = [NSDate date];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = indexPath.item;
    NSDate *requiredMonth = [calendar dateByAddingComponents:components toDate:today options:0];
    [cell setDelegate:self];
    cell.month = requiredMonth;
    cell.daysType = [allDays objectAtIndex:indexPath.item];
    cell.tag = indexPath.item;
    if(_testIPhone==0)
    {
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
                cell.frame = CGRectMake(0, 0, collectionView.frame.size.width/2.0, collectionView.frame.size.height);
        }
        else
        {
                cell.frame = CGRectMake(0, 0, collectionView.frame.size.width, collectionView.frame.size.height);
        }
    }
    else
    {
            cell.frame = CGRectMake(0, 0, collectionView.frame.size.width, collectionView.frame.size.height);
    }

    [cell refresh];
    if(!cell)
    {


        if(_testIPhone==0)
        {
            if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
            {
                cell = [[CAMonthView alloc] initWithFrame:CGRectMake(0, 0, collectionView.frame.size.width/2.0, collectionView.frame.size.height) andMonth:requiredMonth];
            }
            else
            {
                cell = [[CAMonthView alloc] initWithFrame:CGRectMake(0, 0, collectionView.frame.size.width, collectionView.frame.size.height) andMonth:requiredMonth];
            }
        }
        else
        {
            cell = [[CAMonthView alloc] initWithFrame:CGRectMake(0, 0, collectionView.frame.size.width, collectionView.frame.size.height) andMonth:requiredMonth];
        }

    }
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}
- (NSArray*)dayNumbers:(NSArray*)dates
{
    NSMutableArray *result = [NSMutableArray new];
    for (NSDate *date in dates)
    {
        NSDateComponents *firstComponents = [calendar components:NSDayCalendarUnit fromDate:date];
        [result addObject:[[NSNumber alloc] initWithInt:firstComponents.day]];
    }
    return result;
}
- (BOOL)sameMonth:(NSDate*)date andDate: (NSDate*)secondDate
{
    NSDateComponents *firstComponents = [calendar components:NSMonthCalendarUnit|NSYearCalendarUnit fromDate:date];
    NSDateComponents *secondComponents = [calendar components:NSMonthCalendarUnit|NSYearCalendarUnit fromDate:secondDate];
    
    NSDate *first = [calendar dateFromComponents:firstComponents];
    NSDate *second = [calendar dateFromComponents:secondComponents];
    return ([first compare:second]==NSOrderedSame);
}
- (void) longPressBegan:(UILongPressGestureRecognizer*)gesture buttonType:(dayType) typeOfDay andMonthView:(CAMonthView*) monthView
{
    [collectionDaysView bringSubviewToFront:monthView];
}
- (void) longPressMoved:(UILongPressGestureRecognizer*)gesture buttonType:(dayType) typeOfDay
{
    
}
- (void) longPressEnd:(UILongPressGestureRecognizer*)gesture buttonType:(dayType) typeOfDay
{

    for(CAMonthView *monthView in collectionDaysView.visibleCells)
    {
        CGPoint touchLocation = [gesture locationInView:collectionDaysView];
        for(CADay *dayView in monthView.daysButtons)
        {
            touchLocation = [gesture locationInView:monthView];
            if(CGRectContainsPoint(dayView.frame, touchLocation))
            {
                if(typeOfDay==CADayTypeDayToSelected&&(dayView.typeOfDay==CADayTypeDayTo||dayView.typeOfDay==CADayTypeDayToBetween))
                {
                    [dayView sendActionsForControlEvents:UIControlEventTouchUpInside];
                }
                else if(typeOfDay==CADayTypeDayReturnSelected&&(dayView.typeOfDay==CADayTypeDayReturn||dayView.typeOfDay==CADayTypeDayReturnBetween))
                {
                    [dayView sendActionsForControlEvents:UIControlEventTouchUpInside];
                }
                
            }
            
        }
        
    }
    
}
#pragma mark UICollectionView
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
        if(_testIPhone==0)
        {
            if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
            {
                
                NSInteger offsetX = round((*targetContentOffset).x/(collectionDaysView.frame.size.width/2.0+1));
                (*targetContentOffset).x = offsetX*(collectionDaysView.frame.size.width/2.0+1);
                NSDate *date = [NSDate date];
                NSDateComponents *dateComp = [[NSDateComponents alloc] init];
                dateComp.month = offsetX;
                NSDate *month = [calendar dateByAddingComponents:dateComp toDate:date options:0];
                [_delegate calendarScrollView:self selectedMonthChanged:month];
            }
            else
            {
                
                NSInteger offsetX = round((*targetContentOffset).x/(collectionDaysView.frame.size.width));
                (*targetContentOffset).x = offsetX*(collectionDaysView.frame.size.width+1);
                NSDate *date = [NSDate date];
                NSDateComponents *dateComp = [[NSDateComponents alloc] init];
                dateComp.month = offsetX;
                NSDate *month = [calendar dateByAddingComponents:dateComp toDate:date options:0];
                [_delegate calendarScrollView:self selectedMonthChanged:month];
            }
        }
        else
        {
            NSInteger offsetX = round((*targetContentOffset).x/(collectionDaysView.frame.size.width));
            (*targetContentOffset).x = offsetX*(collectionDaysView.frame.size.width+1);
            NSDate *date = [NSDate date];
            NSDateComponents *dateComp = [[NSDateComponents alloc] init];
            dateComp.month = offsetX;
            NSDate *month = [calendar dateByAddingComponents:dateComp toDate:date options:0];
            [_delegate calendarScrollView:self selectedMonthChanged:month];
        }
}
@end
