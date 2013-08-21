//
//  CAScrollableTabScrollViewDelegate.h
//  CASpecialOffers
//
//  Created by denisdbv@gmail.com on 25.06.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#ifndef CASpecialOffers_CAScrollableTabScrollViewDelegate_h
#define CASpecialOffers_CAScrollableTabScrollViewDelegate_h

@class CAScrollableTabScrollView;

@protocol CAScrollableTabScrollViewDelegate <NSObject>

- (void)scrollableTabScrollView:(CAScrollableTabScrollView *)scrollView didSelectItemAtIndex:(NSInteger)index;

@end

#endif
