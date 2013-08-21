//
//  CAScrollableTabContentView.h
//  CASpecialOffers
//
//  Created by denisdbv@gmail.com on 25.06.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAScrollableTabDelegate.h"
#import "CAScrollableTabContentViewDelegate.h"
#import "CAScrollableTab.h"

@interface CAScrollableTabContentView : UIView <CAScrollableTabDelegate>

@property (nonatomic, weak) id <CAScrollableTabContentViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

-(NSInteger) tabCount;
- (CAScrollableTab *)tabAtIndex:(NSInteger)index;

@end
