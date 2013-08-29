//
//  draw.m
//  CASpecialOffers
//
//  Created by Viktor Bespalov on 8/26/13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "drawArrowView.h"
#import "CAColorSpecOffers.h"

@implementation drawArrowView
{
    UIColor *colorArrows;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setColor:(UIColor*)colorArrow
{

    colorArrows = colorArrow;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0f);

    CGContextSetStrokeColorWithColor(context, colorArrows.CGColor);

    CGContextMoveToPoint(context, 0.0f, 0.0f);
    CGContextAddLineToPoint(context, 4.0f, 4.0f);
    CGContextAddLineToPoint(context, 0.0f, 8.0f);
    
    CGContextStrokePath(context);

}

@end
