//
//  CADay.h
//  CAManagersLib
//
//  Created by macmini1 on 17.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "CACalendarStyle.h"


@interface CADay : UIButton
{
    CAGradientLayer *gradientLayer;
    UIImageView *flightTypeImageView;
    NSArray *gradientColors;
}
@property dayType typeOfDay;
-(void)refreshDay;
@end
