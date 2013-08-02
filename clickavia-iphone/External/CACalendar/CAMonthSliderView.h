//
//  CAMonthSliderView.h
//  CAManagersLib
//
//  Created by macmini1 on 08.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CACalendarStyle.h"
#import <QuartzCore/QuartzCore.h>

@class CAMonthSliderView;

@protocol CAMonthSliderViewDelegate
- (void)monthSliderView:(CAMonthSliderView*) monthSliderView selectedMonthChanged:(NSDate*) month;
@end
@interface CAMonthSliderView : UIView <UIGestureRecognizerDelegate,UIScrollViewDelegate>
{
    NSMutableArray *monthLabels;
    NSInteger selectedIndex;
    UIView *tapRectView;
    CGPoint oldPointTranslation;
    UIScrollView *monthView;
    BOOL panNotInRect;
    CAGradientLayer *gradientLayer; //for self View
    CAGradientLayer *gradientLayerMonth;//slider rectangle (tapRectView)
    UIImageView *backgroundView;//for self view
    UIImageView *backgroundMonthView;//slider rectangle (tapRectView)
}
@property (assign) id <CAMonthSliderViewDelegate> delegate;
@property NSInteger testIPhone; // if 0 - use UI_USER_INTERFACE_IDIOM for check device, !=0 - this is iphone
- (void)updateWithSelectedMonth:(NSDate*)selectedMonth;
@end
