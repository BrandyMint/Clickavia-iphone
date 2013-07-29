//
//  CAScrollableTabScrollView.h
//  CASpecialOffers
//
//  Created by denisdbv@gmail.com on 25.06.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAScrollableTabScrollViewDelegate.h"
#import "CAScrollableTabContentViewDelegate.h"

@interface CAScrollableTabScrollView : UIScrollView <CAScrollableTabContentViewDelegate>

@property (nonatomic, weak) id <CAScrollableTabScrollViewDelegate> tabDelegate;

- (id)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

- (void)setSelectedIndex:(NSInteger)index;

@end
