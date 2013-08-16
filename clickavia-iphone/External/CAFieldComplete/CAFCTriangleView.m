//
//  CATriangleComplete.m
//  cafieldcomplete
//
//  Created by macmini1 on 31.07.13.
//  Copyright (c) 2013 easylab. All rights reserved.
//

#import "CAFCTriangleView.h"
#import <QuartzCore/QuartzCore.h>

@implementation CAFCTriangleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)layoutSubviews
{
    self.backgroundColor = [UIColor clearColor];
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGContextAddLineToPoint(ctx, CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGContextClosePath(ctx);
    CGContextSetFillColorWithColor(ctx, [[CAFCStyle sharedStyle] colorForTriangleView].CGColor);
    CGContextFillPath(ctx);
}
@end
