//
//  CADay.m
//  CAManagersLib
//
//  Created by macmini1 on 17.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "CADay.h"

@implementation CADay
- (id)initWithFrame:(CGRect)frame
//button created in code
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialise];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
//button created in Interface Builder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialise];
    }
    return self;
}

- (void)initialise
{
    _typeOfDay = CADayTypeOther;
    gradientColors = [NSArray new];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
}
-(void)refreshDay
{
    [self setupColors];
}
-(void)setupColors
{
    [gradientLayer removeFromSuperlayer];
    [flightTypeImageView removeFromSuperview];
    self.layer.cornerRadius = [[CACalendarStyle sharedStyle] getCornerRadiusForDay:_typeOfDay];
    gradientLayer = [CAGradientLayer new];
    gradientLayer.colors = [[CACalendarStyle sharedStyle] getGradientColorsForDay:_typeOfDay];
    gradientLayer.frame = self.bounds;
    gradientLayer.cornerRadius = self.layer.cornerRadius;
    [self.layer insertSublayer:gradientLayer atIndex:0];
    [self setTitleColor:[[CACalendarStyle sharedStyle] getFontColorForDay:_typeOfDay] forState:UIControlStateNormal];
    self.titleLabel.font = [[CACalendarStyle sharedStyle] getFontForDay:_typeOfDay];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    flightTypeImageView = [[CACalendarStyle sharedStyle] getFlightTypeImageViewForDay:_typeOfDay];
    CGRect frame = flightTypeImageView.frame;
    frame.origin.x = self.frame.size.width - flightTypeImageView.frame.size.width;
    flightTypeImageView.frame = frame;
    [self addSubview:flightTypeImageView];
    self.titleLabel.shadowOffset = [[CACalendarStyle sharedStyle] getShadowOffsetForDay:_typeOfDay];
    self.titleLabel.shadowColor = [[CACalendarStyle sharedStyle] getShadowColorForDay:_typeOfDay];
    [self setImage:[[CACalendarStyle sharedStyle] getImageForDay:_typeOfDay] forState:UIControlStateNormal];

}
@end
