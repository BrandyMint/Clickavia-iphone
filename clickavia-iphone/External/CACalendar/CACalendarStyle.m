//
//  CACalendarStyle.m
//  CAManagersLib
//
//  Created by macmini1 on 25.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "CACalendarStyle.h"

@implementation CACalendarStyle
+ (CACalendarStyle*) sharedStyle
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{_sharedObject = [[self alloc] init];});
    return _sharedObject;
}
- (NSArray*) getGradientColorsForDay:(dayType)typeOfDay
{
    NSArray *gradientColors;
    switch (typeOfDay)
    {
        case CADayTypeLast:
            break;
        case CADayTypeToday:
            gradientColors = [[NSArray alloc] initWithObjects:(id)[UIColor colorWithRed:214/255.0 green:214/255.0 blue:214/255.0 alpha:1.0].CGColor,
                              (id)[UIColor colorWithRed:214/255.0 green:214/255.0 blue:214/255.0 alpha:1.0].CGColor,
                              (id)[UIColor colorWithRed:214/255.0 green:214/255.0 blue:214/255.0 alpha:1.0].CGColor,
                              nil];
            break;
        case CADayTypeTodayTo:
            break;
        case CADayTypeTodayToSelected:
            gradientColors = [[NSArray alloc] initWithObjects:(id)[UIColor colorWithRed:0.2 green:1.0 blue:0 alpha:1.0].CGColor,
                              (id)[UIColor colorWithRed:0.2 green:0.9 blue:0 alpha:1.0].CGColor,
                              (id)[UIColor colorWithRed:0.2 green:1.0 blue:0 alpha:1.0].CGColor,nil];
            break;
        case CADayTypeDayTo:
            break;
        case CADayTypeDayToSelected:
            gradientColors = [[NSArray alloc] initWithObjects:(id)[UIColor colorWithRed:0.2 green:1.0 blue:0 alpha:1.0].CGColor,
                              (id)[UIColor colorWithRed:0.2 green:0.9 blue:0 alpha:1.0].CGColor,
                              (id)[UIColor colorWithRed:0.2 green:1.0 blue:0 alpha:1.0].CGColor,nil];
            break;
        case CADayTypeDayToBetween:
            gradientColors = [[NSArray alloc] initWithObjects:(id)[UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0].CGColor,
                              (id)[UIColor colorWithRed:205/255.0 green:235/255.0 blue:205/255.0 alpha:1.0].CGColor,
                              (id)[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0].CGColor,nil];
            break;
        case CADayTypeDayReturn:
            break;
        case CADayTypeDayReturnSelected:
            gradientColors = [[NSArray alloc] initWithObjects:(id)[UIColor colorWithRed:0 green:0.5 blue:1.0 alpha:1.0].CGColor,
                              (id)[UIColor colorWithRed:0 green:0.5 blue:1.0 alpha:1.0].CGColor,
                              (id)[UIColor colorWithRed:0 green:0.5 blue:1.0 alpha:1.0].CGColor,nil];
            break;
        case CADayTypeDayReturnBetween:
            gradientColors = [[NSArray alloc] initWithObjects:(id)[UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0].CGColor,
                              (id)[UIColor colorWithRed:205/255.0 green:235/255.0 blue:205/255.0 alpha:1.0].CGColor,
                              (id)[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0].CGColor,nil];
            break;
        case CADayTypeDayBetweeen:
            gradientColors = [[NSArray alloc] initWithObjects:(id)[UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0].CGColor,
                              (id)[UIColor colorWithRed:205/255.0 green:235/255.0 blue:205/255.0 alpha:1.0].CGColor,
                              (id)[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0].CGColor,nil];
            break;
        case CADayTypeOther:
        default:
            break;
    }
    return gradientColors;
}
- (UIFont*) getFontForDay:(dayType)typeOfDay
{
    UIFont *font;
    switch (typeOfDay)
    {
        case CADayTypeLast:
            font = [UIFont systemFontOfSize:12.0];
            break;
        case CADayTypeToday:
            font = [UIFont systemFontOfSize:12.0];
            break;
        case CADayTypeTodayTo:
            font = [UIFont boldSystemFontOfSize:12.0];
            break;
        case CADayTypeTodayToSelected:
            font = [UIFont boldSystemFontOfSize:12.0];
            break;
        case CADayTypeDayTo:
            font = [UIFont boldSystemFontOfSize:12.0];
            break;
        case CADayTypeDayToSelected:
            font = [UIFont boldSystemFontOfSize:12.0];
            break;
        case CADayTypeDayToBetween:
            font = [UIFont boldSystemFontOfSize:12.0];
            break;
        case CADayTypeDayReturn:
            font = [UIFont boldSystemFontOfSize:12.0];
            break;
        case CADayTypeDayReturnSelected:
            font = [UIFont boldSystemFontOfSize:12.0];
            break;
        case CADayTypeDayReturnBetween:
            font = [UIFont boldSystemFontOfSize:12.0];
            break;
        case CADayTypeDayBetweeen:
            font = [UIFont systemFontOfSize:12.0];
            break;
        case CADayTypeOther:
        default:
            font = [UIFont systemFontOfSize:12.0];
            break;
    }
    return font;
}

