//
//  CAScrollableTabScrollView.m
//  CASpecialOffers
//
//  Created by denisdbv@gmail.com on 25.06.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "CAScrollableTabScrollView.h"
#import "CAScrollableTabContentView.h"

@implementation CAScrollableTabScrollView

@synthesize tabDelegate = _tabDelegate;

- (id)initWithFrame:(CGRect)frame titles:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CAScrollableTabContentView *contentView = [[CAScrollableTabContentView alloc] initWithFrame:self.bounds titles:titles];
        contentView.delegate = (id)self;
        
        self.contentSize = contentView.frame.size;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.alwaysBounceHorizontal = NO;
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:contentView];
    }
    return self;
}

- (void)setSelectedIndex:(NSInteger)index
{
    [[self subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if( [obj isKindOfClass:[CAScrollableTabContentView class]] ) {
            if( [obj tabCount] > 0 )    {
                CAScrollableTab *tabToSelect = [obj tabAtIndex:index];
                [tabToSelect setSelected:YES];
            }
        }
    }];
}

- (void)scrollableTabContentView:(CAScrollableTabContentView *)contentView didSelectItemAtIndex:(NSInteger)index;
{
    if([_tabDelegate respondsToSelector:@selector(scrollableTabScrollView:didSelectItemAtIndex:)])
    {
        [_tabDelegate scrollableTabScrollView:self didSelectItemAtIndex:index];
    }
}

@end
