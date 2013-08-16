//
//  CAFCStyle.m
//  cafieldcomplete
//
//  Created by macmini1 on 31.07.13.
//  Copyright (c) 2013 easylab. All rights reserved.
//

#import "CAFCStyle.h"

@implementation CAFCStyle
+ (CAFCStyle*) sharedStyle
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{_sharedObject = [[self alloc] init];});
    return _sharedObject;
}
- (UIColor*) colorForDestinationName
{
    return [UIColor blackColor];
}
- (UIColor*) colorForDestinationCode
{
    return [UIColor blackColor];
}
- (UIFont*) fontForDestinationName
{
    return [UIFont systemFontOfSize:15.0];
}
- (UIFont*) fontForDestinationCode
{
    return [UIFont systemFontOfSize:11.0];
}
//table customization
- (NSArray*) gradientColorsForTable
{
    return [[NSArray alloc] initWithObjects:(id)[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0].CGColor,
            (id)[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0].CGColor,
            (id)[UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0].CGColor,nil];;
}
- (UIImage*) imageForBackgroundForTable
{
    return [UIImage imageNamed:@""];
}
- (CGFloat) cornerRadiusForTable
{
    return 10.0;
}
- (CGFloat) codeLabelCenterOffsetForCell
{
    return 1.5;
}
//text field customization
- (NSArray*) gradientColorsForTextField
{
    return [[NSArray alloc] initWithObjects:(id)[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0].CGColor,
                   (id)[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0].CGColor,
                   (id)[UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0].CGColor,nil];;
}
- (UIImage*) imageForBackgroundForTextField
{
    return [UIImage imageNamed:@""];
}
- (CGFloat) cornerRadiusForTextField
{
    return 5.0;
}
- (CGFloat) codeLabelCenterOffsetForTextField
{
    return 1.0;
}
//triangle view customization
- (UIColor *)colorForTriangleView
{
    return [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
}
@end