-(UIColor*)getFontColorForDay:(dayType)typeOfDay
{
    UIColor *fontColor;
    switch (typeOfDay)
    {
        case CADayTypeLast:
            fontColor = [UIColor lightGrayColor];
            break;
        case CADayTypeToday:
            fontColor = [UIColor darkGrayColor];
            break;
        case CADayTypeTodayTo:
            fontColor = [UIColor greenColor];
            break;
        case CADayTypeTodayToSelected:
            fontColor = [UIColor whiteColor];
            break;
        case CADayTypeDayTo:
            fontColor = [UIColor greenColor];
            break;
        case CADayTypeDayToSelected:
            fontColor = [UIColor whiteColor];
            break;
        case CADayTypeDayToBetween:
            fontColor = [UIColor greenColor];
            break;
        case CADayTypeDayReturn:
            fontColor = [UIColor blueColor];
            break;
        case CADayTypeDayReturnSelected:
            fontColor = [UIColor whiteColor];
            break;
        case CADayTypeDayReturnBetween:
            fontColor = [UIColor blueColor];
            break;
        case CADayTypeDayBetweeen:
            fontColor = [UIColor darkGrayColor];
            break;
        case CADayTypeOther:
        default:
            fontColor = [UIColor blackColor];
            break;
    }
    return fontColor;
}
- (CGFloat)getCornerRadiusForDay:(dayType)typeOfDay
{
    CGFloat cornerRadius = 0;
    switch (typeOfDay)
    {
        case CADayTypeLast:
            break;
        case CADayTypeToday:
            cornerRadius = 5.0;
            break;
        case CADayTypeTodayTo:
            cornerRadius = 5.0;
            break;
        case CADayTypeTodayToSelected:
            cornerRadius = 5.0;
            break;
        case CADayTypeDayTo:
            break;
        case CADayTypeDayToSelected:
            break;
        case CADayTypeDayToBetween:
            break;
        case CADayTypeDayReturn:
            break;
        case CADayTypeDayReturnSelected:
            break;
        case CADayTypeDayReturnBetween:
            break;
        case CADayTypeDayBetweeen:
            break;
        case CADayTypeOther:
        default:
            break;
    }
    return cornerRadius;
}
- (UIImageView*)getFlightTypeImageViewForDay:(dayType)typeOfDay
{
    UIImageView *view;
    if(typeOfDay==CADayTypeDayToSelected)
    {
        view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        view.backgroundColor = [UIColor lightGrayColor];
    }
    else if (typeOfDay==CADayTypeDayReturnSelected)
    {
        view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        view.backgroundColor = [UIColor lightGrayColor];
    }
    else
    {
        view = nil;
    }
    view.frame = CGRectMake(0, 0, 20, 12);
    return view;
}
- (CGSize) getShadowOffsetForDay:(dayType)typeOfDay
{
    CGSize shadowOffset = CGSizeZero;
    switch (typeOfDay)
    {
        case CADayTypeLast:
            shadowOffset = CGSizeMake(0.01, 0.01);
            break;
        case CADayTypeToday:
            shadowOffset = CGSizeMake(0.01, 0.01);
            break;
        case CADayTypeTodayTo:
            shadowOffset = CGSizeMake(0.01, 0.01);
            break;
        case CADayTypeTodayToSelected:
            shadowOffset = CGSizeMake(0.01, 0.01);
            break;
        case CADayTypeDayTo:
            shadowOffset = CGSizeMake(0.01, 0.01);
            break;
        case CADayTypeDayToSelected:
            shadowOffset = CGSizeMake(0.01, 0.01);
            break;
        case CADayTypeDayToBetween:
            shadowOffset = CGSizeMake(0.01, 0.01);
            break;
        case CADayTypeDayReturn:
            shadowOffset = CGSizeMake(0.01, 0.01);
            break;
        case CADayTypeDayReturnSelected:
            shadowOffset = CGSizeMake(0.01, 0.01);
            break;
        case CADayTypeDayReturnBetween:
            shadowOffset = CGSizeMake(0.01, 0.01);
            break;
        case CADayTypeDayBetweeen:
            shadowOffset = CGSizeMake(0.01, 0.01);
            break;
        case CADayTypeOther:
            shadowOffset = CGSizeMake(0.01, 0.01);
        default:
            break;
    }
    return shadowOffset;
}
- (UIColor*) getShadowColorForDay:(dayType)typeOfDay
{
    UIColor *shadowColor;
    switch (typeOfDay)
    {
        case CADayTypeLast:
            shadowColor = [UIColor blackColor];
            break;
        case CADayTypeToday:
            shadowColor = [UIColor blackColor];
            break;
        case CADayTypeTodayTo:
            shadowColor = [UIColor blackColor];
            break;
        case CADayTypeTodayToSelected:
            shadowColor = [UIColor blackColor];
            break;
        case CADayTypeDayTo:
            shadowColor = [UIColor blackColor];
            break;
        case CADayTypeDayToSelected:
            shadowColor = [UIColor blackColor];
            break;
        case CADayTypeDayToBetween:
            shadowColor = [UIColor blackColor];
            break;
        case CADayTypeDayReturn:
            shadowColor = [UIColor blackColor];
            break;
        case CADayTypeDayReturnSelected:
            shadowColor = [UIColor blackColor];
            break;
        case CADayTypeDayReturnBetween:
            shadowColor = [UIColor blackColor];
            break;
        case CADayTypeDayBetweeen:
            shadowColor = [UIColor blackColor];
            break;
        case CADayTypeOther:
            shadowColor = [UIColor blackColor];
        default:
            break;
    }
    return shadowColor;
}
-(UIImage *)getImageForDay:(dayType)typeOfDay
{
    NSString *imageName;
    switch (typeOfDay)
    {
        case CADayTypeLast:
            imageName = @"";
            break;
        case CADayTypeToday:
            imageName = @"";
            break;
        case CADayTypeTodayTo:
            imageName = @"";
            break;
        case CADayTypeTodayToSelected:
            imageName = @"";
            break;
        case CADayTypeDayTo:
            imageName = @"";
            break;
        case CADayTypeDayToSelected:
            imageName = @"";
            break;
        case CADayTypeDayToBetween:
            imageName = @"";
            break;
        case CADayTypeDayReturn:
            imageName = @"";
            break;
        case CADayTypeDayReturnSelected:
            imageName = @"";
            break;
        case CADayTypeDayReturnBetween:
            imageName = @"";
            break;
        case CADayTypeDayBetweeen:
            imageName = @"";
            break;
        case CADayTypeOther:
            imageName = @"";
        default:
            break;
    }
    return [UIImage imageNamed:imageName];
}
- (CGFloat) getSpaceBetweenSliderAndScroll
{
    return 10;
}
- (CGFloat) getSliderViewHeight
{
    return 28;
}
- (CGFloat) getSliderViewMarginLeftIPad
{
    return 14.0;
}
- (CGFloat) getSliderViewMarginLeftIPhone
{
    return 5.1;
}
- (CGFloat) getSliderViewMarginTopIPad
{
    return 3.0;
}
- (CGFloat) getSliderViewMarginTopIPhone
{
    return 3.0;
}
- (CGFloat) getSliderViewKWidthIPhone
{
    return 5.5;
}
- (UIColor*) getSliderViewMonthFontColor
{
    return [UIColor blackColor];
}
- (UIFont*) getSliderViewMonthFont
{
    return [UIFont systemFontOfSize:12.0];
}
- (NSArray*)getSliderViewGradientColors
{
    return [[NSArray alloc] initWithObjects:(id)[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0].CGColor,
                                            (id)[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0].CGColor,
                                            (id)[UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0].CGColor,nil];
}
- (NSArray*) getSliderViewMonthGradientColors
{
    return [[NSArray alloc] initWithObjects:(id)[UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0].CGColor,
            (id)[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0].CGColor,
            (id)[UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0].CGColor,nil];
}
- (UIImage*) getSliderViewImage
{
    return [UIImage imageNamed:@""];
}
- (UIImage*) getSliderViewMonthImage
{
    return [UIImage imageNamed:@""];
}
- (CGFloat) getSliderViewMonthCornerRadius
{
    return 5.5;
}
- (NSArray*) getCalendarViewGradienColors
{
    return [[NSArray alloc] initWithObjects:(id)[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0].CGColor,
            (id)[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0].CGColor,
            (id)[UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0].CGColor,nil];
}
- (UIImage*) getCalendarViewBackgroundImage
{
    return [UIImage imageNamed:@""];
}
@end
