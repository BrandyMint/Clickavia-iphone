//
//  CAScrollableTab.m
//  CASpecialOffers
//
//  Created by denisdbv@gmail.com on 25.06.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "CAScrollableTab.h"
#import <QuartzCore/QuartzCore.h>

#define TAB_TEXT_FONT [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];

@implementation CAScrollableTab
{
    NSInteger _index;
}

@synthesize delegate = _delegate;
@synthesize selected = _selected;

+ (CGFloat)widthForText:(NSString *)sampleText;
{
    UIFont *font = TAB_TEXT_FONT;
    CGSize textSize = [sampleText sizeWithFont:font];
    return textSize.width;  //1.40
}

+ (Class)layerClass {
    return [CAGradientLayer class];
}

- (id)initWithFrame:(CGRect)frame tabCell:(CATabCell*)cell index:(NSInteger)index
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _index = index;
        
        [self setSelected:NO];
        [self setupLabelsInFrame:frame tabCell:cell];
        
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:recognizer];
    }
    return self;
}

- (void)tapAction:(UIGestureRecognizer *)gestureRecognizer;
{
    self.selected = YES;
    
    if([_delegate respondsToSelector:@selector(scrollableTabDidSelectItemAtIndex:)])
    {
        [_delegate scrollableTabDidSelectItemAtIndex:_index];
    }
}

- (void)setSelected:(BOOL)selected;
{
    CAGradientLayer *tabLayer = (CAGradientLayer *)self.layer;
    tabLayer.cornerRadius = 4;
    NSMutableArray *mutableColors = [NSMutableArray arrayWithCapacity:2];
    
    if(!selected)
    {
        UIColor *darkColor = [UIColor colorWithRed:0.121f green:0.121f blue:0.121f alpha:1.0];
        UIColor *lightColor = [UIColor colorWithRed:0.262f green:0.262f blue:0.262f alpha:1.0];
        [mutableColors addObject:(id)lightColor.CGColor];
        [mutableColors addObject:(id)darkColor.CGColor];
    }
    else
    {
        UIColor *darkColor = [UIColor colorWithRed:0.262f green:0.262f blue:0.262f alpha:1.0];
        UIColor *lightColor = [UIColor colorWithRed:0.121f green:0.121f blue:0.121f alpha:1.0];
        [mutableColors addObject:(id)lightColor.CGColor];
        [mutableColors addObject:(id)darkColor.CGColor];
    }
    
    tabLayer.colors = mutableColors;
}

- (void) setupLabelsInFrame:(CGRect)frame tabCell:(CATabCell*)cell
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = TAB_TEXT_FONT;
    titleLabel.text = cell.title;
    [titleLabel sizeToFit];
    
    UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    subTitleLabel.backgroundColor = [UIColor clearColor];
    subTitleLabel.textColor = [UIColor whiteColor];
    subTitleLabel.font = TAB_TEXT_FONT;
    subTitleLabel.text = cell.subTitle;
    [subTitleLabel sizeToFit];
    
    NSInteger xOffset = (frame.size.width - (titleLabel.frame.size.width+subTitleLabel.frame.size.width+((cell.subTitle.length>0)?10:0)))/2;
    NSInteger yOffset = (frame.size.height - titleLabel.frame.size.height)/2;
    
    titleLabel.frame = CGRectMake(xOffset, yOffset, titleLabel.frame.size.width, titleLabel.frame.size.height);
    
    [self addSubview:titleLabel];
    
    if(cell.subTitle.length > 0)    {
        xOffset = titleLabel.frame.origin.x + titleLabel.frame.size.width + 10;
        yOffset = titleLabel.frame.origin.y;
        
        subTitleLabel.frame = CGRectMake(xOffset, yOffset, subTitleLabel.frame.size.width, subTitleLabel.frame.size.height);
        
        [self addSubview:subTitleLabel];
    }
}

//

@end
