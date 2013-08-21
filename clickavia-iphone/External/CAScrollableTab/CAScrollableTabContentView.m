//
//  CAScrollableTabContentView.m
//  CASpecialOffers
//
//  Created by denisdbv@gmail.com on 25.06.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "CAScrollableTabContentView.h"
#import "CAScrollableTabScrollView.h"
#import "CAScrollableTab.h"
#import "CATabCell.h"

@implementation CAScrollableTabContentView
{
    NSMutableArray *_tabs;
}

@synthesize delegate = _delegate;

const int MARGIN = 5.0f;
const int MARGIN_TAB = 7.0f;

- (id)initWithFrame:(CGRect)frame titles:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _tabs = [NSMutableArray arrayWithCapacity:[titles count]];
        
        __block CGFloat currentPosition = MARGIN;
        [titles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            CATabCell *tabCell = (CATabCell*)obj;
            
            CGFloat titleWidth = [CAScrollableTab widthForText:tabCell.title];
            CGFloat subTitleWidth = [CAScrollableTab widthForText:tabCell.subTitle];
            
            NSInteger itemWidth = titleWidth + subTitleWidth + 20;
            if(subTitleWidth > 0)
                itemWidth += 10;
            
            CGRect tabFrame = CGRectMake(currentPosition, MARGIN, itemWidth, frame.size.height-10);
            
            CAScrollableTab *tabView = [[CAScrollableTab alloc] initWithFrame:tabFrame tabCell:tabCell index:idx];
            tabView.delegate = (id)self;
            
            [_tabs addObject:tabView];
            
            [self addSubview:tabView];
            
            currentPosition += itemWidth + MARGIN_TAB;
        }];
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, currentPosition - MARGIN_TAB + MARGIN, self.frame.size.height);
        
    }
    return self;
}

-(NSInteger) tabCount
{
    return _tabs.count;
}

- (CAScrollableTab *)tabAtIndex:(NSInteger)index
{
    return _tabs[index];
}

- (void)scrollableTabDidSelectItemAtIndex:(NSInteger)index
{
    [_tabs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if( idx != index  )
            [obj setSelected:NO];
    }];
    
    if([_delegate respondsToSelector:@selector(scrollableTabContentView:didSelectItemAtIndex:)])
    {
        [_delegate scrollableTabContentView:self didSelectItemAtIndex:index];
    }
}

@end
