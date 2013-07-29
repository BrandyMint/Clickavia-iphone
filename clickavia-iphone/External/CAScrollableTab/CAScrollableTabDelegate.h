//
//  CAScrollableTabDelegate.h
//  CASpecialOffers
//
//  Created by denisdbv@gmail.com on 25.06.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#ifndef CASpecialOffers_CAScrollableTabDelegate_h
#define CASpecialOffers_CAScrollableTabDelegate_h

@protocol CAScrollableTabDelegate <NSObject>

- (void)scrollableTabDidSelectItemAtIndex:(NSInteger)index;

@end

#endif
