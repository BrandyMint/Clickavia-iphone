//
//  MonthView.m
//  CAManagersLib
//
//  Created by macmini1 on 11.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "CAMonthView.h"

@implementation CAMonthView

- (id)initWithFrame:(CGRect)frame andMonth:(NSDate*)month
{
    self = [super initWithFrame:frame];
    if (self) {
        _month = month;
        [self baseSetup];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self baseSetup];
    }
    return self;
}
- (void) baseSetup
{
    self.userInteractionEnabled = YES;
    
}
- (void) refresh
{
    [self reloadDays];
}
- (void) refreshColors
{
    for(int i = 0; i<_daysButtons.count;i++)
    {
        CADay *button = [_daysButtons objectAtIndex:i];
        button.typeOfDay = ((NSNumber*)[_daysType objectAtIndex:i]).integerValue;
        [button refreshDay];
    }
    self.backgroundColor = [UIColor clearColor];
}
- (void)dayButtonTouch:(id)sender
{
    CADay *daySender = sender;
    if(daySender.typeOfDay!=CADayTypeDayReturnHidden&&daySender.typeOfDay!=CADayTypeDayToHidden&&daySender.typeOfDay!=CADayTypeOther)
    {
        [_delegate monthView:self didSelectDay:((UIButton*)sender).tag];        
    }
}

