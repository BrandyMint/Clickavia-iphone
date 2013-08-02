//
//  CACalendarScrollView.h
//  CAManagersLib
//
//  Created by macmini1 on 08.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAMonthSliderView.h"
#import "CAMonthView.h"
#import "CACalendarCollectionViewFlowLayout.h"

@class CACalendarScrollView;

@protocol CACalendarScrollViewDelegate
- (void)calendarScrollView:(CACalendarScrollView*) calendarScrollView selectedDateChanged:(NSDate*) date;
- (void)calendarScrollView:(CACalendarScrollView*) calendarScrollView selectedMonthChanged:(NSDate*) month;
@end
@interface CACalendarScrollView : UIView <UIGestureRecognizerDelegate,CAMonthViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>
{
    NSMutableArray *firstMonthDayNamesLabels;
    NSMutableArray *secondMonthDayNamesLabels;
    NSArray *daysTo;
    NSArray *daysReturn;
    UICollectionView *collectionDaysView;
    NSInteger offset;
    CACalendarCollectionViewFlowLayout *flowLayout;
    NSDate *lastUpdateScroll;
    
    NSCalendar *calendar;
    
    
    NSMutableArray *allDays;
    NSNumber *dayToIndex;
    NSNumber *monthToIndex;
    NSNumber *dayReturnIndex;
    NSNumber *monthReturnIndex;
}
@property (assign) id<CACalendarScrollViewDelegate> delegate;
@property (strong,nonatomic) UIFont *font;
@property (strong,nonatomic) UIColor *textNamesColor;
@property NSInteger testIPhone; // if 0 - use UI_USER_INTERFACE_IDIOM for check device, !=0 - this is iphone

@property CGSize sizeOfDay;
@property CGFloat spaceBetweenDayTitlesAndCalendar;
@property (strong,nonatomic) UIColor *defaultDayColor;
@property (strong,nonatomic) UIColor *todayDayColor;
@property (strong,nonatomic) UIColor *lastDayColor;
@property (strong,nonatomic) UIColor *selectToDateColor;
@property (strong,nonatomic) UIColor *selectReturnDateColor;
- (void)updateWithSelectedDate:(NSDate*)selectedDate;
- (void) selectFlyToDaysByDateArray:(NSArray *)dayArray;
- (void) selectFlyReturnDaysByDateArray:(NSArray *)dayArray;
- (void) selectFlyToDate:(NSDate*)date;
- (void) selectFlyReturnDate:(NSDate*)date;
- (void) selectFlyToDate:(NSDate *)toDate andReturn:(NSDate*)returnDate;
- (void) resetSelection;
- (void) resetAll;
+ (NSInteger)daysCountIntervalBetween:(NSDate*)firstDate andDate:(NSDate*)secondDate;
+ (NSArray*)dayDistanceBetweenDate:(NSDate*)firstDate andSecondDate:(NSDate*)secondDate;
@end
