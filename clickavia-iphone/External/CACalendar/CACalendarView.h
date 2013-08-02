//
//  CACalendarView.h
//  CAManagersLib
//
//  Created by macmini1 on 08.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAMonthSliderView.h"
#import "CACalendarScrollView.h"
#import "CACalendarStyle.h"

@class CACalendarView;
@protocol CACalendarViewDelegate
- (void) calendarView:(CACalendarView*)calendarView didSelectDate:(NSDate*)date;
- (void) calendarView:(CACalendarView *)calendarView didSelectMonth:(NSDate *)date;
@end


@interface CACalendarView : UIView<CAMonthSliderViewDelegate,CACalendarScrollViewDelegate>
{
    NSArray *flyToDays;
    NSArray *flyReturnDays;
    NSDate *selectedFlyTo;
    NSDate *selectedFlyReturn;
    NSDate *currentMonth;
    NSCalendar *currentCalendar;

    CAGradientLayer *gradientLayer;
    UIImageView *backgroundImageView;
}
@property (assign) id<CACalendarViewDelegate> delegate;
@property (strong,nonatomic) CAMonthSliderView *monthSliderView;
@property (strong,nonatomic) CACalendarScrollView *calendarScrollView;
@property CGFloat spaceBetweenSliderAndCalendar;
- (void)selectDate:(NSDate*)date;
- (void)selectFlyToDaysByDateArray:(NSArray*)dayArray;
- (void)selectFlyReturnDaysByDateArray:(NSArray*)dayArray;
- (NSDate*) getFlyToDate;
- (NSDate*) getFlyReturnDate;
- (NSDate*) getCurrentMonth;
+(NSComparisonResult) compareDate:(NSDate*)first and:(NSDate*)second;
@end