- (void) reloadDays
{
    for(UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
    
    if(_month==nil)
    {
        _month = [NSDate date];
    }
    
    _daysButtons = [NSMutableArray new];
    notThisMonthDays = [NSMutableArray new];
    
    UIFont *font = [UIFont systemFontOfSize:12];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange days = [calendar rangeOfUnit:NSDayCalendarUnit
                                  inUnit:NSMonthCalendarUnit
                                 forDate:_month];
    [calendar setFirstWeekday:2];
    
    NSDateComponents *comp = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:_month];
    [comp setDay:1];
    NSDate *firstDayOfMonth = [calendar dateFromComponents:comp];
    NSInteger week = 0;
    longTapView = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.frame.size.width / 7.0,self.frame.size.height / 7.0)];
    longTapView.hidden = YES;
    [self addSubview:longTapView];
    NSInteger previousMonthDayCount = 0;
    NSInteger nextMonthDayCount = 0;
    for(int i = 0; i<days.length;i++)
    {
        
        
        NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
        [dateComponents setDay:i];
        
        NSDate *date = [calendar dateByAddingComponents:dateComponents toDate:firstDayOfMonth options:0];
        NSDateComponents *weekdayComponents = [calendar components:(NSDayCalendarUnit | NSWeekdayCalendarUnit) fromDate:date];
        NSInteger weekday = [weekdayComponents weekday];
        CADay *button = [CADay buttonWithType:UIButtonTypeCustom];
        [button setTitle:[[NSString alloc] initWithFormat:@"%02i",i+1] forState:UIControlStateNormal];
        button.titleLabel.font = font;
        button.typeOfDay = ((NSNumber*)[_daysType objectAtIndex:i]).integerValue;

        NSInteger offsetX = weekday==1?6:(weekday-2);
        if(i==0)
        {
            previousMonthDayCount = offsetX-1;
        }
        if(i==(days.length-1))
        {
            nextMonthDayCount = 7-offsetX-1;
        }
        CGFloat width = self.frame.size.width / 7.0;
        CGFloat height = self.frame.size.height / 7.0;
        CGRect frame = CGRectMake(width*offsetX, week*height, width,height);
        if(offsetX==6)
        {
            week++;
        }
        button.frame = frame;
        [button refreshDay];
        [button addTarget:self action:@selector(dayButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
        UILongPressGestureRecognizer *longpress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longpress:)];
        [button addGestureRecognizer:longpress];
        button.tag = i;
        [_daysButtons addObject:button];
        [self addSubview:button];
    }
    NSDateComponents *previousComp = [calendar components:NSMonthCalendarUnit fromDate:_month];
    previousComp.month = -1;
    NSDate *date = [calendar dateByAddingComponents:previousComp toDate:firstDayOfMonth options:0];
    NSInteger daysCount = [calendar rangeOfUnit:NSDayCalendarUnit
                                  inUnit:NSMonthCalendarUnit
                                 forDate:date].length;
    for (int i = 0; i <= previousMonthDayCount;i++)
    {
        CADay *button = [CADay buttonWithType:UIButtonTypeCustom];
        [button setTitle:[[NSString alloc] initWithFormat:@"%02i",daysCount-previousMonthDayCount+i] forState:UIControlStateNormal];
        button.titleLabel.font = font;
        button.typeOfDay = CADayTypeLast;
        
        NSInteger offsetX = i;
        CGFloat width = self.frame.size.width / 7.0;
        CGFloat height = self.frame.size.height / 7.0;
        CGRect frame = CGRectMake(width*offsetX,0, width,height);
        button.frame = frame;
        [button refreshDay];
        [self addSubview:button];
    }
    for (int i = nextMonthDayCount; i > 0;i--)
    {
        CADay *button = [CADay buttonWithType:UIButtonTypeCustom];
        [button setTitle:[[NSString alloc] initWithFormat:@"%02i",(nextMonthDayCount-i+1)] forState:UIControlStateNormal];
        button.titleLabel.font = font;
        button.typeOfDay = CADayTypeLast;
        
        NSInteger offsetX = 7-i;
        CGFloat width = self.frame.size.width / 7.0;
        CGFloat height = self.frame.size.height / 7.0;
        CGRect frame = CGRectMake(width*offsetX,week*height, width,height);
        button.frame = frame;
        [button refreshDay];
        [self addSubview:button];
    }

}
- (void)longpress:(UILongPressGestureRecognizer*)gesture
{
    CADay *day = (CADay*)gesture.view;
    if(day.typeOfDay==CADayTypeDayToSelected||day.typeOfDay==CADayTypeDayReturnSelected)
    {
        if(gesture.state == UIGestureRecognizerStateBegan)
        {
            [self bringSubviewToFront:longTapView];
            [_delegate longPressBegan:gesture buttonType:day.typeOfDay andMonthView:self];
            longTapView.backgroundColor = day.typeOfDay==CADayTypeDayReturnSelected?[UIColor colorWithRed:0.0 green:0.0 blue:0.5 alpha:0.2]:[UIColor colorWithRed:0.0 green:0.5 blue:0.0 alpha:0.2];
            CGPoint point = [gesture locationInView:longTapView.superview];
            longTapView.center = point;

            [longTapView setHidden:NO];
        }
        else if(gesture.state == UIGestureRecognizerStateChanged)
        {
            longTapView.backgroundColor = day.typeOfDay==CADayTypeDayReturnSelected?[UIColor colorWithRed:0.0 green:0.0 blue:0.5 alpha:0.2]:[UIColor colorWithRed:0.0 green:0.5 blue:0.0 alpha:0.2];
            CGPoint point = [gesture locationInView:longTapView.superview];
            longTapView.center = point;
        }
        else if(gesture.state == UIGestureRecognizerStateEnded)
        {

            for(CADay *dayView in _daysButtons)
            {
                [_delegate longPressEnd:gesture buttonType:day.typeOfDay];
            }

            longTapView.hidden = YES;
        }
        
    }
}
- (void)setupDayStyle:(NSDate*)date forButton:(CADay*)button
{
    NSDate *today = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];
    
    NSDate* dateOnly = [calendar dateFromComponents:components];
    components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:today];
    NSDate* todayOnly = [calendar dateFromComponents:components];
    
    
    NSComparisonResult result = [todayOnly compare:dateOnly];
    if(button.typeOfDay==CADayTypeOther)
    {
        if(result==NSOrderedSame)
        {
            button.typeOfDay = CADayTypeToday;
            
        }
        else if(result==NSOrderedAscending)
        {
            button.typeOfDay = CADayTypeOther;
        }
        else
        {
            button.typeOfDay = CADayTypeLast;
        }
        
    }
}



@end
