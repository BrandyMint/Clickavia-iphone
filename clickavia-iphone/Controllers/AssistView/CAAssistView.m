//
//  CAAssistView.m
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 9/24/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CAAssistView.h"
#import <QuartzCore/QuartzCore.h>

@implementation CAAssistView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(UIView*) initByAssistText:(NSString*)assistText font:(UIFont*)font indentsBorder:(float)indentsBorder;
{
    NSString *text = assistText;
    CGSize boundingSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width - 2*indentsBorder, CGFLOAT_MAX);
    CGSize requiredSize = [text sizeWithFont:font constrainedToSize:boundingSize lineBreakMode:UILineBreakModeWordWrap];
    CGFloat requiredHeight = requiredSize.height;
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(indentsBorder, indentsBorder, [[UIScreen mainScreen] bounds].size.width-indentsBorder, requiredHeight)];
    label.text = text;
    label.font = font;
    label.textAlignment = NSTextAlignmentLeft;
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    label.textColor = [UIColor whiteColor];
    
    label.layer.shadowColor = [[UIColor blackColor] CGColor];
    label.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    label.layer.shadowRadius = 0;
    label.layer.shadowOpacity = 0.2;
    
    UIView* assistView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, requiredHeight + 2*indentsBorder)];
    assistView.backgroundColor = [UIColor orangeColor];
    
    CGRect backgroundImageFrame = assistView.frame;
    UIImageView* backgroundImage = [[UIImageView alloc] initWithFrame:backgroundImageFrame];
    backgroundImage.image = [[UIImage imageNamed:@"_bar-green-warm.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch];
    
    [assistView addSubview:backgroundImage];
    [assistView addSubview:label];
    
    return assistView;
}

@end
