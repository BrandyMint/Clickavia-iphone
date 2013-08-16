//
//  CACalendarStyle.h
//  CAManagersLib
//
//  Created by macmini1 on 25.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum
{
    CADayTypeLast,
    CADayTypeToday,
    CADayTypeTodayTo,
    CADayTypeTodayToSelected,
    CADayTypeDayTo,
    CADayTypeDayToSelected,
    CADayTypeDayToBetween,
    CADayTypeDayReturn,
    CADayTypeDayReturnSelected,
    CADayTypeDayReturnBetween,
    CADayTypeDayReturnHidden,
    CADayTypeDayToHidden,
    CADayTypeDayBetweeen,
    CADayTypeOther
}dayType;

@interface CACalendarStyle : NSObject
+ (CACalendarStyle *) sharedStyle;
//style for Day
- (NSArray*) getGradientColorsForDay:(dayType) typeOfDay;
- (UIFont*) getFontForDay:(dayType) typeOfDay;
- (UIColor*) getFontColorForDay:(dayType) typeOfDay;
- (CGFloat) getCornerRadiusForDay:(dayType) typeOfDay;
- (UIImageView*) getFlightTypeImageViewForDay:(dayType) typeOfDay;
- (CGSize) getShadowOffsetForDay:(dayType) typeOfDay;
- (UIColor*) getShadowColorForDay:(dayType) typeOfDay;
- (UIImage*) getImageForDay:(dayType) typeOfDay;
//style for CACalendarView
- (CGFloat) getSpaceBetweenSliderAndScroll;
- (NSArray*) getCalendarViewGradienColors;
- (UIImage*) getCalendarViewBackgroundImage;
//style for MonthSlider
- (CGFloat) getSliderViewHeight;
- (CGFloat) getSliderViewMarginTopIPhone;
- (CGFloat) getSliderViewMarginTopIPad;
- (CGFloat) getSliderViewMarginLeftIPhone;
- (CGFloat) getSliderViewMarginLeftIPad;
- (CGFloat) getSliderViewKWidthIPhone;
- (UIColor*) getSliderViewMonthFontColor;
- (UIFont*) getSliderViewMonthFont;
- (NSArray*) getSliderViewGradientColors;
- (NSArray*) getSliderViewMonthGradientColors;
- (UIImage*) getSliderViewImage;
- (UIImage*) getSliderViewMonthImage;
- (CGFloat) getSliderViewMonthCornerRadius;
@end
