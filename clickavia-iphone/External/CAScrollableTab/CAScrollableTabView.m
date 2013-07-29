//
//  CAScrollableTabView.m
//  CASpecialOffers
//
//  Created by denisdbv@gmail.com on 25.06.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "CAScrollableTabView.h"
#import "CAScrollableTabScrollView.h"
#import "CAScrollableTabColorKeys.h"
#import <QuartzCore/QuartzCore.h>

@interface CAScrollableTabView()
-(void) addScrollView;
- (NSDictionary *) colorInfo;
@end

@implementation CAScrollableTabView
{
    CAScrollableTabScrollView *_scrollView;
}

@synthesize delegate = _delegate;
@synthesize dataSource = _dataSource;

+ (Class)layerClass {
    return [CAGradientLayer class];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initScrollableView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)    {
        [self initScrollableView];
    }
    return self;
}

-(void) initScrollableView
{
    [self addObserver:self forKeyPath:@"dataSource" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if( [keyPath isEqualToString:@"dataSource"] )
    {
        [self setBackgroundColorView];
        [self addScrollView];
    }
}

-(void) addScrollView
{
    NSArray *titles = [_dataSource titlesInScrollableTabView:self];
    
    if( _scrollView )
        [_scrollView removeFromSuperview];
    
    _scrollView = [[CAScrollableTabScrollView alloc] initWithFrame:self.bounds titles:titles];
    _scrollView.tabDelegate = (id)self;
    [self addSubview: _scrollView];
}

-(void) reloadData
{
    [self addScrollView];
}

- (void)setSelectedItemIndex:(NSInteger)index
{
    [_delegate scrollableTabView:self didSelectItemAtIndex:index];
    [_scrollView setSelectedIndex:index];
}

-(void) setBackgroundColorView
{
    CAGradientLayer *layer = (CAGradientLayer *)self.layer;
    
    NSDictionary *colorInfo = [self colorInfo];
    
    UIColor *darkColor = [colorInfo objectForKey:kCAScrollableDarkColor];
    UIColor *lightColor = [colorInfo objectForKey:kCAScrollableLightColor];
    NSMutableArray *mutableColors = [NSMutableArray arrayWithCapacity:2];
    [mutableColors addObject:(id)lightColor.CGColor];
    [mutableColors addObject:(id)darkColor.CGColor];
    
    layer.colors = mutableColors;
}

- (NSDictionary *) colorInfo
{
    NSMutableDictionary *mutableColorInfo = [NSMutableDictionary dictionaryWithCapacity:2];
    [mutableColorInfo setObject:[_dataSource lightColorInScrollableView:self] forKey:kCAScrollableLightColor];
    [mutableColorInfo setObject:[_dataSource darkColorInScrollableView:self] forKey:kCAScrollableDarkColor];
    
    return mutableColorInfo;
}

- (void)scrollableTabScrollView:(CAScrollableTabScrollView *)scrollView didSelectItemAtIndex:(NSInteger)index
{
    if([_delegate respondsToSelector:@selector(scrollableTabView:didSelectItemAtIndex:)])
    {
        [_delegate scrollableTabView:self didSelectItemAtIndex:index];
    }
}

@end
