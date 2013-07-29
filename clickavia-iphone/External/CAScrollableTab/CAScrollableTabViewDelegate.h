//
//  CAScrollableTabViewDelegate.h
//  CASpecialOffers
//
//  Created by denisdbv@gmail.com on 25.06.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#ifndef CASpecialOffers_CAScrollableTabViewDelegate_h
#define CASpecialOffers_CAScrollableTabViewDelegate_h

@class CAScrollableTabView;

@protocol CAScrollableTabViewDelegate <NSObject>

- (void)scrollableTabView:(CAScrollableTabView *)tabView didSelectItemAtIndex:(NSInteger)index;

@end

#endif
