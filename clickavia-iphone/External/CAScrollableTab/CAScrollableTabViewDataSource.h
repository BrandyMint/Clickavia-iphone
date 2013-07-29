//
//  CAScrollableTabViewDataSource.h
//  CASpecialOffers
//
//  Created by denisdbv@gmail.com on 25.06.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#ifndef CASpecialOffers_CAScrollableTabViewDataSource_h
#define CASpecialOffers_CAScrollableTabViewDataSource_h

@class CAScrollableTabView;

@protocol CAScrollableTabViewDataSource <NSObject>

@required

- (NSArray *)titlesInScrollableTabView:(CAScrollableTabView *)tabView;

- (UIColor *)lightColorInScrollableView:(CAScrollableTabView *)tabView;
- (UIColor *)darkColorInScrollableView:(CAScrollableTabView *)tabView;

@end

#endif
