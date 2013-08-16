//
//  MonthView.h
//  CAManagersLib
//
//  Created by macmini1 on 11.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CADay.h"
@class CAMonthView;
@protocol CAMonthViewDelegate
- (void) monthView:(CAMonthView*)calendarView didSelectDay:(NSInteger)day;
- (void) longPressBegan:(UILongPressGestureRecognizer*)gesture buttonType:(dayType) typeOfDay andMonthView:(CAMonthView*)monthView;
- (void) longPressMoved:(UILongPressGestureRecognizer*)gesture buttonType:(dayType) typeOfDay;
- (void) longPressEnd:(UILongPressGestureRecognizer*)gesture buttonType:(dayType) typeOfDay;
@end
@interface CAMonthView : UICollectionViewCell
{
    UIView *longTapView;
    NSMutableArray *notThisMonthDays;
}
@property (strong,nonatomic) NSDate *month;
@property (strong,nonatomic) NSMutableArray *daysType;
@property (strong,nonatomic) NSMutableArray *daysButtons;
@property (assign) id<CAMonthViewDelegate> delegate;
- (id)initWithFrame:(CGRect)frame andMonth:(NSDate*)month;
- (void)refresh;
- (void)refreshColors;
@end
